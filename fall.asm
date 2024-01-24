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
; TRETIS  variant
;-------------------
; block dimensions
DX=4
DY=6 
BLOCK_WIDTH=4 
BLOCK_HEIGHT=6 

; well dimensions and position 
WELL_WIDTH=BLOCK_WIDTH*10
WELL_HEIGHT=BLOCK_HEIGHT*22
WELL_BOTTOM=VRES-BLOCK_HEIGHT  
WELL_TOP=WELL_BOTTOM-WELL_HEIGHT-1
WELL_LEFT=(HRES-WELL_WIDTH)/2
WELL_RIGHT=WELL_LEFT+WELL_WIDTH+1 
; next tetramino box dimensions and position 
NEXT_WIDTH=4*BLOCK_WIDTH+4
NEXT_HEIGHT=4*BLOCK_HEIGHT+4
NEXT_LEFT=WELL_RIGHT+2 
NEXT_TOP=WELL_TOP 
NEXT_BOTTOM=NEXT_TOP+NEXT_HEIGHT+1 
NEXT_RIGHT=NEXT_LEFT+NEXT_WIDTH+1
NEXT_COORDS=((NEXT_TOP+2)<<8)+NEXT_LEFT+2

INIT_DLY=12 

; score gain as row drop 
ONE_ROW=100
TWO_ROWS=250
THREE_ROWS=450
FOUR_ROWS=800

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

FALL_GAIN: .word 0,ONE_ROW,TWO_ROWS,THREE_ROWS,FOUR_ROWS 

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
; at each block check 
; for collision. 
; if collision stop drawing 
; return collision flag   
; input:
;    X  position {xl,xh}
;    Y  tetra pointer 
; output:
;    A   0 -> no collision 
;        -1 -> collision 
;-------------------------
    TPOS=1 ; tetramino top-left position  
    TLIST=TPOS+2 ; blocks list pointer 
    BCNT=TLIST+2 ; block counter 
    COLLISION=BCNT+1
    VAR_SIZE=COLLISION 
draw_tetra:
    push #0 ;collision flag 
    push #4 ; block counter 
    pushw y  ;block list pointer 
    pushw x  ; top-left position 
1$: ldw x,y
    ldw x,(x)
    addw x,(TPOS,sp)
    ldw y,#TBLOCK 
    ld a,#DY 
    call put_sprite
    jreq 2$ 
    ld a,#-1
    ld (COLLISION,sp),a 
2$: 
    ldw y,(TLIST,sp)
    addw y,#2 
    ldw (TLIST,sp),y 
    dec (BCNT,sp)
    jrne 1$ 
9$:
    ld a,(COLLISION,sp)
    _drop VAR_SIZE 
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
    ld a,#INIT_DLY  
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
    ldw y,#((WELL_BOTTOM)<<8)+WELL_RIGHT 
    call rectangle 
; draw next tetramino box 
    ldw x,#(#NEXT_TOP<<8)+NEXT_LEFT 
    ldw y,#(NEXT_BOTTOM<<8)+NEXT_RIGHT 
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

;-------------------------
; drop tetramino to 
; lowest possible position 
; without delay 
;-------------------------
    COOR=1 
    VAR_SIZE=2 
tetra_free_fall:
    _vars VAR_SIZE 
0$:
    _ldxz tetra_y 
    ldw (COOR,sp),x 
    call draw_current_tetra ; erase it 
1$: ldw x,(COOR,sp)
    addw x,#(BLOCK_HEIGHT<<8) 
    _strxz tetra_y 
    call draw_current_tetra
    jrne 4$ ; collision  
    jra 0$
4$: ; collision, back off 
    call draw_current_tetra ; erase it 
    ldw x,(COOR,sp) ; previous coordinates 
    _strxz tetra_y 
    call draw_current_tetra 
    _drop VAR_SIZE 
    ret 

;--------------------
; move tetramino 
; 1 block 
; input:
;    X    BLOCK_WIDTH shift right 
;         -BLOCK_WIDTH shift left  
;--------------------
    COOR=1
    SHIFT=COOR+2 
    VAR_SIZE=SHIFT+1
