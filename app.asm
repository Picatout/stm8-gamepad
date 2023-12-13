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

    CY=1
    CX=CY+1
    OLDY=CX+1
    OLDX=OLDY+1
    KPAD=OLDX+1
    VAR_SIZE=KPAD
main:
.if 0
    _vars VAR_SIZE 
    ldw x,#0x1C2C  
    ldw (CY,sp),x 
    ldw (OLDY,sp),x 
.endif 
    call beep
    call snake 
    call tv_cls
.if 0    
    ldw y,#qbf 
    call tv_puts     
ldw x,#0
ldw y,#(24<<8)+63
call line 
ldw x,#(2<<8)+2
ldw y,#(24<<8)+63 
call line 
jra .
inf_loop:
wfi 
jra inf_loop     
.endif 
    ldw x,(CY,sp)
    ldw y,#check_board 
    ld a,#8 
    call put_sprite 
0$:  
    ldw x,(OLDY,sp)
    cpw x,(CY,sp)
    jreq 1$ 
    ldw y,#check_board 
    ld a,#8 
    call put_sprite
    ldw x,(CY,sp)
    ldw (OLDY,sp),x
    ld a,#8 
    ldw y,#check_board
    call put_sprite 
1$:
    call read_keypad
    ld (KPAD,sp),a 
    ld a,#BTN_RIGHT 
    and a,(KPAD,sp)
    jreq 2$
    ld a,(CX,sp)
    cp a,#HRES-8 
    jreq 8$ 
    inc (CX,sp) 
    jra 8$
2$:   
    ld a,#BTN_LEFT
    and a,(KPAD,sp) 
    jreq 3$ 
    tnz (CX,sp)
    jreq 8$ 
    dec (CX,sp)
    jra 8$ 
3$: 
    ld a,#BTN_DOWN
    and a,(KPAD,sp)
    jreq 4$ 
    ld a,(CY,sp)
    cp a,#VRES-8 
    jreq 8$ 
    inc (CY,sp) 
    jra 8$ 
4$: 
    ld a,#BTN_UP
    and a,(KPAD,sp)
    jreq 8$ 
    tnz (CY,sp)
    jreq 8$ 
    dec (CY,sp)
8$:
    ld a,#4 
    call pause 
    jra 0$ 

qbf: .asciz "THE QUICK BROWN FOX JUMP OVER THE LAZY DOG."

check_board: .byte 0xAA,0x55,0xAA,0x55,0xAA,0x55,0xAA,0x55