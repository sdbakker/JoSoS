[BITS 32]

%include "jos32struc.inc"
EXTERN jos_stc
EXTERN _check_vendor
EXTERN _check_model
GLOBAL _keyboardhandler

_keyboardhandler:
	push eax
	push ebx
	push ecx
	push edx

	mov ebx, key_tbl ;load address of scan code translation table key_tbl for use with xlat

	xor eax,eax
	in al, 0x60
	
	cmp al, 0x3a
	jae near .end
	mov cl, al
	xlatb 
	mov ah, al
	mov al, cl

	mov ebx, [bfptr] ;scan code is in al, ascii code in ah. Now we can load a pointer to the keyb. buffer
	
.handle:
	cmp ah, 0x00
	je near .end
	cmp ah, 0x0d
	je near .CR
	cmp ah, 0x08
	je near .BACKSP

.p1
	mov byte [ebx], ah
	inc ebx
	cmp ebx, kbdbuffer + 55
	je .p2
	mov [bfptr], ebx
	jmp .p3	
.p2	
	mov ebx, kbdbuffer
	mov [bfptr], ebx

.p3	
	inc byte [inbfr]
	cmp byte [GetSTC_JOS32(Vid_cur_X)], 53
	jae near .end

	mov byte [letter], ah
	mov al, 0x01
	mov ah, 0x07

	mov dl, [GetSTC_JOS32(Vid_cur_Y)]
	mov dh, [GetSTC_JOS32(Vid_cur_X)]
	mov esi, letter
	int 38h


	inc byte [GetSTC_JOS32(Vid_cur_X)]
	mov al, 0x02
	mov dh, [GetSTC_JOS32(Vid_cur_X)]
	mov dl, [GetSTC_JOS32(Vid_cur_Y)]
	int 38h
	jmp .end

	.CR
	cmp byte [inbfr], 0x00
	je near .end
	mov byte [letter], 0x20
;	inc byte [GetSTC_JOS32(Vid_cur_Y)]		
	mov byte [GetSTC_JOS32(Vid_cur_X)], 3
	mov dh, [GetSTC_JOS32(Vid_cur_X)]
	mov dl, [GetSTC_JOS32(Vid_cur_Y)]
	mov al, 0x02
	int 38h

	xor ecx, ecx
	mov cx, 50  	; why does this work fine on my 486DX4 and not on my newer celeron ??
	mov dh, 3
	.clrl
	mov esi, letter 
	mov dl, [GetSTC_JOS32(Vid_cur_Y)]
	mov al, 0x01
	mov ah, 0x07
	int 38h
	inc dh
	loop .clrl
	
	mov ebx, kbdbuffer
	mov [bfptr], ebx
 	call cmd
	 	
	jmp .end
	
	.BACKSP
	
	cmp ebx, kbdbuffer
	je .p4
	dec ebx
	mov [bfptr], ebx
	cmp byte [inbfr], 0x00
	je .p4
	dec byte [inbfr]
.p4
	mov byte [letter], 0x20
	cmp byte [GetSTC_JOS32(Vid_cur_X)], 3
	je .end
	dec byte [GetSTC_JOS32(Vid_cur_X)]
	mov dl, [GetSTC_JOS32(Vid_cur_Y)]
	mov dh, [GetSTC_JOS32(Vid_cur_X)]
	mov al, 0x01
	mov ah, 0x07
	mov esi, letter
	int 38h
	mov al, 0x02
	int 38h
	jmp .end
	
	.end
	pop edx
	pop ecx
	pop ebx
	pop eax
	ret


cmd:

	xor ecx, ecx
	mov edi, check_model	;
.c1	mov esi, kbdbuffer
	mov cx, [inbfr] 
	cld
.c2	
	repe cmpsb
	je .p2

	mov cx, [inbfr]
	mov esi, kbdbuffer
	mov edi, check_vendor
	repe cmpsb
	je .p3
	
	mov cx, [inbfr]
	mov esi, kbdbuffer
	mov edi, id
	repe cmpsb
	je .p1

	mov cx, [inbfr]
	mov esi, kbdbuffer
	mov edi, help
	repe cmpsb
	je .p4
	jne near .p0

	
	
.p1
	cmp byte [inbfr], 2
	jne near .p0
	mov esi, id_cmd
	call _cmd_id
	jmp .end
.p2
	cmp byte [inbfr], 10
	jne near .p0
	call dword [cmd1]
	mov esi, [GetSTC_JOS32(model_adr)]
	call _cmd_id
	jmp .end
.p3
	cmp byte [inbfr], 11
	jne near .p0  
	call dword [cmd2]
	mov esi, GetSTC_JOS32(Vendor)
	call _cmd_id
	jmp .end
.p4
	cmp byte [inbfr], 4
	jne near .p0	
	mov al, 0x03
	int 38h

	mov byte [GetSTC_JOS32(Vid_cur_scr_Y)], 0x06
	
	mov esi, help_msg
	call _cmd_id
	mov esi, help_msg0
	call _cmd_id
	mov esi, help_msg1
	call _cmd_id
	mov esi, help_msg2
	call _cmd_id
	mov esi, help_msg3
	call _cmd_id
	mov esi, help_msg4
	call _cmd_id
	mov esi, help_msg0
	call _cmd_id
	jmp .end	
.p0	
	mov esi, unknown_cmd
	call _cmd_id
.end
	mov byte [inbfr], 0
	ret

_cmd_id:
	push eax 
	push ebx
	push edx

	mov al, 0x01
	mov ah, 0x07
	mov dl, [GetSTC_JOS32(Vid_cur_scr_Y)]
	mov dh, [GetSTC_JOS32(Vid_cur_scr_X)]
	int 38h
	inc byte [GetSTC_JOS32(Vid_cur_scr_Y)]

	pop edx
	pop ebx
	pop eax
	ret
	

	letter db 0,0

kbdbuffer	db 0
		times 55 db 0

bfptr		dd kbdbuffer
inbfr		db 0

key_tbl	db 	0x00, 0x1B
	db	0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x30, 0x2D, 0x3D
	db	0x08, 0x09, 0x71, 0x77, 0x65, 0x72, 0x74, 0x79, 0x75, 0x69, 0x6F, 0x70
	db	0x5B, 0x5D, 0x0D, 0x00, 0x61, 0x73, 0x64, 0x66, 0x67, 0x68, 0x6A, 0x6B, 0x6C
	db	0x3B, 0x27, 0x60, 0x00, 0x5C, 0x7A, 0x78, 0x63, 0x76, 0x62, 0x6E, 0x6D 
	db	0x2C, 0x2E, 0x2F, 0x00, 0x00, 0x00, 0x20, 0x00

cmd1	dd	_check_model
cmd2	dd	_check_vendor
;cmd3	dd	_help

	check_model	db 'checkmodel',0
	check_vendor	db 'checkvendor',0
	id		db 'id',0
	help		db 'help',0
	unknown_cmd	db 'error: Unknown command',0
	id_cmd		db '__JOS version 0.01a',0
	help_msg	db 'current commands:',0
	help_msg0	db ' ',0
	help_msg1	db '    help:        this one',0
	help_msg2	db '    id:          __jos version' ,0
	help_msg3	db '    checkmodel:  shows processor model',0
	help_msg4	db '    checkvendor: shows processor vendor',0
	empty_line	times 50 db 0x20
			db 0
