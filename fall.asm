;;
; Copyright Jacques Deschênes 2023,2024  
; This file is part of stm8-gamepad
;
;     stm8-gamepadis free software: you can redistribute it and/or modify
;     it under the terms of the GNU General Public License as published by
;     the Free Software Foundation, either version 3 of the License, or
;     (at your option) any later version.
;
;     stm8-gamepadis distributed in the hope that it will be useful,
;     but WITHOUT ANY WARRANTY; without even the implied warranty of
;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;     GNU General Public License for more details.
;
;     You should have received a copy of the GNU General Public License
;     along with ntsc_tuto.  If not, see <http://www.gnu.org/licenses/>.
;;

;-------------------
; FALL 
; TRETIS  inspired  
;-------------------

TETRA_WIDTH=8 ; 8x8 pixels tetrahedrons blocks 
WELL_WIDTH=TETRA_WIDTH*10
WELL_DEPTH=TETRA_WIDTH*22
 
    .area G_DATA 

    .area CODE 
; sprites 
I0: .byte 4,1,0xff,0xff,0xff,0xff; horizontal I 
I1: .byte 1,4,0xff,0xff,0xff,0xff ; vertical I 
SQUARE: .byte 2,2,0xff,0xff,0xff,0xff 
T0: .byte 6,4,0xfc,0xfc,0x30,0x30 ; normal T 
T1: .byte 4,6,0x30,0x30,0xf0,0xf0,0x30,0x30 ; T rotated right  
T2: .byte 4,6,0xc0,0xc0,0xf0,0xf0,0xc0,0xc0 ; T rotated left 
T3: .byte 6,4,0x30,0x30,0xf0,0xf0 ; T upside down 
L0: .byte 6,4,0xfc,0xfc,0xc0,0xc0 ; L rotated right 
L1: .byte 4,6,0xf0,0xf0,0x30,0x30,0x30,0x30 ; L upside down 
L2: .byte 6,4,0xc,0xc,0xfc,0xfc ; L rotated left 
L3: .byte 4,6,0xc0,0xc0,0xc0,0xfc,0xfc ; L upside 
J0: .byte 6,4,0xfc,0xfc,0xc,0xc ; J rotated left 
J1:  .byte 4,6,0xc0,0xc0,0xc0,0xc0,0xfc,0xfc ; J upside 
J2: .byte 6,4,0xc0,0xc0,0xfc,0xfc ; j rotated right 
J3: .byte 4,6,0xfc,0xfc,0xc,0xc,0xc,0xc  ; j upside down 
Z0: .byte 6,4,0xf0,0xf0,0x3c,0x3c ; 
Z1: .byte 4,6,0x30,0x30,0x3c,0x30,0xc0,0xc0 
S0: .byte 6,4,0x3c,0x3c,0xf0,0xf0 
S1: .byte 4,6,0xc0,0xc0,0xf0,0xf0,0xc,0xc 

;--------------------
; draw the well in 
; wich tetrahedrons 
; falls.
;--------------------
draw_well:
; top side 
    ldw x,#(1<<8)+WELL_WIDTH+1
    ldw y,#((VRES-WELL_DEPTH)<<8)+(VRES-WELL_DEPTH)
    call line
; left side 
    ldw x,#(0<<8)+0
    ldw y,#((VRES-WELL_DEPTH)<<8)+VRES
    call line
;bottom  
    ldw x,#(1<<8)+WELL_WIDTH+1 
    ldw y,#((VRES-1)<<8)+VRES-1
    call line 
;right side
    ldw x,#((WELL_WIDTH+1)<<8)+WELL_WIDTH+1
    ldw y,#((VRES-WELL_DEPTH)<<8)+VRES
    call line 
    ret 

;-------------------------
; initialize game 
;-------------------------
fall_init:
    call tv_cls  
    ldw y,#fall_name
    ldw x,#(10<<8)+13
    _strxz cy 
    call tv_puts 
    ldw x,#(11<<8)+6
    _strxz cy 
    ldw y,#name_in_length
    call tv_puts
    ld a,#2
    call roll_up
    call tv_cls 
    call draw_well 
    ldw y,#korobeniki
    call tune
    ldw x,#255 
    call wait_key_release 
    ret 

fall:
    call fall_init
    call wait_key 
    ret 

name_in_length:
.asciz "Ce n'est pas TETRIS (R)." 

korobeniki:
    _note MI4,HALF+QUARTER
    _note SOLD4,QUARTER
    _note SI4,HALF 
    _note SOL4,QUARTER
    _note MI4,QUARTER 

    _note LA4,HALF+QUARTER 
    _note DOD5,QUARTER 
    _note MI5,HALF 
    _note RE5,QUARTER 
    _note DO5,QUARTER 
    
    _note SI4,HALF+QUARTER 
    _note DO5,QUARTER 
    _note RE5,HALF 
    _note MI5,HALF 

    _note DO5,HALF 
    _note LA4, HALF 
    _note LA4, WHOLE 

    _note FA5, HALF+QUARTER 
    _note SOL5, QUARTER 
    _note LA5, HALF 
    _note SOL5, QUARTER 
    _note FA5, QUARTER 

    _note MI5, HALF+QUARTER 
    _note FA5, QUARTER 
    _note MI5, HALF 
    _note RE5, QUARTER
    _note DO5, QUARTER 

    _note SI4, HALF+QUARTER 
    _note DO5, QUARTER 
    _note RE5, HALF 
    _note MI5, HALF 

    _note DO5, HALF 
    _note LA4, HALF 
    _note LA4, WHOLE 

    _note 0,0

