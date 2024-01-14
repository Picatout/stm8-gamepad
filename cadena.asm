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

;------------------
;   CADENA 
; 
; jeu de réflexion
;-----------------

;---------------------------
; Le joueur doit deviner 
; la combinaison d'un 
; cadena a 4 chiffres.
; Il dispose de 12 essais.
; À chaque essai il reçoit 
; un indice:
; __*__ s'il a un ou plusieurs chiffres 
;       de la combinaison.
; __+__ S'il a un ou plusieurs chiffres 
;       en bonne position.
;-----------------------------------------

    .area G_DATA 
    .org 4 

lock: .blkb 4 ; lock digits 
try: .blkb 4 ; player last try digits 
tries: .blkb 1 ; number of player tries 
scores: .blkb 4 ; players score
set: .blkb 1 ; a game is 3 set 
nbr_players: .blkb 1 ; number of players {1..4}
play_turn: .blkb 1 ; active player 

FRAME_TOP=10 ; grid top coord
FRAME_LEFT=58 ; grid left coord
CELL_SIDE=10 ; square cell size
HINT_LEFT=FRAME_LEFT+4*CELL_SIDE+2 ; hint grid left coordinate

    .area CODE 

lock_init:
    _clrz tries 
    ldw x,#try
    push #4 
    clr a 
1$: ; clear try digits     
    ld (x),a 
    incw x 
    dec (1,sp)
    jrne 1$ 
    ld a,#4 
    ld (1,sp),a 
    call prng 
    ldw y,#lock
2$: ; set random lock number     
    ld a,#10 
    div x,a 
    ld (y),a 
    incw y 
    dec (1,sp)
    jrne 2$  
    _drop 1 
    ret 


;----------------------
; return digit at 
; position in try 
; input:
;    A   pos {0..3}
;----------------------
digit_at:
    pushw x 
    clrw x 
    ld xl,a 
    addw x,#try 
    ld a,(x)
    popw x
    ret 

;---------------------
; set digit at pos 
; input:
;    A   digit {0..9}
;    XL  pos {0..3}
;---------------------
set_digit:
    addw x,#try 
    ld (x),a 
    ret 

;--------------------
;display a single 
; digit
; input:
;    A   digit 
;    XL  xcoord 
;    XH  ycoord 
;---------------------
display_digit:
    pushw y
    pushw x 
    add a,#'0-SPACE 
    ldw y,#FONT_HEIGHT 
    mul y,a 
    addw y,#font_6x8
    ld a,#FONT_HEIGHT-1 
    call put_sprite
    popw x 
    popw y 
    ret 


;-------------------
; display try digits 
; at active row 
;-------------------
    ROWY=1 ; display y coord 
    ROWX=ROWY+1 ; display x coord 
    YSAVE=ROWX+1
    COUNT=YSAVE+2 ; digit count
    VAR_SIZE=COUNT 
display_try:
    push a 
    pushw x 
    pushw y 
    _vars VAR_SIZE 
    ld a,#4 
    ld (COUNT,sp),a 
    ldw y,#try 
; compute Y coordinate
; same for all digits     
    ld a,tries
    ld xl,a 
    ld a,#CELL_SIDE 
    mul x,a 
    addw x,#FRAME_TOP+1 
    ld a,xl 
    ld (ROWY,sp),a 
; x coordinate change for each digit
; left digit x coord 
    ld a,#FRAME_LEFT+2
    ld (ROWX,sp),a 
    ldw x,(ROWY,sp)
1$: ld a,(y)
    call display_digit
    addw x,#CELL_SIDE 
    dec (COUNT,sp)
    jrne 1$  
    _drop VAR_SIZE 
    popw y 
    popw x 
    pop a 
    ret 


;-----------------
; diplay cursor 
; in cell 
; input:
;     XL  xcoord 
;     XH  ycoord 
;-------------------
CURSOR_SHAPE:.byte 0xfc,0xfc
CURSOR_HEIGHT=2
display_cursor:
    pushw x 
    pushw y
    ldw y,#CURSOR_SHAPE 
    ld a,#CURSOR_HEIGHT 
    call put_sprite 
    popw y 
    popw x 
    ret 

;-----------------------
; get a digit value 
; use UP|DOWN to 
; modify displayed digit 
; input:
;    A   start count 
;    XL  xcoord display count 
;    XH  ycoord display count 
;    YL  min value 
;    YH  max value 
;------------------------
    MAX=1 
    MIN=MAX+1 
    YCOOR=MIN+1
    XCOOR=YCOOR+1
    DIGIT=XCOOR+1
    KEY=DIGIT+1
    VAR_SIZE=KEY
