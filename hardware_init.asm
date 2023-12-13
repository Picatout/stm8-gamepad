;;
; Copyright Jacques Deschênes 2023  
; This file is part of ntsc_tuto 
;
;     ntsc_tuto is free software: you can redistribute it and/or modify
;     it under the terms of the GNU General Public License as published by
;     the Free Software Foundation, either version 3 of the License, or
;     (at your option) any later version.
;
;     ntsc_tuto is distributed in the hope that it will be useful,
;     but WITHOUT ANY WARRANTY; without even the implied warranty of
;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;     GNU General Public License for more details.
;
;     You should have received a copy of the GNU General Public License
;     along with ntsc_tuto.  If not, see <http://www.gnu.org/licenses/>.
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; hardware initialization
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

;------------------------
; if unified compilation 
; must be first in list 
;-----------------------

    .module HW_INIT 

    .include "config.inc"

STACK_EMPTY=RAM_SIZE-1 
STACK_SIZE=128   
;;-----------------------------------
    .area SSEG (ABS)
;; working buffers and stack at end of RAM. 	
;;-----------------------------------
    .org RAM_SIZE-STACK_SIZE
stack_full:: .ds STACK_SIZE   ; control stack full 
stack_unf: ; stack underflow ; RAM end +1 -> 0x1800


;;--------------------------------------
    .area HOME 
;; interrupt vector table at 0x8000
;;--------------------------------------

    int cold_start			; RESET vector 
	int NonHandledInterrupt ; trap instruction 
	int NonHandledInterrupt ;int0 TLI   external top level interrupt
	int NonHandledInterrupt ;int1 AWU   auto wake up from halt
	int NonHandledInterrupt ;int2 CLK   clock controller
	int NonHandledInterrupt ;int3 EXTI0 gpio A external interrupts
	int NonHandledInterrupt ;int4 EXTI1 gpio B external interrupts
	int NonHandledInterrupt ;int5 EXTI2 gpio C external interrupts
	int NonHandledInterrupt ;int6 EXTI3 gpio D external interrupts
	int NonHandledInterrupt ;int7 EXTI4 gpio E external interrupts
	int NonHandledInterrupt ;int8 beCAN RX interrupt
	int NonHandledInterrupt ;int9 beCAN TX/ER/SC interrupt
	int NonHandledInterrupt ;int10 SPI End of transfer
	int ntsc_sync_interrupt ;int11 TIM1 update/overflow/underflow/trigger/break
	int ntsc_video_interrupt ; int12 TIM1 capture/compare
	int NonHandledInterrupt ;int13 TIM2 update /overflow
	int NonHandledInterrupt ;int14 TIM2 capture/compare
	int NonHandledInterrupt ;int15 TIM3 Update/overflow
	int NonHandledInterrupt ;int16 TIM3 Capture/compare
	int NonHandledInterrupt ;int17 UART1 TX completed
	int NonHandledInterrupt ;int18 UART1 RX full  
	int NonHandledInterrupt ;int19 I2C 
	int NonHandledInterrupt ;int20 UART3 TX completed
	int NonHandledInterrupt ;int21 UART3 RX full
	int NonHandledInterrupt ;int22 ADC2 end of conversion
	int Timer4UpdateHandler ;int23 TIM4 update/overflow ; use to blink tv cursor 
	int NonHandledInterrupt ;int24 flash writing EOP/WR_PG_DIS
	int NonHandledInterrupt ;int25  not used
	int NonHandledInterrupt ;int26  not used
	int NonHandledInterrupt ;int27  not used
	int NonHandledInterrupt ;int28  not used
	int NonHandledInterrupt ;int29  not used


KERNEL_VAR_ORG=4
;--------------------------------------
    .area DATA (ABS)
	.org KERNEL_VAR_ORG 
;--------------------------------------	

ticks: .blkw 1 ; millisecond counter
delay_timer: .blkb 1 
sound_timer: .blkb 1 
; keep the following 3 variables in this order 
acc16:: .blkb 1 ; 16 bits accumulator, acc24 high-byte
acc8::  .blkb 1 ;  8 bits accumulator, acc24 low-byte  
fmstr:: .blkw 1 ; frequency in Mhz of Fmaster
ptr16::  .blkb 1 ; 16 bits pointer , farptr high-byte 
ptr8:   .blkb 1 ; 8 bits pointer, farptr low-byte  
flags:: .blkb 1 ; various boolean flags
seedx: .blkw 1  ; prng seed bits 0..15
seedy: .blkw 1  ; prng seed bits 16..31

