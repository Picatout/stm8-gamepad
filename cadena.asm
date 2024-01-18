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

MAX_PLAYERS=4
MAX_TRIES=12
CELL_SIDE=12 ; square cell size
LOCK_LEFT=90 ; lock display left coord 
LOCK_TOP=0 ; lock display top coord 
TRIES_TOP=LOCK_TOP+CELL_SIDE+2 ; grid top coord
TRIES_LEFT=90 ; grid left coord
HINT_LEFT=TRIES_LEFT+4*CELL_SIDE+2 ; hint grid left coordinate
SCORE_TOP=2 ;
PLAYER_NO_LEFT=3
SCORE_LEFT=9 
CURSOR_ROW=FONT_HEIGHT
GAME_SETS=3 ; number of sets per game 


lock: .blkb 4 ; lock digits array 
try: .blkb 4 ; player last try array  
lcpy: .blkb 4 ; lock array copy 
tcpy: .blkb 4 ; try array copy 
tries: .blkb 1 ; number of player tries 
scores: .blkb MAX_PLAYERS ; players score
set: .blkb 1 ; a game is 3 set 
nbr_players: .blkb 1 ; number of players {1..MAX_PLAYERS}
play_turn: .blkb 1 ; active player 


    .area CODE 

;--------------------------
;  game initialization
;--------------------------
lock_init:
    _clrz tries 
    ld a,#1 
    _straz set
    _straz play_turn  
    ldw x,#try
    push #4 
1$: ; clear try digits     
    clr (x) 
    incw x 
    dec (1,sp)
    jrne 1$ 
; clear players score 
    ld a,#MAX_PLAYERS 
    ldw x,#scores
    ld (1,sp),a 
2$: clr (x)
    incw x
    dec (1,sp)
    jrne 2$
    _drop 1  
new_lock:     
; generate lock hidden number     
    push #4 
    clrw x 
    call set_seed 
    call prng 
    ldw y,#lock
4$: ; set lock array     
    ld a,#10 
    div x,a 
    ld (y),a 
    incw y 
    dec (1,sp)
    jrne 4$
    call draw_stars   
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
    add a,#'0
    call draw_char  
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
    clr a 
    call compute_digit_coords
    ldw y,#try
1$: ld a,(y)
    call display_digit
    addw x,#CELL_SIDE
    incw y 
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
; input: digit coords
;     XL  xcoord 
;     XH  ycoord 
;-------------------
CURSOR_SHAPE:.byte 0xfc,0xfc
CURSOR_HEIGHT=2
display_cursor:
    pushw x 
    pushw y
    addw x,#(CURSOR_ROW<<8); underscore digit
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
    call display_cursor 
    call wait_key 
    ld (KEY,sp),a 
; erase display
; and cursor 
    ld a,(DIGIT,sp)
    ldw x,(YCOOR,sp)
    call display_digit 
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
    addw x,#TRIES_LEFT+3 
    pushw x  ; xcoord 
    ld a,tries
    ldw x,#CELL_SIDE 
    mul x,a 
    addw x,#TRIES_TOP+2
    swapw x ; ycoord 
    addw x,(1,sp)
    _drop 2 
    ret 



;----------------------
; get player input try 
;----------------------
    YCOOR=1
    XCOOR=YCOOR+1
    CPOS=XCOOR+1 ; which digit user is at
    IDIGIT=CPOS+1 ; digit set value
    KEY=IDIGIT+1
    VAR_SIZE=KEY 
player_try:
    _vars VAR_SIZE 
    clrw x 
    ldw (CPOS,sp),x 
    ldw x,#try 
    ld a,(x)
    ld (IDIGIT,sp),a 
1$:
    call display_try ; show digits
    ld a,(CPOS,sp)
    call compute_digit_coords
    ldw (YCOOR,sp),x 
    call display_cursor ; show cursor
2$: ; user input 
    ldw x,#30
    call wait_key_release
    call wait_key
    ld (KEY,sp),a 
    call display_try ; erase digits 
    ld a,(CPOS,sp)
    ldw x,(YCOOR,sp) 
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
    clrw x 
    ld a,(CPOS,sp)
    ld xl,a
    ld a,(IDIGIT,sp)
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
    call display_try
    ldw x,#255
    call wait_key_release
    _drop VAR_SIZE 
    ret 

;----------------------
; draw character using 
; put_sprite 
; input:
;     A  character 
;     X   coordinates 
; output:
;     X  unchanged 
;------------------------
draw_char:
    pushw y
    pushw x  
    sub a,#SPACE 
    ldw y,#FONT_HEIGHT
    mul y,a 
    addw y,#font_6x8
    ld a,#FONT_HEIGHT
    call put_sprite 
    popw x 
    popw y 
    ret 

