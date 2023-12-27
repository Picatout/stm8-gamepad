;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  configuration parameters 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;-----------------------
;  version  
;  information 
;-----------------------
	MAJOR=1
	MINOR=1
	REV=0

; set to 1 to add dbg_print code 
DEBUG=1

; master clock frequency in hz 
	FMSTR=16000000 

SOUND_PORT=PD_BASE 
SOUND_BIT=(0)


; navigation buttons 
KPAD_PORT=PB_BASE 
KPAD_IDR=PB_IDR
BIT_A=(5)
BIT_B=(4)
BIT_LEFT=(0)
BIT_RIGHT=(2)
BIT_DOWN=(1)
BIT_UP=(3)
BTN_MASK=0x3f

BTN_A=(1<<BIT_A) 
BTN_B=(1<<BIT_B)
BTN_LEFT=(1<<BIT_LEFT) 
BTN_RIGHT=(1<<BIT_RIGHT)
BTN_DOWN=(1<<BIT_DOWN) 
BTN_UP=(1<<BIT_UP)


	.include "inc/ascii.inc"
	.include "inc/stm8s207.inc"
	.include "inc/gen_macros.inc" 
	.include "app_macros.inc" 




