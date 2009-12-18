; Divide Error
_int0:
	mov byte [0xb8050], 'D'
	mov byte [0xb8051], 0x47
	mov byte [0xb8052], '0'
	mov byte [0xb8053], 0x47
	hlt
	iret
; Debug
_int1:
	mov byte [0xb8050], 'D'
	mov byte [0xb8051], 0x47
	mov byte [0xb8052], 'B'
	mov byte [0xb8053], 0x47
	hlt
	iret
; NMI interrupt
_int2:
	mov byte [0xb8050], 'N'
	mov byte [0xb8051], 0x47
	mov byte [0xb8052], 'M'
	mov byte [0xb8053], 0x47
	hlt
	iret
; Breakpoint
_int3:
	mov byte [0xb8050], 'B'
	mov byte [0xb8051], 0x47
	mov byte [0xb8052], 'P'
	mov byte [0xb8053], 0x47
	hlt
	iret
; Overflow
_int4:
	mov byte [0xb8050], 'O'
	mov byte [0xb8051], 0x47
	mov byte [0xb8052], 'V'
	mov byte [0xb8053], 0x47
	hlt
	iret
; BOUND Range Exceeded
_int5:
	mov byte [0xb8050], 'B'
	mov byte [0xb8051], 0x47
	mov byte [0xb8052], 'R'
	mov byte [0xb8053], 0x47
	hlt
	iret
; Invalid Opcode
_int6:
	mov byte [0xb8050], 'I'
	mov byte [0xb8051], 0x47
	mov byte [0xb8052], 'n'
	mov byte [0xb8053], 0x47
	mov byte [0xb8054], 'v'
	mov byte [0xb8055], 0x47
	mov byte [0xb8056], 'a'
	mov byte [0xb8057], 0x47
	mov byte [0xb8058], 'l'
	mov byte [0xb8059], 0x47
	mov byte [0xb805a], 'i'
	mov byte [0xb805b], 0x47
	mov byte [0xb805c], 'd'
	mov byte [0xb805d], 0x47
	mov byte [0xb805e], ' '
	mov byte [0xb805f], 0x47
	mov byte [0xb8060], 'O'
	mov byte [0xb8061], 0x47
	mov byte [0xb8062], 'p'
	mov byte [0xb8063], 0x47
	mov byte [0xb8064], 'c'
	mov byte [0xb8065], 0x47
	mov byte [0xb8066], 'o'
	mov byte [0xb8067], 0x47
	mov byte [0xb8068], 'd'
	mov byte [0xb8069], 0x47
	mov byte [0xb806a], 'e'
	mov byte [0xb806b], 0x47
	hlt
	iret
; Device Not Available
_int7:
	mov byte [0xb8050], 'N'
	mov byte [0xb8051], 0x47
	mov byte [0xb8052], 'A'
	mov byte [0xb8053], 0x47
	hlt
	iret
; Double Fault
_int8:
	mov byte [0xb8050], 'D'
	mov byte [0xb8051], 0x47
	mov byte [0xb8052], 'F'
	mov byte [0xb8053], 0x47
	hlt
	iret
; Coprocessor Segment Overrun
_int9:
	mov byte [0xb8050], 'C'
	mov byte [0xb8051], 0x47
	mov byte [0xb8052], 'S'
	mov byte [0xb8053], 0x47
	hlt
	iret
; Invalid TSS
_inta:
	mov byte [0xb8050], 'T'
	mov byte [0xb8051], 0x47
	mov byte [0xb8052], 'S'
	mov byte [0xb8053], 0x47
	hlt
	iret
; Segment Not Present
_intb:
	mov byte [0xb8050], 'S'
	mov byte [0xb8051], 0x47
	mov byte [0xb8052], 'P'
	mov byte [0xb8053], 0x47
	hlt
	iret
; Stack-Segment Fault
_intc:
	mov byte [0xb8050], 'S'
	mov byte [0xb8051], 0x47
	mov byte [0xb8052], 'T'
	mov byte [0xb8053], 0x47
	hlt
	iret
; General Protaction
_intd:
	mov byte [0xb8050], 'G'
	mov byte [0xb8051], 0x47
	mov byte [0xb8052], 'P'
	mov byte [0xb8053], 0x47
	hlt
	iret
; Page Fault
_inte:
	mov byte [0xb8050], 'P'
	mov byte [0xb8051], 0x47
	mov byte [0xb8052], 'F'
	mov byte [0xb8053], 0x47
	hlt
	iret
; reserved
;_int15:
;	hlt
;	iret
; Floating-Point Error
_int10:
	mov byte [0xb8050], 'F'
	mov byte [0xb8051], 0x47
	mov byte [0xb8052], 'E'
	mov byte [0xb8053], 0x47
	hlt
	iret
; Alignment Check
_int11:
	mov byte [0xb8050], 'A'
	mov byte [0xb8051], 0x47
	mov byte [0xb8052], 'C'
	mov byte [0xb8053], 0x47
	hlt
	iret
; Machine Check
_int12:
	mov byte [0xb8050], 'M'
	mov byte [0xb8051], 0x47
	mov byte [0xb8052], 'C'
	mov byte [0xb8053], 0x47
	hlt
	iret
; Streaming SIMD Extensions
_int13:
	mov byte [0xb8050], 'S'
	mov byte [0xb8051], 0x47
	mov byte [0xb8052], 'E'
	mov byte [0xb8053], 0x47
	hlt
	iret