get_digit:
    _vars VAR_SIZE 
    ldw (MAX,sp),y 
    ldw (YCOOR,sp),x 
    ld (DIGIT,sp),a 
1$: 
    ldw x,#255 
    call wait_key_release 
; display actual digit
; and cursor  
    ld a,(DIGIT,sp)
    ldw x,(YCOOR,sp)
    call display_digit  
    addw x,#(FONT_HEIGHT-1)<<8
    call display_cursor 
    call wait_key 
    ld (KEY,sp),a 
; erase display
; and cursor 
    ld a,(DIGIT,sp)
    ldw x,(YCOOR,sp)
    call display_digit 
    addw x,#(FONT_HEIGHT-1)<<8
    call display_cursor 
    ld a,(KEY,sp)
    cp a,#BTN_UP 
    jrne 4$
    ld a,(DIGIT,sp)
    cp a,(MAX,sp)
    jreq 1$
    inc (DIGIT,sp)
    jra 1$ 
4$: cp a,#BTN_DOWN 
    jrne 6$
    ld a,(DIGIT,sp)
    cp a,(MIN,sp)
    jreq 1$ 
    dec (DIGIT,sp)
    jra 1$ 
6$: cp a,#BTN_A 
    jrne 1$
    ldw x,#255 
    call wait_key_release 
    ld a,(DIGIT,sp)
    _drop VAR_SIZE 
    ret 

;--------------------
; compute digit 
; coordinates in 
; try frame 
; input:
;    A  digit position 
;---------------------
compute_digit_coords:
    ldw x,#CELL_SIDE 
    mul x,a 
    addw x,#FRAME_LEFT+2 
    pushw x
    ld a,try 
    ldw x,#CELL_SIDE 
    mul x,a 
    addw x,#FRAME_TOP+2
    swapw x 
    addw x,(1,sp)
    _drop 2 
    ret 


;----------------------
; get user input try 
;----------------------
    YCOOR=1
    XCOOR=YCOOR+1
    CPOS=XCOOR+1 ; which digit user is at
    IDIGIT=CPOS+1 ; digit set value
    KEY=IDIGIT+1
    VAR_SIZE=KEY 
get_user_try:
    _vars VAR_SIZE 
    clrw x 
    ldw (CPOS,sp),x 
1$:
    ld a,(CPOS,sp)
    call compute_digit_coords
    call display_cursor ; show cursor
    call display_try ; show digits
2$: ; user input 
    ldw x,#30
    call wait_key_release
    call wait_key
    ld (KEY,sp),a 
    call display_try ; erase digits 
    ld a,(CPOS,sp)
    call compute_digit_coords 
    call display_cursor ; hide cursor 
    ld a,(KEY,sp)
    cp a,#BTN_UP
    jrne 4$
    ld a,(IDIGIT,sp)
    cp a,#9 
    jrne 3$ 
    ld a,#-1
3$: inc a 
32$:
    ld (IDIGIT,sp),a
    ld xl,a 
    ld a,(CPOS,sp)
    ld xh,a
    clr a 
    rrwa x  
    call set_digit 
    jra 1$ 
4$:
    cp a,#BTN_DOWN 
    jrne 6$
    ld a,(IDIGIT,sp)
    jrne 5$ 
    ld a,#10
5$: dec a 
    jra 32$
6$:
    cp a,#BTN_LEFT 
    jrne 8$ 
    ld a,(CPOS,sp)
    jreq 1$
    dec (CPOS,sp)
62$:
    ld a,(CPOS,sp)
    call digit_at
    ld (IDIGIT,sp),a  
    jra 1$ 
8$:    
    cp a,#BTN_RIGHT 
    jrne 10$
    ld a,(CPOS,sp)
    cp a,#3 
    jreq 1$
    inc (CPOS,sp)
    jra 62$
10$:    
    cp a,#BTN_A 
    jrne 1$ 
    ldw x,#255
    call wait_key_release
    _drop VAR_SIZE 
    ret 

;---------------------
; evaluate user input
; and display hint 
; at active row 
;---------------------
display_hint:

    ret 


;---------------------
; draw verticals lines 
; equaly spaced
; same Y offset
; same length   
; input:
;    A  count of lines 
;    XL left 
;    XH top    
;    YL length
;    YH step    
;---------------------
    COUNT=1
    YPOS=COUNT+1 
    XPOS=YPOS+1
    STEP=XPOS+1 
    LEN=STEP+1
    VAR_SIZE=LEN 
