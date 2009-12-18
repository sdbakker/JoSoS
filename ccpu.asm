%include "jos32struc.inc"
EXTERN jos_stc
GLOBAL _check_vendor
GLOBAL _check_model
GLOBAL _check_mhz

%include "ptable.inc"
_check_vendor:
	push eax
	push ebx
	push ecx
	push edx

	xor eax, eax
	cpuid
	mov [GetSTC_JOS32(Vendor)], ebx
	mov [GetSTC_JOS32(Vendor)+4], edx
	mov [GetSTC_JOS32(Vendor)+8], ecx
	mov byte [GetSTC_JOS32(Vendor)+12],0 
	pop edx
	pop ecx
	pop ebx
	pop eax
	ret


_check_model:
	push eax
	push ebx
	push ecx
	push edx
	
	mov eax, 0x01
	cpuid

	shr eax, 4
	cmp eax, 0x048
	je .p9
	cmp eax, 0x65
	je .p21
	cmp eax, 0x66
	je .p22
	cmp eax, 0x67
	je .p23
	cmp eax, 0x68
	je .p24
	jmp .done

	.p9
	mov dword [GetSTC_JOS32(model_adr)], p9
	jmp .done
	.p21
	mov dword [GetSTC_JOS32(model_adr)], p21
	jmp .done
	.p22
	mov dword [GetSTC_JOS32(model_adr)], p22
	jmp .done
	.p23
	mov dword [GetSTC_JOS32(model_adr)], p23
	jmp .done
	.p24
	mov dword [GetSTC_JOS32(model_adr)], p24
	jmp .done

	.done
	pop edx
	pop ecx
	pop ebx
	pop eax
	ret


_check_mhz:


ret
