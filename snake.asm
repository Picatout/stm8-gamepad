;------------------------
; snake game 
; snake grow by eating mouse 
; 2 buttons used LEFT|RIGHT 
; to change snake direction 
; collision with walls,itself 
; and boulder end game
;------------------------

    .area G_DATA (ABS)
    .org 4 
app_variables:
score: .blkw 1 ; game score 
speed: .blkb 1 ; snake speed delay
chrono: .blkb 1 ; chronometer delay 
max_score: .blkw 1 ; maximum score 
game_flags: .blkb 1 ; game boolean flags 
snake_len: .blkb 1 ; snake length 
snake_dir: .blkb 1 ; head direction 
food_coord: .blkw 1 ; food coordinates
snake_body: .blkw 32 ;  snake rings coords 

    .area CODE 
; chronometer delay 
CHRONO_DELAY=127

; snake speed value 
MIN_SPEED=1 
MAX_SPEED=9 

; borders position and area dimensions 
LEFT_BORDER=0 ; left fence position 
MIN_XCOOR=LEFT_BORDER+1; minimum snake x coordinate 
RIGHT_BORDER=(HRES-4)&0xFC ; right fence position , 4 pixels reserved for calories bargraph.
MAX_XCOOR=(RIGHT_BORDER-SNAKE_SPRITE_WIDTH) ; maximum snake x coordinate  
PG_WIDTH=(RIGHT_BORDER-MIN_XCOOR) ; play ground width 
TOP_BORDER=FONT_HEIGHT ; top fence y position , 1 character height reserved for status display  
MIN_YCOOR=(TOP_BORDER+1) ; minimum snake y coordinate   
BOTTOM_BORDER=(VRES-1) ; bottom fence position 
MAX_YCOOR=(BOTTOM_BORDER-SNAKE_SPRITE_HEIGHT)
PG_HEIGHT=(BOTTOM_BORDER-MIN_YCOOR); play ground height 

; game boolean flags 
F_FOOD_COLL=0  ; collision with food, earn point
F_NO_FOOD=1    ; no food available 
F_GAME_OVER=2  ; game ended
F_POO=3        ; snake poo 

; snake heading 
NORTH=0 
EAST=1
SOUTH=2 
WEST=4 

; game sprites 
; first 2 numbers: width,height 
SNAKE_SPRITE_WIDTH=4 
SNAKE_SPRITE_HEIGHT=4
HEAD_UP:    .byte SNAKE_SPRITE_WIDTH,SNAKE_SPRITE_HEIGHT,0X60,0X60,0X90,0X60
HEAD_RIGHT: .byte SNAKE_SPRITE_WIDTH,SNAKE_SPRITE_HEIGHT,0X40,0XB0,0XB0,0X40 
HEAD_DOWN:  .byte SNAKE_SPRITE_WIDTH,SNAKE_SPRITE_HEIGHT,0X60,0X90,0X60,0X60 
HEAD_LEFT:  .byte SNAKE_SPRITE_WIDTH,SNAKE_SPRITE_HEIGHT,0X20,0XD0,0XD0,0X20 
RING:       .byte SNAKE_SPRITE_WIDTH,SNAKE_SPRITE_HEIGHT,0x60,0x90,0X90,0X60 
MOUSE_WIDTH=5 
MOUSE_HEIGHT=4
MOUSE:      .byte MOUSE_WIDTH,MOUSE_HEIGHT,0X00,0X70,0XF8,0XA0 
POO_WIDTH=4
POO_HEIGHT=4
POO:    .byte POO_WIDTH,POO_HEIGHT,0x40,0x60,0x70,0xf0
CB_WIDTH=3
CB_HEIGHT=1
CHRONO_BAR:    .byte CB_WIDTH,CB_HEIGHT,0x70 


;----------------------
; draw walls around 
; game area 
;---------------------
draw_walls:
; top fence  
    ldw x,#RIGHT_BORDER+1 
    ldw y,#(TOP_BORDER<<8)+TOP_BORDER  
    call line
; bottom fence  
    ldw x,#RIGHT_BORDER+1 
    ldw y,#(BOTTOM_BORDER<<8)+BOTTOM_BORDER
    call line 
; left fence     
    clrw x 
    ldw y,#((TOP_BORDER+1)<<8)+BOTTOM_BORDER
    call line 
; right fence
    ldw x,#(RIGHT_BORDER<<8)+RIGHT_BORDER
    ldw y,#((TOP_BORDER+1)<<8)+BOTTOM_BORDER
    call line 
    ret 

