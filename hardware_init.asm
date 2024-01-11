;;
; Copyright Jacques Deschênes 2023,2024  
; This file is part of stm8-gamepad
;
;     stm8-gamepad is free software: you can redistribute it and/or modify
;     it under the terms of the GNU General Public License as published by
;     the Free Software Foundation, either version 3 of the License, or
;     (at your option) any later version.
;
;     stm8-gamepad is distributed in the hope that it will be useful,
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
; video buffe
VBUFF_SIZE=HRES*VRES/8 ; 200*192/8=4800 bytes 
    .org RAM_SIZE-STACK_SIZE-VBUFF_SIZE
tv_buffer: .blkb  VBUFF_SIZE
; stack at end of RAM 
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
.if DEBUG 
.if NUCLEO
	int UartRxHandler       ; int21 UART3 RX full 
.else 
	int NonHandledInterrupt ;int21 UART3 RX full
.endif ;; NUCLEO
.else 
	int NonHandledInterrupt ;int21 UART3 RX full
.endif ;; DEBUG 	
	int NonHandledInterrupt ;int22 ADC2 end of conversion
	int NonHandledInterrupt ;int23 TIM4 update$overflow 
	int NonHandledInterrupt ;int24 flash writing EOP/WR_PG_DIS
	int NonHandledInterrupt ;int25  not used
	int NonHandledInterrupt ;int26  not used
	int NonHandledInterrupt ;int27  not used
	int NonHandledInterrupt ;int28  not used
	int NonHandledInterrupt ;int29  not used


SYS_VAR_SIZE=32 
KERNEL_VAR_ORG=256-SYS_VAR_SIZE 
;--------------------------------------
    .area DATA (ABS)
	.org KERNEL_VAR_ORG 
;--------------------------------------	

ticks: .blkw 1 ; 2 millisecond counter
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
cy: .blkb 1 ; text cursor y coord {0..7} 
cx: .blkb 1 ; text cursor y coord {0..15}

.if NUCLEO 
.if DEBUG 
RX_QUEUE_SIZE=8 
rx1_head: .blkb 1 
rx1_tail: .blkb 1 
rx1_queue: .blkb 8 
.endif ;; DEBUG 
.endif ;; NUCLEO 

	.area CODE 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; non handled interrupt 
; reset MCU
;;;;;;;;;;;;;;;;;;;;;;;;;;;
NonHandledInterrupt:
	_swreset ; see "inc/gen_macros.inc"

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

;----------------------------------
; TIMER3 used as audio tone output 
; on port D:2. pin 27
; channel 3 configured as PWM mode 1 
;-----------------------------------  
timer3_init:
	bset CLK_PCKENR1,#CLK_PCKENR1_TIM3 ; enable TIMER3 clock 
 	bset SOUND_PORT+GPIO_DDR,#SOUND_BIT
	mov TIM3_CCMR2,#(6<<TIM3_CCMR2_OC2M) ; PWM mode 1 
	mov TIM3_PSCR,#8 ; Ft2clk=fmstr/256=62500 hertz 
	bres TIM3_CR1,#TIM3_CR1_CEN
	bres TIM3_CCER1,#TIM3_CCER1_CC2E
	ret 
 
.if 0
;--------------------------
; set software interrupt 
; priority 
; input:
;   A    priority 1,2,3 
;   X    vector# 
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
; select ITC_SPRX register 
	ld a,#4 
	div x,a 
	sll a  ; slot*2 
	ld (SLOT,sp),a
	addw x,#ITC_SPR1 
	ldw (SPR_ADDR,sp),x 
; build mask
	ldw x,#0xfffc ; slot 0 mask 	
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
	tnz (SLOT,sp)
	jreq 4$
3$:	sll a  
	dec (SLOT,sp) 
	jrne 3$
4$:	 
	or a,(MASKED,sp)
	ldw x,(SPR_ADDR,sp)
	ld (x),a 
	_drop VSIZE 
	ret 
.endif 

