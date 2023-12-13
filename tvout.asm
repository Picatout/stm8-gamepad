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


; display resolution in pixels 
HRES=96
VRES=64 
BYTES_PER_LINE=12


; values based on 16 Mhz crystal

FR_HORZ=15734
HLINE=(FMSTR/FR_HORZ); horizontal line duration 
HALF_LINE=HLINE/2 ; half-line during sync. 
EPULSE=37 ; pulse width during pre and post equalization
VPULSE=436 ; pulse width during vertical sync. 
HPULSE=75 ; 4.7µSec horizontal line sync pulse width. 
LINE_DELAY=(140) 

; ntsc synchro phases 
PH_VSYNC=0 
PH_PRE_VIDEO=1
PH_VIDEO=2 
PH_POST_VIDEO=3 

FIRST_VIDEO_LINE=55 
VIDEO_LINES=192

;ntsc flags 
F_EVEN=0 ; odd/even field flag 
F_CURSOR=1 ; tv cursor active 
F_CUR_VISI=2 ; tv cursor state, 1 visible 
F_VIDEO=4 ; enable video output 

;-------------------------------
    .area CODE 
;------------------------------

;------------------------------
; initialize TIMER1 for 
; NTSC synchronisation 
; signal 
;------------------------------
ntsc_init:
    _clrz ntsc_flags 
    _clrz ntsc_phase 
; enable TIMER1 and SPI clock 
    bset CLK_PCKENR1,#CLK_PCKENR1_TIM1
    bset CLK_PCKENR1,#CLK_PCKENR1_SPI
; set MOSI pin as output high-speed push-pull 
    bset PC_DDR,#6 
    bres PC_ODR,#6
    bset PC_CR1,#6
    bset PC_CR2,#6
    clr SPI_SR 
    clr SPI_DR 
    mov SPI_CR1,#(1<<SPI_CR1_SPE)|(1<<SPI_CR1_MSTR)|(2<<SPI_CR1_BR)
; initialize timer1 for pwm
; generate NTSC sync signal  on CH3 
    mov TIM1_IER,#1 ; UIE set 
    bset TIM1_CR1,#TIM1_CR1_ARPE ; auto preload enabled 
    mov TIM1_CCMR3,#(7<<TIM1_CCMR3_OCMODE)  |(1<<TIM1_CCMR3_OC3PE)
    bset TIM1_CCER2,#0
    bset TIM1_BKR,#7
; use channel 2 for video stream trigger 
; set pixel out delay   
    mov TIM1_CCMR2,#(6<<TIM1_CCMR2_OCMODE) 
    mov TIM1_CCR2H,#LINE_DELAY>>8 
    mov TIM1_CCR2L,#LINE_DELAY&0xFF
; begin with PH_PRE_EQU odd field 
    _clrz ntsc_phase 
    mov TIM1_ARRH,#HLINE>>8
    mov TIM1_ARRL,#HLINE&0XFF
    mov TIM1_CCR3H,#HPULSE>>8 
    mov TIM1_CCR3L,#HPULSE&0XFF
    call tv_cls 
    bset TIM1_CR1,#TIM1_CR1_CEN 
    ld a,#1
    call video_on_off 
    ret 

;--------------------
; enable|disable 
; video output 
; input:
;   A    0->off 
;        1->on
;--------------------
video_on_off:
    tnz a 
    jreq 1$ 
; enable video 
    bset ntsc_flags,#F_VIDEO 
    bset TIM1_IER,#TIM1_IER_UIE 
    ret     
1$: ; disable video 
    bres ntsc_flags,#F_VIDEO 
    bres TIM1_IER,#TIM1_IER_CC2IE 
    bset TIM1_IER,#TIM1_IER_UIE 
    ret 