;-----------------------
; compute hint position
; input:
;    A    grid column {0,1}
; output:
;     XL  xcoord 
;     XH  ycoord 
;-----------------------
hint_coord: 
    ldw x,#CELL_SIDE 
    mul x,a 
    addw x,#(HINT_LEFT+3)
    pushw x 
    ld a,tries 
    ldw x,#CELL_SIDE 
    mul x,a 
    addw x,#TRIES_TOP+2
    swapw x 
    addw x,(1,sp)
    _drop 2 
    ret 

;-----------------------
; display hint 
; input:
;    XL   C value 
;    XH   P value 
;-------------------------
    P=1 
    C=P+1 
    VAR_SIZE=C    
display_hint:
    _vars VAR_SIZE 
    ldw (P,sp),x
; display P in hint grid 
    clr a 
    call hint_coord
    ld a,(P,sp)
    add a,#'0 
    call draw_char  
; display C in hint grid 
    ld a,#1
    call hint_coord 
    ld a,(C,sp)
    add a,#'0 
    call draw_char  
    _drop VAR_SIZE 
    ret 

;---------------------
; evaluate user input
; and display hint 
; at active row 
;---------------------
    P=1   ; count digit in position 
    C=P+1 ; count digit in lock 
    COUNT=C+1 ; digit counter 
    LPOS=COUNT+1 ; 'lcpy' array index  
    TPOS=LPOS+2 ; 'try' array index 
    VAR_SIZE=TPOS+1  
eval_try:
    _vars VAR_SIZE 
    clrw x 
    ldw (P,sp),x
    ldw (LPOS,sp),x 
    ldw (TPOS,sp),x 
; copy 'lock' and 'try array in 
; 'lcpy' and 'tcpy'
    ld a,#8 
    ld (COUNT,sp),a
    ldw y,#lock 
    ldw x,#lcpy 
0$:
    ld a,(y)
    ld (x),a 
    incw y 
    incw x 
    dec (COUNT,sp)
    jrne 0$ 
; each 'tcpy' digit must be compared 
; with each 'lcpy' digit. 
; each digit in right position increment 
; 'P' and if present elsewhere increment 'C'.
;
; count 'P' 
    ldw y,#lcpy 
    ldw x,#tcpy
    ld a,#4 
    ld (COUNT,sp),a   
1$: 
    ld a,(x)
    cp a,(y)
    jrne 2$ 
    inc (P,sp);digit at position 
; two avoid recounting it in 'C' phase 
; change their values 
    ld a,#255
    ld (y),a 
    ld (x),a 
2$: incw y 
    incw x 
    dec (COUNT,sp)
    jrne 1$ 
;    
; count 'C' digits           
    ld a,(TPOS+1,sp)
3$:
    inc a 
    and a,#3      
    ld (LPOS+1,sp),a 
    ldw x,#tcpy 
    ld a,#3 ; number of compare 
    ld (COUNT,sp),a 
    addw x,(TPOS,sp)
4$:    
    ldw y,#lcpy
    addw y,(LPOS,sp)
    ld a,(x)
    jrmi 6$
    cp a,(y)
    jrne 5$ ; no match 
    inc (C,sp) 
    ld a,#255 
    ld (y),a 
    jra 6$
5$: ; compare to next lock digit 
    ld a,(LPOS+1,sp)
    inc a 
    and a,#3 
    ld (LPOS+1,sp),a 
    dec (COUNT,sp)
    jrne 4$
6$:
    inc (TPOS+1,sp)
    ld a,(TPOS+1,sp)
    cp a,#4 
    jrmi 3$  
8$: ; display hint
    ldw x,(P,sp)
    call display_hint
    ld a,(P,sp) 
    _drop VAR_SIZE 
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
; draw game grids 
;------------------------
draw_grids:
; draw lock grid 
; horizontal lines 
    ldw x,#(LOCK_TOP<<8)+LOCK_LEFT 
    ldw y,#(CELL_SIDE<<8)+4*CELL_SIDE 
    ld a,#2
    call draw_hlines 
; vertical lines 
    ldw x,#(LOCK_TOP<<8)+LOCK_LEFT 
    ldw y,#(CELL_SIDE<<8)+CELL_SIDE 
    ld a,#5 
    call draw_vlines
; draw tries grid
; horizontal lines 
    ld a,#CELL_SIDE*4 
    ld yl,a ; line length 
    ld a,#CELL_SIDE 
    ld yh,a ; step  
    ldw x,#(TRIES_TOP<<8)+TRIES_LEFT
    ld a,#13 ; count 
    CALL draw_hlines 
