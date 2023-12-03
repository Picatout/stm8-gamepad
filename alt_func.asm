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

