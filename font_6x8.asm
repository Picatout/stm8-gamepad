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

FONT_HEIGHT=8
FONT_WIDTH=6
font_6x8: 
.byte 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00  ; space ASCII 32
.byte 0x20,0x20,0x20,0x20,0x20,0x00,0x20,0x00  ; !
.byte 0x50,0x50,0x50,0x00,0x00,0x00,0x00,0x00  ; "
.byte 0x50,0x50,0xF8,0x50,0xF8,0x50,0x50,0x00  ; #
.byte 0x20,0x78,0xA0,0x70,0x28,0xF0,0x20,0x00  ; $
.byte 0xC0,0xC8,0x10,0x20,0x40,0x98,0x18,0x00  ; %
.byte 0x60,0X90,0xA0,0x40,0xA8,0x90,0x68,0x00  ; &
.byte 0x60,0x20,0x40,0x00,0x00,0x00,0x00,0x00  ; '
.byte 0x10,0x20,0x40,0x40,0x40,0x20,0x10,0x00  ; (
.byte 0x40,0x20,0x10,0x10,0x10,0x20,0x40,0x00  ; )
.byte 0x00,0x20,0xA8,0x70,0xA8,0x20,0x00,0x00  ; *
.byte 0x00,0x20,0x20,0xF8,0x20,0x20,0x00,0x00  ; +
.byte 0x00,0x00,0x00,0x70,0x70,0x30,0x60,0x40  ; ,
.byte 0x00,0x00,0x00,0xF0,0x00,0x00,0x00,0x00  ; -
.byte 0x00,0x00,0x00,0x00,0x00,0x60,0x60,0x00  ; .
.byte 0x00,0x06,0x0c,0x18,0x30,0x60,0x00,0x00  ; /
.byte 0x70,0x88,0x98,0xA8,0xC8,0x88,0x70,0x00  ; 0
.byte 0x20,0x60,0x20,0x20,0x20,0x20,0xF8,0x00  ; 1
.byte 0x70,0x88,0x10,0x20,0x40,0x80,0xF8,0x00  ; 2
.byte 0xF0,0x08,0x08,0xF0,0x08,0x08,0xF0,0x00  ; 3
.byte 0x10,0x30,0x50,0x90,0xF8,0x10,0x10,0x00  ; 4
.byte 0xF8,0x80,0x80,0xF0,0x08,0x08,0xF0,0x00  ; 5
.byte 0x30,0x40,0x80,0xF0,0x88,0x88,0x70,0x00  ; 6
.byte 0xF8,0x08,0x10,0x20,0x40,0x40,0x40,0x00  ; 7
.byte 0x70,0x88,0x88,0x70,0x88,0x88,0x70,0x00  ; 8
.byte 0x70,0x88,0x88,0x70,0x08,0x08,0x70,0x00  ; 9
.byte 0x00,0x60,0x60,0x00,0x60,0x60,0x00,0x00  ; :
.byte 0x00,0x60,0x60,0x00,0x60,0x60,0x20,0x40  ; ;
.byte 0x10,0x20,0x40,0x80,0x40,0x20,0x10,0x00  ; <
.byte 0x00,0x00,0xF8,0x00,0xF8,0x00,0x00,0x00  ; =
.byte 0x40,0x20,0x10,0x08,0x10,0x20,0x40,0x00  ; >
.byte 0x70,0x88,0x08,0x10,0x20,0x00,0x20,0x00  ; ?
.byte 0x70,0x88,0x08,0x68,0xA8,0xA8,0x70,0x00  ; @
.byte 0x70,0x88,0x88,0xF8,0x88,0x88,0x88,0x00  ; A
.byte 0xF0,0x88,0x88,0xF0,0x88,0x88,0xF0,0x00  ; B
.byte 0x78,0x80,0x80,0x80,0x80,0x80,0x78,0x00  ; C
.byte 0xF0,0x88,0x88,0x88,0x88,0x88,0xF0,0x00  ; D
.byte 0xF8,0x80,0x80,0xF8,0x80,0x80,0xF8,0x00  ; E
.byte 0xF8,0x80,0x80,0xF8,0x80,0x80,0x80,0x00  ; F
.byte 0x78,0x80,0x80,0xB0,0x88,0x88,0x70,0x00  ; G
.byte 0x88,0x88,0x88,0xF8,0x88,0x88,0x88,0x00  ; H
.byte 0x70,0x20,0x20,0x20,0x20,0x20,0x70,0x00  ; I
.byte 0x78,0x08,0x08,0x08,0x08,0x90,0x60,0x00  ; J
.byte 0x88,0x90,0xA0,0xC0,0xA0,0x90,0x88,0x00  ; K
.byte 0x80,0x80,0x80,0x80,0x80,0x80,0xF8,0x00  ; L
.byte 0x88,0xD8,0xA8,0x88,0x88,0x88,0x88,0x00  ; M
.byte 0x88,0x88,0xC8,0xA8,0x98,0x88,0x88,0x00  ; N
.byte 0x70,0x88,0x88,0x88,0x88,0x88,0x70,0x00  ; O
.byte 0xF0,0x88,0x88,0xF0,0x80,0x80,0x80,0x00  ; P
.byte 0x70,0x88,0x88,0x88,0xA8,0x90,0x68,0x00  ; Q
.byte 0xF0,0x88,0x88,0xF0,0xA0,0x90,0x88,0x00  ; R
.byte 0x78,0x80,0x80,0x70,0x08,0x08,0xF0,0x00  ; S
.byte 0xF8,0x20,0x20,0x20,0x20,0x20,0x20,0x00  ; T
.byte 0x88,0x88,0x88,0x88,0x88,0x88,0x70,0x00  ; U
.byte 0x88,0x88,0x88,0x88,0x88,0x50,0x20,0x00  ; V
.byte 0x88,0x88,0x88,0xA8,0xA8,0xD8,0x88,0x00  ; W
.byte 0x88,0x88,0x50,0x20,0x50,0x88,0x88,0x00  ; X
.byte 0x88,0x88,0x88,0x50,0x20,0x20,0x20,0x00  ; Y
.byte 0xF8,0x10,0x20,0x40,0x80,0x80,0xF8,0x00  ; Z
.byte 0x60,0x40,0x40,0x40,0x40,0x40,0x60,0x00  ; [
.byte 0x00,0x80,0x40,0x20,0x10,0x08,0x00,0x00  ; '\'
.byte 0x18,0x08,0x08,0x08,0x08,0x08,0x18,0x00  ; ]
.byte 0x20,0x50,0x88,0x00,0x00,0x00,0x00,0x00  ; ^
.byte 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFE  ; _
.byte 0x40,0x20,0x10,0x00,0x00,0x00,0x00,0x00  ; `
.byte 0x00,0x00,0x70,0x08,0x78,0x88,0x78,0x00  ; a
.byte 0x80,0x80,0x80,0xB0,0xC8,0x88,0xF0,0x00  ; b
.byte 0x00,0x00,0x70,0x80,0x80,0x88,0x70,0x00  ; c
.byte 0x08,0x08,0x08,0x68,0x98,0x88,0x78,0x00  ; d
.byte 0x00,0x00,0x70,0x88,0xF8,0x80,0x70,0x00  ; e
.byte 0x30,0x48,0x40,0xE0,0x40,0x40,0x40,0x00  ; f
.byte 0x00,0x00,0x78,0x88,0x88,0x78,0x08,0x70  ; g
.byte 0x80,0x80,0xB0,0xC8,0x88,0x88,0x88,0x00  ; h
.byte 0x00,0x20,0x00,0x20,0x20,0x20,0x20,0x00  ; i
.byte 0x10,0x00,0x30,0x10,0x10,0x90,0x60,0x00  ; j
.byte 0x80,0x80,0x90,0xA0,0xC0,0xA0,0x90,0x00  ; k
.byte 0x60,0x20,0x20,0x20,0x20,0x20,0x70,0x00  ; l
.byte 0x00,0x00,0xD0,0xA8,0xA8,0x88,0x88,0x00  ; m
.byte 0x00,0x00,0xB0,0xC8,0x88,0x88,0x88,0x00  ; n
.byte 0x00,0x00,0x70,0x88,0x88,0x88,0x70,0x00  ; o
.byte 0x00,0x00,0xF0,0x88,0x88,0xF0,0x80,0x80  ; p
.byte 0x00,0x00,0x68,0x90,0x90,0xB0,0x50,0x18  ; q
.byte 0x00,0x00,0xB0,0xC8,0x80,0x80,0x80,0x00  ; r
.byte 0x00,0x00,0x70,0x80,0x70,0x08,0xF0,0x00  ; s
.byte 0x40,0x40,0xE0,0x40,0x40,0x48,0x30,0x00  ; t
.byte 0x00,0x00,0x88,0x88,0x88,0x98,0x68,0x00  ; u
.byte 0x00,0x00,0x88,0x88,0x88,0x50,0x20,0x00  ; v
.byte 0x00,0x00,0x88,0x88,0xA8,0xA8,0x50,0x00  ; w
.byte 0x00,0x00,0x88,0x50,0x20,0x50,0x88,0x00  ; x
.byte 0x00,0x00,0x88,0x88,0x88,0x78,0x08,0x70  ; y
.byte 0x00,0x00,0xF8,0x10,0x20,0x40,0xF8,0x00  ; z
.byte 0x20,0x40,0x40,0x80,0x40,0x40,0x20,0x00  ; {
.byte 0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x00  ; |
.byte 0x40,0x20,0x20,0x10,0x20,0x20,0x40,0x00  ; }
.byte 0x00,0x00,0x40,0xA8,0x10,0x00,0x00,0x00  ; ~  ASCII 126 
.byte 0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC  ; block cursor  127
.byte 0x40,0x20,0x10,0xF8,0x10,0x20,0x40,0x00  ; flèche droite 128 
.byte 0x10,0x20,0x40,0xF8,0x40,0x20,0x10,0x00  ; flèche gauche 129
.byte 0x20,0x70,0xA8,0x20,0x20,0x20,0x00,0x00  ; flèche haut   130
.byte 0x00,0x20,0x20,0x20,0xA8,0x70,0x20,0x00  ; flèche bas    131
.byte 0x00,0x70,0xF8,0xF8,0xF8,0x70,0x00,0x00  ; rond		  132 
.byte 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xff  ; underline cursor 133
.byte 0x80,0x80,0x80,0x80,0x80,0x80,0x80,0x80  ; insert cursor 134
font_end:
