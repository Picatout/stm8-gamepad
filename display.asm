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


CHAR_PER_LINE=33
LINE_PER_SCREEN=24

    .macro _curpos x,y 
    ldw x,#(y<<8)+x 
    _strxz cy 
    .endm 
    
;--------------------------
; clear tv display 
;--------------------------
tv_cls:
    pushw y 
    ldw x,#VBUFF_SIZE 
    ldw y,#tv_buffer
1$: clr (y)
    incw y 
    decw x 
    jrne 1$
    _clrz cx 
    _clrz cy   
    popw y 
    ret 

;----------------------
; clear text line 
; input:
;     A  line# 
;-----------------------
clr_text_line: 
    pushw x
    pushw y  
    ldw x,#FONT_HEIGHT*BYTES_PER_LINE 
    ldw y,x 
    mul y,a 
    addw y,#tv_buffer 
    clr a 
    call fill 
    popw y 
    popw x 
    ret 


;------------------------
; build bitmask from 
; bit position 
; input:
;    A    position {0..7}
;------------------------
bit_mask:
    push a 
    ld a,#128 
1$: tnz (1,sp)
    jreq 9$ 
2$:
    srl a 
    dec (1,sp)
    jrne 2$
9$: _drop 1 
    ret 

;------------------------
; compute pixel address 
; and bit mask from 
; from coordinates 
; input:
;     XH   y coord 
;     XL   x coord 
; output:
;     A    bit mask 
;     X    byte address 
;------------------------
    YCOOR=1
    XCOOR=2 
    BOFS=3  ; byte offset 
    BOFSL=4  ; xcoord/8
    BPOS=5   ; bit position xcoord%8
    VAR_SIZE=5
pixel_addr:
    _vars VAR_SIZE
    ldw (YCOOR,sp),x 
    clrw x 
    ldw (BOFS,sp),x 
    ld a,(XCOOR,sp)
    ld xl,a 
    ld a,#8 
    div x,a 
;    sub a,#7 
;    neg a 
    ld (BPOS,sp),a
    ld a,xl 
    ld (BOFSL,sp),a 
    ld a,(YCOOR,sp)
    ldw x,#BYTES_PER_LINE 
    mul x,a 
    addw x,#tv_buffer
    addw x,(BOFS,sp)
    ld a,(BPOS,sp)
    call bit_mask 
    _drop VAR_SIZE  
    ret 

;-----------------------------
; return pixel state 
; input:
;      A    pixel state 
;     XH    y coord {0..63}
;     XL    x coord (0..95)
;---------------------------
put_pixel:
    tnz a 
    jreq reset_pixel

;-------------------------
; set pixel 
; input:
;     XH    y coord {0..63}
;     XL    x coord (0..95)
;---------------------------
set_pixel:
    call pixel_addr
    or a,(x)
    ld (x),a 
    ret 

;-------------------------
; reset pixel 
; input:
;     XH    y coord {0..63}
;     XL    x coord (0..95)
;---------------------------
reset_pixel:
    call pixel_addr
    cpl a 
    and a,(x)
    ld (x),a 
    ret 

;-------------------------
; invert pixel 
; input:
;     XH    y coord {0..63}
;     XL    x coord (0..95)
;---------------------------
invert_pixel:
    call pixel_addr 
    xor a,(x)
    ld (x),a 
    ret 

;-----------------------------
; return pixel state 
; input:
;     XH    y coord {0..63}
;     XL    x coord (0..95)
;---------------------------
get_pixel:
    call pixel_addr 
    and a,(x)
    ret 


;-----------------------------
; move text 1 line up 
; clear bottom line 
;-----------------------------
scroll_text_up:
    push a 
    pushw x 
    pushw y 
; count bytes to copy     
    ldw x,#(VRES-FONT_HEIGHT)*BYTES_PER_LINE
    _strxz acc16  
; destination address     
    ldw x,#tv_buffer 
    ldw y,x 
; source address     
    addw y,#BYTES_PER_LINE*FONT_HEIGHT 
    call move 
; clear bottom text line 
    ld a,#LINE_PER_SCREEN-1
    call clr_text_line
    popw y 
    popw x 
    pop a 
    ret 

;----------------------------
; move text cursor to 
; next line 
;----------------------------
crlf:
    _clrz cx 
    _ldaz cy 
    inc a
    cp a,#LINE_PER_SCREEN
    jrmi 1$
    call scroll_text_up
    ret  
1$: 
    _straz cy 
    ret 

;------------------------------
; move text cursor right 
;------------------------------
cursor_right:
    _incz cx 
    _ldaz cx 
    cp a,#CHAR_PER_LINE  
    jrpl crlf 
    ret 

