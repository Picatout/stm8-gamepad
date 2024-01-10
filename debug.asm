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

    .area CODE 

.if NUCLEO 
    .include "inc/nucleo_8s207.inc" 
    .include "uart.asm"

;-----------------------
; print value in 
; acc16 in hexadecimal
; on terminal 
;----------------------
dbg_print:
.if DEBUG 
    pushw x 
    ldw x,acc16 
    call uart_print_hex
    popw x
.endif ;; DEBUG      
    ret 

;-----------------------
; print value in A 
; in hexadecimal on 
; terminal 
;-----------------------
dbg_print_hex:
.if DEBUG 
    push a 
    call uart_print_hex_byte
    ld a,#SPACE 
    call uart_putc 
    pop a 
.endif ;; DEBUG 
    ret 

;-------------------------
; send CRLF to terminal 
;-------------------------
dbg_nl:
.if DEBUG 
    push a 
    ld a,#CR 
    call uart_putc
    pop a  
.endif ;; DEBUG 
    ret 

 .else 
;---------------------
; print value in acc16 
; at coords Y,X={0,26}
; wait key to continue 
;---------------------
    CURPOS=1 
    VAR_SIZE=2
dbg_print:
.if DEBUG 
	push a 
    pushw x 
    _vars VAR_SIZE 
    _ldxz cy 
    ldw (CURPOS,sp),x 
    ldw x,#26
    _strxz cy 
    _ldxz acc16 
    call put_uint16
	ld a,#SPACE 
	call tv_putc
    ldw x,(CURPOS,sp)
    _strxz cy 
	call wait_key 
	ldw x,#60
	call wait_key_release 
    _drop VAR_SIZE 
    popw x
	pop a 
.endif ;; DEBUG 
    ret 

;-----------------------
; print A in hexadecimal
;-----------------------
dbg_print_hex:
.if DEBUG 
	_clrz cy 
	mov cx,#26
	push a 
	swap a 
	call hex_digit 
	pop a 
hex_digit:
	and a,#15
	add a,#'0 
	cp a,#'9+1
	jrmi 1$
	add a,#7 
1$: call tv_putc
.endif  ;; DEBUG 
	ret 

.endif ;; NUCLEO 

