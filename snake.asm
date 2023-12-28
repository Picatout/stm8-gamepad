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
max_score: .blkw 1 ; maximum score 
game_flags: .blkb 1 ; game boolean flags 
snake_len: .blkb 1 ; snake length 
snake_dir: .blkb 1 ; head direction 
food_coord: .blkw 1 ; food coordinates
snake_body: .blkw 32 ;  snake rings coords 

    .area CODE 

; game boolean flags 
F_FOOD_COLL=0  ; collision with food, earn point
F_NO_FOOD=1    ; no food available 
F_GAME_OVER=2  ; game ended

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
POO_WIDTH=7
POO_HEIGHT=4
POO:    .byte POO_WIDTH,POO_HEIGHT,0x10,0x38,0x7c,0xfe


;----------------------
; draw walls around 
; game area 
;---------------------
draw_walls:
; top wall 
    ldw x,#HRES 
    ldw y,#8*256+8  
    call line
; bottom wall 
    ldw x,#HRES 
    ldw y,#(VRES-1)*256+(VRES-1)
    call line 
; left wall     
    ldw x,#0 
    ldw y,#8*256+(VRES-1)
    call line 
; right wall     
    ldw x,#((HRES-1)*256)+(HRES-1)
    ldw y,#8*256+(VRES-1)
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
food_collision:
    pushw x 
    _clrz game_flags 
    ld a,#MOUSE_WIDTH
    add a,#SNAKE_SPRITE_WIDTH
    push a
    ld a,xl ; snake head x coord 
    sub a,food_coord+1 ; food x coord 
    jrpl 1$ 
    neg a  ; abs(delta)
1$: 
    cp a,(1,sp) 
    jrpl 3$ ; if >= 0 collision object not mouse 
    ld a,#MOUSE_HEIGHT
    add a,#SNAKE_SPRITE_HEIGHT
    ld (1,sp),a 
    ld a,xh   ; head y coord 
    sub a,food_coord ; food y coord 
    jrpl 2$
    neg a 
2$:
    cp a,(1,sp)
    jrmi 4$ 
3$: ; collision object not mouse 
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
    _ldxz score 
    incw x 
    ld a,food_coord ; mouse y coord 
    cp a,#9 
    jrne 5$
    incw x      
5$: cp a,#VRES-MOUSE_HEIGHT-1
    jrne 6$ 
    incw  x 
6$: ld a,food_coord+1 ; mouse x coord
    cp a,#1 
    jrne 7$ 
    incw x  
7$: cp a,#HRES-MOUSE_WIDTH-1
    jrne 8$
    incw x
8$:
    ld a,xl 
    and a,#3 
    jrne 81$ 
    call snake_poo
81$:
    _strxz score
    _clrz food_coord 
    _clrz food_coord+1     
9$:
    _drop 1 
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
    btjt game_flags,#F_FOOD_COLL,9$
; erase last ring 
    ldw x,(TAIL,sp)
    ldw y,#RING
    call draw_sprite
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
    jreq 4$ 
    ld (KPAD,sp),a  
    ld a,#BTN_LEFT 
    and a,(KPAD,sp)
    jreq 2$ 
    call rotate_head
    jra 3$
2$: ld a,#BTN_RIGHT 
    and a,(KPAD,sp)
    jreq 3$ 
    call rotate_head 
3$:
    ldw x,#90
    call wait_key_release
4$:
    _drop 1 
    ret 

;-------------------------
; create a new mouse 
; at random position 
;-------------------------
new_food:
    call prng
    ld a,#VRES-MOUSE_HEIGHT-FONT_HEIGHT-2 
    div x,a 
    add a,#FONT_HEIGHT+1
    _straz food_coord 
    call prng 
    ld a,#HRES-MOUSE_WIDTH-2 
    div x,a 
    inc a 
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
    ret 

;----------------------
; print score top left 
; corner 
;----------------------
prt_score:
    pushw x 
    _clrz cx 
    _clrz cy 
    _ldxz score 
    call put_uint16
    popw x
    ret 

;-------------------------
; game initialization
;-------------------------
snake_init:
    ld a,#(1<<F_NO_FOOD)
    _straz game_flags 
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
    ld a,#60
    call pause
1$: 
    btjf game_flags,#F_NO_FOOD,2$
    call prt_score 
    call new_food 
2$:
    call move_snake 
    btjt game_flags,#F_GAME_OVER,game_over  
    call user_input
    ld a,#6
    call pause 
    jra 1$
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
    ldw y,#max_score_str
    call tv_puts 
    _ldxz max_score 
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
score_str: .asciz "score: "
max_score_str: .asciz "max score: "
prompt: .asciz "A new game\rB exit"
