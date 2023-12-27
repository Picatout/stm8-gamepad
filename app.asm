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

.if DEBUG 
    CURPOS=1 
    VAR_SIZE=2
dbg_print:
    pushw x 
    _vars VAR_SIZE 
    _ldxz cy 
    ldw (CURPOS,sp),x 
    ldw x,#(7<<8)+8
    _strxz cy 
    _ldxz acc16 
    call put_uint16
    ldw x,(CURPOS,sp)
    _strxz cy 
    _drop VAR_SIZE 
    popw x 
    ret 

print_hex:
	push a 
	swap a 
	call hex_digit 
	pop a 
hex_digit:
	and a,#15
	add a,#'0 
	cp a,#'9+1
	jrmi 1$
	add a,#7 
1$: call tv_putc 
	ret 

.endif 

;---------------------------------------
; move memory block 
; input:
;   X 		destination 
;   Y 	    source 
;   acc16	bytes count 
; output:
;   X       destination 
;--------------------------------------
	INCR=1 ; incrament high byte 
	LB=2 ; increment low byte 
	VSIZE=2
move::
	push a 
	pushw x 
	_vars VSIZE 
	clr (INCR,sp)
	clr (LB,sp)
	pushw y 
	cpw x,(1,sp) ; compare DEST to SRC 
	popw y 
	jreq move_exit ; x==y 
	jrmi move_down
move_up: ; start from top address with incr=-1
	addw x,acc16
	addw y,acc16
	cpl (INCR,sp)
	cpl (LB,sp)   ; increment = -1 
	jra move_loop  
move_down: ; start from bottom address with incr=1 
    decw x 
	decw y
	inc (LB,sp) ; incr=1 
move_loop:	
    _ldaz acc16 
	or a, acc8
	jreq move_exit 
	addw x,(INCR,sp)
	addw y,(INCR,sp) 
	ld a,(y)
	ld (x),a 
	pushw x 
	_ldxz acc16 
	decw x 
	ldw acc16,x 
	popw x 
	jra move_loop
move_exit:
	_drop VSIZE
	popw x 
	pop a 
	ret 	

;--------------------
; fill memory block 
; input: 
;     A   fill value 
;     X   count 
;     Y   addr (incr)
;---------------------
fill:
	ld (y),a 
	incw y 
	decw x 
	jrne fill
	ret 

;--------------------------
; application entry point 
;--------------------------
main:
.if 0
; kpad test 
	call tv_cls 
1$:	call wait_key 
	call print_hex 
	call wait_key_release
	clrw x 
	_strxz cy 
	jra 1$ 
.endif  
    call menu 
    call (x)
    jra main 



;---------------------------
; display list of games
;--------------------------
	GAM_ADR=1
	KPAD=GAM_ADR+16
	SEL=KPAD+1 
	COUNT=SEL+1
	VAR_SIZE=COUNT 
menu:
	_vars VAR_SIZE 
	clr (SEL,sp)
	clr (COUNT,sp)
	ldw x,sp 
	incw x 
	_strxz ptr16 
	call tv_cls  
	ldw y,#prog_list
; build games list on stack     
1$: ld a,(y)
    jreq user_select 
	ld a,(COUNT,sp)
	ld xh,a 
	ld a,#SPACE  
	call select_mark 
	call tv_puts  
	incw y 
	ld a,(COUNT,sp)
	sll a 
	clrw x 
	ld xl,a 
	ld a,(y)
	incw y 
	ld ([ptr16],X),a 
	incw x 
	ld a,(y)
	incw y 
	ld ([ptr16],x),a
	inc (COUNT,sp)
	jra 1$ 
; display selection cursor and 
; wait for user input    
user_select:
    ldw x,#0x200 
	call wait_key_release
	ld a,(SEL,sp)
	ld xh,a 
	ld a,#'>
	call select_mark
	call wait_key 
	ld (KPAD,sp),a
	ld a,(SEL,sp)
	ld xh,a
	ld a,#SPACE 
	call select_mark
	ld a,(KPAD,sp)
	and a,#BTN_DOWN ; down button? 
	jreq 4$ 
; down button 
	ld a,(SEL,sp)
	inc a 
	cp a,(COUNT,sp)
	jreq user_select
	ld (SEL,sp),a 
	jra user_select 
; up button ?
4$: 
	ld a,(KPAD,sp)
	and a,#BTN_UP
	jreq 6$ 
	ld a,(SEL,sp)
	dec a 
	jrmi user_select 
	ld (SEL,sp),a 
	jra user_select 
6$:
	ld a,(KPAD,sp)
	and a,#BTN_A
	jreq user_select
	call wait_key_release 
	ld a,(SEL,sp)
	sll a 
	clrw x 
	ld xl,a 
	ldw x,([ptr16],x)
	_drop VAR_SIZE 
	ret 

;-------------------------------
; display or erase 
; selection marker 
; input:
;    A    char to diplay 
;    XH   selected item {0..7}
;------------------------------
select_mark:
    push a 
    clr a 
    ld xl,a 
	_strxz cy 
    pop a 
	call tv_putc 
	ret 


prog_list:
.asciz "SNAKE"
.word snake
.asciz "FALL"
.word fall
.asciz "QUICK BROWN FOX"
.word quick
.asciz "TV NOISE TEST"
.word noise_test    
.word 0 

noise_test:
	call tv_cls 
	push #23
1$:	ldw y,#h 
	call tv_puts 
	dec (1,sp)
	jrne 1$
	_drop 1 
	call wait_key 
	call wait_key_release 
	ret 
h: .asciz "HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH"	

quick:
    call tv_cls 
    ldw y,#qbf 
    call tv_puts 
    call wait_key 
    call wait_key_release 
    ret 

qbf: .asciz "THE QUICK BROWN FOX JUMP OVER THE LAZY DOG.\r"
