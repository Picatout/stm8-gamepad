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

;--------------------------------
; game of life 
; John H. Conway 
; cellular automaton simulation 
;--------------------------------

GRID_WIDTH=32
GRID_ROW_BYTES=4
GRID_HEIGHT=22
GRID_SIZE=(GRID_ROW_BYTES*GRID_HEIGHT)
GRID_LEFT=0
GRID_TOP=1
GRID_CNTR_X=(GRID_WIDTH)/2-1
GRID_CNTR_Y=(GRID_HEIGHT)/2-1
BLOCK=127
CELL=132 
EMPTY=SPACE 

    .area G_DATA (ABS)
    .org 4 
gen: .blkw 1 ; generation
src: .blkw 1 ; source grid address 
dest: .blkw 1 ; dest grid address 
grid1: .blkb GRID_SIZE 
grid2: .blkb GRID_SIZE

    .area CODE 

print_gen:
    pushw x
    ldw x,#12
    _strxz cy 
    _ldxz gen 
    call put_uint16
    popw x 
    ret 

;------------------------
; program initialization
;------------------------
life_init:
    clrw x
    _strxz gen 
    ldw x,#2*GRID_SIZE
    ldw y,#grid1
    _stryz src 
    clr a 
    call fill
    ldw x,#grid2 
    _strxz dest
    ret 

;------------------------
; compute cell byte index
; in array  
; input:
;    XL   x coord 
;    XH   y coord 
; output:
;    A     bit mask
;    X     unchanged
;    Y     array byte index  
;-----------------------     
    YCOOR=1
    XCOOR=2 
cell_index:
    pushw x 
    ldw y,#GRID_ROW_BYTES 
    ld a,(YCOOR,sp)
    mul y,a 
    clr a 
    ld xh,a  
    ld a,#8 
    div x,a 
   _strxz acc16 
    addw y,acc16 
    call bit_mask
    popw x 
    ret 

;-------------------
; get cell state 
; from array   
; input:
;    XL   x coord 
;    XH   y coord
;     Y   array addr   
; output:
;    A   cell state
;    X   unchanged   
;    Y   unchanged   
;------------------
get_cell_state:
    pushw x 
    pushw y 
    call cell_index 
    addw y,(1,sp) 
    and a,(y)
    popw y 
    popw x
    ret 

;-------------------------
; put cell state to display
; input:
;    XL   x coord 
;    XH   y coord  
;    Y    array addr
; output:
;    X   display {x,y} coordinates
;    Y   unchanged   
;---------------------------
display_cell:
    call get_cell_state
    push #SPACE 
    tnz a 
    jreq 1$ 
    ld a,#CELL 
    ld (1,sp),a 
1$:
    pop a 
display_char:    
    addw x,#(GRID_TOP<<8)+GRID_LEFT
    _strxz cy 
    call tv_putc 
    ret 

;-------------------------
; toggle cell state at 
; input:
;    XL   gx 
;    XH   gy
;    Y    array addr 
; output:
;     A    inverted cell state 
;     X    unchanged  
;     Y    unchanged 
;-------------------------- 
toggle_cell:
    pushw y 
    call cell_index  
    addw y,(1,sp)
    xor a,(y)
    ld (y),a 
    popw y 
    ret 

;---------------------
; set cell bit in array 
; input:
;   XL   xcoord 
;   XH   ycoord 
;   Y    array addr 
; output:
;   X    unchanged 
;   y    unchanged 
;------------------------ 
set_cell:
    pushw y
    call cell_index 
    addw y,(1,sp)
    or a,(y)
    ld (y),a 
    popw y 
    ret 

;--------------------------
; get top row neighbors
; count
; input:
;    XL   x coord 
;    XH   y coord 
;    Y    grid addr 
; output:
;    A    count
;    X    not changed 
;    Y    not changed 
;--------------------------
    YCOOR=1
    XCOOR=YCOOR+1 
    ADDR=XCOOR+1 
    COUNT=ADDR+2  
    VAR_SIZE=COUNT 
