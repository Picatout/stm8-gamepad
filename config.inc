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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  configuration parameters 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;-----------------------
;  version  
;  information 
;-----------------------
	MAJOR=1
	MINOR=3
	REV=0

; set to 1 to add dbg_print code 
DEBUG=0

; set to 1 when using NUCLEO-8S207K8 
NUCLEO=0

; master clock frequency in hz 
	FMSTR=16000000 

SOUND_PORT=PD_BASE 
SOUND_BIT=(0)


; navigation buttons 
KPAD_PORT=PB_BASE 
KPAD_IDR=PB_IDR
BIT_A=(5)
BIT_B=(4)
BIT_LEFT=(0)
BIT_RIGHT=(2)
BIT_DOWN=(1)
BIT_UP=(3)
BTN_MASK=0x3f

BTN_A=(1<<BIT_A) 
BTN_B=(1<<BIT_B)
BTN_LEFT=(1<<BIT_LEFT) 
BTN_RIGHT=(1<<BIT_RIGHT)
BTN_DOWN=(1<<BIT_DOWN) 
BTN_UP=(1<<BIT_UP)


	.include "inc/ascii.inc"
	.include "inc/stm8s207.inc"
	.include "inc/gen_macros.inc" 
	.include "app_macros.inc" 




