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

;------------------------
; sound generation
;------------------------

    .area CODE 

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


;---------------------------
;  scale 
;---------------------------
DO3=262
DOD3=277 
RE=294
RED3=311 
MI3=330 
FA3=349 
FA3D=370 
SOL3=392
SOLD3=415
LA3=440
LAD3=466
SI3=494
DO4=523
DOD4=554
RE4=587
RED4=622
MI4=659
FA4=698
FAD4=740
SOL4=784
SOLD4=831
LA4=880
LAD4=932
SI4=988
DO5=1046
DOD5=1109
RE5=1175
RED5=1244 
MI5=1318
FA5=1397
FAD5=1480
SOL5=1568
SOLD5=1661
LA5=1760
LAD5=1865
SI5=1975

;--------------------
; notes duration 
;-------------------
WHOLE=60
HALF=30
QUARTER=15
HEIGHT=7


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
2$:	
    call tone
    ld a,#4
    call pause  
	call kpad_input 
    jrne 9$
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

;---------------------------
; sound rapidly increasing 
; in frequency 
;---------------------------
laser: 
	ldw x,#200 
	pushw x 
1$:	ld a,#1 
	call tone 
	ldw x,(1,sp)
	ld a,#8
	div x,a 
	addw x,(1,sp)
	ldw (1,sp),x 
	cpw x,#5000
	jrmi 1$
	_drop 2	
	ret 

;---------------------------
; dropping tonality 
;-------------------------
drop:
	ldw x,#5000
	pushw x 
1$: ld a,#1 
	call tone 
	ldw x,(1,sp)
	ld a,#8 
	div x,a 
	subw x,(1,sp)
	negw x 
	ldw (1,sp),x 
	cpw x,#200 
	jrpl 1$ 
	_drop 2
	ret 
	