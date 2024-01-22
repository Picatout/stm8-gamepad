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
; block dimensions
DX=4
DY=6 
BLOCK_WIDTH=4 
BLOCK_HEIGHT=6 

; well dimensions and position 
WELL_WIDTH=BLOCK_WIDTH*10+1
WELL_HEIGHT=BLOCK_HEIGHT*22+1
WELL_BOTTOM=VRES-BLOCK_HEIGHT  
WELL_TOP=WELL_BOTTOM-WELL_HEIGHT-1
WELL_LEFT=(HRES-WELL_WIDTH)/2
WELL_RIGHT=WELL_LEFT+WELL_WIDTH 
; next tetramino box dimensions and position 
NEXT_WIDTH=4*BLOCK_WIDTH+4
NEXT_HEIGHT=4*BLOCK_HEIGHT+4
NEXT_LEFT=WELL_RIGHT+2 
NEXT_TOP=WELL_TOP 
NEXT_COORDS=((NEXT_TOP+2)<<8)+NEXT_LEFT+2

    .area G_DATA 
    .org 4 

lines_dropped: .blkw 1 ; number of lines dropped
fall_score: .blkw 1 ; score 
cur_tetra: .blkb 1  ; current tetra falling ; {0..6}
next_tetra: .blkb 1 ; next tetra to fall {0..6} 
tetra_rot: .blkb 1 ;tetra rotation {0..3}
tetra_y: .blkb 1 ; current tetra y coord 
tetra_x: .blkb 1 ; current tetra x coord 
top_y:  .blkb 1 ; top tetra y coord 
fall_dly: .blkb 1 ; falling speed delay 

    .area CODE 
; basic sprite 

TBLOCK: .byte 0xF0,0xF0,0xF0,0xF0,0xF0,0xF0


; sprites 
; list of BLOCK with relative coordinate to top left corner.
; last byte is sprite width  

; tetramino building macro  
    .macro _rpos x,y 
    .word (y<<8)+x 
    .endm 

; list of tetraminos in all rotations 
; horizontal I
I0: 
_rpos 0,0 
_rpos DX,0
_rpos 2*DX,0
_rpos 3*DX,0
.byte 4*BLOCK_WIDTH ; tetramino width  
; vertical I 
I1: ; vertical I 
_rpos 0,0 
_rpos 0,DY 
_rpos 0,2*DY 
_rpos 0,3*DY
.byte BLOCK_WIDTH ; width  
; square 
SQR: 
_rpos 0,0 
_rpos DX,0
_rpos 0,DY 
_rpos DX,DY 
.byte 2*BLOCK_WIDTH 
; T in upside position 
T0: 
_rpos 0,0 
_rpos DX,0 
_rpos 2*DX,0 
_rpos DX,DY
.byte 3*BLOCK_WIDTH  
; T 90deg. right 
T1: 
_rpos DX,0 
_rpos 0,DY 
_rpos DX,DY 
_rpos DX,2*DY 
.byte 2*BLOCK_WIDTH
; T upside down 
T2: 
_rpos DX,0 
_rpos 0,DY 
_rpos DX,DY 
_rpos 2*DX,DY 
.byte 3*BLOCK_WIDTH 
; T 90deg. left 
T3: 
_rpos 0,0 
_rpos 0,DY 
_rpos DX,DY 
_rpos 0,2*DY
.byte 2*BLOCK_WIDTH  
; L upside 
L0:
_rpos 0,0 
_rpos 0,DY 
_rpos 0,2*DY 
_rpos DX,2*DY
.byte 2*BLOCK_WIDTH  
; L 90deg. right 
L1:
_rpos 0,0 
_rpos DX,0 
_rpos 2*DX,0 
_rpos 0,DY
.byte 3*BLOCK_WIDTH 
; L upside down 
L2:
_rpos 0,0
_rpos DX,0 
_rpos DX,DY 
_rpos DX,2*DY
.byte 2*BLOCK_WIDTH  
; L 90deg. LEFT  
L3:
_rpos 2*DX,0
_rpos 0,DY 
_rpos DX,DY 
_rpos 2*DX,DY
.byte 3*BLOCK_WIDTH  
; J upside position 
J0: 
_rpos DX,0
_rpos DX,DY 
_rpos 0,2*DY 
_rpos DX,2*DY
.byte 2*BLOCK_WIDTH  
; J 90deg. right 
J1:
_rpos 0,0 
_rpos 0,DY 
_rpos DX,DY 
_rpos 2*DX,DY
.byte 3*BLOCK_WIDTH  
; J upside down 
J2:
_rpos 0,0 
_rpos DX,0
_rpos 0,DY
_rpos 0,2*DY
.byte 2*BLOCK_WIDTH  
; J 90deg left 
J3:
_rpos 0,0
_rpos DX,0 
_rpos 2*DX,0 
_rpos 2*DX,DY
.byte 3*BLOCK_WIDTH   
; Z upside 
Z0:
_rpos 0,0 
_rpos DX,0 
_rpos DX,DY 
_rpos 2*DX,DY  
.byte 3*BLOCK_WIDTH 
; Z 90deg. rotation 
Z1:
_rpos DX,0 
_rpos 0,DY 
_rpos DX,DY 
_rpos 0,2*DY
.byte 2*BLOCK_WIDTH  
; S upside 
S0:
_rpos DX,0
_rpos 2*DX,0
_rpos 0,DY 
_rpos DX,DY
.byte 3*BLOCK_WIDTH  
; S 90deg. rotation 
S1:
_rpos 0,0 
_rpos 0,DY 
_rpos DX,DY 
_rpos DX,2*DY 
.byte 2*BLOCK_WIDTH 

