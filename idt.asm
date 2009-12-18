; entries for interrupt descriptor table
GLOBAL _initInterrupts
GLOBAL _EOI
GLOBAL _EOI2
GLOBAL _EOI12
GLOBAL _delay

EXTERN _disps
EXTERN _keyboardhandler
EXTERN jos_stc
;----------------------------------------------------------------------------------

%include "res.inc"
%include "use.inc"

_initInterrupts:
	push eax
	push ebx

	mov eax, 0x1000
	; int 0
	mov ebx, _int0
	mov word [eax], bx
	mov word [eax+2], 0x08
	mov word [eax+4], 0x8e00
	shr ebx, 16
	mov word [eax+6], bx
	add eax, 8
	; int 1
	mov ebx, _int1
	mov word [eax], bx
	mov word [eax+2], 0x08
	mov word [eax+4], 0x8e00
	shr ebx, 16
	mov word [eax+6], bx
	add eax, 8
	; int 2
	mov ebx, _int2
	mov word [eax], bx
	mov word [eax+2], 0x08
	mov word [eax+4], 0x8e00
	shr ebx, 16
	mov word [eax+6], bx
	add eax, 8
	; int 3
	mov ebx, _int3
	mov word [eax], bx
	mov word [eax+2], 0x08
	mov word [eax+4], 0x8e00
	shr ebx, 16
	mov word [eax+6], bx
	add eax, 8
	; int 4
	mov ebx, _int4
	mov word [eax], bx
	mov word [eax+2], 0x08
	mov word [eax+4], 0x8e00
	shr ebx, 16
	mov word [eax+6], bx
	add eax, 8
	; int 5
	mov ebx, _int5
	mov word [eax], bx
	mov word [eax+2], 0x08
	mov word [eax+4], 0x8e00
	shr ebx, 16
	mov word [eax+6], bx
	add eax, 8
	; int 6
	mov ebx, _int6
	mov word [eax], bx
	mov word [eax+2], 0x08
	mov word [eax+4], 0x8e00
	shr ebx, 16
	mov word [eax+6], bx
	add eax, 8
	; int 7
	mov ebx, _int7
	mov word [eax], bx
	mov word [eax+2], 0x08
	mov word [eax+4], 0x8e00
	shr ebx, 16
	mov word [eax+6], bx
	add eax, 8
	; int 8
	mov ebx, _int8
	mov word [eax], bx
	mov word [eax+2], 0x08
	mov word [eax+4], 0x8e00
	shr ebx, 16
	mov word [eax+6], bx
	add eax, 8
;	; int 9
	mov ebx, _int9
	mov word [eax], bx
	mov word [eax+2], 0x08
	mov word [eax+4], 0x8e00
	shr ebx, 16
	mov word [eax+6], bx
	add eax, 8
	; int 10
	mov ebx, _inta
	mov word [eax], bx
	mov word [eax+2], 0x08
	mov word [eax+4], 0x8e00
	shr ebx, 16
	mov word [eax+6], bx
	add eax, 8
;;	; int 11
	mov ebx, _intb
	mov word [eax], bx
	mov word [eax+2], 0x08
	mov word [eax+4], 0x8e00
	shr ebx, 16
	mov word [eax+6], bx
	add eax, 8
;	; int 12
	mov ebx, _intc
	mov word [eax], bx
	mov word [eax+2], 0x08
	mov word [eax+4], 0x8e00
	shr ebx, 16
	mov word [eax+6], bx
	add eax, 8
;	; int 13
	mov ebx, _intd
	mov word [eax], bx
	mov word [eax+2], 0x08
	mov word [eax+4], 0x8e00
	shr ebx, 16
	mov word [eax+6], bx
	add eax, 8
;	; int 14
	mov ebx, _inte
	mov word [eax], bx
	mov word [eax+2], 0x08
	mov word [eax+4], 0x8e00
	shr ebx, 16
	mov word [eax+6], bx
	add eax, 8
;	; int 15 reserved
	add eax, 8
;	;int 16
	mov ebx, _int10
	mov word [eax], bx
	mov word [eax+2], 0x08
	mov word [eax+4], 0x8e00
	shr ebx, 16
	mov word [eax+6], bx
	add eax, 8
;	; int 17
	mov ebx, _int11
	mov word [eax], bx
	mov word [eax+2], 0x08
	mov word [eax+4], 0x8e00
	shr ebx, 16
	mov word [eax+6], bx
	add eax, 8
;	; int 18
	mov ebx, _int12
	mov word [eax], bx
	mov word [eax+2], 0x08
	mov word [eax+4], 0x8e00
	shr ebx, 16
	mov word [eax+6], bx
	add eax, 8
;	; int 19
	mov ebx, _int13
	mov word [eax], bx
	mov word [eax+2], 0x08
	mov word [eax+4], 0x8e00
	shr ebx, 16
	mov word [eax+6], bx
	add eax, 8
	;----------------------------------PIC1------------------------------------
	mov eax,0x1100