;-------------------------
; put character on tv 
; input:
;    A    character 
;------------------------
    XCOORH=1
    XCOOR=XCOORH+1
    BYTECNT=XCOOR+1
    SHIFT=BYTECNT+1
    MASK=SHIFT+1
    ROW=MASK+2
    VAR_SIZE=ROW+1  
tv_putc:
    pushw y 
    pushw x 
    _vars VAR_SIZE 
    cp a,#CR 
    jrne 1$ 
    call crlf 
    jp 9$
 1$:
    sub a,#SPACE 
    ldw x,#FONT_HEIGHT
    mul x,a 
    addw x,#font_6x8
    ldw y,x 
    ldw x,#0x03ff
    ldw (MASK,sp),x 
    ld a,#FONT_HEIGHT
    ld (BYTECNT,sp),a 
    _ldaz cx 
    ldw x,#FONT_WIDTH  
    mul x,a
    ld a,#8 
    div x,a 
    ld (SHIFT,sp),a 
    ldw (XCOORH,sp),x     
    _ldaz cy 
    ldw x,#FONT_HEIGHT
    mul x,a 
    ld a,#BYTES_PER_LINE
    mul x,a 
    addw x,(XCOORH,sp)
    addw x,#tv_buffer 
; shift MASK 
    ld a,(SHIFT,sp)
    jreq 4$
    scf 
3$: rrc (MASK,sp)
    rrc (MASK+1,sp)
    dec a 
    jrne 3$
; get font row 
; and shift it 
4$:     
    ld a,(y)
    incw y 
    ld (ROW,sp),a 
    clr (ROW+1,sp)
    ld a,(SHIFT,sp)
    jreq 6$ 
5$:  
    srl (ROW,sp)
    rrc (ROW+1,sp)
    dec a 
    jrne 5$ 
6$: 
    ld a,(MASK,sp)
    and a,(x)
    or a,(ROW,sp)
    ld (x),a 
    ld a,(1,x)
    and a,(MASK+1,sp)
    or a,(ROW+1,sp)
    ld (1,x),a 
    addw x,#BYTES_PER_LINE
    dec (BYTECNT,sp)
    jrne 4$ 
    call cursor_right
9$:
    _drop VAR_SIZE 
    popw x 
    popw y
    ret 

;--------------------------
; put string on tv 
; input:
;   Y     *asciz 
;--------------------------
tv_puts:
    ld a,(y)
    jreq 9$
    incw y 
    call tv_putc 
    jra tv_puts 
9$:
    ret

;--------------------------
; center align text
; on display  
; input:
;     Y   *string ; len {0..CHAR_PER_LINE}
; output:
;     Y   to terminating 0
;--------------------------
center_align:
    call strlen 
    sub a,#CHAR_PER_LINE
    neg a 
    srl a 
    _straz cx 
    call tv_puts 
    ret 

;----------------------------
; print unsigned integer 
; input:
;    X uint16_t 
;-----------------------------
    UINT=1
    ISTR=UINT+2 
    VAR_SIZE=ISTR+5
put_uint16:
    pushw y 
    _vars VAR_SIZE 
    ldw (UINT,sp),x 
    ldw x,sp 
    addw x,#ISTR+5
    ldw y,x 
    clr (y)
    ldw x,(UINT,sp) 
1$: decw y 
    ld a,#10 
    div x,a 
    add a,#'0 
    ld (y),a
    tnzw x 
    jrne 1$ 
    call tv_puts 
    _drop VAR_SIZE 
    popw y 
    ret 

;-----------------------
; scroll all display up 
; until display is empty  
; or key pressed.
; input:
;    A   speed delay 
;----------------------
	ROWS=1
	LOOP_DLY=2
	VAR_SIZE=2
roll_up: 
	push a 
	push #VRES
1$: 
	ldw x,#VRES<<8 
    call scroll_up 
	ld a,(LOOP_DLY,sp)
	call pause 
	dec (ROWS,sp)
	jreq 9$ 
	call read_keypad
	jreq 1$ 
9$:	ldw x,#255
    call wait_key_release
	_drop VAR_SIZE 
	ret 

;-------------------------------
; line drawing 
;  X0<=X1 
;  Y0<=Y1 
; input:
;     XH  x0 
;     XL  x1 
;     YH  y0 
;     YL  y1 
;--------------------------------
    X0=1  ; int8 
    X1=2  ; int8 
    Y0=3  ; int8 
    Y1=4  ; int8 
    DX=5   ; int16 
    DY=7   ; int16 
    DELTA=9 ; int16 
    VAR_SIZE=10