; vertical lines    
    ld a,#CELL_SIDE*12 
    ld yl,a ; line length 
    ld a,#CELL_SIDE 
    ld yh,a ; line step 
    ldw x,#(TRIES_TOP<<8)+TRIES_LEFT 
    ld a,#5
    call draw_vlines
; draw hint grid 
; horizontal lines 
    ld a,#CELL_SIDE*2 
    ld yl,a 
    ld a,#CELL_SIDE 
    ld yh,a 
    ldw x,#(TRIES_TOP<<8)+HINT_LEFT 
    ld a,#13
    call draw_hlines 
;vertical lines 
    ld a,#CELL_SIDE*12 
    ld yl,a ; line length 
    ld a,#CELL_SIDE 
    ld yh,a ; line step 
    ldw x,#(TRIES_TOP<<8)+HINT_LEFT  
    ld a,#3
    call draw_vlines
    ldw x,#((LOCK_TOP+2)<<8)+HINT_LEFT+3
    pushw x 
    ldw y,#font_6x8
    addw y,#('P-SPACE)*FONT_HEIGHT
    ld a,#FONT_HEIGHT 
    call put_sprite 
    popw x 
    addw x,#CELL_SIDE 
    ldw y,#font_6x8
    addw y,#('C-SPACE)*FONT_HEIGHT
    ld a,#FONT_HEIGHT 
    call put_sprite 
    ret

;----------------------
; show lock code 
;------------------------
    DIGIT=1
    COUNT=DIGIT+2
    VAR_SIZE=COUNT 
show_code:
    _vars VAR_SIZE
    clrw x 
    ldw (DIGIT,sp),x
    ldw x,#((LOCK_TOP+2)<<8)+LOCK_LEFT+3 
    ld a,#4
    ld (COUNT,sp),a
1$: 
    ldw y,#lock 
    addw y,(DIGIT,sp)
    ld a,(y)
    add a,#'0 
    call draw_char
    addw x,#CELL_SIDE 
    inc (DIGIT+1,SP)
    dec (COUNT,sp)
    jrne 1$           
    _drop VAR_SIZE 
    ret 

;----------------------
; draw '*' in lock grid 
;----------------------
draw_stars:
    push #4 
    ldw x,#((LOCK_TOP+2)<<8)+LOCK_LEFT+3
1$:
    ld a,#'* 
    call draw_char 
    addw x,#CELL_SIDE
    dec (1,sp)
    jrne 1$ 
    _drop 1 
    ret 

;---------------------
; display game rules
; and ask number of 
; players 
;---------------------
TEXT_LINES=6
rules: 
.asciz "Une variante du jeu Mastermind.\r"
.asciz "Il faut deviner la combinaison.\r"
.asciz "une parti dure 3 manches.\r" 
.asciz "'C', 1+ chiffre est bon.\r"
.asciz "'P', 1+ chiffre est en position.\r\r"  
.asciz "Combien de joueurs (1..4)? "

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

;-----------------
; reset variables 
; next player 
; move pointer 
;-----------------
player_reset:
    _clrz tries
    call new_lock 
    push #4 
    ldw x,#try 
1$: clr (x)
    incw x 
    dec (1,sp)
    jrne 1$ 
    _drop 1 
; erase previous pointer  
    _ldaz play_turn 
    cp a,#1 
    jreq 2$
    dec a 
    add a,#SCORE_TOP
    _straz cy 
    _clrz cx
    ld a,#SPACE 
    call tv_putc 
    _ldaz play_turn 
2$: ; put new pointer 
    add a,#SCORE_TOP 
    _straz cy 
    _clrz cx
    ld a,#'>
    call tv_putc
    call beep   
    ret 
;-----------------
; evaluate player score
;----------------------
NEXT_STR: .asciz "A) JOUEUR SUIVANT"
player_score:
    pushw x
    call draw_stars 
    call show_code 
    clrw x
    _ldaz play_turn
    dec a 
    ld xl,a 
    addw x,#scores  
    ld a,#MAX_TRIES 
    sub a,tries 
    add a,(x)
    ld (x),a 
    clrw x 
    ld xl,a 
    ld a,#SCORE_TOP 
    add a,play_turn 
    _straz cy 
    mov cx,#SCORE_LEFT
    call put_uint16
    _clrz cx 
    mov cy,#23
    ldw y,#NEXT_STR 
    call tv_puts 
    call wait_key
    ldw x,#255 
    call wait_key_release
    popw x 
    ret 

;------------------
; set game for 
; next try 
;------------------
next_try:
    inc tries 
    ld a,#MAX_TRIES 
    cp a,tries 
    jrpl 2$
    ret 
