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

DEBUG=1 ; set to 0 for final version 

WANT_PRNG=1 ; to have prng generator 

WANT_TERMINAL=1 ; to have support for usart terminal  

RX_QUEUE_SIZE=16
TIB_SIZE=40

SOUND_PORT=PD_BASE 
SOUND_BIT=2 


; navigation buttons 
BTN_CROSS_PORT=PD_BASE 
BTN_CROSS_IDR=PD_IDR
BTN_LEFT=3
BTN_RIGHT=4
BTN_DOWN=5
BTN_UP=6 
; selection buttons 
BTN_SEL_PORT=PB_BASE 
BTN_SEL_IDR=PB_IDR 
BTN_SEL_A=4
BTN_SEL_B=5




	.include "inc/ascii.inc"
	.include "inc/stm8s103f3.inc"
	.include "inc/stm8s103f3_config.inc" 
	.include "inc/gen_macros.inc" 
	.include "app_macros.inc" 