; list of tetraminos in all rotation
tetra_all:  
I_TETRA: .word I0,I1,I0,I1 
SQR_TETRA: .word SQR,SQR,SQR,SQR 
T_TETRA: .word T0,T1,T2,T3 
L_TETRA: .word L0,L1,L2,L3 
J_TETRA: .word J0,J1,J2,J3 
S_TETRA: .word S0,S1,S0,S1 
Z_TETRA: .word Z0,Z1,Z0,Z1 

;-------------------------
; theme tune 
; Russian folk song 
;-------------------------
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

;-------------------------
; draw tetramino 
; input:
;    X  position {xl,xh}
;    Y  tetra pointer 
;-------------------------
    TPOS=1
    TLIST=TPOS+2
    BCNT=TLIST+2
    COLLIDED=BCNT+1
    VAR_SIZE=COLLIDED 
draw_tetra:
    push #0 ; COLLIDED 
    push #4 ; block counter 
    pushw y  ;block list 
    pushw x  ; top-left position 
1$: ldw x,y
    ldw x,(x)
    addw x,(TPOS,sp)
    ldw y,#TBLOCK 
    ld a,#DY 
    call put_sprite
    or a,(COLLIDED,sp)
    ld (COLLIDED,sp),a  
    ldw y,(TLIST,sp)
    addw y,#2 
    ldw (TLIST,sp),y 
    dec (BCNT,sp)
    jrne 1$ 
    ld a,(COLLIDED,sp)
    _drop VAR_SIZE 
    tnz a 
    ret 

;-------------------------------
; get tetramino 
; sprite address 
; input:
;     A  tetra index {0..7}
;     XL tetra rotation {0..3}
; output:
;    Y   *tetramino 
;------------------------------
get_tetra_sprite:
; addr=tetra_all[8*A+2*XL] 
    sll a 
    sll a 
    sll a 
    clrw y 
    ld yl,a 
    addw y,#tetra_all 
    sllw x 
    pushw x 
    addw y,(1,sp)
    ldw y,(y)
    _drop 2 
    ret 

;-------------------
; display lines and 
; scores 
;-------------------
display_fall_score:
    mov cx,#7 
    _clrz cy 
    ldw x,lines_dropped 
    call put_uint16
    mov cx,#7 
    mov cy,#2 
    ldw x,fall_score
    call put_uint16 
    ret

;-------------------------
; initialize game 
;-------------------------
LINES_STR: .asciz "LINES:\r\rSCORE:" 
 

fall_init:
    ld a,#15 
    _straz fall_dly 
    ld a,#VRES-1
    _straz top_y
    clrw x 
    _strxz fall_score 
    _strxz lines_dropped
    call tv_cls 
    ldw y,#LINES_STR 
    call tv_puts 
; draw well 
    ldw x,#(WELL_TOP<<8)+WELL_LEFT 
    ldw y,#(WELL_HEIGHT<<8)+WELL_WIDTH
    call rectangle 
; draw next tetramino box 
    ldw x,#(#NEXT_TOP<<8)+NEXT_LEFT 
    ldw y,#(NEXT_HEIGHT<<8)+NEXT_WIDTH  
    call rectangle 
    clrw x 
    call set_seed 
    ret 

;---------------------
; display banner 
; and play korobeniki 
; tune
;---------------------
brief_descr:
.asciz "Une variante de TETRIS.\r" 
.asciz "Jacques Deschenes (c) 2024"
fall_intro:
    call tv_cls  
    mov cy,#10
    ldw y,#fall_name
    call center_align 
    _incz cy 
    ldw y,#brief_descr
    call center_align 
    incw y 
    call center_align  
    ldw y,#korobeniki
    call tune
    ldw x,#255 
    call wait_key_release 
    ret 