; tvout variables 
ntsc_flags: .blkb 1 
ntsc_phase: .blkb 1 ; 
scan_line: .blkw 1 ; video lines {0..262} 

; display variables 
cx: .blkb 1 ; text cursor x coord {0..15} 
cy: .blkb 1 ; text cursor y coord {0..7}

app_variables:
snake_len: .blkb 1 ; snake length 
snake_dir: .blkb 1 ; head direction 
snake_body: .blkw 32 ;  snake rings coords 

; video buffer size=768 bytes 
	.org 0x80 
VBUFF_SIZE=HRES/8*VRES
tv_buffer: .blkb  VBUFF_SIZE


	.area CODE 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; non handled interrupt 
; reset MCU
;;;;;;;;;;;;;;;;;;;;;;;;;;;
NonHandledInterrupt:
	_swreset ; see "inc/gen_macros.inc"

;------------------------------
; TIMER 4 is used to maintain 
; timers and ticks 
; interrupt interval is 1.664 msec 
;--------------------------------
Timer4UpdateHandler:
	clr TIM4_SR 
	_ldxz ticks
	incw x 
	_strxz ticks
; decrement delay_timer and sound_timer on ticks mod 10==0
	ld a,#10
	div x,a 
	tnz a
	jrne 9$
1$:	 
	btjf flags,#F_GAME_TMR,2$  
	dec delay_timer 
	jrne 2$ 
	bres flags,#F_GAME_TMR  
2$:
	btjf flags,#F_SOUND_TMR,9$
	dec sound_timer 
	jrne 9$ 
	bres flags,#F_SOUND_TMR
9$:
	iret 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;    peripherals initialization
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;----------------------------------------
; inialize MCU clock 
; select HSE 
; no CPU divisor 
;----------------------------------------
clock_init:	
	bres CLK_SWCR,#CLK_SWCR_SWIF 
	mov CLK_SWR,#CLK_SWR_HSE  
	btjf CLK_SWCR,#CLK_SWCR_SWIF,. 
	bset CLK_SWCR,#CLK_SWCR_SWEN
2$: 
	clr CLK_CKDIVR   	
	ret

;---------------------------------
; TIM4 is configured to generate an 
; interrupt every 1.66 millisecond 
;----------------------------------
timer4_init:
	bset CLK_PCKENR1,#CLK_PCKENR1_TIM4
	bres TIM4_CR1,#TIM4_CR1_CEN 
	mov TIM4_PSCR,#7 ; Fmstr/128=125000 hertz  
	mov TIM4_ARR,#(256-125) ; 125000/125=1 msec 
	mov TIM4_CR1,#((1<<TIM4_CR1_CEN)|(1<<TIM4_CR1_URS))
	bset TIM4_IER,#TIM4_IER_UIE
	ret

;----------------------------------
; TIMER2 used as audio tone output 
; on port D:2. pin 19 
; channel 3 configured as PWM mode 1 
;-----------------------------------  
timer2_init:
	bset CLK_PCKENR1,#CLK_PCKENR1_TIM2 ; enable TIMER2 clock 
 	mov TIM2_CCMR3,#(6<<TIM2_CCMR3_OCM) ; PWM mode 1 
	mov TIM2_PSCR,#8 ; Ft2clk=fmstr/256=62500 hertz 
	bres TIM2_CR1,#TIM2_CR1_CEN
	bres TIM2_CCER2,#TIM2_CCER2_CC3E
	ret 
 
.if 0
;--------------------------
; set software interrupt 
; priority 
; input:
;   A    priority 1,2,3 
;   X    vector 
;---------------------------
	SPR_ADDR=1 
	PRIORITY=3
	SLOT=4
	MASKED=5  
	VSIZE=5
set_int_priority::
	_vars VSIZE
	and a,#3  
	ld (PRIORITY,sp),a 
	ld a,#4 
	div x,a 
	sll a  ; slot*2 
	ld (SLOT,sp),a
	addw x,#ITC_SPR1 
	ldw (SPR_ADDR,sp),x 
; build mask
	ldw x,#0xfffc 	
	ld a,(SLOT,sp)
	jreq 2$ 
	scf 
1$:	rlcw x 
	dec a 
	jrne 1$