;-------------------------------
; TIMER1 update interrupt handler 
; interrupt happend at end 
; of each phase and and pwm 
; is set for next phase 
;-------------------------------
ntsc_sync_interrupt:
    clr TIM1_SR1 
    _ldxz scan_line 
    incw x 
    _strxz scan_line 
    _ldaz ntsc_phase 
    cp a,#PH_VSYNC  
    jrne test_pre_video 
    cpw x,#1 
    jrne  1$ 
    mov TIM1_ARRH,#HALF_LINE>>8 
    mov TIM1_ARRL,#HALF_LINE & 0xff 
    mov TIM1_CCR3H,#EPULSE>>8 
    mov TIM1_CCR3L,#EPULSE&0xff 
    jp sync_exit 
1$: cpw x,#7 
    jrne 2$ 
    mov TIM1_CCR3H,#VPULSE>>8 
    mov TIM1_CCR3L,#VPULSE&0xff 
    jp sync_exit 
2$:
    cpw x,#13 
    jrne 3$ 
    mov TIM1_CCR3H,#EPULSE>>8 
    mov TIM1_CCR3L,#EPULSE&0xff 
    jp sync_exit 
3$: 
    cpw x,#18 
    jrne 5$ 
    btjt ntsc_flags,#F_EVEN,sync_exit 
4$:
    mov TIM1_ARRH,#HLINE>>8 
    mov TIM1_ARRL,#HLINE & 0xff 
    mov TIM1_CCR3H,#HPULSE>>8 
    mov TIM1_CCR3L,#HPULSE&0xff 
    inc a 
    jp sync_exit 
5$: 
    cpw x,#19 
    jreq 4$ 
    jra sync_exit 
test_pre_video:
    cp a,#PH_PRE_VIDEO 
    jrne post_video  
    cpw x,#FIRST_VIDEO_LINE
    jrne sync_exit 
    inc a 
    btjf ntsc_flags,#F_VIDEO,sync_exit
    bres TIM1_IER,#TIM1_IER_UIE 
    bset TIM1_IER,#TIM1_IER_CC2IE
    jra sync_exit
post_video:
    cpw x,#271
    jrne 2$ 
    btjf ntsc_flags,#F_EVEN,#3$  
    jra sync_exit  
2$: 
    cpw x,#272 
    jrne sync_exit 
    mov TIM1_ARRH,#HALF_LINE>>8
    mov TIM1_ARRL,#HALF_LINE & 0xff 
3$: ;field end     
    clr a 
    clrw x 
    _strxz scan_line
    bcpl ntsc_flags,#F_EVEN
sync_exit:
    _straz ntsc_phase
    iret 



;----------------------------------
; TIMER1 compare interrupt handler
;----------------------------------
    .macro _shift_out_scan_line
        n=0

        .rept BYTES_PER_LINE
             ld a,(n,x) 
             btjf SPI_SR,#SPI_SR_TXE,. 
             ld SPI_DR,a
             n=n+1 
        .endm 
    .endm 
    BPL=1 
    VAR_SIZE=1
ntsc_video_interrupt:
    _vars VAR_SIZE
    clr TIM1_SR1
; compute postion in buffer 
; 3 scan line/video buffer line 
; ofs=scan_line/3+tv_buffer       
    _ldxz scan_line 
    subw x,#FIRST_VIDEO_LINE
    ld a,#3 
    div x,a
    ld a,#BYTES_PER_LINE  
    mul x,a  ; tv_buffer line  
    addw x,#tv_buffer
    ld a,#BYTES_PER_LINE
    ld (BPL,sp),a 
    bset SPI_CR1,#SPI_CR1_SPE  
;    _shift_out_scan_line
1$: ld a,(x)
    incw x 
    ld SPI_DR,a 
    btjf SPI_SR,#SPI_SR_TXE,. 
    dec (BPL,sp)
    jrne 1$ 
    clr SPI_DR
    btjf SPI_SR,#SPI_SR_TXE,. 
    btjt SPI_SR,#SPI_SR_BSY,.
    bres SPI_CR1,#SPI_CR1_SPE  
    _ldxz scan_line 
    incw x 
    _strxz scan_line 
    cpw x,#FIRST_VIDEO_LINE+VIDEO_LINES
    jrmi 4$ 
    bres TIM1_IER,#TIM1_IER_CC2IE
    bset TIM1_IER,#TIM1_IER_UIE
4$: _drop VAR_SIZE
    iret 