top_count:
    _vars VAR_SIZE 
    clr (COUNT,sp)
    ldw (YCOOR,sp),x 
    ldw (ADDR,sp),y 
    ld a,xh 
    tnz a 
    jreq 9$ ; not top neighbors
    dec a 
    ld xh,a 
    call get_cell_state
    jreq 1$ 
    inc (COUNT,sp)
1$: ld a,xl 
    dec a 
    jrmi 2$ ; no left neighbor
    ld xl,a 
    call get_cell_state
    jreq 2$ 
    inc (COUNT,sp)
2$: ld a,(XCOOR,sp) 
    inc a 
    cp a,#GRID_WIDTH 
    jreq 9$
    ld xl,a  
    call get_cell_state
    jreq 9$ 
    inc (COUNT,sp)
9$: 
    ld a,(COUNT,sp)
    ldw x,(YCOOR,sp)
    ldw y,(ADDR,sp)
    _drop VAR_SIZE 
    ret 

;--------------------------
; get same row neighbors 
; count 
; input:
;    XL   x coord 
;    XH   y coord 
;    Y    grid addr 
; output:
;    A    count  
;    X    not changed 
;    Y    not changed 
;--------------------------
    YCOOR=1
    XCOOR=YCOOR+1 
    ADDR=XCOOR+1 
    COUNT=ADDR+2  
    VAR_SIZE=COUNT 
row_count:
    _vars VAR_SIZE 
    clr (COUNT,sp)
    ldw (YCOOR,sp),x 
    ldw (ADDR,sp),y 
    ld a,xl 
    dec a 
    jrmi 1$ 
    ld xl,a 
    call get_cell_state 
    jreq 1$ 
    inc (COUNT,sp)
1$: ld a,(XCOOR,sp)
    inc a 
    cp a,#GRID_WIDTH
    jreq 2$ 
    ld xl,a 
    call get_cell_state
    jreq 2$ 
    inc (COUNT,sp)
2$: 
    ld a,(COUNT,sp)
    ldw x,(YCOOR,sp)
    ldw y,(ADDR,sp)
    _drop VAR_SIZE 
    ret 

;--------------------------
; get bottom row neighbors 
; count
; input:
;    XL   x coord 
;    XH   y coord 
;    Y    grid addr 
; output:
;    A    count  
;    X    not changed 
;    Y    not changed 
;--------------------------
    YCOOR=1
    XCOOR=YCOOR+1 
    ADDR=XCOOR+1 
    COUNT=ADDR+2  
    VAR_SIZE=COUNT 
bottom_count:
    _vars VAR_SIZE 
    clr (COUNT,sp)
    ldw (YCOOR,sp),x 
    ldw (ADDR,sp),y 
    ld a,xh 
    inc a 
    cp a,#GRID_HEIGHT
    jreq 9$ ; no bottom row
    ld xh,a 
    call get_cell_state
    jreq 1$ 
    inc (COUNT,sp)
1$: 
    ld a,(XCOOR,sp)
    dec a 
    jrmi 2$ ; no left column 
    ld xl,a 
    call get_cell_state
    jreq 2$ 
    inc (COUNT,sp)
2$: 
    ld a,(XCOOR,sp)
    inc a 
    cp a,#GRID_WIDTH
    jreq 9$ ; no right column 
    ld xl,a 
    call get_cell_state
    jreq 9$ 
    inc (COUNT,sp)
9$: 
    ld a,(COUNT,sp)
    ld a,(COUNT,sp)     
    ldw x,(YCOOR,sp)
    ldw y,(ADDR,sp)
    _drop VAR_SIZE 
    ret 

;----------------------
; input:
;    XL    x coord 
;    XH    Y coord 
;    y     array addr 
; output:
;    A     count 
;    X     not changed 
;    Y     not changed 
;----------------------
neighbor_count: 
    call top_count 
    push a 
    call bottom_count 
    add a,(1,sp)
    cp a,#4 
    jrpl 9$
    ld (1,sp),a 
    call row_count 
    add a,(1,sp)
