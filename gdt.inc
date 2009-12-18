;global descriptor table
 	null_gdt	equ 00h
	kernelc_gdt	equ 08h
	kerneld_gdt	equ 10h


 ; null selector 
gdt 	
gdt_null:
	dw 0, 0, 0, 0
 ;4GB Code Read/Execute
system32_code:
	dw 0xffff
	dw 0
	db 0
	db 10011010b
	db 11001111b
	db 0
;4GB data Read/Write
system32_data:
	dw 0xffff
	dw 0
	db 0
	db 10010010b
	db 11001111b
	db 0
gdt_end

gdtptr 	dw gdt-gdt_end-1
	dd 0x0 ; base (physical address)