line:
    _vars VAR_SIZE 
    ldw (X0,sp),x
    ldw (Y0,sp),y
    ld a,xh 
    cp a,(X1,sp)
    jreq 3$ ; vertical line 
    ld a,yh 
    cp a,(Y1,sp)
    jreq 4$ ; horizontal line
    ld a,(X1,sp)
    sub a,(X0,sp)
    clrw x 
    ld xl,a 
    ldw (DX,sp),x 
    ld a,(Y1,sp)
    sub a,(Y0,sp)
    ld xl,a 
    ldw (DY,sp),x 
    sllw x 
    subw x,(DX,sp)
    ldw (DELTA,sp),x 
1$:  
    ld a,(X0,sp)
    cp a,(X1,sp)
    jreq 9$ 
    ld xl,a 
    ld a,(Y0,sp)
    ld xh,a
    call set_pixel 
    ldw x,(DELTA,sp)
    tnzw x
    jrmi 2$
    inc (Y0,sp)
    subw x,(DX,sp)
    subw x,(DX,sp)
2$: 
    addw x,(DY,sp)
    addw x,(DY,sp)
    ldw (DELTA,sp),x  
    inc (X0,sp)
    jra 1$
3$: ; vertical line 
    ld a,(X0,sp)
    ld xl,a 
    ld a,(Y0,sp)
    ld xh,a 
    call set_pixel 
    inc (Y0,sp)
    ld a,(Y0,sp)
    cp a,(Y1,sp)
    jrult 3$ 
    jra 9$ 
4$: ; horizontal line 
    ld a,(X0,sp)
    ld xl, a 
    ld a,(Y0,sp)
    ld xh,a 
    call set_pixel
    inc (X0,sp)
    ld a,(X0,sp)
    cp a,(X1,sp)
    jrult 4$  
9$:
    _drop VAR_SIZE 
    ret 


;----------------------------
; draw rectangle 
; X={x0,y0} top left corner 
; Y={x1,y1} down right corner 
;
; input:
;    XH   top   ycoord 
;    XL   left  xcoord 
;    YH   down 
;    YL   right    
;---------------------------
    BOTTOM =1
    RIGHT=BOTTOM+1 
    TOP=RIGHT+1
    LEFT=TOP+1
rectangle:
    pushw x
    pushw y 
; top horizontal
    ld a,xh 
    ld yh,a ; y0
    ld yl,a ; y1
    swapw x ; XH=x0  
    ld a,(RIGHT,sp)
    ld xl,a ; x1  
    call line 
; bottom horizontal     
    ld a,(LEFT,sp)
    ld xh,a ; x0 
    ld a,(RIGHT,sp)
    ld xl,a ; x1   
    ld a,(BOTTOM,sp)
    ld yh,a ; y0 
    ld yl,a ; y1
    call line 
; left vertical
    ld a,(LEFT,sp)
    ld xh,a ; x0 
    ld xl,a ; x1 
    ld a,(TOP,sp)
    ld yh,a ; y0 
    ld a,(BOTTOM,sp)
    inc a 
    ld yl,a ; y1 
    call line 
; right vertical     
    ld a,(RIGHT,sp)
    ld xh,a ; x0 
    ld xl,a ; x1 
    ld a,(TOP,sp)
    ld yh,a ; y0 
    ld a,(BOTTOM,sp)
    inc a 
    ld yl,a ; y1  
    call line 
    popw y 
    popw x 
    ret 


;--------------------------------------
; use invert_pixel 
; to put sprite on screen 
; normal sprite are 8 bits wide 
; n rows 
; input:
;     A     row count 
;     XH    ycoord 
;     XL    xcoord
;     Y     sprite address  
; output:
;     A     collision if not null
;     Z     if not zero the collision  
;-------------------------------------
    ROWS=1
    SPRITE=ROWS+1 
    SHIFT=SPRITE+2
    COLL=SHIFT+1
    EDGE=COLL+1
    VAR_SIZE=EDGE
put_sprite:
    _vars VAR_SIZE 
    clr (COLL,sp) 
    ld (ROWS,sp),a
    clr (EDGE,sp)
    ld a,xl  
    srl a 
    srl a  
    srl a 
    cp a,#BYTES_PER_LINE-1
    jrmi 0$ 
    cpl (EDGE,sp) 
0$:  
    call pixel_addr 
    ld (SHIFT,sp),a
1$:    
    clr (SPRITE+1,sp)
    ld a,(y)
    incw y 
    ld (SPRITE,sp),a 
    ld a,(SHIFT,sp)
2$: jrmi 4$
3$: ; shift sprite and mask
    srl (SPRITE,sp)
    rrc (SPRITE+1,sp)
    sll a
    jrpl 3$ 
4$: 
    ld a,(SPRITE,sp)
    xor a,(x)
    ld (x),a
    and a,(SPRITE,sp)
    cp a,(SPRITE,sp)
    jreq 5$
    inc (COLL,sp)