;---------------------------------
; draw current tetramino in the 
; well 
;---------------------------------
draw_current_tetra:
    clrw x 
    _ldaz tetra_rot 
    ld xl,a 
    _ldaz cur_tetra
    call get_tetra_sprite
    _ldxz tetra_y
    call draw_tetra 
    ret 

;---------------------------------
; draw next tetramino in the 
; box 
; input: 
;---------------------------------
draw_next_tetra:
    _ldaz next_tetra 
    clrw x 
    call get_tetra_sprite
; show next tetramino in box      
    ldw x,#NEXT_COORDS
    call draw_tetra  
    ret 

;---------------------------------
; generate new random 
; tetramino 
; output:
;     A    tetramino index {0..6}
;---------------------------------
new_tetra:
    call prng 
    ld a,#7 
    div x,a 
    _straz next_tetra
    call draw_next_tetra
; set current tetra position and rotation 
; to well top, rotation 0.    
    ldw x,#((WELL_TOP+1)<<8)+(WELL_WIDTH)/2+WELL_LEFT+1
    _strxz tetra_y 
    _clrz tetra_rot
    ret 

;------------------------
; compute current tetramino 
; right bound 
; ouput:
;     A    xcoord 
;---------------------------
right_bound:
    clrw x 
    _ldaz tetra_rot 
    ld xl,a 
    _ldaz cur_tetra
    call get_tetra_sprite
    ld a,(8,y) ; tetramino width 
    add a,tetra_x 
    ret 

;---------------------
; read keypad 
; and update 
; tetramino x coord 
; and rotation 
; BTN_A right rotation 
; BTN_B left rotation 
; BTN_LEFT move left 
; BTN_RIGHT move right 
;---------------------
    KEY=1 
fall_player_input:
    push #0 
    call read_keypad 
    ld (KEY,sp),a 
    call draw_current_tetra ; erase it 
    tnz (KEY,sp)
    jreq 9$ 
    ld a,(KEY,sp) 
    cp a,#BTN_A 
    jrne 2$ 
    _ldaz tetra_rot 
    inc a 
    and a,#3 
    _straz tetra_rot 
    jra 3$ 
2$:
    cp a,#BTN_B 
    jrne 4$
    _ldaz tetra_rot 
    dec a 
    and a,#3 
    _straz tetra_rot 
3$: ; check tetramino for right wall collision 
    ; shift it left is so.
    call right_bound 
    cp a,#WELL_LEFT+WELL_WIDTH 
    jrmi 8$ 
    push a 
    ld a,#WELL_RIGHT 
    sub a,(1,sp)
    _straz tetra_x 
    _drop 1 
    jra 8$ 
4$:
    cp a,#BTN_LEFT 
    jrne 6$
    _ldaz tetra_x
    cp a,#WELL_LEFT+1  
    jreq 8$ 
    sub a,#BLOCK_WIDTH 
    _straz tetra_x 
    jra 8$ 
6$:
    cp a,#BTN_RIGHT 
    jrne 8$ 
    call right_bound 
    cp a,#WELL_LEFT+WELL_WIDTH 
    jrpl 8$ 
    _ldaz tetra_x 
    add a,#BLOCK_WIDTH
    _straz tetra_x 
8$: 
    ldw x,#1 
    call wait_key_release
9$: _drop 1    
    ret 

;--------------------------
; update tetra position 
;--------------------------
fall_update:
    _ldaz tetra_y 
    add a,#BLOCK_HEIGHT 
    _straz tetra_y 
    ret 

;----------------------
; game entry point 
;----------------------
fall:
    call fall_intro 
0$:
    call fall_init
    call new_tetra 
1$: ; new fall begin here 
    call display_fall_score
; new tetramino loop
; here tetramino in the next box 
; is moved to current 
; and a new 'next tetra' is generated      
    call draw_next_tetra ; erase next box 
    _movz cur_tetra,next_tetra     
; generate new next_tetra     
    call new_tetra
    call draw_current_tetra  
2$: ; falling loop
    call fall_player_input 
    call fall_update 
    call draw_current_tetra
    jrne 4$  
    _ldaz fall_dly 
    call pause 
    jra 2$    
4$: ; fall tetramino collided with bottom or other tetramino
    call draw_current_tetra ; erase_hit 
    ;rewind up 
    _ldaz tetra_y 
    sub a,#BLOCK_HEIGHT
    _straz tetra_y 
    cp a,top_y 
    jrpl 5$
    _straz top_y
    cp a,#WELL_TOP+1
    jreq 9$  
5$:
    call draw_current_tetra
    jra 1$ 
9$: ; well full, game end 
    call draw_current_tetra
    ldw x,#(4<<8)
    call again 
    cp a,#BTN_A 
    jreq 0$    
    ret 