;---------------------------
; draw sprite 
; input:
;   XH   y coord 
;   XL   x coord 
;   Y    sprite data 
;----------------------------
draw_sprite:
    ld a,(1,y)
    addw y,#2
    jp put_sprite

;---------------------------
; select head sprite from 
; value of snake_dir 
; and draw it 
; input:
;    X    position 
;---------------------------
draw_head:
    ldw y,#6 
    _ldaz snake_dir 
    mul y,a 
    addw y,#HEAD_UP 
    jra draw_sprite  


;--------------------------
; snake initial draw 
;--------------------------
    LEN=1
    IDX=LEN+1 
    VAR_SIZE=IDX+1
draw_snake:
    _vars VAR_SIZE
    ldw x,snake_body  
    call draw_head 
    _ldaz snake_len
    dec a  
    ld (LEN,sp),a  
    ldw x,#snake_body+2 
1$:
    ldw (IDX,sp),x ; array index  
    ldw y,#RING 
    ldw x,(x)
    call draw_sprite
    dec (LEN,sp) 
    jreq 9$
    ldw x,(IDX,sp)
    addw x,#2 ; next element  
    jra 1$
9$:
    _drop VAR_SIZE 
    ret 

;---------------------
; shit happen 
;---------------------
snake_poo:
    push a 
    pushw x 
    _ldaz snake_len 
    dec a 
    clrw x 
    ld xl,a 
    addw x,#snake_body
    ldw x,(x)
    ldw y,#POO 
    call draw_sprite 
    popw x 
    pop a
    bres game_flags,#F_POO 
    ret 

;-----------------------------
; check for collision object
; if not mouse then game over.
; if MOUSE increase score and 
; delete mouse. 
; input:  
;    X   position 
; output:
;    game_flags:F_FOOD_COLL
;    X   unchanged 
;-------------------------------
    POS=1
    GAIN=2
    VAR_SIZE=2 
food_collision:
    pushw x
    _vars VAR_SIZE 
    clr (GAIN,sp)  
    _clrz game_flags 
    ld a,#MOUSE_WIDTH
    add a,#SNAKE_SPRITE_WIDTH
    ld (POS,sp),a 
    ld a,xl ; snake head x coord 
    sub a,food_coord+1 ; food x coord 
    jrpl 1$ 
    neg a  ; abs(delta)
1$: ; delta X 
    cp a,(POS,sp) 
    jrpl 3$ ; if delta X >= 0 collision object not mouse 
    ld a,#MOUSE_HEIGHT
    add a,#SNAKE_SPRITE_HEIGHT
    ld (POS,sp),a 
    ld a,xh   ; head y coord 
    sub a,food_coord ; food y coord 
    jrpl 2$
    neg a 
2$: ; delta Y 
    cp a,(POS,sp)
    jrmi 4$ 
3$: ; if delta Y >= 0 collision object not mouse 
    bset game_flags,#F_GAME_OVER
    jrpl 9$ 
4$:  ; collision with mouse
; erase food 
    ldw x,food_coord
    ldw y,#MOUSE 
    call draw_sprite
    bset game_flags,#F_NO_FOOD 
    bset game_flags,#F_FOOD_COLL
    _incz snake_len 
    inc (GAIN,sp)
    ld a,food_coord ; mouse y coord 
    cp a,#MIN_YCOOR 
    jrne 5$
    inc (GAIN,sp) ; food at top border     
5$: cp a,#MAX_YCOOR 
    jrne 6$ 
    inc (GAIN,sp) ; food at bottom border 
6$: ld a,food_coord+1 ; mouse x coord
    cp a,#MIN_XCOOR 
    jrne 7$ 
    inc (GAIN,sp) ; food at left border 
7$: cp a,#MAX_XCOOR
    jrne 8$
    inc (GAIN,sp) ; food at right border 
8$: ; score+=(MAX_SPEED+1-speed)*(GAIN,sp)
    ld a,#MAX_SPEED+1
    sub a,speed 
    clrw x 
    ld xl,a 
    ld a,(GAIN,sp)
    mul x,a ; gain 
    ld a,xl 
    addw x,score
    _strxz score
    cp a,#6
    jrmi 81$ 
    bset game_flags,#F_POO 
81$:
    _clrz food_coord 
    _clrz food_coord+1     
    call beep 
9$:
    _drop VAR_SIZE
    popw x 
    ret 


