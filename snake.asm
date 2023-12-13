;------------------------
; snake game 
;------------------------


    .area CODE 

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
TREE_WIDTH=6
TREE_HEIGHT=8
TREE:       .byte TREE_WIDTH,TREE_HEIGHT,0X44,0X54,0X54,0X38,0X10,0X10,0X10,0X10
ROCK_WIDTH=7
ROCK_HEIGHT=5
ROCK:       .byte ROCK_WIDTH,ROCK_HEIGHT,0x28,0x54,0xaa,0x54,0xaa


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


;--------------------------
; draw snake for the first 
; time 
;--------------------------
    LEN=1
    IDX=LEN+1 
    VAR_SIZE=IDX+1
draw_snake:
    _vars VAR_SIZE 
    _ldaz snake_dir
    ldw x,#6 
    mul x,a 
    _strxz acc16  
    ldw y,#HEAD_UP
    addw y,acc16 ; head sprite address 
    _ldaz snake_len 
    ld (LEN,sp),a  
    ldw x,#snake_body 
    ldw (IDX,sp),x ; array index  
; draw head 
1$:
    ldw x,(x)
    call draw_sprite
    dec (LEN,sp) 
    jreq 9$
; snake body 
    ldw x,(IDX,sp)
    addw x,#2 ; next element  
    ldw (IDX,sp),x 
    ldw Y,#RING
    jra 1$ 
9$:
    _drop VAR_SIZE 
    ret 

;-----------------------
; move snake 
;------------------------
move_snake:
    ldw y,#6 
    _ldaz snake_dir 
    mul y,a 
    addw y,#HEAD_UP 
    ldw x,#snake_body 
    ldw x,(x)
    pushw x
    call draw_sprite 
    popw x 
    ldw y,#RING 
    call draw_sprite 
    _ldaz snake_len 
    dec a 
    sll a 
    clrw x 
    ld xl,a  
    addw x,#snake_body 
    pushw x 
    ldw y,#RING
    ldw x,(x)
    call draw_sprite 
    popw x
    ldw y,x  
    incw x 
    decw y 
    _ldaz snake_len
    dec a
    sll a 
    push a 
1$: 
    ld a,(y)
    decw y 
    ld (x),a 
    decw x 
    dec (1,sp)
    jrne 1$
    _drop 1 
    ldw x,#snake_body 
    ldw x,(x)
    _ldaz snake_dir 
    cp a,#NORTH
    jrne 2$ 
    subw x,#SNAKE_SPRITE_HEIGHT<<8
    jra 9$ 
2$: cp a,#EAST
    jrne 3$ 
    addw x,#SNAKE_SPRITE_WIDTH 
    jra 9$ 
3$: cp a,#SOUTH 
    jrne 4$ 
    addw x,#SNAKE_SPRITE_HEIGHT<<8 
    jra 9$ 
4$: subw x,#SNAKE_SPRITE_WIDTH 
9$: ldw snake_body,x 
    ldw y,#6 
    mul y,a 
    addw y,#HEAD_UP
    call draw_sprite     
    ret 


draw_walls:
    ldw x,#96
    ldw y,#8*256+8  
    call line
    ldw x,#96 
    ldw y,#(VRES-1)*256+(VRES-1)
    call line 
    ldw x,#0 
    ldw y,#8*256+(VRES-1)
    call line 
    ldw x,#(95*256)+95
    ldw y,#8*256+(VRES-1)
    call line 
    ret 

;--------------------------
; wait for buttons released 
; but no more than 100msec
;--------------------------
    DLY=1
    VAR_SIZE=2
wait_btn_release:
    _vars VAR_SIZE
    ldw x,ticks 
    addw x,#100 
    ldw (DLY,sp),x 
1$: 
    ldw x,ticks 
    cpw x,(DLY,sp)
    jreq 9$     
    call read_keypad
    tnz a 
    jrne 1$ 
9$:
    _drop VAR_SIZE 
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
    call wait_btn_release
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
    _drop 1 
    ret 

snake_init:
    call tv_cls
    call draw_walls 
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
    call draw_snake 
    ret 

snake:
    call snake_init
    ld a,#100 
    call pause
1$:
    call move_snake 
    tnz a 
    jrne game_over 
    call user_input
    ld a,#7
    call pause 
    jra 1$
game_over:
    ldw y,#gover 
    call tv_puts 
    ld a,#100
    call pause 
    jra snake 
    ret 

gover: .asciz "game over"