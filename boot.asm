[BITS 16]
[org 0x0]

jmp short boot
nop
; some equ's to make a poor mans life easier
	KERNSEG		equ 0x1000	; place for kernel
	BOOTSEG 	equ 0x07c0	; old bootsector location
	NBOOTSEG	equ 0x9000 	; new bootsector location
	STACKSEG	equ 0x8000	; temp stack segment
	BIOSDATA	equ 0x7000	; new location of BIOS Data Area
	OLDBIOS		equ 0x0040	; old location of BIOS Data Area
	VIDEOSEG	equ 0xb800

; some variables to make a poor mans life easier
	bootdrive	db 0
	;IDT nothing yeet
	idtr
		dw 0
		dd 0x1000
		
	;LDT is loaded from ldt.inc
	;gdtptr has to be loaded int gdtr
	%include "gdt.inc"
	
boot:	
	mov [bootdrive], dl
	; let us first move out of the way to location NBOOTSEG
	cld
	mov ax, BOOTSEG
	mov ds, ax
	mov ax,NBOOTSEG
	mov es,ax
	xor di, di
	xor si,si
	mov cx, 0x200
	cli
	rep movsb

	jmp NBOOTSEG:continue

continue:
	mov ax, 3
	int 0x10
        
	mov ax,1112h
	mov bl,0
	int 10h

	mov cx, 0x05
	.loop:
	mov esi, NL_MSG
	call print_msg
	loop .loop
       
load_kernel:
	mov ah,0
	mov dl, [bootdrive]
	int 0x13
	cld
	mov si, LOADING
	call print_msg
	mov cx, 0002
	mov dh,0
	xor bx,bx
read_next:
	mov ax, 0x1000
	mov es,ax
	mov ax,0x0201
	mov dl,[bootdrive]
	int 0x13
	jc read_next
	
	push ax
	push bx
	mov ax, 0e2eh
	xor bx,bx
	int 10h
	pop bx
	pop ax

	inc cl
	add bx, 0x200
	cmp cl, 18
	jna read_next
	mov cl, 01
	cmp dh, 00
	je .side
	jmp .done_read
	.side
	mov dh, 01
	jmp read_next
	.done_read
	call print_msg
	nop
relocate:	
	; relocate BIOS Data Area
	mov ax, OLDBIOS
	mov ds,ax
	mov ax,BIOSDATA
	mov es,ax
	xor di, di
	xor si,si
	mov cx, 0x100
	rep movsb
	sti

	;set up segments	
	mov ax, NBOOTSEG
	mov ds,ax
	mov es,ax
	xor si,si
	xor bp,bp
	;set up stack
	mov ax,STACKSEG
	mov ss, ax
	mov ax, 0x1fff
	mov sp, ax
	;set up video segment
	mov ax, VIDEOSEG
	mov gs,ax
	
	mov ax, 3		; clear screen
	int 10h
	mov ax,1112h		; set nice mode
	mov bl,0
	int 10h
	jmp further
not_ok:
	mov si, NOTOK_MSG
	call print_msg
	jmp short $
;--------------------------------------------------------------------
further:

	push dword 0
	popfd
	in al,0x70
	or al,0x80
	out 0x70,al

	mov si, NOTOK_MSG
	call print_msg
	
	push es
	xor ax,ax
	mov es, ax
	xor di,di
	mov si, gdt
	mov cx, gdt_end-gdt
	rep movsb
	pop es

	mov si, NOTOK_MSG
	call print_msg

	lgdt [gdtptr]
	lidt [idtr]
	
	;ps2 A20 enable
	mov si, NOTOK_MSG
	call print_msg
	
	in al,0x92
	or al,2
	out 0x92,al

	;old A20 enable 
	mov si, NOTOK_MSG
	call print_msg
	call test_A20
	call A20enable
	
	mov si, YES_msg
	call print_msg

protected:

	mov eax,cr0
	inc eax
	mov cr0, eax
	jmp short flush

flush:
	mov bx, kerneld_gdt
	mov ds,bx
	mov es,bx
	mov fs,bx
	mov gs,bx
	mov ss,bx
	jmp dword 0x08:0x90000 + go_go
;------------------------------------------------------------------------------------
A20enable:
	;enable A20
	cli
	xor cx,cx
clear_buf:
	in al, 64h
	test al, 02h
	loopnz clear_buf
	mov al, 0D1h
	out 64h, al
clear_buf2:
	in al, 64h
	test al, 02h
	loopnz clear_buf2
	mov al, 0dfh
	out 60h, al
	mov cx, 14h
wait_kbc:
	out 0edh, ax
	loop wait_kbc
	sti
test_A20:
	xor ax,ax
	mov fs,ax
	dec ax
	mov gs, ax

	mov al, byte [fs:0]
	mov ah, al
	not al
	xchg al,byte [gs:10h]
	cmp ah,byte [fs:0]
	jz A20enabled
	ret
	
A20already:
	mov si, YES_msg
	call print_msg
	jmp A20ok
A20enabled:
	mov si, NOTOK_MSG
	call print_msg
A20ok:
	mov si, NOTOK_MSG
;-----------------------------------------------------------------------------
go_go:
[BITS 32]
push dword 0
popfd
mov eax,0x10000
jmp eax
jmp short $
;----------------------------------------------------------------------------------
; some functions
;----------------------------------------------------------------------------------
[BITS 16]
print_msg:
; uses ds:si as pointer to string 
; corrupted: ax
	cld		;clear direction flag
	mov ah, 0x0E 	;teletype mode for displaying
	lodsb 		;stort byte from ds:si in al and incr si
	cmp al, 0
	jz print_msg_done
	int 0x10
	jmp print_msg
print_msg_done:
	ret


;-----------------------------------------------------------------------------------
; other stuff
;-----------------------------------------------------------------------------------
	LOADING		db 'LOADING',0
	NOTOK_MSG	db 10,13,'NOT OK',10,13,0
	NL_MSG		db 10,13,0
	YES_msg		db 10,13,'OK',10,13,0

	times 512-2-($-$$) db 0x0
	dw 0xAA55