;	; int 20 , IRQ0
	mov ebx, _int20
	mov word [eax], bx
	mov word [eax+2], 0x08
	mov word [eax+4], 0x8e00
	shr ebx, 16
	mov word [eax+6], bx
	add eax, 8
	; int 21 , IRQ1
	mov ebx, _int21
	mov word [eax], bx
	mov word [eax+2], 0x08
	mov word [eax+4], 0x8e00
	shr ebx, 16
	mov word [eax+6], bx
	add eax, 8
	; int 22 , IRQ2
	mov ebx, _int22
	mov word [eax], bx
	mov word [eax+2], 0x08
	mov word [eax+4], 0x8e00
	shr ebx, 16
	mov word [eax+6], bx
	add eax, 8
	; int 23 , IRQ3
	mov ebx, _int23
	mov word [eax], bx
	mov word [eax+2], 0x08
	mov word [eax+4], 0x8e00
	shr ebx, 16
	mov word [eax+6], bx
	add eax, 8
	; int 24 , IRQ4
	mov ebx, _int24
	mov word [eax], bx
	mov word [eax+2], 0x08
	mov word [eax+4], 0x8e00
	shr ebx, 16
	mov word [eax+6], bx
	add eax, 8
	; int 25 , IRQ5
	mov ebx, _int25
	mov word [eax], bx
	mov word [eax+2], 0x08
	mov word [eax+4], 0x8e00
	shr ebx, 16
	mov word [eax+6], bx
	add eax, 8
	; int 26 , IRQ6
	mov ebx, _int26
	mov word [eax], bx
	mov word [eax+2], 0x08
	mov word [eax+4], 0x8e00
	shr ebx, 16
	mov word [eax+6], bx
	add eax, 8
	; int 27 , IRQ7
	mov ebx, _int27
	mov word [eax], bx
	mov word [eax+2], 0x08
	mov word [eax+4], 0x8e00
	shr ebx, 16
	mov word [eax+6], bx
	add eax, 8
	;-------------------------PIC2-----------------------;
	mov eax, 0x1180
	; int 30 , IRQ8
	mov ebx, _int30
	mov word [eax], bx
	mov word [eax+2], 0x08
	mov word [eax+4], 0x8e00
	shr ebx, 16
	mov word [eax+6], bx
	add eax, 8
	; int 31 , IRQ9
	mov ebx, _int31
	mov word [eax], bx
	mov word [eax+2], 0x08
	mov word [eax+4], 0x8e00
	shr ebx, 16
	mov word [eax+6], bx
	add eax, 8
	; int 32 , IRQ10
	mov ebx, _int32
	mov word [eax], bx
	mov word [eax+2], 0x08
	mov word [eax+4], 0x8e00
	shr ebx, 16
	mov word [eax+6], bx
	add eax, 8
	; int 33 , IRQ11
	mov ebx, _int33
	mov word [eax], bx
	mov word [eax+2], 0x08
	mov word [eax+4], 0x8e00
	shr ebx, 16
	mov word [eax+6], bx
	add eax, 8
	; int 34 , IRQ12
	mov ebx, _int34
	mov word [eax], bx
	mov word [eax+2], 0x08
	mov word [eax+4], 0x8e00
	shr ebx, 16
	mov word [eax+6], bx
	add eax, 8
	; int 35 , IRQ13
	mov ebx, _int35
	mov word [eax], bx
	mov word [eax+2], 0x08
	mov word [eax+4], 0x8e00
	shr ebx, 16
	mov word [eax+6], bx
	add eax, 8
	; int 36 , IRQ14
	mov ebx, _int36
	mov word [eax], bx
	mov word [eax+2], 0x08
	mov word [eax+4], 0x8e00
	shr ebx, 16
	mov word [eax+6], bx
	add eax, 8
	; int 37 , IRQ15
	mov ebx, _int37
	mov word [eax], bx
	mov word [eax+2], 0x08
	mov word [eax+4], 0x8e00
	shr ebx, 16
	mov word [eax+6], bx
	;int38
	add eax, 8
	mov ebx, _int38
	mov word [eax], bx
	mov word [eax+2], 0x08
	mov word [eax+4], 0x8e00
	shr ebx, 16
	mov word [eax+6], bx

	lidt [IDTR]
	call _delay
	call InitPic
	pop ebx
	pop eax
	
	ret

InitPic
	push eax
	push ebx
	
	mov al, 00010001b	; send ICW1
	out 20h, al
	out 0ah, al
	call _delay

	mov al, 20h		; send ICW2 IRQ0=INT20h
	out 21h, al
	mov al, 30h		; IRQ8 = INT30h
	out 0a1h, al
	call _delay

	mov al, 00000100b	; ICW3 for master, PIC2 connected to pin 2
	out 21h, al
	mov al, 00000010b	; ICW3 for slave, PIC connected to IRQ2 of master
	out 0a1h, al
	call _delay

	mov al, 00000001b	; ICW4 80x86 architecture, manuel EOI
	out 21h, al
	out 0a1h, al
	call _delay

	xor al,al		; send OCW1: enable all interrupts
	out 21h, al
	out 0a1h, al
	call _delay

	pop ebx
	pop eax
	ret

_EOI:
	push eax
	mov al, 20h
	out 20h, al
	pop eax
	ret

_EOI2:
	push eax
	mov al, 20h
	out 0a0h,al
	pop eax
	ret

_EOI12	push eax
	mov al, 20h
	out 0a0h, al
	out 20h, al
	pop eax
	ret

_delay:
	jmp .next
.next:
	ret
;---------------------------------------------------------------------------------
IDTR
	dw 0x800
	dd 0x1000

