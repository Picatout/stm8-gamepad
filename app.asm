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
    call tv_puts 
1$:
    call crlf 
    _ldxz ticks 
    _strxz acc16 
    call put_uint16 
    ld a,#139
    call pause
    jra 1$ 

qbf: .asciz "THE QUICK BROWN FOX JUMP OVER THE LAZY DOG."