2$: 
    call draw_stars
    call show_code 
    jra next_player 
    

;--------------------
; set game for next 
; player 
;--------------------
next_player:
    _clrz tries 
    _ldaz play_turn 
    cp a,nbr_players 
    jreq 9$
    _incz play_turn
9$:
    ret 

;---------------------
; set game for next  
; set 
;--------------------
next_set:
    ld a,#1 
    _straz play_turn 
    ld a,set 
    cp a,#GAME_SETS
    jreq 9$ 
    _incz set
9$:
    ret 


;--------------
; display 
; game frame
;--------------
SET_STR: .asciz "MANCHE:"
HEADER_STR: .asciz "\r\rJOUEUR POINTS\r"
draw_frame:
    pushw x 
    pushw y
    call tv_cls 
; display set number 
    ldw y,#SET_STR 
    call tv_puts 
    clrw x 
    ld a,set 
    ld xl,a 
    call put_uint16
; display players list 
; with their score 
    ldw y,#HEADER_STR 
    call tv_puts 
    push #0
    ldw y,#scores 
1$:
    mov cx, #PLAYER_NO_LEFT 
    clrw x 
    inc (1,sp)
    ld a,(1,sp)
    ld xl,a 
    call put_uint16
    mov cx, #SCORE_LEFT  
    ld a,(y)
    incw y
    clrw x 
    ld xl,a 
    call put_uint16
    call crlf 
    ld a,nbr_players
    cp a,(1,sp)
    jrne 1$ 
    _drop 1 
; draw separator line 
    ldw x,#((FONT_WIDTH*6+2)<<8)+(FONT_WIDTH*6+2)
    ld a,nbr_players 
    inc a 
    ldw y,#FONT_HEIGHT 
    mul y,a 
    addw y,#((SCORE_TOP*FONT_HEIGHT)<<8)+(SCORE_TOP*FONT_HEIGHT)
    call line  
    call draw_grids
    popw y
    popw x 
    ret 

;--------------------
; game over 
;--------------------
WINNER_STR: .asciz "GAGNANT: JOUEUR "
DRAW_STR: .asciz "PARTIE NULLE " 
SCORE_STR: .asciz " POINTS" 

    P_COUNT=1
    MAX_SCORE=P_COUNT+1
    WINNER=MAX_SCORE+1
    DRAW=WINNER+1
    VAR_SIZE=DRAW  
show_winner:
    _vars VAR_SIZE 
    clrw x 
    ldw (MAX_SCORE,sp),x 
    clr (DRAW,sp)
    _ldaz nbr_players
    ld (P_COUNT,sp),a 
    ldw x,#scores
1$: 
    ld a,(x)
    jreq 3$ 
    cp a,(MAX_SCORE,sp)
    jreq 2$ 
    jrmi 3$ 
    ld (MAX_SCORE,sp),a
    _ldaz nbr_players
    sub a,(P_COUNT,sp)
    ld (WINNER,sp),a
    jra 3$
2$:  
; 2 players have same score 
; set draw flag
    cpl (DRAW,sp)
3$: incw x 
    dec (P_COUNT,sp)
    jrne 1$ 
; display game result 
    _clrz cx 
    mov cy,#20 
    tnz (MAX_SCORE,sp)
    jreq 4$ 
    tnz (DRAW,sp)
    jreq 5$
4$:
    ldw y,#DRAW_STR
    call tv_puts 
    jra 6$ 
5$:    
    ldw y,#WINNER_STR
    call tv_puts
    clrw x 
    ld a,(WINNER,sp)
    inc a 
    ld xl,a 
    call put_uint16
    ld a,#SPACE 
    call tv_putc  
6$: 
    clrw x 
    ld a,(MAX_SCORE,sp)
    ld xl,a 
    call put_uint16
    ldw y,#SCORE_STR 
    call tv_puts 
    _drop VAR_SIZE 
    ret 


;----------------------
; game entry point 
;----------------------
lock_game:
    call display_rules 
0$: ; new game 
    call lock_init
1$: ; new player
    call draw_frame
    call player_reset 
2$: ; player loop 
    ldw x,#255 
    call wait_key_release
    call player_try
    call eval_try 
    cp a,#4 ; number of digits in position 
    jreq 3$
    _incz tries 
    _ldaz tries 
    cp a,#MAX_TRIES 
    jrmi 2$ 
3$: ; got code 
    call player_score 
    call next_player  
    jrne 1$ 
    call next_set 
    jrne 1$ 
    call show_winner 

4$: ; end of game 
    ldw x,#(22<<8)
    call again     
    cp a,#BTN_A 
    jreq 0$ 
    ret 