tetra_shift:
    _vars VAR_SIZE 
    ldw (SHIFT,sp),x 
    _ldxz tetra_y 
    ldw (COOR,sp),x 
    call draw_current_tetra ; erase it 
    ldw x,(COOR,sp)
    addw x,(SHIFT,sp)
    _strxz tetra_y 
    call draw_current_tetra 
    jreq 9$ 
; collision back off
    call draw_current_tetra ; erase it 
    ldw x,(COOR,sp)
    _strxz tetra_y 
    call draw_current_tetra ; back to original position 
9$:
    _drop VAR_SIZE 
    ret 

;---------------------
; rotate tetramino 
; 90 degree 
; input:
;    A    1 rotate right 
;        -1 rotate left  
;---------------------
    ORG=1
    ROT=2
    VAR_SIZE=2
tetra_rotate:
    push a 
    call draw_current_tetra ; erase it 
    _ldaz tetra_rot
    push a  
    add a,(ROT,sp) 
    and a,#3 
    _straz tetra_rot 
    call draw_current_tetra
    jreq 9$ 
; collision cancel rotation 
    call draw_current_tetra ; erate it 
    ld a,(ORG,sp)
    _straz tetra_rot 
    call draw_current_tetra ; restore original 
9$: _drop VAR_SIZE 
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

fall_player_input:
    call read_keypad 
    jreq 9$ 
1$:    
    cp a,#BTN_A 
    jrne 2$ 
    ld a,#1 
    call tetra_rotate 
    jra 9$ 
2$:
    cp a,#BTN_B 
    jrne 4$
    ld a,#-1 
    call tetra_rotate 
    jra 9$ 
4$:
    cp a,#BTN_LEFT 
    jrne 6$
    ldw x,#-BLOCK_WIDTH
    call tetra_shift 
    jra 9$ 
6$:
    cp a,#BTN_RIGHT 
    jrne 8$ 
    ldw x,#BLOCK_WIDTH
    call tetra_shift 
8$: 
    cp a,#BTN_DOWN 
    jrne 9$ 
    call tetra_free_fall 
9$:     
    ldw x,#1 
    call wait_key_release
    ret 

;--------------------------
; update tetra position
; down  
;--------------------------
    YCOOR=1
    COLLISION=1
    VAR_SIZE=1  
fall_update:
    call draw_current_tetra ; erase it 
    _ldaz tetra_y 
    push a 
    add a,#BLOCK_HEIGHT 
    _straz tetra_y 
    call draw_current_tetra ; draw at new position 
    jrne  1$
    ld (COLLISION,sp),a 
    _ldaz tetra_y 
    cp a,top_y 
    jrpl 9$
    mov top_y,tetra_y 
    jra 9$  
1$: ; collision back off 
    call draw_current_tetra ; erase new position 
    ld a,(YCOOR,sp)
    _straz tetra_y 
    call draw_current_tetra ; draw at original position 
    ld a,#-1 ; collision flag
    ld (COLLISION,sp),a  
9$: 
    ld a,(COLLISION,sp)
    _drop VAR_SIZE 
    ret 


;-------------------
; move well containt 
; 1 row down 
; input:
;    A   ycoor bottom row 
;        all lines from up 
;        to this row 
;        are move down 
;        1 block 
;-------------------
    SCANL_CNTR=1 ; scan lines to move 
    PIXEL_CNTR=SCANL_CNTR+1
    R_FROM=PIXEL_CNTR+1 ; start at this row  
    R_TO=R_FROM+1 ; move to this row 
    LEFT=R_TO+1  ; left coord 
    RIGHT=LEFT+1 ; right bound 
    VAR_SIZE=RIGHT   
row_down:
    _vars VAR_SIZE 
    ld (R_FROM,sp),a 
    add a,#BLOCK_HEIGHT 
    ld (R_TO,sp),a 
    ld a,(R_FROM,sp)
    sub a,#WELL_TOP 
    ld (SCANL_CNTR,sp),a 
    ld a,#WELL_RIGHT-1
    ld (RIGHT,sp),a 