;---------------------
; according to 
; actual head position 
; and direction compute 
; next snake head 
; coordinates
; input:
;   X     actual position
; output:
;   X     next position 
;---------------------
next_head_pos:
    _ldaz snake_dir 
    cp a,#NORTH 
    jrne 2$ 
; going north 
    subw x,#SNAKE_SPRITE_HEIGHT<<8
    jra 9$        
2$: cp a,#EAST 
    jrne 4$ 
;going east 
    addw x,#SNAKE_SPRITE_WIDTH 
    jra 9$ 
4$: cp a,#SOUTH 
    jrne 6$
;going south 
    addw x,#SNAKE_SPRITE_HEIGHT<<8
    jra 9$ 
6$: ; going west 
    subw x,#SNAKE_SPRITE_WIDTH 
9$:
    ret 

;------------------------------
; move memory block from 
; low address to higher address    
; input:
;    A   count 
;    X   destination 
;    Y   source 
;-------------------------------
move_array_up:
    push a 
1$: ld a,(y)
    decw y 
    ld (x),a 
    decw x 
    dec (1,sp)
    jrne 1$ 
    _drop 1 
    ret 

;-----------------------
; move snake 
;-----------------------
    POS=1 ; new head coordinates 
    HEAD=POS+2 ; actual head position 
    TAIL=HEAD 
    VAR_SIZE=HEAD+1
move_snake:
    pushw x 
    pushw y 
    _vars VAR_SIZE 
; erase head by drawing over it 
    ldw x,snake_body 
    ldw (HEAD,sp),x 
    call draw_head 
; draw ring at head position     
    ldw x,(HEAD,sp)  ; head position 
    ldw y,#RING 
    call draw_sprite 
;draw head at new position 
    ldw x,(HEAD,sp)
    call next_head_pos
    ldw (POS,sp),x
    call draw_head
    jreq 1$
;collision deteted  
    ldw x,(POS,sp)
    call food_collision 
    btjt game_flags,#F_GAME_OVER,9$
1$: 
; move array elements 1 cell toward tail 
    _ldaz snake_len
    dec a
    sll a 
    clrw x 
    ld xl,a 
    addw x,#snake_body ; last array element 
    ldw y,x 
    ldw x,(x)
    ldw (TAIL,sp),x ; last ring position  
    ldw x,y 
    decw y 
    incw x 
    _ldaz snake_len 
    dec a 
    sll a     
    call move_array_up 
; set 1 element as new head position 
    ldw x,(POS,sp)
    ldw snake_body,x    
    btjt game_flags,#F_FOOD_COLL,8$
; erase last ring 
    ldw x,(TAIL,sp)
    ldw y,#RING
    call draw_sprite
    jra 9$ 
8$:
    btjf game_flags,#F_POO,9$ 
    call snake_poo 
9$:
    _drop VAR_SIZE 
    popw y 
    popw x  
    ret 


;--------------------------
; rotate snake head 
; input
;     A   {LEFT,RIGHT}
;--------------------------
rotate_head:
    push a 
    _ldaz snake_dir 
    ldw y,#6 
    mul y,a 
    addw y,#HEAD_UP
    ldw x,snake_body 
    call draw_sprite 
    pop a 
    cp a,#BTN_LEFT 
    jrne 2$ 
    _ldaz snake_dir 
    dec a 
    jra 4$ 
2$: _ldaz snake_dir 
    inc a 
4$: and a,#3 
    _straz snake_dir 
    ldw y,#6
    mul y,a 
    addw y,#HEAD_UP 
    ldw x,snake_body 
    call draw_sprite 
    ret 

;--------------------------
; read keypad 
; LEFT turn left 
; RIGHT turn right 
;--------------------------
    KPAD=1
user_input:
    push #0 
    call read_keypad
    jreq 8$ 
    ld (KPAD,sp),a  
    ld a,#BTN_LEFT 
    and a,(KPAD,sp)
    jreq 2$ 
    call rotate_head
    jra 6$
2$: ld a,#BTN_RIGHT 
    and a,(KPAD,sp)
    jreq 3$ 
    call rotate_head
    jra 6$ 
3$:
    ld a,#BTN_UP 
    and a,(KPAD,sp)
    jreq 4$
    ld a,#MIN_SPEED 
    cp a,speed 
    jreq 6$  
    _decz speed
    call prt_info 
    jra 6$ 
4$: ld a,#BTN_DOWN 
    and a,(KPAD,sp)
    jreq 6$
    ld a,#MAX_SPEED 
    cp a,speed 
    jreq 6$
    _incz speed
    call prt_info  
