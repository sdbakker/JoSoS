;----------------------------------------------------------------------------
; protected mode test kernel
;----------------------------------------------------------------------------

; to assemble: nasm pkernel.asm -f bin -o pkernel.bin
; to transfer to disk: partcopy pkernel.bin 0 200 -f0 200

[BITS 32]
%include "jos32struc.inc"

GLOBAL _start32
EXTERN jos_stc
EXTERN _initInterrupts
EXTERN _delay
EXTERN _check_vendor
EXTERN _check_model

_start32:

	mov dx, 0x3f2
	xor al,al
	out dx, al
	call _initInterrupts


        ;call top_menu

        mov byte [GetSTC_JOS32(Vid_cur_scr_Y)], 0x04
        mov byte [GetSTC_JOS32(Vid_cur_scr_X)], 0x03
        mov byte [GetSTC_JOS32(Vid_cur_X)], 0x03
        mov byte [GetSTC_JOS32(Vid_cur_Y)], 0x19
        mov al, 0x01
        mov ah, 0x47
        xor dx, dx
        mov esi, top_msg 
	int 38h
	mov esi, omheining
	mov ah, 0x02
	mov dx, 0x03
	int 38h
	
 	mov al, 0x01
 	mov ah, 0x02
 	mov dl, [GetSTC_JOS32(Vid_cur_scr_Y)]
 	mov dh, [GetSTC_JOS32(Vid_cur_scr_X)]
       	mov esi, kernelmsg	
	int 38h
 	add byte [GetSTC_JOS32(Vid_cur_scr_Y)],2

	mov ah, 0x07 ; set prompt
	mov dl, [GetSTC_JOS32(Vid_cur_Y)]
	mov dh, 0
	mov esi, ddp
	int 38h

	mov al, 0x02 ; set hardware cursor
	mov dl, [GetSTC_JOS32(Vid_cur_Y)]
	mov dh, [GetSTC_JOS32(Vid_cur_X)]
	int 38h

       	in ax, 0x70
	and ax, 0x7f
	out 0x70, ax

	;set PIT freq
	mov al, 34h
	out 43h, al
	mov ax, (1234DDh / 25) ; 25 fps
	out 40h, al
	shr ax, 8
	out 40h, al
	;done 

	sti
dummy:
        jmp dummy

;----------------------------------------------------------------------------
; functions
;----------------------------------------------------------------------------
top_menu:
	   xor dx,dx
	   mov cx, 0x4f		;80 colums
	   .loop
	   mov esi, top_menu 
	   mov al, 0x01
           mov ah, 0x47
           int 38h
           mov dh, cl
           loop .loop

	   ret


;----------------------------------------------------------------------------
; data
;----------------------------------------------------------------------------
	IDTR 
			dw 0x800
			db 0x1000
	omheining	db 0xda,
			times 78 db 0xc4
			db 0xbf,10,13

			db 0xb3 
			times 78 db 0x20
			db 0xb3,10,13
			
			db 0xc3
			times 78 db 0xc4
			db 0xb4,10,13

			db 0xb3 
			times 78 db 0x20
			db 0xb3,10,13

			db 0xb3 
			times 78 db 0x20
			db 0xb3,10,13

			db 0xb3 
			times 78 db 0x20
			db 0xb3,10,13

			db 0xb3 
			times 78 db 0x20
			db 0xb3,10,13

			db 0xb3 
			times 78 db 0x20
			db 0xb3,10,13

			db 0xb3 
			times 78 db 0x20
			db 0xb3,10,13

			db 0xb3 
			times 78 db 0x20
			db 0xb3,10,13

			db 0xb3 
			times 78 db 0x20
			db 0xb3,10,13

			db 0xb3
			times 78 db 0x20
			db 0xb3,10,13

			db 0xb3 
			times 78 db 0x20
			db 0xb3,10,13

			db 0xb3 
			times 78 db 0x20
			db 0xb3,10,13

			db 0xb3 
			times 78 db 0x20
			db 0xb3,10,13

			db 0xb3 
			times 78 db 0x20
			db 0xb3,10,13

			db 0xb3 
			times 78 db 0x20
			db 0xb3,10,13

			db 0xb3 
			times 78 db 0x20
			db 0xb3,10,13

			db 0xb3 
			times 78 db 0x20
			db 0xb3,10,13

			db 0xc0
			times 78 db 0xc4
			db 0xd9, 0

	top_msg		db '                                                                                ',0
	ddp		db '$>  ',0
	kernelmsg 	db '__JOS: SYSTEM32 loaded',0