;------------------------
; suspend execution 
; input:
;   A     16.7*n msec   
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
;   A   duration 16.7*n msec    
;   X   frequency 
;------------------------
FR_T3_CLK=62500
tone:
	pushw y 
	push a 
	ldw y,x 
	ldw x,#FR_T3_CLK 
	divw x,y 
	ld a,xh 
	ld TIM3_ARRH,a 
	ld a,xl 
	ld TIM3_ARRL,a 
	srlw x 
	ld a,xh 
	ld TIM3_CCR2H,a 
	ld a,xl 
	ld TIM3_CCR2L,a 
	bset TIM3_CCER1,#TIM3_CCER1_CC2E
	bset TIM3_CR1,#TIM3_CR1_CEN 
	bset TIM3_EGR,#TIM3_EGR_UG
	pop a 
	_straz sound_timer  
	bset flags,#F_SOUND_TMR 
1$:  
	btjt flags,#F_SOUND_TMR,1$
	bres TIM3_CR1,#TIM3_CR1_CEN 
	bres TIM3_CCER1,#TIM3_CCER1_CC2E
	popw y 
	ret 

;-----------------
; 1Khz beep 
;-----------------
beep:
	push a 
	pushw x 
	ldw x,#1000 ; hertz 
	ld a,#8
	call tone
	popw x 
	pop a   
	ret 

	.macro _note  f,d 
	.word f 
	.byte d 
	.endm 
;-----------------------
; play a tune 
; struct {
;	uint16t frequency 
;	utin86  duration 60*n msec 
;} note_t 
; score: note[,note],0 
; input:
;   Y   score_list 
;-----------------------
tune:
	ldw x,y
	ldw x,(x)
	ld a,(2,y)
	jreq 9$
	tnzw x 
	jrne 2$
	call pause 
	addw y,#3
	jra tune  
2$:	call tone 
	addw y,#3
	jra tune  
9$:
	ret 

;------------------------
; generate white noise 
; input:
;    A  duration 60*A msec.
;-------------------------- 
noise:
	pushw x
	_straz sound_timer 
	push #0  
	bset flags,#F_SOUND_TMR
1$: call prng
	ld a,#16 
	ld (1,sp),a  
2$:	sllw x 
	bccm SOUND_PORT,#SOUND_BIT
	ld a,#10 
4$:	dec a 
	jrne 4$
	dec (1,sp)
	jrne 2$  
	btjt flags,#F_SOUND_TMR,1$
	_drop 1 
	popw x 
	ret 

;------------------------
; reading keypad 
; without debouncing 
; output:
;     A   reading 
;-----------------------
kpad_input:
	ld a,KPAD_IDR 
	and a,#BTN_MASK 
	xor a,#BTN_MASK  
	ret 


;-------------------------
; read keypad
; ouput:
;    A 
;       BTN_A -> bit 0 (1)
;       BTN_B -> bit 3 (8)
;       BTN_LEFT -> bit 4 (16)
;       BTN_RIGHT -> bit 5 (32)
;       BTN_DOWN -> bit 6 (64)
;       BNT_UP -> bit 7  (128)
;    Z   set no key 
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
	addw x,#1
	ldw (DEBOUNCE,sp),x 	
2$: call kpad_input 
	cp a,(BUTTONS,sp)
	jrne 1$
	ldw x,ticks 
	cpw x,(DEBOUNCE,sp)
	jrne 2$
	_drop VAR_SIZE  
	popw x
	tnz a 
	ret 

;----------------------------
; wait until key pressed 
; output:
;    A    key
;----------------------------
wait_key:
	call read_keypad 
	jreq wait_key
	ret 

;--------------------------
; wait for buttons released 
; but no more than 100msec
; input:
;    X   maximum delay, x/60 sec 
;--------------------------
    DLY=1
    VAR_SIZE=2
wait_key_release:
    _vars VAR_SIZE
    addw x,ticks
	ldw (DLY,sp),x 
1$: 
    ldw x,ticks 
    cpw x,(DLY,sp)
    jrpl 9$     
    call kpad_input
    jrne 1$ 
9$:
    _drop VAR_SIZE 
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
	ld PE_CR1,a 
	ld PF_CR1,a 
	ld PG_CR1,a 
	ld PH_CR1,a 
	ld PI_CR1,a 
	call clock_init	
	call timer3_init
.if DEBUG 
.if NUCLEO
	call uart_init
	call uart_cls 
.endif ;; NUCLEO  
.endif ;; DEBUG 
	call ntsc_init ;
	rim ; enable interrupts 
	clrw x 
	call set_seed
4$:
	jp main ; in tv_term.asm 