6$:
    ldw x,#10
    call wait_key_release
8$:
    _drop 1 
    ret 

;-----------------------
; when snake eat mouse 
; reset chronometer 
;-----------------------
chrono_reset:
    push #CHRONO_DELAY
1$:
    _ldaz chrono 
    cp a,(1,sp)
    jrpl 9$ 
    ld a,#VRES-1 
    sub a,chrono
    ld xh,a  
    ld a,#RIGHT_BORDER+1
    ld xl,a 
    ldw y,#CHRONO_BAR
    call draw_sprite
    _incz chrono 
    jra 1$  
9$: _drop 1 
    ret 

;-------------------------
; decrement chrono 
; remove a chrono tick 
;-------------------------
chrono_decr:
    _decz chrono 
    ld a,#VRES-1 
    sub a,chrono 
    ld xh,a 
    ld a,#(RIGHT_BORDER+1)
    ld xl,a 
    ldw y,#CHRONO_BAR 
    call draw_sprite 
    tnz chrono 
    ret 

;-------------------------
; create a new mouse 
; at random position 
;-------------------------
new_food:
    call prng
    ld a,#PG_HEIGHT 
    div x,a 
    add a,#MIN_YCOOR
    _straz food_coord 
    call prng 
    ld a,#PG_WIDTH 
    div x,a 
    add a,#MIN_XCOOR
    _straz food_coord+1
    ldw x,food_coord 
    ldw y,#MOUSE 
    call draw_sprite 
    tnz a 
    jreq 9$ 
    ldw x,food_coord 
    ldw y,#MOUSE 
    call draw_sprite 
    jra new_food 
9$: _clrz game_flags
    call chrono_reset 
    ret 

;----------------------
; print score top left 
; corner 
;----------------------
prt_info:
    pushw x 
    _clrz cx 
    _clrz cy 
    ldw y,#score_str
    call tv_puts 
    _ldxz score 
    call put_uint16
    ld a,#12
    _straz cx 
    ldw y,#speed_str 
    call tv_puts
    ld a,#MAX_SPEED+1 
    sub a,speed 
    clrw x 
    ld xl,a 
    call put_uint16
    ld a,#24
    _straz cx 
    ldw y,#max_str 
    call tv_puts 
    ldw x,max_score
    call put_uint16
    popw x
    ret 
score_str: .asciz "SCORE:"
speed_str: .asciz "SPEED:"  
max_str: .asciz "max:"

;-------------------------
; game initialization
;-------------------------
snake_init:
    ld a,#(1<<F_NO_FOOD)
    _straz game_flags 
    _clrz chrono 
    ld a,#5 
    _straz speed
    clrw x 
    _strxz score 
    _strxz food_coord
    call set_seed  ; using ticks 
    ld a,#3
    _straz snake_len 
    ld a,#EAST
    _straz snake_dir
    ldw x,#snake_body 
    ldw y,#(31<<8)+48 
    ldw (x),y
    subw y,#SNAKE_SPRITE_WIDTH
    ldw (2,x),y 
    subw y,#SNAKE_SPRITE_WIDTH
    ldw (4,x),y 
    call tv_cls
    call draw_walls
    call draw_snake 
    ret 

;-------------------------
; game main routine
;-------------------------
snake:
    call snake_init
    ld a,#30
    call pause
1$: 
    btjf game_flags,#F_NO_FOOD,2$
    call prt_info 
    call new_food 
2$:
    call move_snake 
    btjt game_flags,#F_GAME_OVER,game_over  
    call user_input
    call chrono_decr  
    jreq timeout
    _ldaz speed 
    call noise 
    jra 1$
timeout:
    ldw x,#(12<<8)+10 
    _strxz cy 
    ldw y,#timeout_str
    call tv_puts 
    ld a,#60 
    call pause
game_over:
    _ldxz score 
    cpw x,max_score 
    jrmi 4$ 
    _strxz max_score
4$:
    ldw x,#0xffff 
    call wait_key_release
    call tv_cls 
    ldw y,#gover 
    call tv_puts 
    ldw y,#score_str
    call tv_puts 
    _ldxz score 
    call put_uint16
    call crlf 
    ldw y,#prompt 
    call tv_puts 
6$:
    call wait_key 
    cp a,#BTN_A 
    jreq snake 
    cp a,#BTN_B 
    jreq 9$
    jra 6$
9$:     
    ret 

gover: .asciz "game over\r"
timeout_str: .asciz "TIME OUT" 
prompt: .asciz "A new game\rB exit"
