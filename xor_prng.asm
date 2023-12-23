;;
; Copyright Jacques Deschênes 2023  
; This file is part of xor_prng 
;
;     xor_prng is free software: you can redistribute it and/or modify
;     it under the terms of the GNU General Public License as published by
;     the Free Software Foundation, either version 3 of the License, or
;     (at your option) any later version.
;
;     xor_prng is distributed in the hope that it will be useful,
;     but WITHOUT ANY WARRANTY; without even the implied warranty of
;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;     GNU General Public License for more details.
;
;     You should have received a copy of the GNU General Public License
;     along with xor_prng.  If not, see <http://www.gnu.org/licenses/>.
;;



;---------------------------------
; Pseudo Random Number Generator 
; XORShift algorithm.
; 32 bits seed.
;---------------------------------

;---------------------------------
;  seedx:seedy= x:y ^ seedx:seedy
; output:
;  X:Y   seedx:seedy new value   
;---------------------------------
xor_seed32:
    ld a,xh 
    _xorz seedx 
    _straz seedx
    ld a,xl 
    _xorz seedx+1 
    _straz seedx+1 
    ld a,yh 
    _xorz seedy
    _straz seedy 
    ld a,yl 
    _xorz seedy+1 
    _straz seedy+1 
    _ldxz seedx  
    _ldyz seedy 
    ret 

;-----------------------------------
;   x:y= x:y << a 
;  input:
;    A     shift count 
;    X:Y   uint32 value 
;  output:
;    X:Y   uint32 shifted value   
;-----------------------------------
sll_xy_32: 
    sllw y 
    rlcw x
    dec a 
    jrne sll_xy_32 
    ret 

;-----------------------------------
;   x:y= x:y >> a 
;  input:
;    A     shift count 
;    X:Y   uint32 value 
;  output:
;    X:Y   uint32 shifted value   
;-----------------------------------
srl_xy_32: 
    srlw x 
    rrcw y 
    dec a 
    jrne srl_xy_32 
    ret 

;-------------------------------------
;  PRNG generator proper 
; input:
;   none 
; ouput:
;   X     bits 31...16  PRNG seed  
;  use: 
;   seedx:seedy   system variables   
;--------------------------------------
prng::
	pushw y   
    _ldxz seedx
	_ldyz seedy  
	ld a,#13
    call sll_xy_32 
    call xor_seed32
    ld a,#17 
    call srl_xy_32
    call xor_seed32 
    ld a,#5 
    call sll_xy_32
    call xor_seed32
    popw y 
    ret 


;---------------------------------
; initialize seedx:seedy 
; input:
;    X    0 -> seedx=ticks, seedy=[0x6000] 
;    X    !0 -> seedx=X, y=[0x6000], seedy=swapw(y)
;-------------------------------------------
set_seed:
    tnzw x 
    jrne 1$ 
    ldw x,ticks 
    _strxz seedx
    ldw x,#0x6000  
    _strxz seedy  
    ret 
1$:  
    _strxz seedx
    ldw y,0x6000
    swapw y 
    _stryz seedy 
    ret 


