;;
; Copyright Jacques Deschênes 2023  
; This file is part of ntsc_tuto 
;
;     ntsc_tuto is free software: you can redistribute it and/or modify
;     it under the terms of the GNU General Public License as published by
;     the Free Software Foundation, either version 3 of the License, or
;     (at your option) any later version.
;
;     ntsc_tuto is distributed in the hope that it will be useful,
;     but WITHOUT ANY WARRANTY; without even the implied warranty of
;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;     GNU General Public License for more details.
;
;     You should have received a copy of the GNU General Public License
;     along with ntsc_tuto.  If not, see <http://www.gnu.org/licenses/>.
;;


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
    popw y 
    ret 

;------------------------
; build bitmask from 
; bit position 
; input:
;    A    position {0..7}
;------------------------
bit_mask:
    push a 
    ld a,#1 
1$: tnz (1,sp)
    jreq 9$ 
2$:
    sll a 
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
    sub a,#7 
    neg a 
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
; move text 1 line up 
; clear bottom line 
;-----------------------------
scroll_up:
    push a 
    pushw x 
    pushw y 
; count bytes to copy     
    ldw x,#(VRES-FONT_HEIGHT)*BYTES_PER_LINE
    pushw x 
; destination address     
    ldw x,#tv_buffer 
    ldw y,x 
; source address     
    addw y,#BYTES_PER_LINE*FONT_HEIGHT 
1$: ld a,(y)
    incw y 
    ld (x),a
    incw x
    pushw x 
    ldw x,(3,sp)
    decw x
    ldw (3,sp),x 
    popw x 
    jrne 1$     
; clear bottom text line 
    ldw x,#(FONT_HEIGHT*BYTES_PER_LINE) 
    ldw (1,sp),x 
    subw y,(1,sp)
2$: clr (y)
    incw y 
    decw x 
    jrne 2$    
    _drop 2     
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
    cp a,#8
    jrmi 1$
    call scroll_up
    ret  
1$: 
    _straz cy 
    ret 

;------------------------------
; move text cursor right 
;------------------------------
cursor_right:
    _ldaz cx 
    inc a 
    _straz cx 
    cp a,#16 
    jrmi 2$ 
    call crlf  
2$:
    ret 

;-------------------------
; put character on tv 
; input:
;    A    character 
;------------------------
    YCOOR=1
    XCOOR=YCOOR+1
    BYTECNT=XCOOR+1
    BITCNT=BYTECNT+1
    BYTE=BITCNT+1
    VAR_SIZE=BYTE  
tv_putc:
    pushw y 
    _vars VAR_SIZE 
    sub a,#SPACE 
    ldw x,#FONT_HEIGHT
    mul x,a 
    addw x,#font_6x8
    ldw y,x 
    _ldaz cx 
    ldw x,#FONT_WIDTH  
    mul x,a
    ld a,xl     
    ld (XCOOR,sp),a 
    _ldaz cy 
    ld xl,a 
    ld a,#FONT_HEIGHT
    ld (BYTECNT,sp),a 
    mul x,a
    ld a,xl 
    ld (YCOOR,sp),a 
10$:
    ld a,#FONT_WIDTH
    ld (BITCNT,sp),a 
    ld a,(y)
    incw y 
    ld (BYTE,sp),a
0$:
    ldw x,(YCOOR,sp)
    sll (BYTE,sp)    
    jrc 1$ 
    call reset_pixel
    jra 2$ 
1$: call set_pixel 
2$: 
    inc (XCOOR,sp)
    dec (BITCNT,sp)
    jrne 0$
    ld a,(XCOOR,sp)
    sub a,#FONT_WIDTH
    ld (XCOOR,sp),a 
    inc (YCOOR,sp)
    dec (BYTECNT,sp)
    jrne 10$
    call cursor_right
    _drop VAR_SIZE 
    popw y 
    ret 

;--------------------------
; put string on tv 
; input:
;   Y     *aciz 
;--------------------------
tv_puts:
    ld a,(y)
    jreq 9$
    incw y 
    call tv_putc 
    jra tv_puts 
9$:
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
9$:
    _drop VAR_SIZE 
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
