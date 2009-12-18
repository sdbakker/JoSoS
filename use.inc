;----------------------------------------------------------------------------------
;IRQ 0 Test 0x20
%include "jos32struc.inc"
_int20: ;irq 0 
	push eax
	push ebx
	inc dword [GetSTC_JOS32(ticks)]
	mov eax, [GetSTC_JOS32(ticks)]
	mov ebx, [GetSTC_JOS32(prev_ticks)]
	sub eax,ebx
	cmp eax,25
	je .1sec
	
	.done
	pop ebx
	pop eax
	call _EOI
	iret
	
	.1sec
	mov eax,[GetSTC_JOS32(ticks)]
	mov [GetSTC_JOS32(prev_ticks)], eax
	mov al, [dummy]
	inc al
	mov [dummy], al
	mov byte [0xb8060], al
	mov byte [0xb8061], 0x47
	jmp .done
	
_int21: ;irq 1
	call _keyboardhandler
;	mov byte [0xb8060], 'K'
;	mov byte [0xb8061], 0x47
;	mov byte [0xb8062], 'e'
;	mov byte [0xb8063], 0x47
;	mov byte [0xb8064], 'y'
;	mov byte [0xb8065], 0x47
;	mov byte [0xb8066], 'b'
;	mov byte [0xb8067], 0x47
;	mov byte [0xb8068], 'o'
;	mov byte [0xb8069], 0x47
;	mov byte [0xb806a], 'a'
;	mov byte [0xb806b], 0x47
;	mov byte [0xb806c], 'r'
;	mov byte [0xb806d], 0x47
;	mov byte [0xb806e], 'd'
;	mov byte [0xb806f], 0x47
;	mov byte [0xb8070], ' '
;	mov byte [0xb8071], 0x47
;	mov byte [0xb8072], 'p'
;	mov byte [0xb8073], 0x47
;	mov byte [0xb8074], 'r'
;	mov byte [0xb8075], 0x47
;	mov byte [0xb8076], 'e'
;	mov byte [0xb8077], 0x47
;	mov byte [0xb8078], 's'
;	mov byte [0xb8079], 0x47
;	mov byte [0xb807a], 's'
;	mov byte [0xb807b], 0x47
	call _EOI
	iret
_int22: ;irq 2
	call _EOI
	iret
_int23: ; irq 3
	call _EOI
	iret
_int24: ; irq 4
	call _EOI
	iret
_int25: ; irq 5 
	call _EOI
	iret
_int26: ; irq 6
	call _EOI
	iret
_int27: ; irq 7
	call _EOI
	iret
;---------------------------------------PIC2---------------------------------------
_int30: ; irq 8
	call _EOI12
	iret
_int31: ; irq 9
	call _EOI12
	iret
_int32: ; irq 10
	call _EOI12
	iret
_int33: ; irq 11
	call _EOI12
	iret
_int34: ; irq 12
	mov byte [0xb8010], 'M'
	mov byte [0xb8011], 0x47
	mov byte [0xb8012], 'o'
	mov byte [0xb8013], 0x47
	mov byte [0xb8014], 'u'
	mov byte [0xb8015], 0x47
	mov byte [0xb8016], 's'
	mov byte [0xb8017], 0x47
	mov byte [0xb8018], 'e'
	mov byte [0xb8019], 0x47
	mov byte [0xb801a], ' '
	mov byte [0xb801b], 0x47
	mov byte [0xb801c], 'I'
	mov byte [0xb801d], 0x47
	mov byte [0xb801e], 'n'
	mov byte [0xb801f], 0x47
	mov byte [0xb8020], 't'
	mov byte [0xb8021], 0x47
	mov byte [0xb8022], 'e'
	mov byte [0xb8023], 0x47
	mov byte [0xb8024], 'r'
	mov byte [0xb8025], 0x47
	mov byte [0xb8026], 'r'
	mov byte [0xb8027], 0x47
	mov byte [0xb8028], 'u'
	mov byte [0xb8029], 0x47
	mov byte [0xb802a], 'p'
	mov byte [0xb802b], 0x47
	mov byte [0xb802c], 't'
	mov byte [0xb802d], 0x47
	call _EOI12
	iret
_int35: ; irq 13
	call _EOI12
	iret
_int36: ; irq 14
	call _EOI12
	iret
_int37: ; irq 15
	call _EOI12
	iret
_int38:
	call _disps
	iret
	

dummy	db 0
old_t	dd 0
new_t	dd 0
