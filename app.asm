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

main:
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
    ldw x,#0xffff 
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
.asciz "QUICK BROWN FOX"
.word quick   
.word 0 

quick:
    call tv_cls 
    ldw y,#qbf 
    call tv_puts 
    call wait_key 
    call wait_key_release 
    ret 

qbf: .asciz "THE QUICK BROWN FOX JUMP OVER THE LAZY DOG."
