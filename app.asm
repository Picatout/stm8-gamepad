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

main:
    call beep
    call tv_cls
    ldw y,#qbf
1$: _clrz cx 
    ld a,#4 
    _straz cy  
    ld a,#SPACE 
    call tv_putc 
    ldw x,#0x3030
    ldw y,#check_board 
    ld a,#8 
    call put_sprite 
    tnz a 
    jreq 2$
    _clrz cx 
    ld a,#4 
    _straz cy 
    ld a,#'C 
    call tv_putc
2$:
    ld a,#50 
    call pause 
    jra 1$ 

qbf: .asciz "THE QUICK BROWN FOX JUMP OVER THE LAZY DOG."

check_board: .byte 0xAA,0x55,0xAA,0x55,0xAA,0x55,0xAA,0x55