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


 
; boolean flags 
    F_GAME_TMR=7 ; game timer expired reset 
    F_SOUND_TMR=6 ; sound timer expired reset  
    F_DISP_MODE=5 ; display mode 0->text,1->graphic 
    F_ST_ABORT=4 ; keypad btn down abort sound timer 
    F_GT_ABORT=3 ; keypad btn down abort game timer 

;--------------------------------------
;   assembler flags 
;-------------------------------------

    ; microseconds delay {1..16384}
    ; Fmstr=16Mhz 
    ; overhead 7 cy 
    ; loop 4cy*n 
    .macro _usec n, ?loop 
        pushw x
        ldw x,#n*4  
    loop: ; 4 cy 
        decw x 
        nop 
        jrne loop
        popw x 
    .endm 



;----------------------------------
; functions arguments access 
; from stack 
; caller push arguments before call
; and drop them after call  
;----------------------------------    
    ; get argument in X 
    .macro _get_arg n 
    ldw x,(2*(n+1),sp)
    .endm 

    ; store X in argument n 
    .macro _store_arg n 
    ldw (2*(n+1),sp),x 
    .endm 

    ; drop function arguments 
    .macro _drop_args n 
    addw sp,#2*n
    .endm 


    ; read buttons 
    .macro _read_buttons
    ld a,#BTN_PORT+GPIO_IDR 
    and a,#ALL_KEY_UP
    .endm 


;-----------------------------
;   keypad macros 
;-----------------------------

    .macro _btn_down btn 
    ld a,BTN_IDR 
    and a,#(1<<btn)
    or a,#(1<<btn)
    .endm 

    .macro _btn_up 
    ld a,#BTN_IDR 
    and a,#(1<<btn)
    .endm 

    .macro _btn_state 
    ld a,#BTN_IDR 
    and a,#ALL_KEY_UP
    .endm 

    .macro _wait_key_release  ?loop 
    loop:
    ld a,BTN_IDR 
    and a,#ALL_KEY_UP 
    cp a,#ALL_KEY_UP 
    jrne loop 
    .endm 

;------------------------
; LED control 
;-----------------------

    .macro _led_on 
    bset LED_PORT+GPIO_ODR,#LED_BIT 
    .endm 

    .macro _led_off 
    bres LED_PORT+GPIO_ODR,#LED_BIT
    .endm 

    .macro _led_toggle 
    bcpl LED_PORT+GPIO_ODR,#LED_BIT
    .endm 

    