2$:	ld a,xl 
; apply mask to slot 
	ldw x,(SPR_ADDR,sp)
	and a,(x)
	ld (MASKED,sp),a 
; shift priority to slot 
	ld a,(PRIORITY,sp)
	ld xl,a 
	ld a,(SLOT,sp)
	jreq 4$
3$:	sllw x 
	dec a 
	jrne 3$
4$:	ld a,xl 
	or a,(MASKED,sp)
	ldw x,(SPR_ADDR,sp)
	ld (x),a 
	_drop VSIZE 
	ret 
.endif 

;------------------------
; suspend execution 
; input:
;   A     n/60 seconds  
;-------------------------
pause:
	_straz delay_timer 
	bset flags,#F_GAME_TMR 
1$: 	
	btjt flags,#F_GAME_TMR,1$ 
	ret 

;-----------------------
; tone generator 
; Ft2clk=62500 hertz 
; input:
;   A   duration n*10 msec    
;   X   frequency 
;------------------------
FR_T2_CLK=62500
tone:
	pushw y 
	push a 
	ldw y,x 
	ldw x,#FR_T2_CLK 
	divw x,y 
	ld a,xh 
	ld TIM2_ARRH,a 
	ld a,xl 
	ld TIM2_ARRL,a 
	srlw x 
	ld a,xh 
	ld TIM2_CCR3H,a 
	ld a,xl 
	ld TIM2_CCR3L,a 
	bset TIM2_CCER2,#TIM2_CCER2_CC3E
	bset TIM2_CR1,#TIM2_CR1_CEN 
	bset TIM2_EGR,#TIM2_EGR_UG
	pop a 
	_straz sound_timer  
	bset flags,#F_SOUND_TMR 
1$: wfi 
	btjt flags,#F_SOUND_TMR,1$
	bres TIM2_CR1,#TIM2_CR1_CEN 
	bres TIM2_CCER2,#TIM2_CCER2_CC3E
	popw y 
	ret 

;-----------------
; 1Khz beep 
;-----------------
beep:
	ldw x,#1000 ; hertz 
	ld a,#20
	call tone  
	ret 



;------------------------
; reading keypad 
; without debouncing 
; output:
;     A   reading 
;-----------------------
kpad_input:
	ld a,BTN_CROSS_IDR 
	srl a 
	and a,#0x3C 
	push a 
	ld a,BTN_SEL_IDR 
	swap a 
	and a,#3 
	or a,(1,sp)
	xor a,#0x3f 
	_drop 1 
	ret 


;-------------------------
; read keypad
; ouput:
;    A 
;       BTN_A -> bit 0 (1)
;       BTN_B -> bit 1 (2)
;       BTN_LEFT -> bit 2 (4)
;       BTN_RIGHT -> bit 3 (8)
;       BTN_DOWN -> bit 4 (16)
;       BNT_UP -> bit 5  (32)
;-------------------------
	DEBOUNCE=1
	BUTTONS=DEBOUNCE+2
	VAR_SIZE=BUTTONS 
read_keypad:
	pushw x 
	_vars VAR_SIZE
	call kpad_input 
1$:	ld (BUTTONS,sp),a  
    ldw x,ticks 
	addw x,#10 
	ldw (DEBOUNCE,sp),x 	
2$: call kpad_input 
	cp a,(BUTTONS,sp)
	jrne 1$
	ldw x,ticks 
	cpw x,(DEBOUNCE,sp)
	jrne 2$
	_drop VAR_SIZE  
	popw x 
	ret 

;-------------------------------------
;  initialization entry point 
;-------------------------------------
cold_start:
;set stack 
	sim
	ldw x,#STACK_EMPTY
	ldw sp,x
; clear all ram 
0$: clr (x)
	decw x 
	jrne 0$
; disable all peripherals clock 
	clr CLK_PCKENR1 
	clr CLK_PCKENR2 
; activate pull up on all inputs 
; or push pull on output 
	ld a,#255 
	ld PA_CR1,a 
	ld PB_CR1,a 
	ld PC_CR1,a 
	ld PD_CR1,a 
	bset PC_DDR,#7 
	clr PC_ODR
	call clock_init	
	call timer4_init
	call timer2_init
	call ntsc_init ;
	rim ; enable interrupts 
.if WANT_PRNG
	clrw x 
	call set_seed
.endif 	
	jp main ; in tv_term.asm 