9$:
    _drop 1
    ret 

;--------------------------
; compute next generation
; from src array to  
; dest array. 
; update display as each 
; cell is evaluated.
;--------------------------
    YCOOR=1
    XCOOR=YCOOR+1
    COL_COUNT=XCOOR+1
    ROW_COUNT=COL_COUNT+1
    INDEX=ROW_COUNT+1
    MASK=INDEX+2
    STATE=MASK+1 
    VAR_SIZE=STATE 
next_gen:
    _vars VAR_SIZE
    clr (YCOOR,sp)
    ld a,#GRID_HEIGHT
    ld (ROW_COUNT,sp),a 
1$: ;row loop 
    clr (XCOOR,sp)
    ld a,#GRID_WIDTH
    ld (COL_COUNT,sp),a 
2$: ;column loop 
    ldw x,(YCOOR,sp)
    call cell_index 
    ld (MASK,sp),a 
    ldw (INDEX,sp),y
; reset dest cell 
    addw y,dest 
    cpl a 
    and a,(y)
    ld (y),a
; get source cell state        
    ldw y,src
    addw y,(INDEX,sp) 
    ld a,(y)
    and a,(MASK,sp)
    ld (STATE,sp),a 
    ldw y,src 
    call neighbor_count
    ldw y,dest
    addw y,(INDEX,sp) 
    cp a,#2
    jreq 3$ ; ==2 no cell change  
    jrmi 4$ ; <2 reset cell 
    cp a,#4 
    jrpl 4$ ; >=4 reset cell  
; ==3 set cell     
    ld a,(MASK,sp)
    jra 5$ 
3$: ; no cell change 
    ld a,(STATE,sp)
    jra 5$      
4$: ; reset cell 
    clr a 
5$: or a,(y)
    ld (y),a ; new state in dest array 
    ldw x,(YCOOR,sp)
    _ldyz dest
    call display_cell
    inc (XCOOR,sp)
    dec (COL_COUNT,sp)
    jrne 2$ 
    inc (YCOOR,sp)
    dec (ROW_COUNT,sp)
    jrne 1$     
    _ldxz gen 
    incw x
    _strxz gen 
    _ldyz src 
    _ldxz dest 
    _strxz src 
    _stryz dest 
    _drop VAR_SIZE 
    ret 

gen_str: .asciz "GENERATION: "
init_str: .asciz "create pattern";
erase_str: .asciz "              ";


;---------------------
; user initialize grid 
; moving cursor around
;---------------------
    YCOOR=1
    XCOOR=YCOOR+1
    KEY=XCOOR+1 
    VAR_SIZE=KEY 
grid_init:
    _vars VAR_SIZE 
    clr (KEY,sp)
    ldw x,#(GRID_CNTR_Y<<8)+GRID_CNTR_X
    ldw (YCOOR,sp),x
    call tv_cls 
    ldw y,#init_str 
    call tv_puts 
1$: ldw x,#10
    call wait_key_release
    ld a,#BLOCK
    ldw x,(YCOOR,sp) 
    call display_char  
    call wait_key 
    ld (KEY,sp),a 
    ldw x,(YCOOR,sp)
    _ldyz src 
    call display_cell 
    ld a,#BTN_UP 
    cp a,(KEY,sp)
    jrne 2$ 
    tnz (YCOOR,sp)
    jreq 1$ 
    dec (YCOOR,sp)
    jra 1$ 
2$:  ld a,#BTN_DOWN 
    cp a,(KEY,sp)
    jrne 4$
    ld a,#GRID_HEIGHT-1 
    cp a,(YCOOR,sp)
    jreq 1$ 
    inc (YCOOR,sp)
    jra 1$ 
4$: ld a,#BTN_LEFT
    cp a,(KEY,sp)
    jrne 6$
    tnz (XCOOR,sp)
    jreq 1$ 
    dec (XCOOR,sp)
    jra 1$ 
