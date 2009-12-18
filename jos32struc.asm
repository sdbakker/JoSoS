%include "jos32struc.inc"
GLOBAL jos_stc

jos_stc: istruc STC_JOS32
	at Vid_cur_X,		db 0
	at Vid_cur_Y,		db 0
	at ticks,		dd 0
	at prev_ticks,		dd 0
iend 
