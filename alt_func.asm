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

;-----------------------------
; Alternate functions mapping 
;-----------------------------
	.area OPT2 (ABS)
	.org 0x4800

opt0:    .byte 0  ; opt 0
opt1:    .byte 0  ; opt1
nopt1:   .byte 0xff ; opt1 
opt2:    .byte 0x2 
nopt2:   .byte 0xfd 



    .area HOME 
    .area SSEG 
    .area DATA  