6$: ld a,#BTN_RIGHT 
    cp a,(KEY,sp)
    jrne 8$ 
    ld a,#GRID_WIDTH-1 
    cp a,(XCOOR,sp) 
    jreq 1$ 
    inc (XCOOR,sp)
    jra 1$ 
8$: ld a,#BTN_A
    cp a,(KEY,sp)
    jrne 12$ 
    ldw y,src 
    ldw x,(YCOOR,sp)
    call toggle_cell
    call display_cell
    jra 1$
12$: ld a,#BTN_B 
     cp a,(KEY,sp)
     jrne 1$    
    ldw y,#erase_str
    clrw x 
    _strxz cy 
    call tv_puts 
    call wait_key_release
    _drop VAR_SIZE
    ret 

;---------------------------
; game of life 
; simulation entry function
;---------------------------
game_of_life:
    call life_init
    ldw y,#patterns 
    call menu 
    tnzw x 
    jrne 1$
    ret 
1$: cpw x,#free_hand 
    jrne set_pattern 
free_hand:
    call grid_init
sim_init:
    clrw x 
    _strxz cy 
    ldw y,#erase_str
    call tv_putc 
    clrw x 
    _strxz cy 
    ldw y,#gen_str
    call tv_puts 
sim:
    call print_gen
    call next_gen
ld a,#15 
call pause     
    call kpad_input 
    jreq sim  
    jra game_of_life

;-------------------------
; set predefined pattern 
; input:
;   x     pattern address 
;-------------------------
    PATTERN=1
    VAR_SIZE=2 
set_pattern:
    _vars VAR_SIZE 
    ldw y,src 
1$: ldw (PATTERN,sp),x 
    ldw x,(x)
    cpw x,#-1 
    jreq 9$
    call set_cell
    ldw x,(PATTERN,sp)
    addw x,#2
    jra 1$  
9$: 
    _drop VAR_SIZE 
    jp sim_init


; liste de configuration prédéfinie 
patterns:
.asciz "FREE HAND"
.word free_hand 
.asciz "GLIDER"
.word glider 
.asciz "CLOCK"
.word clock
.asciz "PENTADECATHLON"
.word pentadecathon
.asciz "PENTOMINO R"
.word pento_r 
.asciz "EXIT" 
.word  0  
.word 0 

  .macro _coord x,y 
  .word ((y+GRID_CNTR_Y)<<8)+x+GRID_CNTR_X   
  .endm 

PATTERN_END=0XFFFF   
glider: 
    _coord 1,0 
    _coord 2,1
    _coord 2,2 
    _coord 1,2
    _coord 0,2 
    .word PATTERN_END 

clock:
    _coord 6,0
    _coord 7,0
    _coord 6,1
    _coord 7,1
    _coord 4,3
    _coord 5,3
    _coord 6,3
    _coord 7,3
    _coord 0,4
    _coord 1,4
    _coord 3,4
    _coord 6,4
    _coord 8,4
    _coord 0,5 
    _coord 1,5
    _coord 3,5
    _coord 5,5 
    _coord 8,5
    _coord 3,6
    _coord 5,6
    _coord 8,6
    _coord 10,6
    _coord 11,6
    _coord 3,7
    _coord 8,7
    _coord 10,7
    _coord 11,7
    _coord 4,8
    _coord 5,8
    _coord 6,8
    _coord 7,8 
    _coord 4,10
    _coord 5,10
    _coord 4,11 
    _coord 5,11
    .word PATTERN_END 

pentadecathon:
    _coord 2,0
    _coord 7,0
    _coord 0,1
    _coord 1,1
    _coord 3,1
    _coord 4,1
    _coord 5,1
    _coord 6,1
    _coord 8,1
    _coord 9,1
    _coord 2,2 
    _coord 7,2
    .word PATTERN_END 

pento_r:
    _coord 1,0
    _coord 1,1 
    _coord 2,1
    _coord 0,2
    _coord 1,2
    .word PATTERN_END 
