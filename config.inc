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

; master clock frequency in hz 
	FMSTR=16000000 


WANT_PRNG=1 ; to have prng generator 

RX_QUEUE_SIZE=16
TIB_SIZE=40

SOUND_PORT=PD_BASE 
SOUND_BIT=2 


; navigation buttons 
BTN_CROSS_PORT=PD_BASE 
BTN_CROSS_IDR=PD_IDR
BIT_LEFT=3
BIT_RIGHT=4
BIT_DOWN=5
BIT_UP=6 
; selection buttons 
BTN_SEL_PORT=PC_BASE 
BTN_SEL_IDR=PC_IDR 
BIT_A=4
BIT_B=5

BTN_A=1 
BTN_B=2
BTN_LEFT=4 
BTN_RIGHT=8
BTN_DOWN=16 
BTN_UP=32



	.include "inc/ascii.inc"
	.include "inc/stm8s103f3.inc"
	.include "inc/stm8s103f3_config.inc" 
	.include "inc/gen_macros.inc" 
	.include "app_macros.inc" 