draw_vlines:
    pushw y 
    pushw x 
    push a 
1$: ld a,(XPOS,sp)
    ld xh,a 
    ld xl,a 
    ld a,(YPOS,sp)
    ld yh,a 
    add a,(LEN,sp)
    ld yl,a 
    call line 
    ld a,(XPOS,sp)
    add a,(STEP,sp)
    ld (XPOS,sp),a 
    dec (COUNT,sp)
    jrne 1$     
    _drop VAR_SIZE 
    ret 

;---------------------
; draw horizontal lines 
; equaly spaced
; same X offset
; same length   
; input:
;    A  count of lines 
;    XL left  
;    XH top   
;    YL length
;    YH step    
;---------------------
    COUNT=1
    YPOS=COUNT+1 
    XPOS=YPOS+1
    STEP=XPOS+1 
    LEN=STEP+1
    VAR_SIZE=LEN 
draw_hlines:
    pushw y ; step,len 
    pushw x ; top,left 
    push a ; count  
1$: ld a,(XPOS,sp)
    ld xh,a 
    add a,(LEN,sp)
    ld xl,a 
    ld a,(YPOS,sp)
    ld yh,a 
    ld yl,a 
    call line 
    ld a,(YPOS,sp)
    add a,(STEP,sp)
    ld (YPOS,sp),a 
    dec (COUNT,sp)
    jrne 1$     
    _drop VAR_SIZE 
    ret 

;------------------------
; draw game frame 
;------------------------
ARG_SIZE=5 ; space reserved on stack for draw_grid parameters
draw_frame:
    call tv_cls
    ldw x,#FRAME_LEFT/FONT_WIDTH + 1
    _strxz cy  
    ldw y,#lock_name 
    call tv_puts 
; draw tries grid
; horizontal lines 
    ld a,#CELL_SIDE*4 
    ld yl,a ; line length 
    ld a,#CELL_SIDE 
    ld yh,a ; step  
    ldw x,#(FRAME_TOP<<8)+FRAME_LEFT
    ld a,#13 ; count 
    CALL draw_hlines 
; vertical lines    
    ld a,#CELL_SIDE*12 
    ld yl,a ; line length 
    ld a,#CELL_SIDE 
    ld yh,a ; line step 
    ldw x,#(FRAME_TOP<<8)+FRAME_LEFT 
    ld a,#5
    call draw_vlines
; draw hint grid 
; horizontal lines 
    ld a,#CELL_SIDE*2 
    ld yl,a 
    ld a,#CELL_SIDE 
    ld yh,a 
    ldw x,#(FRAME_TOP<<8)+HINT_LEFT 
    ld a,#13
    call draw_hlines 
;vertical lines 
    ld a,#CELL_SIDE*12 
    ld yl,a ; line length 
    ld a,#CELL_SIDE 
    ld yh,a ; line step 
    ldw x,#(FRAME_TOP<<8)+HINT_LEFT  
    ld a,#3
    call draw_vlines
    ret

;---------------------
; display game rules
; and ask number of 
; players 
;---------------------
TEXT_LINES=6
display_rules:
    pushw x 
    pushw y 
    call tv_cls 
    ldw x,#(8<<8)+13
    _strxz cy
    ldw y,#lock_name 
    call tv_puts 
    ldw x,#(10<<8)
    _strxz cy 
    push #TEXT_LINES     
    ldw y,#rules 
1$:    
    call tv_puts 
    incw y 
    dec (1,sp)
    jrne 1$ 
    _drop 1
    _ldaz cy 
    ldw x,#FONT_HEIGHT 
    mul x,a 
    swapw x 
    pushw x 
    _ldaz cx 
    ldw x,#FONT_WIDTH 
    mul x,a 
    addw x,(1,sp)
    _drop 2 
    ld a,#1 
    ldw y,#(4<<8)+1
    call get_digit
    _straz nbr_players
    popw y
    popw x  
    ret

rules: 
.asciz "Une variante du jeu Mastermind.\r"
.asciz "Il faut deviner la combinaison.\r"
.asciz "une parti dure 3 manches.\r" 
.asciz "'C', 1+ chiffre est bon.\r"
.asciz "'P', 1+ chiffre est en position.\r\r"  
.asciz "Combien de joueurs (1..4)? "
.word 0

;----------------------
; game entry point 
;----------------------
lock_game:
    call display_rules 
1$: ldw x,#255 
    call wait_key_release
    call lock_init 
    call draw_frame
    call get_user_try
    cp a,#BTN_A 
    jreq 1$ 
    cp a,#BTN_B 
    jrne lock_game   
    ret 
