%ifndef __jos32struc__
%define __jos32struc__

struc	STC_JOS32
	stc_dummy:	resb 1
	Vendor:		resb 13
	model_adr:	resd 1  
	Vid_cur_X:	resb 1
	Vid_cur_Y:	resb 1
	Vid_cur_scr_X:	resb 1
	Vid_cur_scr_Y:	resb 1
	ticks:		resd 1
	prev_ticks:	resd 1
endstruc

%define GetSTC_JOS32(item) jos_stc + item
%endif
