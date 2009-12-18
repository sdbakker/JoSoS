;=-------------------------------=;
;- int 38h - string operations   -;
;- al: 0x01 = printstring        -;
;      0x02 = set hardware cursor-;
;      0x03 = clrscr		 -;
;      0x04 = scroll	 	 -;
;- ah: attribute                 -;
;- dh: x(col), dl: y(row)        -;
;- ds:esi = dataseg:stringoffset -;
;=-------------------------------=;

;---------------------------------------------------------------
; TOGOer: create different int's for command line and info box.
;---------------------------------------------------------------


%include "jos32struc.inc"
GLOBAL _disps
EXTERN jos_stc

	vidseg  equ 0xb8000
	pos_x	db 0
	pos_y	db 1
	attr	db 0
	
_disps:
	pushad	
	; which function is requested?
	cmp al, 0x01
	je .print_string	
	cmp al, 0x02
	je .hardware_cursor
	cmp al, 0x03
	je .clrscr
	cmp al, 0x04
	je .scroll
	jmp done
.print_string
	call print_string
	jmp done
.hardware_cursor
	call hardware_cursor
	jmp done
.clrscr
	call clrscr
	jmp done
.scroll
	call scroll
	jmp done
done:
	popad
	ret	
;--------------------------------------------------------------------;
; print string - 0x01
;--------------------------------------------------------------------;	
print_string:
 	mov bx, 0x10
	mov ds, bx
	mov [pos_x], dh
	mov [pos_y], dl
	mov [attr], ah
.repeat
	lodsb					; load byte from ds:esi into al
	cmp al, 0				; 0?, return from interrupt
	jz .done
	call print_character
	jmp .repeat
.done	
	;mov byte [GetSTC_JOS32(Vid_cur_X)], [pos_x]
	;mov byte [GetSTC_jOS32(Vid_cur_Y)], [pos_y]
	ret

line_feed:
	add byte [pos_y], 1			; jump to next row
	jmp char_done
carriage_return:
	mov byte [pos_x], 0			; jump to first col
	jmp char_done				; return to print_string

print_character:
	cmp al, 10				; line feed or carriage return
	jz line_feed
	cmp al, 13
	jz carriage_return

	push eax
	xor ebx, ebx
	mov bl, [pos_x]
	shl bl, 1

	xor eax, eax
	mov al, [pos_y]
	mov edx, 160
	mul edx

	mov edi, vidseg
	add edi, eax
	add edi, ebx

	pop eax
	cld
	stosw

	add byte [pos_x], 1
	
char_done:
	ret
;----------------------------------------------------------------------------------;
; hardware_cursor 0x02
;----------------------------------------------------------------------------------;

hardware_cursor:
	xor ebx,ebx
	xor eax,eax
	mov bl, dh	;x
	mov [GetSTC_JOS32(Vid_cur_X)], dh
	mov al, dl	;y
	mov [GetSTC_JOS32(Vid_cur_Y)], dl
	mov edx, 80	; multiply y with max rows (80) to get row offset
	mul edx
	add ebx, eax	; add x to get column offset
	
	; write low byte to vga card
	mov al, 0xf
	mov dx, 0x03d4
	out dx, al
	mov al, bl
	mov dx, 0x03d5
	out dx, al

	; now high byte
	mov al, 0xe
	mov dx, 0x03d4
	out dx, al
	mov al, bh
	mov dx, 0x03d5
	out dx, al

	ret


;----------------------------------------------------------------------------------;
; clrscr 0x03
;----------------------------------------------------------------------------------;
clrscr:
	push eax
	push ecx
	push edx
	
	xor ecx, ecx
	mov cx, 15
	mov dh, 0x03
	mov dl, 0x06
	mov al, 0x01
	mov ah, 0x07
	mov esi, empty
	int 38h

	.l1
	mov esi, empty
	inc dl
	int 38h
	loop .l1
	
	pop edx 
	pop ecx
	pop eax
	ret

;----------------------------------------------------------------------------------;
; scroll 0x04
;----------------------------------------------------------------------------------;
scroll:
	ret
	
_print_cmd_char:
	ret
_print_info:
	ret
_move_hw_curs:
	ret
_interpret_cmd:
	ret

	empty	times 72 db 0x20
			 db 0
