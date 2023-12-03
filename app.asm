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
    clrw x 
    call set_seed  
1$:  
    call prng 
    ld a,#HRES 
    div x,a 
    push a 
    call prng 
    ld a,#VRES 
    div x,a 
    ld xh,a 
    pop a 
    ld xl,a 
    call invert_pixel 
    jra 1$ 