1$: ; scan line loop 
    ld a,#WELL_LEFT+1 
    ld (LEFT,sp),a
    ld a,#BLOCK_WIDTH*10
    ld (PIXEL_CNTR,sp),a  
2$: ; pixel_loop
    ld a,(LEFT,sp)
    ld xl,a 
    ld a,(R_FROM,sp)
    ld xh,a 
    call get_pixel 
    ldw x,(R_TO,sp)
    call put_pixel 
    inc (LEFT,sp)
    dec (PIXEL_CNTR,sp)
    jrne 2$
    dec (R_FROM,sp)
    dec (R_TO,sp)
    dec (SCANL_CNTR,sp)
    jrne 1$
    _drop VAR_SIZE 
    ret 

;-------------------------
; check if the row is 
; full a row is 10 blocks 
; wide and only 1 pixel 
; per block need to be 
; sampled.
; input:
;    XL  xcoord 
;    XL  ycoord 
;    coordinate of left
;    block corner.
; output:
;    A    boolean flag true
;         if row full 
;    Z    set if not full 
;-------------------------
    YCOOR=1
    XCOOR=YCOOR+1 
    FULL=XCOOR+1
    BLK_CNT=FULL+1
    VAR_SIZE=BLK_CNT 
row_full:
    push #10 ; count pixels to sample
    push #0 ; flag false 
    pushw x ; 
1$: call get_pixel  
    jreq  9$ ; empty block 
    ld a,(XCOOR,sp)
    add a,#BLOCK_WIDTH
    ld (XCOOR,sp),a
    ldw x,(YCOOR,sp)
    dec (BLK_CNT,sp)
    jrne 1$
    cpl (FULL,sp)
9$: ld a,(FULL,sp)
    _drop VAR_SIZE 
    ret 

;---------------------------
; check for full row 
; remove them 
; adjust score 
;----------------------------
    YCOOR=1 ; scan start y  
    XCOOR=YCOOR+1  ; scan start x 
    FULL_ROWS=XCOOR+1 ; how many full rows {0..4}
    VAR_SIZE=FULL_ROWS 
check_score:
    _vars VAR_SIZE 
    clr (FULL_ROWS,sp)
    ld a,#WELL_BOTTOM-BLOCK_HEIGHT
    ld (YCOOR,sp),a 
    ld a,#WELL_LEFT+1
    ld (XCOOR,sp),a  
1$: ; row loop 
    ldw x,(YCOOR,sp)
    call row_full
    jrne 2$ 
    ld a,(YCOOR,sp)
    sub a,#BLOCK_HEIGHT 
    ld (YCOOR,sp),a 
    ldw x,(YCOOR,sp)
    ld a,xh 
    cp a,#WELL_TOP+BLOCK_HEIGHT   
    jruge 1$ 
    jra 4$ 
2$: ; this row is full 
    ; drop it. 
    inc (FULL_ROWS,sp)
    ld a,(YCOOR,sp)
    dec a 
    call row_down
    _ldaz top_y 
    add a,#BLOCK_HEIGHT
    _straz top_y 
    jra 1$
4$: ; adjust score 
    clrw x 
    ld a,(FULL_ROWS,sp)
    sll a 
    ld xl,a 
    addw x,#FALL_GAIN 
    ldw x,(x)
    addw x,fall_score
    _strxz fall_score 
    ldw y,#10000
    divw x,y 
    ld a,xl 
    sub a,#INIT_DLY 
    neg a 
    _straz fall_dly 
    clrw x 
    ld a,(FULL_ROWS,sp)
    ld xl,a 
    addw x,lines_dropped
    _strxz lines_dropped     
    _drop VAR_SIZE 
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
    jreq 2$ 
    call draw_current_tetra ; erase it 
    jra 9$    
2$: ; falling loop
    _ldaz fall_dly 
    call pause 
    call fall_player_input 
    call fall_update 
    jreq 2$  
    call check_score 
    jra 1$    
9$: ; well full, game end 
    ldw x,#(4<<8)
    call again 
    cp a,#BTN_A 
    jreq 0$    
    ret 