5$: tnz (EDGE,sp) 
    jrne 6$ 
    ld a,(SPRITE+1,sp)
    xor a,(1,x)
    ld (1,x),a 
    and a,(SPRITE+1,sp) 
    cp a,(SPRITE+1,sp)
    jreq 6$
    inc (COLL,sp)
6$: addw x,#BYTES_PER_LINE 
    dec (ROWS,sp)
    jrne 1$
    ld a,(COLL,sp)
    _drop VAR_SIZE 
    ret 


;---------------------
; scroll up 1 line 
; from [XL..XH[
; input: 
;   XL  first line 
;   XH  last line 
;---------------------
scroll_up:
    push a 
    pushw y 
    pushw x 
; move bytes count     
    ld a,xh 
    sub a,(2,sp)
    ldw x,#BYTES_PER_LINE
    mul x,a 
    subw x,#BYTES_PER_LINE 
    _strxz acc16 
; dest addr 
    ld a,(2,sp)
    ldw x,#BYTES_PER_LINE
    mul x, a 
    addw x,#tv_buffer
; source addr 
    ldw y,x 
    addw y,#BYTES_PER_LINE
    call move 
; clear line XH-1 
    ld a,(1,sp)
    dec a 
    ldw x,#BYTES_PER_LINE
    ldw y,x 
    mul y,a 
    addw y,#tv_buffer
    clr a 
    call fill  
    popw x  
    popw y 
    pop a 
    ret 

;----------------------
; scroll down 1 line 
; from [XL..XH[
; input:
;    XL   first line 
;    XH   last line 
;----------------------
scroll_down: 
    push a 
    pushw y 
    pushw x 
; move bytes count 
    ld a,xh 
    sub a,(2,sp) ; XL 
    ldw x,#BYTES_PER_LINE
    mul x,a
    subw x,#BYTES_PER_LINE  
    _strxz acc16 
; source addr 
    ld a,(2,sp) ; XL 
    ldw y,#BYTES_PER_LINE
    mul y,a 
    addw Y,#tv_buffer
; destinaton addr     
    ldw x,y 
    addw x,#BYTES_PER_LINE 
    call move 
; clear line XL 
    ld a,(2,sp) ; XL  
    ldw x,#BYTES_PER_LINE
    ldw y,x 
    mul y,a 
    addw y,#tv_buffer
    clr a 
    call fill  
    popw x  
    popw y 
    pop a 
    ret 

;------------------------------
; shift video line 
; 4 pixels left 
; input:
;    A   video line {0..VRES-1}
;-------------------------------

left_4pixels:
    pushw x 
    pushw y 
    ldw x,#BYTES_PER_LINE
    ldw y,x 
    mul x,a 
    addw x,#tv_buffer
1$:
    ld a,(x)
    swap a 
    and a,#0xf0 
    push a 
    ld a,(1,x)
    swap a 
    and a,#0xf 
    or a,(1,sp)
    _drop 1 
    decw y 
    jreq 2$
    ld (x),a 
    incw x
    jra 1$
2$: and a,#0xf0
    ld (x),a 
    popw y 
    popw x 
    ret 

;-------------------
; scroll left  4 pixels
; from [XL..XH[ 
; input:
;   XL   first line 
;   XH   last line 
;-------------------
scroll_left:
    pushw x 
    ld a,(2,sp)
1$:
    call left_4pixels 
    inc (2,sp)
    ld a,(2,sp)
    cp a,(1,sp)
    jrmi 1$
    popw x 
    ret 

;-------------------
; shift video line 
; 4 pixels right 
; input:
;     A   line 
;-------------------
right_4pixels:
    pushw y 
    pushw x 
    inc a 
    ldw x,#BYTES_PER_LINE
    ldw y,x 
    mul x,a
    subw x,#2  
    addw x,#tv_buffer 
1$: ld a,(1,x)
    and a,#0xf0
    swap a 
    push a
    ld a,(x)
    and a,#0xf 
    swap a 
    or a,(1,sp)
    ld (1,x),a
    _drop 1
    decw y 
    jreq 2$ 
    decw x 
    jra 1$
2$: ld a,#0xf 
    and a,(1,x)
    ld (1,x),a 
    popw x 
    popw y 
    ret 

;-------------------
; scroll right 
; 4 pixels 
; input:
;   XL   first line 
;   XH   last line 
;-------------------
scroll_right:
    pushw x 
    ld a,(2,sp)
1$: 
    call right_4pixels 
    inc (2,sp)
    ld a,(2,sp)
    cp a,(1,sp)
    jrmi 1$
    popw x 
    ret 

