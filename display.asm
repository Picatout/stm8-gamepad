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
    ldw x,#VBUFF_SIZE
    pushw x 
    ldw x,#tv_buffer
1$: clr (x)
    incw x 
    dec (2,sp)
    jrne 1$ 
    dec (1,sp)
    jrne 1$
    _clrz cx 
    _clrz cy 
    _drop 2
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
    _ldaz cx 
    inc a 
    _straz cx 
    cp a,#16
    jrmi 3$
    _clrz cx 
    _ldaz cy 
    inc a 
    and a,#7 
    _straz cy 
3$:    
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