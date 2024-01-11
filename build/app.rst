ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 1.
Hexadecimal [24-Bits]



                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2023,2024  
                                      3 ; This file is part of stm8-gamepad
                                      4 ;
                                      5 ;     stm8-gamepad is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     stm8-gamepad is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with ntsc_tuto.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                                     19 
                                     20 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                     21 ;;; hardware initialization
                                     22 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
                                     23 
                                     24 ;------------------------
                                     25 ; if unified compilation 
                                     26 ; must be first in list 
                                     27 ;-----------------------
                                     28 
                                     29     .module HW_INIT 
                                     30 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 2.
Hexadecimal [24-Bits]



                                     31     .include "config.inc"
                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2023,2024  
                                      3 ; This file is part of stm8-gamepad
                                      4 ;
                                      5 ;     stm8-gamepadis free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     stm8-gamepadis distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with ntsc_tuto.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                                     19 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                     20 ;;  configuration parameters 
                                     21 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                     22 
                                     23 ;-----------------------
                                     24 ;  version  
                                     25 ;  information 
                                     26 ;-----------------------
                           000001    27 	MAJOR=1
                           000001    28 	MINOR=1
                           000000    29 	REV=0
                                     30 
                                     31 ; set to 1 to add dbg_print code 
                           000000    32 DEBUG=0
                                     33 
                                     34 ; set to 1 when using NUCLEO-8S207K8 
                           000001    35 NUCLEO=1
                                     36 
                                     37 ; master clock frequency in hz 
                           F42400    38 	FMSTR=16000000 
                                     39 
                           00500F    40 SOUND_PORT=PD_BASE 
                           000000    41 SOUND_BIT=(0)
                                     42 
                                     43 
                                     44 ; navigation buttons 
                           005005    45 KPAD_PORT=PB_BASE 
                           005006    46 KPAD_IDR=PB_IDR
                           000005    47 BIT_A=(5)
                           000004    48 BIT_B=(4)
                           000000    49 BIT_LEFT=(0)
                           000002    50 BIT_RIGHT=(2)
                           000001    51 BIT_DOWN=(1)
                           000003    52 BIT_UP=(3)
                           00003F    53 BTN_MASK=0x3f
                                     54 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 3.
Hexadecimal [24-Bits]



                           000020    55 BTN_A=(1<<BIT_A) 
                           000010    56 BTN_B=(1<<BIT_B)
                           000001    57 BTN_LEFT=(1<<BIT_LEFT) 
                           000004    58 BTN_RIGHT=(1<<BIT_RIGHT)
                           000002    59 BTN_DOWN=(1<<BIT_DOWN) 
                           000008    60 BTN_UP=(1<<BIT_UP)
                                     61 
                                     62 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 4.
Hexadecimal [24-Bits]



                                     63 	.include "inc/ascii.inc"
                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2019 
                                      3 ; This file is part of MONA 
                                      4 ;
                                      5 ;     MONA is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     MONA is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with MONA.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                                     19 ;-------------------------------------------------------
                                     20 ;     ASCII control  values
                                     21 ;     CTRL_x   are VT100 keyboard values  
                                     22 ; REF: https://en.wikipedia.org/wiki/ASCII    
                                     23 ;-------------------------------------------------------
                           000001    24 		CTRL_A = 1
                           000001    25 		SOH=CTRL_A  ; start of heading 
                           000002    26 		CTRL_B = 2
                           000002    27 		STX=CTRL_B  ; start of text 
                           000003    28 		CTRL_C = 3
                           000003    29 		ETX=CTRL_C  ; end of text 
                           000004    30 		CTRL_D = 4
                           000004    31 		EOT=CTRL_D  ; end of transmission 
                           000005    32 		CTRL_E = 5
                           000005    33 		ENQ=CTRL_E  ; enquery 
                           000006    34 		CTRL_F = 6
                           000006    35 		ACK=CTRL_F  ; acknowledge
                           000007    36 		CTRL_G = 7
                           000007    37         BELL = 7    ; vt100 terminal generate a sound.
                           000008    38 		CTRL_H = 8  
                           000008    39 		BS = 8     ; back space 
                           000009    40         CTRL_I = 9
                           000009    41     	TAB = 9     ; horizontal tabulation
                           00000A    42         CTRL_J = 10 
                           00000A    43 		LF = 10     ; line feed
                           00000B    44 		CTRL_K = 11
                           00000B    45         VT = 11     ; vertical tabulation 
                           00000C    46 		CTRL_L = 12
                           00000C    47         FF = 12      ; new page
                           00000D    48 		CTRL_M = 13
                           00000D    49 		CR = 13      ; carriage return 
                           00000E    50 		CTRL_N = 14
                           00000E    51 		SO=CTRL_N    ; shift out 
                           00000F    52 		CTRL_O = 15
                           00000F    53 		SI=CTRL_O    ; shift in 
                           000010    54 		CTRL_P = 16
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 5.
Hexadecimal [24-Bits]



                           000010    55 		DLE=CTRL_P   ; data link escape 
                           000011    56 		CTRL_Q = 17
                           000011    57 		DC1=CTRL_Q   ; device control 1 
                           000011    58 		XON=DC1 
                           000012    59 		CTRL_R = 18
                           000012    60 		DC2=CTRL_R   ; device control 2 
                           000013    61 		CTRL_S = 19
                           000013    62 		DC3=CTRL_S   ; device control 3
                           000013    63 		XOFF=DC3 
                           000014    64 		CTRL_T = 20
                           000014    65 		DC4=CTRL_T   ; device control 4 
                           000015    66 		CTRL_U = 21
                           000015    67 		NAK=CTRL_U   ; negative acknowledge
                           000016    68 		CTRL_V = 22
                           000016    69 		SYN=CTRL_V   ; synchronous idle 
                           000017    70 		CTRL_W = 23
                           000017    71 		ETB=CTRL_W   ; end of transmission block
                           000018    72 		CTRL_X = 24
                           000018    73 		CAN=CTRL_X   ; cancel 
                           000019    74 		CTRL_Y = 25
                           000019    75 		EM=CTRL_Y    ; end of medium
                           00001A    76 		CTRL_Z = 26
                           00001A    77 		SUB=CTRL_Z   ; substitute 
                           00001A    78 		EOF=SUB      ; end of text file in MSDOS 
                           00001B    79 		ESC = 27     ; escape 
                           00001C    80 		FS=28        ; file separator 
                           00001D    81 		GS=29        ; group separator 
                           00001E    82 		RS=30		 ; record separator 
                           00001F    83 		US=31 		 ; unit separator 
                           000020    84 		SPACE = 32
                           00002C    85 		COMMA = 44
                           00003A    86 		COLON = 58 
                           00003B    87 		SEMIC = 59  
                           000023    88 		SHARP = 35
                           000027    89 		TICK = 39
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 6.
Hexadecimal [24-Bits]



                                     64 	.include "inc/stm8s207.inc"
                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2019,2022 
                                      3 ; This file is part of MONA 
                                      4 ;
                                      5 ;     MONA is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     MONA is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with MONA.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                     19 ; 2022/11/14
                                     20 ; STM8S207K8 µC registers map
                                     21 ; sdas source file
                                     22 ; author: Jacques Deschênes, copyright 2018,2019,2022
                                     23 ; licence: GPLv3
                                     24 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                     25 
                                     26 ;;;;;;;;;;;
                                     27 ; bits
                                     28 ;;;;;;;;;;;;
                           000000    29  BIT0 = 0
                           000001    30  BIT1 = 1
                           000002    31  BIT2 = 2
                           000003    32  BIT3 = 3
                           000004    33  BIT4 = 4
                           000005    34  BIT5 = 5
                           000006    35  BIT6 = 6
                           000007    36  BIT7 = 7
                                     37  	
                                     38 ;;;;;;;;;;;;
                                     39 ; bits masks
                                     40 ;;;;;;;;;;;;
                           000001    41  B0_MASK = (1<<0)
                           000002    42  B1_MASK = (1<<1)
                           000004    43  B2_MASK = (1<<2)
                           000008    44  B3_MASK = (1<<3)
                           000010    45  B4_MASK = (1<<4)
                           000020    46  B5_MASK = (1<<5)
                           000040    47  B6_MASK = (1<<6)
                           000080    48  B7_MASK = (1<<7)
                                     49 
                                     50 ; HSI oscillator frequency 16Mhz
                           F42400    51  FHSI = 16000000
                                     52 ; LSI oscillator frequency 128Khz
                           01F400    53  FLSI = 128000 
                                     54 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 7.
Hexadecimal [24-Bits]



                                     55 ; controller memory regions
                           001800    56  RAM_SIZE = (0x1800) ; 6KB 
                           000400    57  EEPROM_SIZE = (0x400) ; 1KB
                                     58 ; STM8S207K8 have 64K flash
                           010000    59  FLASH_SIZE = (0x10000)
                                     60 ; erase block size 
                           000080    61 BLOCK_SIZE=128 ; bytes 
                                     62 
                           000000    63  RAM_BASE = (0)
                           0017FF    64  RAM_END = (RAM_BASE+RAM_SIZE-1)
                           004000    65  EEPROM_BASE = (0x4000)
                           0043FF    66  EEPROM_END = (EEPROM_BASE+EEPROM_SIZE-1)
                           005000    67  SFR_BASE = (0x5000)
                           0057FF    68  SFR_END = (0x57FF)
                           006000    69  BOOT_ROM_BASE = (0x6000)
                           007FFF    70  BOOT_ROM_END = (0x7fff)
                           008000    71  FLASH_BASE = (0x8000)
                           017FFF    72  FLASH_END = (FLASH_BASE+FLASH_SIZE-1)
                           004800    73  OPTION_BASE = (0x4800)
                           000080    74  OPTION_SIZE = (0x80)
                           00487F    75  OPTION_END = (OPTION_BASE+OPTION_SIZE-1)
                           0048CD    76  DEVID_BASE = (0x48CD)
                           0048D8    77  DEVID_END = (0x48D8)
                           007F00    78  DEBUG_BASE = (0X7F00)
                           007FFF    79  DEBUG_END = (0X7FFF)
                                     80 
                                     81 ; options bytes
                                     82 ; this one can be programmed only from SWIM  (ICP)
                           004800    83  OPT0  = (0x4800)
                                     84 ; these can be programmed at runtime (IAP)
                           004801    85  OPT1  = (0x4801)
                           004802    86  NOPT1  = (0x4802)
                           004803    87  OPT2  = (0x4803)
                           004804    88  NOPT2  = (0x4804)
                           004805    89  OPT3  = (0x4805)
                           004806    90  NOPT3  = (0x4806)
                           004807    91  OPT4  = (0x4807)
                           004808    92  NOPT4  = (0x4808)
                           004809    93  OPT5  = (0x4809)
                           00480A    94  NOPT5  = (0x480A)
                           00480B    95  OPT6  = (0x480B)
                           00480C    96  NOPT6 = (0x480C)
                           00480D    97  OPT7 = (0x480D)
                           00480E    98  NOPT7 = (0x480E)
                           00487E    99  OPTBL  = (0x487E)
                           00487F   100  NOPTBL  = (0x487F)
                                    101 ; option registers usage
                                    102 ; read out protection, value 0xAA enable ROP
                           004800   103  ROP = OPT0  
                                    104 ; user boot code, {0..0x3e} 512 bytes row
                           004801   105  UBC = OPT1
                           004802   106  NUBC = NOPT1
                                    107 ; alternate function register
                           004803   108  AFR = OPT2
                           004804   109  NAFR = NOPT2
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 8.
Hexadecimal [24-Bits]



                                    110 ; miscelinous options
                           004805   111  WDGOPT = OPT3
                           004806   112  NWDGOPT = NOPT3
                                    113 ; clock options
                           004807   114  CLKOPT = OPT4
                           004808   115  NCLKOPT = NOPT4
                                    116 ; HSE clock startup delay
                           004809   117  HSECNT = OPT5
                           00480A   118  NHSECNT = NOPT5
                                    119 ; flash wait state
                           00480D   120 FLASH_WS = OPT7
                           00480E   121 NFLASH_WS = NOPT7
                                    122 
                                    123 ; watchdog options bits
                           000003   124   WDGOPT_LSIEN   =  BIT3
                           000002   125   WDGOPT_IWDG_HW =  BIT2
                           000001   126   WDGOPT_WWDG_HW =  BIT1
                           000000   127   WDGOPT_WWDG_HALT = BIT0
                                    128 ; NWDGOPT bits
                           FFFFFFFC   129   NWDGOPT_LSIEN    = ~BIT3
                           FFFFFFFD   130   NWDGOPT_IWDG_HW  = ~BIT2
                           FFFFFFFE   131   NWDGOPT_WWDG_HW  = ~BIT1
                           FFFFFFFF   132   NWDGOPT_WWDG_HALT = ~BIT0
                                    133 
                                    134 ; CLKOPT bits
                           000003   135  CLKOPT_EXT_CLK  = BIT3
                           000002   136  CLKOPT_CKAWUSEL = BIT2
                           000001   137  CLKOPT_PRS_C1   = BIT1
                           000000   138  CLKOPT_PRS_C0   = BIT0
                                    139 
                                    140 ; AFR option, remapable functions
                           000007   141  AFR7_BEEP    = BIT7
                           000006   142  AFR6_I2C     = BIT6
                           000005   143  AFR5_TIM1    = BIT5
                           000004   144  AFR4_TIM1    = BIT4
                           000003   145  AFR3_TIM1    = BIT3
                           000002   146  AFR2_CCO     = BIT2
                           000001   147  AFR1_TIM2    = BIT1
                           000000   148  AFR0_ADC2    = BIT0
                                    149 
                                    150 ; device ID = (read only)
                           0048CD   151  DEVID_XL  = (0x48CD)
                           0048CE   152  DEVID_XH  = (0x48CE)
                           0048CF   153  DEVID_YL  = (0x48CF)
                           0048D0   154  DEVID_YH  = (0x48D0)
                           0048D1   155  DEVID_WAF  = (0x48D1)
                           0048D2   156  DEVID_LOT0  = (0x48D2)
                           0048D3   157  DEVID_LOT1  = (0x48D3)
                           0048D4   158  DEVID_LOT2  = (0x48D4)
                           0048D5   159  DEVID_LOT3  = (0x48D5)
                           0048D6   160  DEVID_LOT4  = (0x48D6)
                           0048D7   161  DEVID_LOT5  = (0x48D7)
                           0048D8   162  DEVID_LOT6  = (0x48D8)
                                    163 
                                    164 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 9.
Hexadecimal [24-Bits]



                           005000   165 GPIO_BASE = (0x5000)
                           000005   166 GPIO_SIZE = (5)
                                    167 ; PORTS SFR OFFSET
                           000000   168 PA = 0
                           000005   169 PB = 5
                           00000A   170 PC = 10
                           00000F   171 PD = 15
                           000014   172 PE = 20
                           000019   173 PF = 25
                           00001E   174 PG = 30
                           000023   175 PH = 35 
                           000028   176 PI = 40 
                                    177 
                                    178 ; GPIO
                                    179 ; gpio register offset to base
                           000000   180  GPIO_ODR = 0
                           000001   181  GPIO_IDR = 1
                           000002   182  GPIO_DDR = 2
                           000003   183  GPIO_CR1 = 3
                           000004   184  GPIO_CR2 = 4
                           005000   185  GPIO_BASE=(0X5000)
                                    186  
                                    187 ; port A
                           005000   188  PA_BASE = (0X5000)
                           005000   189  PA_ODR  = (0x5000)
                           005001   190  PA_IDR  = (0x5001)
                           005002   191  PA_DDR  = (0x5002)
                           005003   192  PA_CR1  = (0x5003)
                           005004   193  PA_CR2  = (0x5004)
                                    194 ; port B
                           005005   195  PB_BASE = (0X5005)
                           005005   196  PB_ODR  = (0x5005)
                           005006   197  PB_IDR  = (0x5006)
                           005007   198  PB_DDR  = (0x5007)
                           005008   199  PB_CR1  = (0x5008)
                           005009   200  PB_CR2  = (0x5009)
                                    201 ; port C
                           00500A   202  PC_BASE = (0X500A)
                           00500A   203  PC_ODR  = (0x500A)
                           00500B   204  PC_IDR  = (0x500B)
                           00500C   205  PC_DDR  = (0x500C)
                           00500D   206  PC_CR1  = (0x500D)
                           00500E   207  PC_CR2  = (0x500E)
                                    208 ; port D
                           00500F   209  PD_BASE = (0X500F)
                           00500F   210  PD_ODR  = (0x500F)
                           005010   211  PD_IDR  = (0x5010)
                           005011   212  PD_DDR  = (0x5011)
                           005012   213  PD_CR1  = (0x5012)
                           005013   214  PD_CR2  = (0x5013)
                                    215 ; port E
                           005014   216  PE_BASE = (0X5014)
                           005014   217  PE_ODR  = (0x5014)
                           005015   218  PE_IDR  = (0x5015)
                           005016   219  PE_DDR  = (0x5016)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 10.
Hexadecimal [24-Bits]



                           005017   220  PE_CR1  = (0x5017)
                           005018   221  PE_CR2  = (0x5018)
                                    222 ; port F
                           005019   223  PF_BASE = (0X5019)
                           005019   224  PF_ODR  = (0x5019)
                           00501A   225  PF_IDR  = (0x501A)
                           00501B   226  PF_DDR  = (0x501B)
                           00501C   227  PF_CR1  = (0x501C)
                           00501D   228  PF_CR2  = (0x501D)
                                    229 ; port G
                           00501E   230  PG_BASE = (0X501E)
                           00501E   231  PG_ODR  = (0x501E)
                           00501F   232  PG_IDR  = (0x501F)
                           005020   233  PG_DDR  = (0x5020)
                           005021   234  PG_CR1  = (0x5021)
                           005022   235  PG_CR2  = (0x5022)
                                    236 ; port H not present on LQFP48/LQFP64 package
                           005023   237  PH_BASE = (0X5023)
                           005023   238  PH_ODR  = (0x5023)
                           005024   239  PH_IDR  = (0x5024)
                           005025   240  PH_DDR  = (0x5025)
                           005026   241  PH_CR1  = (0x5026)
                           005027   242  PH_CR2  = (0x5027)
                                    243 ; port I ; only bit 0 on LQFP64 package, not present on LQFP48
                           005028   244  PI_BASE = (0X5028)
                           005028   245  PI_ODR  = (0x5028)
                           005029   246  PI_IDR  = (0x5029)
                           00502A   247  PI_DDR  = (0x502a)
                           00502B   248  PI_CR1  = (0x502b)
                           00502C   249  PI_CR2  = (0x502c)
                                    250 
                                    251 ; input modes CR1
                           000000   252  INPUT_FLOAT = (0) ; no pullup resistor
                           000001   253  INPUT_PULLUP = (1)
                                    254 ; output mode CR1
                           000000   255  OUTPUT_OD = (0) ; open drain
                           000001   256  OUTPUT_PP = (1) ; push pull
                                    257 ; input modes CR2
                           000000   258  INPUT_DI = (0)
                           000001   259  INPUT_EI = (1)
                                    260 ; output speed CR2
                           000000   261  OUTPUT_SLOW = (0)
                           000001   262  OUTPUT_FAST = (1)
                                    263 
                                    264 
                                    265 ; Flash memory
                           000080   266  BLOCK_SIZE=128 
                           00505A   267  FLASH_CR1  = (0x505A)
                           00505B   268  FLASH_CR2  = (0x505B)
                           00505C   269  FLASH_NCR2  = (0x505C)
                           00505D   270  FLASH_FPR  = (0x505D)
                           00505E   271  FLASH_NFPR  = (0x505E)
                           00505F   272  FLASH_IAPSR  = (0x505F)
                           005062   273  FLASH_PUKR  = (0x5062)
                           005064   274  FLASH_DUKR  = (0x5064)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 11.
Hexadecimal [24-Bits]



                                    275 ; data memory unlock keys
                           0000AE   276  FLASH_DUKR_KEY1 = (0xae)
                           000056   277  FLASH_DUKR_KEY2 = (0x56)
                                    278 ; flash memory unlock keys
                           000056   279  FLASH_PUKR_KEY1 = (0x56)
                           0000AE   280  FLASH_PUKR_KEY2 = (0xae)
                                    281 ; FLASH_CR1 bits
                           000003   282  FLASH_CR1_HALT = BIT3
                           000002   283  FLASH_CR1_AHALT = BIT2
                           000001   284  FLASH_CR1_IE = BIT1
                           000000   285  FLASH_CR1_FIX = BIT0
                                    286 ; FLASH_CR2 bits
                           000007   287  FLASH_CR2_OPT = BIT7
                           000006   288  FLASH_CR2_WPRG = BIT6
                           000005   289  FLASH_CR2_ERASE = BIT5
                           000004   290  FLASH_CR2_FPRG = BIT4
                           000000   291  FLASH_CR2_PRG = BIT0
                                    292 ; FLASH_FPR bits
                           000005   293  FLASH_FPR_WPB5 = BIT5
                           000004   294  FLASH_FPR_WPB4 = BIT4
                           000003   295  FLASH_FPR_WPB3 = BIT3
                           000002   296  FLASH_FPR_WPB2 = BIT2
                           000001   297  FLASH_FPR_WPB1 = BIT1
                           000000   298  FLASH_FPR_WPB0 = BIT0
                                    299 ; FLASH_NFPR bits
                           000005   300  FLASH_NFPR_NWPB5 = BIT5
                           000004   301  FLASH_NFPR_NWPB4 = BIT4
                           000003   302  FLASH_NFPR_NWPB3 = BIT3
                           000002   303  FLASH_NFPR_NWPB2 = BIT2
                           000001   304  FLASH_NFPR_NWPB1 = BIT1
                           000000   305  FLASH_NFPR_NWPB0 = BIT0
                                    306 ; FLASH_IAPSR bits
                           000006   307  FLASH_IAPSR_HVOFF = BIT6
                           000003   308  FLASH_IAPSR_DUL = BIT3
                           000002   309  FLASH_IAPSR_EOP = BIT2
                           000001   310  FLASH_IAPSR_PUL = BIT1
                           000000   311  FLASH_IAPSR_WR_PG_DIS = BIT0
                                    312 
                                    313 ; Interrupt control
                           0050A0   314  EXTI_CR1  = (0x50A0)
                           0050A1   315  EXTI_CR2  = (0x50A1)
                                    316 
                                    317 ; Reset Status
                           0050B3   318  RST_SR  = (0x50B3)
                                    319 
                                    320 ; Clock Registers
                           0050C0   321  CLK_ICKR  = (0x50c0)
                           0050C1   322  CLK_ECKR  = (0x50c1)
                           0050C3   323  CLK_CMSR  = (0x50C3)
                           0050C4   324  CLK_SWR  = (0x50C4)
                           0050C5   325  CLK_SWCR  = (0x50C5)
                           0050C6   326  CLK_CKDIVR  = (0x50C6)
                           0050C7   327  CLK_PCKENR1  = (0x50C7)
                           0050C8   328  CLK_CSSR  = (0x50C8)
                           0050C9   329  CLK_CCOR  = (0x50C9)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 12.
Hexadecimal [24-Bits]



                           0050CA   330  CLK_PCKENR2  = (0x50CA)
                           0050CC   331  CLK_HSITRIMR  = (0x50CC)
                           0050CD   332  CLK_SWIMCCR  = (0x50CD)
                                    333 
                                    334 ; Peripherals clock gating
                                    335 ; CLK_PCKENR1 
                           000007   336  CLK_PCKENR1_TIM1 = (7)
                           000006   337  CLK_PCKENR1_TIM3 = (6)
                           000005   338  CLK_PCKENR1_TIM2 = (5)
                           000004   339  CLK_PCKENR1_TIM4 = (4)
                           000003   340  CLK_PCKENR1_UART3 = (3)
                           000002   341  CLK_PCKENR1_UART1 = (2)
                           000001   342  CLK_PCKENR1_SPI = (1)
                           000000   343  CLK_PCKENR1_I2C = (0)
                                    344 ; CLK_PCKENR2
                           000007   345  CLK_PCKENR2_CAN = (7)
                           000003   346  CLK_PCKENR2_ADC2 = (3)
                           000002   347  CLK_PCKENR2_AWU = (2)
                                    348 
                                    349 ; Clock bits
                           000005   350  CLK_ICKR_REGAH = (5)
                           000004   351  CLK_ICKR_LSIRDY = (4)
                           000003   352  CLK_ICKR_LSIEN = (3)
                           000002   353  CLK_ICKR_FHW = (2)
                           000001   354  CLK_ICKR_HSIRDY = (1)
                           000000   355  CLK_ICKR_HSIEN = (0)
                                    356 
                           000001   357  CLK_ECKR_HSERDY = (1)
                           000000   358  CLK_ECKR_HSEEN = (0)
                                    359 ; clock source
                           0000E1   360  CLK_SWR_HSI = 0xE1
                           0000D2   361  CLK_SWR_LSI = 0xD2
                           0000B4   362  CLK_SWR_HSE = 0xB4
                                    363 
                           000003   364  CLK_SWCR_SWIF = (3)
                           000002   365  CLK_SWCR_SWIEN = (2)
                           000001   366  CLK_SWCR_SWEN = (1)
                           000000   367  CLK_SWCR_SWBSY = (0)
                                    368 
                           000004   369  CLK_CKDIVR_HSIDIV1 = (4)
                           000003   370  CLK_CKDIVR_HSIDIV0 = (3)
                           000002   371  CLK_CKDIVR_CPUDIV2 = (2)
                           000001   372  CLK_CKDIVR_CPUDIV1 = (1)
                           000000   373  CLK_CKDIVR_CPUDIV0 = (0)
                                    374 
                                    375 ; Watchdog
                           0050D1   376  WWDG_CR  = (0x50D1)
                           0050D2   377  WWDG_WR  = (0x50D2)
                           0050E0   378  IWDG_KR  = (0x50E0)
                           0050E1   379  IWDG_PR  = (0x50E1)
                           0050E2   380  IWDG_RLR  = (0x50E2)
                           0000CC   381  IWDG_KEY_ENABLE = 0xCC  ; enable IWDG key 
                           0000AA   382  IWDG_KEY_REFRESH = 0xAA ; refresh counter key 
                           000055   383  IWDG_KEY_ACCESS = 0x55 ; write register key 
                                    384  
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 13.
Hexadecimal [24-Bits]



                           0050F0   385  AWU_CSR  = (0x50F0)
                           0050F1   386  AWU_APR  = (0x50F1)
                           0050F2   387  AWU_TBR  = (0x50F2)
                           000004   388  AWU_CSR_AWUEN = 4
                                    389 
                                    390 
                                    391 
                                    392 ; Beeper
                                    393 ; beeper output is alternate function AFR7 on PD4
                           0050F3   394  BEEP_CSR  = (0x50F3)
                           00000F   395  BEEP_PORT = PD
                           000004   396  BEEP_BIT = 4
                           000010   397  BEEP_MASK = B4_MASK
                                    398 
                                    399 ; SPI
                           005200   400  SPI_CR1  = (0x5200)
                           005201   401  SPI_CR2  = (0x5201)
                           005202   402  SPI_ICR  = (0x5202)
                           005203   403  SPI_SR  = (0x5203)
                           005204   404  SPI_DR  = (0x5204)
                           005205   405  SPI_CRCPR  = (0x5205)
                           005206   406  SPI_RXCRCR  = (0x5206)
                           005207   407  SPI_TXCRCR  = (0x5207)
                                    408 
                                    409 ; SPI_CR1 bit fields 
                           000000   410   SPI_CR1_CPHA=0
                           000001   411   SPI_CR1_CPOL=1
                           000002   412   SPI_CR1_MSTR=2
                           000003   413   SPI_CR1_BR=3
                           000006   414   SPI_CR1_SPE=6
                           000007   415   SPI_CR1_LSBFIRST=7
                                    416   
                                    417 ; SPI_CR2 bit fields 
                           000000   418   SPI_CR2_SSI=0
                           000001   419   SPI_CR2_SSM=1
                           000002   420   SPI_CR2_RXONLY=2
                           000004   421   SPI_CR2_CRCNEXT=4
                           000005   422   SPI_CR2_CRCEN=5
                           000006   423   SPI_CR2_BDOE=6
                           000007   424   SPI_CR2_BDM=7  
                                    425 
                                    426 ; SPI_SR bit fields 
                           000000   427   SPI_SR_RXNE=0
                           000001   428   SPI_SR_TXE=1
                           000003   429   SPI_SR_WKUP=3
                           000004   430   SPI_SR_CRCERR=4
                           000005   431   SPI_SR_MODF=5
                           000006   432   SPI_SR_OVR=6
                           000007   433   SPI_SR_BSY=7
                                    434 
                                    435 ; I2C
                           005210   436  I2C_BASE_ADDR = 0x5210 
                           005210   437  I2C_CR1  = (0x5210)
                           005211   438  I2C_CR2  = (0x5211)
                           005212   439  I2C_FREQR  = (0x5212)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 14.
Hexadecimal [24-Bits]



                           005213   440  I2C_OARL  = (0x5213)
                           005214   441  I2C_OARH  = (0x5214)
                           005216   442  I2C_DR  = (0x5216)
                           005217   443  I2C_SR1  = (0x5217)
                           005218   444  I2C_SR2  = (0x5218)
                           005219   445  I2C_SR3  = (0x5219)
                           00521A   446  I2C_ITR  = (0x521A)
                           00521B   447  I2C_CCRL  = (0x521B)
                           00521C   448  I2C_CCRH  = (0x521C)
                           00521D   449  I2C_TRISER  = (0x521D)
                           00521E   450  I2C_PECR  = (0x521E)
                                    451 
                           000007   452  I2C_CR1_NOSTRETCH = (7)
                           000006   453  I2C_CR1_ENGC = (6)
                           000000   454  I2C_CR1_PE = (0)
                                    455 
                           000007   456  I2C_CR2_SWRST = (7)
                           000003   457  I2C_CR2_POS = (3)
                           000002   458  I2C_CR2_ACK = (2)
                           000001   459  I2C_CR2_STOP = (1)
                           000000   460  I2C_CR2_START = (0)
                                    461 
                           000000   462  I2C_OARL_ADD0 = (0)
                                    463 
                           000009   464  I2C_OAR_ADDR_7BIT = ((I2C_OARL & 0xFE) >> 1)
                           000813   465  I2C_OAR_ADDR_10BIT = (((I2C_OARH & 0x06) << 9) | (I2C_OARL & 0xFF))
                                    466 
                           000007   467  I2C_OARH_ADDMODE = (7)
                           000006   468  I2C_OARH_ADDCONF = (6)
                           000002   469  I2C_OARH_ADD9 = (2)
                           000001   470  I2C_OARH_ADD8 = (1)
                                    471 
                           000007   472  I2C_SR1_TXE = (7)
                           000006   473  I2C_SR1_RXNE = (6)
                           000004   474  I2C_SR1_STOPF = (4)
                           000003   475  I2C_SR1_ADD10 = (3)
                           000002   476  I2C_SR1_BTF = (2)
                           000001   477  I2C_SR1_ADDR = (1)
                           000000   478  I2C_SR1_SB = (0)
                                    479 
                           000005   480  I2C_SR2_WUFH = (5)
                           000003   481  I2C_SR2_OVR = (3)
                           000002   482  I2C_SR2_AF = (2)
                           000001   483  I2C_SR2_ARLO = (1)
                           000000   484  I2C_SR2_BERR = (0)
                                    485 
                           000007   486  I2C_SR3_DUALF = (7)
                           000004   487  I2C_SR3_GENCALL = (4)
                           000002   488  I2C_SR3_TRA = (2)
                           000001   489  I2C_SR3_BUSY = (1)
                           000000   490  I2C_SR3_MSL = (0)
                                    491 
                           000002   492  I2C_ITR_ITBUFEN = (2)
                           000001   493  I2C_ITR_ITEVTEN = (1)
                           000000   494  I2C_ITR_ITERREN = (0)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 15.
Hexadecimal [24-Bits]



                                    495 
                           000007   496  I2C_CCRH_FAST = 7 
                           000006   497  I2C_CCRH_DUTY = 6 
                                    498  
                                    499 ; Precalculated values, all in KHz
                           000080   500  I2C_CCRH_16MHZ_FAST_400 = 0x80
                           00000D   501  I2C_CCRL_16MHZ_FAST_400 = 0x0D
                                    502 ;
                                    503 ; Fast I2C mode max rise time = 300ns
                                    504 ; I2C_FREQR = 16 = (MHz) => tMASTER = 1/16 = 62.5 ns
                                    505 ; TRISER = = (300/62.5) + 1 = floor(4.8) + 1 = 5.
                                    506 
                           000005   507  I2C_TRISER_16MHZ_FAST_400 = 0x05
                                    508 
                           0000C0   509  I2C_CCRH_16MHZ_FAST_320 = 0xC0
                           000002   510  I2C_CCRL_16MHZ_FAST_320 = 0x02
                           000005   511  I2C_TRISER_16MHZ_FAST_320 = 0x05
                                    512 
                           000080   513  I2C_CCRH_16MHZ_FAST_200 = 0x80
                           00001A   514  I2C_CCRL_16MHZ_FAST_200 = 0x1A
                           000005   515  I2C_TRISER_16MHZ_FAST_200 = 0x05
                                    516 
                           000000   517  I2C_CCRH_16MHZ_STD_100 = 0x00
                           000050   518  I2C_CCRL_16MHZ_STD_100 = 0x50
                                    519 
                           000000   520  I2C_STD = 0 
                           000001   521  I2C_FAST = 1 
                                    522 
                                    523 ; Standard I2C mode max rise time = 1000ns
                                    524 ; I2C_FREQR = 16 = (MHz) => tMASTER = 1/16 = 62.5 ns
                                    525 ; TRISER = = (1000/62.5) + 1 = floor(16) + 1 = 17.
                                    526 
                           000011   527  I2C_TRISER_16MHZ_STD_100 = 0x11
                                    528 
                           000000   529  I2C_CCRH_16MHZ_STD_50 = 0x00
                           0000A0   530  I2C_CCRL_16MHZ_STD_50 = 0xA0
                           000011   531  I2C_TRISER_16MHZ_STD_50 = 0x11
                                    532 
                           000001   533  I2C_CCRH_16MHZ_STD_20 = 0x01
                           000090   534  I2C_CCRL_16MHZ_STD_20 = 0x90
                           000011   535  I2C_TRISER_16MHZ_STD_20 = 0x11;
                                    536 
                           000001   537  I2C_READ = 1
                           000000   538  I2C_WRITE = 0
                                    539 
                                    540 ; baudrate constant for brr_value table access
                                    541 ; to be used by uart_init 
                           000000   542 B2400=0
                           000001   543 B4800=1
                           000002   544 B9600=2
                           000003   545 B19200=3
                           000004   546 B38400=4
                           000005   547 B57600=5
                           000006   548 B115200=6
                           000007   549 B230400=7
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 16.
Hexadecimal [24-Bits]



                           000008   550 B460800=8
                           000009   551 B921600=9
                                    552 
                                    553 ; UART registers offset from
                                    554 ; base address 
                           000000   555 OFS_UART_SR=0
                           000001   556 OFS_UART_DR=1
                           000002   557 OFS_UART_BRR1=2
                           000003   558 OFS_UART_BRR2=3
                           000004   559 OFS_UART_CR1=4
                           000005   560 OFS_UART_CR2=5
                           000006   561 OFS_UART_CR3=6
                           000007   562 OFS_UART_CR4=7
                           000008   563 OFS_UART_CR5=8
                           000009   564 OFS_UART_CR6=9
                           000009   565 OFS_UART_GTR=9
                           00000A   566 OFS_UART_PSCR=10
                                    567 
                                    568 ; uart identifier
                           000000   569  UART1 = 0 
                           000001   570  UART2 = 1
                           000002   571  UART3 = 2
                                    572 
                                    573 ; pins used by uart 
                           000005   574 UART1_TX_PIN=BIT5
                           000004   575 UART1_RX_PIN=BIT4
                           000005   576 UART3_TX_PIN=BIT5
                           000006   577 UART3_RX_PIN=BIT6
                                    578 ; uart port base address 
                           000000   579 UART1_PORT=PA 
                           00000F   580 UART3_PORT=PD
                                    581 
                                    582 ; UART1 
                           005230   583  UART1_BASE  = (0x5230)
                           005230   584  UART1_SR    = (0x5230)
                           005231   585  UART1_DR    = (0x5231)
                           005232   586  UART1_BRR1  = (0x5232)
                           005233   587  UART1_BRR2  = (0x5233)
                           005234   588  UART1_CR1   = (0x5234)
                           005235   589  UART1_CR2   = (0x5235)
                           005236   590  UART1_CR3   = (0x5236)
                           005237   591  UART1_CR4   = (0x5237)
                           005238   592  UART1_CR5   = (0x5238)
                           005239   593  UART1_GTR   = (0x5239)
                           00523A   594  UART1_PSCR  = (0x523A)
                                    595 
                                    596 ; UART3
                           005240   597  UART3_BASE  = (0x5240)
                           005240   598  UART3_SR    = (0x5240)
                           005241   599  UART3_DR    = (0x5241)
                           005242   600  UART3_BRR1  = (0x5242)
                           005243   601  UART3_BRR2  = (0x5243)
                           005244   602  UART3_CR1   = (0x5244)
                           005245   603  UART3_CR2   = (0x5245)
                           005246   604  UART3_CR3   = (0x5246)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 17.
Hexadecimal [24-Bits]



                           005247   605  UART3_CR4   = (0x5247)
                           004249   606  UART3_CR6   = (0x4249)
                                    607 
                                    608 ; UART Status Register bits
                           000007   609  UART_SR_TXE = (7)
                           000006   610  UART_SR_TC = (6)
                           000005   611  UART_SR_RXNE = (5)
                           000004   612  UART_SR_IDLE = (4)
                           000003   613  UART_SR_OR = (3)
                           000002   614  UART_SR_NF = (2)
                           000001   615  UART_SR_FE = (1)
                           000000   616  UART_SR_PE = (0)
                                    617 
                                    618 ; Uart Control Register bits
                           000007   619  UART_CR1_R8 = (7)
                           000006   620  UART_CR1_T8 = (6)
                           000005   621  UART_CR1_UARTD = (5)
                           000004   622  UART_CR1_M = (4)
                           000003   623  UART_CR1_WAKE = (3)
                           000002   624  UART_CR1_PCEN = (2)
                           000001   625  UART_CR1_PS = (1)
                           000000   626  UART_CR1_PIEN = (0)
                                    627 
                           000007   628  UART_CR2_TIEN = (7)
                           000006   629  UART_CR2_TCIEN = (6)
                           000005   630  UART_CR2_RIEN = (5)
                           000004   631  UART_CR2_ILIEN = (4)
                           000003   632  UART_CR2_TEN = (3)
                           000002   633  UART_CR2_REN = (2)
                           000001   634  UART_CR2_RWU = (1)
                           000000   635  UART_CR2_SBK = (0)
                                    636 
                           000006   637  UART_CR3_LINEN = (6)
                           000005   638  UART_CR3_STOP1 = (5)
                           000004   639  UART_CR3_STOP0 = (4)
                           000003   640  UART_CR3_CLKEN = (3)
                           000002   641  UART_CR3_CPOL = (2)
                           000001   642  UART_CR3_CPHA = (1)
                           000000   643  UART_CR3_LBCL = (0)
                                    644 
                           000006   645  UART_CR4_LBDIEN = (6)
                           000005   646  UART_CR4_LBDL = (5)
                           000004   647  UART_CR4_LBDF = (4)
                           000003   648  UART_CR4_ADD3 = (3)
                           000002   649  UART_CR4_ADD2 = (2)
                           000001   650  UART_CR4_ADD1 = (1)
                           000000   651  UART_CR4_ADD0 = (0)
                                    652 
                           000005   653  UART_CR5_SCEN = (5)
                           000004   654  UART_CR5_NACK = (4)
                           000003   655  UART_CR5_HDSEL = (3)
                           000002   656  UART_CR5_IRLP = (2)
                           000001   657  UART_CR5_IREN = (1)
                                    658 ; LIN mode config register
                           000007   659  UART_CR6_LDUM = (7)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 18.
Hexadecimal [24-Bits]



                           000005   660  UART_CR6_LSLV = (5)
                           000004   661  UART_CR6_LASE = (4)
                           000002   662  UART_CR6_LHDIEN = (2) 
                           000001   663  UART_CR6_LHDF = (1)
                           000000   664  UART_CR6_LSF = (0)
                                    665 
                                    666 ; TIMERS
                                    667 ; Timer 1 - 16-bit timer with complementary PWM outputs
                           005250   668  TIM1_CR1  = (0x5250)
                           005251   669  TIM1_CR2  = (0x5251)
                           005252   670  TIM1_SMCR  = (0x5252)
                           005253   671  TIM1_ETR  = (0x5253)
                           005254   672  TIM1_IER  = (0x5254)
                           005255   673  TIM1_SR1  = (0x5255)
                           005256   674  TIM1_SR2  = (0x5256)
                           005257   675  TIM1_EGR  = (0x5257)
                           005258   676  TIM1_CCMR1  = (0x5258)
                           005259   677  TIM1_CCMR2  = (0x5259)
                           00525A   678  TIM1_CCMR3  = (0x525A)
                           00525B   679  TIM1_CCMR4  = (0x525B)
                           00525C   680  TIM1_CCER1  = (0x525C)
                           00525D   681  TIM1_CCER2  = (0x525D)
                           00525E   682  TIM1_CNTRH  = (0x525E)
                           00525F   683  TIM1_CNTRL  = (0x525F)
                           005260   684  TIM1_PSCRH  = (0x5260)
                           005261   685  TIM1_PSCRL  = (0x5261)
                           005262   686  TIM1_ARRH  = (0x5262)
                           005263   687  TIM1_ARRL  = (0x5263)
                           005264   688  TIM1_RCR  = (0x5264)
                           005265   689  TIM1_CCR1H  = (0x5265)
                           005266   690  TIM1_CCR1L  = (0x5266)
                           005267   691  TIM1_CCR2H  = (0x5267)
                           005268   692  TIM1_CCR2L  = (0x5268)
                           005269   693  TIM1_CCR3H  = (0x5269)
                           00526A   694  TIM1_CCR3L  = (0x526A)
                           00526B   695  TIM1_CCR4H  = (0x526B)
                           00526C   696  TIM1_CCR4L  = (0x526C)
                           00526D   697  TIM1_BKR  = (0x526D)
                           00526E   698  TIM1_DTR  = (0x526E)
                           00526F   699  TIM1_OISR  = (0x526F)
                                    700 
                                    701 ; Timer Control Register bits
                           000007   702  TIM1_CR1_ARPE = (7)
                           000006   703  TIM1_CR1_CMSH = (6)
                           000005   704  TIM1_CR1_CMSL = (5)
                           000004   705  TIM1_CR1_DIR = (4)
                           000003   706  TIM1_CR1_OPM = (3)
                           000002   707  TIM1_CR1_URS = (2)
                           000001   708  TIM1_CR1_UDIS = (1)
                           000000   709  TIM1_CR1_CEN = (0)
                                    710 
                           000006   711  TIM1_CR2_MMS2 = (6)
                           000005   712  TIM1_CR2_MMS1 = (5)
                           000004   713  TIM1_CR2_MMS0 = (4)
                           000002   714  TIM1_CR2_COMS = (2)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 19.
Hexadecimal [24-Bits]



                           000000   715  TIM1_CR2_CCPC = (0)
                                    716 
                                    717 ; Timer Slave Mode Control bits
                           000007   718  TIM1_SMCR_MSM = (7)
                           000006   719  TIM1_SMCR_TS2 = (6)
                           000005   720  TIM1_SMCR_TS1 = (5)
                           000004   721  TIM1_SMCR_TS0 = (4)
                           000002   722  TIM1_SMCR_SMS2 = (2)
                           000001   723  TIM1_SMCR_SMS1 = (1)
                           000000   724  TIM1_SMCR_SMS0 = (0)
                                    725 
                                    726 ; Timer External Trigger Enable bits
                           000007   727  TIM1_ETR_ETP = (7)
                           000006   728  TIM1_ETR_ECE = (6)
                           000005   729  TIM1_ETR_ETPS1 = (5)
                           000004   730  TIM1_ETR_ETPS0 = (4)
                           000003   731  TIM1_ETR_ETF3 = (3)
                           000002   732  TIM1_ETR_ETF2 = (2)
                           000001   733  TIM1_ETR_ETF1 = (1)
                           000000   734  TIM1_ETR_ETF0 = (0)
                                    735 
                                    736 ; Timer Interrupt Enable bits
                           000007   737  TIM1_IER_BIE = (7)
                           000006   738  TIM1_IER_TIE = (6)
                           000005   739  TIM1_IER_COMIE = (5)
                           000004   740  TIM1_IER_CC4IE = (4)
                           000003   741  TIM1_IER_CC3IE = (3)
                           000002   742  TIM1_IER_CC2IE = (2)
                           000001   743  TIM1_IER_CC1IE = (1)
                           000000   744  TIM1_IER_UIE = (0)
                                    745 
                                    746 ; Timer Status Register bits
                           000007   747  TIM1_SR1_BIF = (7)
                           000006   748  TIM1_SR1_TIF = (6)
                           000005   749  TIM1_SR1_COMIF = (5)
                           000004   750  TIM1_SR1_CC4IF = (4)
                           000003   751  TIM1_SR1_CC3IF = (3)
                           000002   752  TIM1_SR1_CC2IF = (2)
                           000001   753  TIM1_SR1_CC1IF = (1)
                           000000   754  TIM1_SR1_UIF = (0)
                                    755 
                           000004   756  TIM1_SR2_CC4OF = (4)
                           000003   757  TIM1_SR2_CC3OF = (3)
                           000002   758  TIM1_SR2_CC2OF = (2)
                           000001   759  TIM1_SR2_CC1OF = (1)
                                    760 
                                    761 ; Timer Event Generation Register bits
                           000007   762  TIM1_EGR_BG = (7)
                           000006   763  TIM1_EGR_TG = (6)
                           000005   764  TIM1_EGR_COMG = (5)
                           000004   765  TIM1_EGR_CC4G = (4)
                           000003   766  TIM1_EGR_CC3G = (3)
                           000002   767  TIM1_EGR_CC2G = (2)
                           000001   768  TIM1_EGR_CC1G = (1)
                           000000   769  TIM1_EGR_UG = (0)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 20.
Hexadecimal [24-Bits]



                                    770 
                                    771 ; Capture/Compare Mode Register 1 - channel configured in output
                           000007   772  TIM1_CCMR1_OC1CE = (7)
                           000006   773  TIM1_CCMR1_OC1M2 = (6)
                           000005   774  TIM1_CCMR1_OC1M1 = (5)
                           000004   775  TIM1_CCMR1_OC1M0 = (4)
                           000004   776  TIM1_CCMR1_OC1MODE= (4)
                           000003   777  TIM1_CCMR1_OC1PE = (3)
                           000002   778  TIM1_CCMR1_OC1FE = (2)
                           000001   779  TIM1_CCMR1_CC1S1 = (1)
                           000000   780  TIM1_CCMR1_CC1S0 = (0)
                                    781 
                                    782 ; Capture/Compare Mode Register 1 - channel configured in input
                           000007   783  TIM1_CCMR1_IC1F3 = (7)
                           000006   784  TIM1_CCMR1_IC1F2 = (6)
                           000005   785  TIM1_CCMR1_IC1F1 = (5)
                           000004   786  TIM1_CCMR1_IC1F0 = (4)
                           000003   787  TIM1_CCMR1_IC1PSC1 = (3)
                           000002   788  TIM1_CCMR1_IC1PSC0 = (2)
                                    789 ;  TIM1_CCMR1_CC1S1 = (1)
                           000000   790  TIM1_CCMR1_CC1S0 = (0)
                                    791 
                                    792 ; Capture/Compare Mode Register 2 - channel configured in output
                           000007   793  TIM1_CCMR2_OC2CE = (7)
                           000006   794  TIM1_CCMR2_OC2M2 = (6)
                           000005   795  TIM1_CCMR2_OC2M1 = (5)
                           000004   796  TIM1_CCMR2_OC2M0 = (4)
                           000004   797  TIM1_CCMR2_OC2MODE= (4)
                           000003   798  TIM1_CCMR2_OC2PE = (3)
                           000002   799  TIM1_CCMR2_OC2FE = (2)
                           000001   800  TIM1_CCMR2_CC2S1 = (1)
                           000000   801  TIM1_CCMR2_CC2S0 = (0)
                                    802 
                                    803 ; Capture/Compare Mode Register 2 - channel configured in input
                           000007   804  TIM1_CCMR2_IC2F3 = (7)
                           000006   805  TIM1_CCMR2_IC2F2 = (6)
                           000005   806  TIM1_CCMR2_IC2F1 = (5)
                           000004   807  TIM1_CCMR2_IC2F0 = (4)
                           000003   808  TIM1_CCMR2_IC2PSC1 = (3)
                           000002   809  TIM1_CCMR2_IC2PSC0 = (2)
                                    810 ;  TIM1_CCMR2_CC2S1 = (1)
                           000000   811  TIM1_CCMR2_CC2S0 = (0)
                                    812 
                                    813 ; Capture/Compare Mode Register 3 - channel configured in output
                           000007   814  TIM1_CCMR3_OC3CE = (7)
                           000006   815  TIM1_CCMR3_OC3M2 = (6)
                           000005   816  TIM1_CCMR3_OC3M1 = (5)
                           000004   817  TIM1_CCMR3_OC3M0 = (4)
                           000004   818  TIM1_CCMR3_OC3MODE= (4)
                           000003   819  TIM1_CCMR3_OC3PE = (3)
                           000002   820  TIM1_CCMR3_OC3FE = (2)
                           000001   821  TIM1_CCMR3_CC3S1 = (1)
                           000000   822  TIM1_CCMR3_CC3S0 = (0)
                                    823 
                                    824 ; Capture/Compare Mode Register 3 - channel configured in input
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 21.
Hexadecimal [24-Bits]



                           000007   825  TIM1_CCMR3_IC3F3 = (7)
                           000006   826  TIM1_CCMR3_IC3F2 = (6)
                           000005   827  TIM1_CCMR3_IC3F1 = (5)
                           000004   828  TIM1_CCMR3_IC3F0 = (4)
                           000003   829  TIM1_CCMR3_IC3PSC1 = (3)
                           000002   830  TIM1_CCMR3_IC3PSC0 = (2)
                                    831 ;  TIM1_CCMR3_CC3S1 = (1)
                           000000   832  TIM1_CCMR3_CC3S0 = (0)
                                    833 
                                    834 ; Capture/Compare Mode Register 4 - channel configured in output
                           000007   835  TIM1_CCMR4_OC4CE = (7)
                           000006   836  TIM1_CCMR4_OC4M2 = (6)
                           000005   837  TIM1_CCMR4_OC4M1 = (5)
                           000004   838  TIM1_CCMR4_OC4M0 = (4)
                           000004   839  TIM1_CCMR4_OC4MODE= (4)
                           000003   840  TIM1_CCMR4_OC4PE = (3)
                           000002   841  TIM1_CCMR4_OC4FE = (2)
                           000001   842  TIM1_CCMR4_CC4S1 = (1)
                           000000   843  TIM1_CCMR4_CC4S0 = (0)
                                    844 
                                    845 ; Capture/Compare Mode Register 4 - channel configured in input
                           000007   846  TIM1_CCMR4_IC4F3 = (7)
                           000006   847  TIM1_CCMR4_IC4F2 = (6)
                           000005   848  TIM1_CCMR4_IC4F1 = (5)
                           000004   849  TIM1_CCMR4_IC4F0 = (4)
                           000003   850  TIM1_CCMR4_IC4PSC1 = (3)
                           000002   851  TIM1_CCMR4_IC4PSC0 = (2)
                                    852 ;  TIM1_CCMR4_CC4S1 = (1)
                           000000   853  TIM1_CCMR4_CC4S0 = (0)
                                    854 
                                    855 ; TIM1_BKR bit fields 
                           000007   856   TIM1_BKR_MOE=(7) ; main output enable
                           000006   857   TIM1_BKR_AOE=(6) ; automatici output enable 
                           000005   858   TIM1_BKR_BKP=(5) ; break polarity 
                           000004   859   TIM1_BKR_BKE=(4) ; break enable   
                           000003   860   TIM1_BKR_OSSR=(3) ; off state selection for Run mode 
                           000002   861   TIM1_BKR_OSSI=(2) ; Off state selection for idle mode
                           000000   862   TIM1_BKR_LOCK=(0) ; lock configuration
                                    863 
                                    864 ; Timer 2 - 16-bit timer
                           005300   865  TIM2_CR1  = (0x5300)
                           005301   866  TIM2_IER  = (0x5301)
                           005302   867  TIM2_SR1  = (0x5302)
                           005303   868  TIM2_SR2  = (0x5303)
                           005304   869  TIM2_EGR  = (0x5304)
                           005305   870  TIM2_CCMR1  = (0x5305)
                           005306   871  TIM2_CCMR2  = (0x5306)
                           005307   872  TIM2_CCMR3  = (0x5307)
                           005308   873  TIM2_CCER1  = (0x5308)
                           005309   874  TIM2_CCER2  = (0x5309)
                           00530A   875  TIM2_CNTRH  = (0x530A)
                           00530B   876  TIM2_CNTRL  = (0x530B)
                           00530C   877  TIM2_PSCR  = (0x530C)
                           00530D   878  TIM2_ARRH  = (0x530D)
                           00530E   879  TIM2_ARRL  = (0x530E)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 22.
Hexadecimal [24-Bits]



                           00530F   880  TIM2_CCR1H  = (0x530F)
                           005310   881  TIM2_CCR1L  = (0x5310)
                           005311   882  TIM2_CCR2H  = (0x5311)
                           005312   883  TIM2_CCR2L  = (0x5312)
                           005313   884  TIM2_CCR3H  = (0x5313)
                           005314   885  TIM2_CCR3L  = (0x5314)
                                    886 
                                    887 ; TIM2_CR1 bitfields
                           000000   888  TIM2_CR1_CEN=(0) ; Counter enable
                           000001   889  TIM2_CR1_UDIS=(1) ; Update disable
                           000002   890  TIM2_CR1_URS=(2) ; Update request source
                           000003   891  TIM2_CR1_OPM=(3) ; One-pulse mode
                           000007   892  TIM2_CR1_ARPE=(7) ; Auto-reload preload enable
                                    893 
                                    894 ; TIMER2_CCMR bitfields 
                           000000   895  TIM2_CCMR_CCS=(0) ; input/output select
                           000003   896  TIM2_CCMR_OCPE=(3) ; preload enable
                           000004   897  TIM2_CCMR_OCM=(4)  ; output compare mode 
                                    898 
                                    899 ; TIMER2_CCER1 bitfields
                           000000   900  TIM2_CCER1_CC1E=(0)
                           000001   901  TIM2_CCER1_CC1P=(1)
                           000004   902  TIM2_CCER1_CC2E=(4)
                           000005   903  TIM2_CCER1_CC2P=(5)
                                    904 
                                    905 ; TIMER2_EGR bitfields
                           000000   906  TIM2_EGR_UG=(0) ; update generation
                           000001   907  TIM2_EGR_CC1G=(1) ; Capture/compare 1 generation
                           000002   908  TIM2_EGR_CC2G=(2) ; Capture/compare 2 generation
                           000003   909  TIM2_EGR_CC3G=(3) ; Capture/compare 3 generation
                           000006   910  TIM2_EGR_TG=(6); Trigger generation
                                    911 
                                    912 ; Timer 3
                           005320   913  TIM3_CR1  = (0x5320)
                           005321   914  TIM3_IER  = (0x5321)
                           005322   915  TIM3_SR1  = (0x5322)
                           005323   916  TIM3_SR2  = (0x5323)
                           005324   917  TIM3_EGR  = (0x5324)
                           005325   918  TIM3_CCMR1  = (0x5325)
                           005326   919  TIM3_CCMR2  = (0x5326)
                           005327   920  TIM3_CCER1  = (0x5327)
                           005328   921  TIM3_CNTRH  = (0x5328)
                           005329   922  TIM3_CNTRL  = (0x5329)
                           00532A   923  TIM3_PSCR  = (0x532A)
                           00532B   924  TIM3_ARRH  = (0x532B)
                           00532C   925  TIM3_ARRL  = (0x532C)
                           00532D   926  TIM3_CCR1H  = (0x532D)
                           00532E   927  TIM3_CCR1L  = (0x532E)
                           00532F   928  TIM3_CCR2H  = (0x532F)
                           005330   929  TIM3_CCR2L  = (0x5330)
                                    930 
                                    931 ; TIM3_CR1  fields
                           000000   932  TIM3_CR1_CEN = (0)
                           000001   933  TIM3_CR1_UDIS = (1)
                           000002   934  TIM3_CR1_URS = (2)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 23.
Hexadecimal [24-Bits]



                           000003   935  TIM3_CR1_OPM = (3)
                           000007   936  TIM3_CR1_ARPE = (7)
                                    937  ; TIM3_IER fields
                           000000   938  TIM3_IER_UIE=(0)
                           000001   939  TIM3_IER_CC1IE=(1)
                           000002   940  TIM3_IER_CC2IE=(2)
                           000003   941  TIM3_IER_CC3IE=(3)
                           000006   942  TIM3_IER_TIE=(6)
                                    943 ;TIM3_SR1 fields 
                           000000   944  TIM3_SR1_UIF=(0)
                           000001   945  TIM3_SR1_CC1IF=(1)
                           000002   946  TIM3_SR1_CC2IF=(2)
                           000003   947  TIM3_SR1_CC3IF=(3)
                           000006   948  TIM3_SR1_TIF=(6)    
                                    949 ;TIM3_SR2 fields
                           000001   950  TIM3_SR2_CC1OF=(1)
                           000002   951  TIM3_SR2_CC2OF=(2)
                           000003   952 TIM3_SR2_CC3OF=(3)
                                    953 ;TIM3_EGR fields 
                           000000   954  TIM3_EGR_UG=(0)
                           000001   955  TIM3_EGR_CC1G=(1)
                           000002   956  TIM3_EGR_CC2G=(2)
                           000003   957  TIM3_EGR_CC3G=(3)
                           000006   958  TIM3_EGR_TG=(6)
                                    959 ; TIM3_CCMR1  fields
                           000000   960  TIM3_CCMR1_CC1S = (0)
                           000003   961  TIM3_CCMR1_OC1PE = (3)
                           000004   962  TIM3_CCMR1_OC1M = (4)  
                                    963 ; TIM3_CCMR2  fields
                           000000   964  TIM3_CCMR2_CC2S = (0)
                           000003   965  TIM3_CCMR2_OC2PE = (3)
                           000004   966  TIM3_CCMR2_OC2M = (4)  
                                    967 ; TIM3_CCMR3  fields
                           000000   968  TIM3_CCMR3_CC3S = (0)
                           000003   969  TIM3_CCMR3_OC3PE = (3)
                           000004   970  TIM3_CCMR3_OC3M = (4)  
                                    971 ; TIM3_CCER3 fields
                           000000   972  TIM3_CCER1_CC1E = (0)
                           000001   973  TIM3_CCER1_CC1P = (1)
                           000004   974  TIM3_CCER1_CC2E = (4)
                           000005   975  TIM3_CCER1_CC2P = (5)
                                    976 ; TIM3_CCER2 fields
                           000000   977  TIM3_CCER2_CC3E = (0)
                           000001   978  TIM3_CCER2_CC3P = (1)
                                    979 
                                    980 ; Timer 4
                           005340   981  TIM4_CR1  = (0x5340)
                           005341   982  TIM4_IER  = (0x5341)
                           005342   983  TIM4_SR  = (0x5342)
                           005343   984  TIM4_EGR  = (0x5343)
                           005344   985  TIM4_CNTR  = (0x5344)
                           005345   986  TIM4_PSCR  = (0x5345)
                           005346   987  TIM4_ARR  = (0x5346)
                                    988 
                                    989 ; Timer 4 bitmasks
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 24.
Hexadecimal [24-Bits]



                                    990 
                           000007   991  TIM4_CR1_ARPE = (7)
                           000003   992  TIM4_CR1_OPM = (3)
                           000002   993  TIM4_CR1_URS = (2)
                           000001   994  TIM4_CR1_UDIS = (1)
                           000000   995  TIM4_CR1_CEN = (0)
                                    996 
                           000000   997  TIM4_IER_UIE = (0)
                                    998 
                           000000   999  TIM4_SR_UIF = (0)
                                   1000 
                           000000  1001  TIM4_EGR_UG = (0)
                                   1002 
                           000002  1003  TIM4_PSCR_PSC2 = (2)
                           000001  1004  TIM4_PSCR_PSC1 = (1)
                           000000  1005  TIM4_PSCR_PSC0 = (0)
                                   1006 
                           000000  1007  TIM4_PSCR_1 = 0
                           000001  1008  TIM4_PSCR_2 = 1
                           000002  1009  TIM4_PSCR_4 = 2
                           000003  1010  TIM4_PSCR_8 = 3
                           000004  1011  TIM4_PSCR_16 = 4
                           000005  1012  TIM4_PSCR_32 = 5
                           000006  1013  TIM4_PSCR_64 = 6
                           000007  1014  TIM4_PSCR_128 = 7
                                   1015 
                                   1016 ; ADC2
                           005400  1017  ADC2_CSR  = (0x5400) ; ADC control/status register
                           005401  1018  ADC2_CR1  = (0x5401) ; ADC configuration register 1
                           005402  1019  ADC2_CR2  = (0x5402) ; ADC configuration register 2
                           005403  1020  ADC2_CR3  = (0x5403) ; ADC configuration register 3
                           005404  1021  ADC2_DRH  = (0x5404) ; ADC data register high
                           005405  1022  ADC2_DRL  = (0x5405) ; ADC data register low 
                           005406  1023  ADC2_TDRH  = (0x5406) ; ADC Schmitt trigger disable register high
                           005407  1024  ADC2_TDRL  = (0x5407) ; ADC Schmitt trigger disable register low 
                                   1025  
                                   1026 ; ADC2 bitmasks
                                   1027 
                           000007  1028  ADC2_CSR_EOC = (7) ; end of conversion flag 
                           000006  1029  ADC2_CSR_AWD = (6) ; analog watchdog flag 
                           000005  1030  ADC2_CSR_EOCIE = (5) ; Interrupt enable for EOC 
                           000004  1031  ADC2_CSR_AWDIE = (4) ; Interrupt enable for AWD 
                           000000  1032  ADC2_CSR_CH = (0) ; bits 3:0 channel select field 
                                   1033  
                           000004  1034  ADC2_CR1_SPSEL2 = (4) ; bits 6:4 pre-scaler selection 
                           000001  1035  ADC2_CR1_CONT = (1) ; continuous converstion 
                           000000  1036  ADC2_CR1_ADON = (0) ; converter on/off 
                                   1037 
                           000006  1038  ADC2_CR2_EXTTRIG = (6) ; external trigger enable 
                           000004  1039  ADC2_CR2_EXTSEL1 = (4) ; bits 5:4 external event selection  
                           000003  1040  ADC2_CR2_ALIGN = (3) ; data alignment  
                           000001  1041  ADC2_CR2_SCAN = (1) ; scan mode eanble 
                                   1042 
                           000007  1043  ADC2_CR3_DBUF = (7) ; data buffer enable 
                           000006  1044  ADC2_CR3_DRH = (6)  ; overrun flag 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 25.
Hexadecimal [24-Bits]



                                   1045 
                                   1046 ; beCAN
                           005420  1047  CAN_MCR = (0x5420)
                           005421  1048  CAN_MSR = (0x5421)
                           005422  1049  CAN_TSR = (0x5422)
                           005423  1050  CAN_TPR = (0x5423)
                           005424  1051  CAN_RFR = (0x5424)
                           005425  1052  CAN_IER = (0x5425)
                           005426  1053  CAN_DGR = (0x5426)
                           005427  1054  CAN_FPSR = (0x5427)
                           005428  1055  CAN_P0 = (0x5428)
                           005429  1056  CAN_P1 = (0x5429)
                           00542A  1057  CAN_P2 = (0x542A)
                           00542B  1058  CAN_P3 = (0x542B)
                           00542C  1059  CAN_P4 = (0x542C)
                           00542D  1060  CAN_P5 = (0x542D)
                           00542E  1061  CAN_P6 = (0x542E)
                           00542F  1062  CAN_P7 = (0x542F)
                           005430  1063  CAN_P8 = (0x5430)
                           005431  1064  CAN_P9 = (0x5431)
                           005432  1065  CAN_PA = (0x5432)
                           005433  1066  CAN_PB = (0x5433)
                           005434  1067  CAN_PC = (0x5434)
                           005435  1068  CAN_PD = (0x5435)
                           005436  1069  CAN_PE = (0x5436)
                           005437  1070  CAN_PF = (0x5437)
                                   1071 
                                   1072 
                                   1073 ; CPU
                           007F00  1074  CPU_A  = (0x7F00)
                           007F01  1075  CPU_PCE  = (0x7F01)
                           007F02  1076  CPU_PCH  = (0x7F02)
                           007F03  1077  CPU_PCL  = (0x7F03)
                           007F04  1078  CPU_XH  = (0x7F04)
                           007F05  1079  CPU_XL  = (0x7F05)
                           007F06  1080  CPU_YH  = (0x7F06)
                           007F07  1081  CPU_YL  = (0x7F07)
                           007F08  1082  CPU_SPH  = (0x7F08)
                           007F09  1083  CPU_SPL   = (0x7F09)
                           007F0A  1084  CPU_CCR   = (0x7F0A)
                                   1085 
                                   1086 ; global configuration register
                           007F60  1087  CFG_GCR   = (0x7F60)
                           000001  1088  CFG_GCR_AL = 1
                           000000  1089  CFG_GCR_SWIM = 0
                                   1090 
                                   1091 ; interrupt software priority 
                           007F70  1092  ITC_SPR1   = (0x7F70) ; (0..3) 0->resreved,AWU..EXT0 
                           007F71  1093  ITC_SPR2   = (0x7F71) ; (4..7) EXT1..EXT4 RX 
                           007F72  1094  ITC_SPR3   = (0x7F72) ; (8..11) beCAN RX..TIM1 UPDT/OVR  
                           007F73  1095  ITC_SPR4   = (0x7F73) ; (12..15) TIM1 CAP/CMP .. TIM3 UPDT/OVR 
                           007F74  1096  ITC_SPR5   = (0x7F74) ; (16..19) TIM3 CAP/CMP..I2C  
                           007F75  1097  ITC_SPR6   = (0x7F75) ; (20..23) UART3 TX..TIM4 CAP/OVR 
                           007F76  1098  ITC_SPR7   = (0x7F76) ; (24..29) FLASH WR..
                           007F77  1099  ITC_SPR8   = (0x7F77) ; (30..32) ..
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 26.
Hexadecimal [24-Bits]



                                   1100 
                           000001  1101 ITC_SPR_LEVEL1=1 
                           000000  1102 ITC_SPR_LEVEL2=0
                           000003  1103 ITC_SPR_LEVEL3=3 
                                   1104 
                                   1105 ; SWIM, control and status register
                           007F80  1106  SWIM_CSR   = (0x7F80)
                                   1107 ; debug registers
                           007F90  1108  DM_BK1RE   = (0x7F90)
                           007F91  1109  DM_BK1RH   = (0x7F91)
                           007F92  1110  DM_BK1RL   = (0x7F92)
                           007F93  1111  DM_BK2RE   = (0x7F93)
                           007F94  1112  DM_BK2RH   = (0x7F94)
                           007F95  1113  DM_BK2RL   = (0x7F95)
                           007F96  1114  DM_CR1   = (0x7F96)
                           007F97  1115  DM_CR2   = (0x7F97)
                           007F98  1116  DM_CSR1   = (0x7F98)
                           007F99  1117  DM_CSR2   = (0x7F99)
                           007F9A  1118  DM_ENFCTR   = (0x7F9A)
                                   1119 
                                   1120 ; Interrupt Numbers
                           000000  1121  INT_TLI = 0
                           000001  1122  INT_AWU = 1
                           000002  1123  INT_CLK = 2
                           000003  1124  INT_EXTI0 = 3
                           000004  1125  INT_EXTI1 = 4
                           000005  1126  INT_EXTI2 = 5
                           000006  1127  INT_EXTI3 = 6
                           000007  1128  INT_EXTI4 = 7
                           000008  1129  INT_CAN_RX = 8
                           000009  1130  INT_CAN_TX = 9
                           00000A  1131  INT_SPI = 10
                           00000B  1132  INT_TIM1_OVF = 11
                           00000C  1133  INT_TIM1_CCM = 12
                           00000D  1134  INT_TIM2_OVF = 13
                           00000E  1135  INT_TIM2_CCM = 14
                           00000F  1136  INT_TIM3_OVF = 15
                           000010  1137  INT_TIM3_CCM = 16
                           000011  1138  INT_UART1_TX_COMPLETED = 17
                           000012  1139  INT_AUART1_RX_FULL = 18
                           000013  1140  INT_I2C = 19
                           000014  1141  INT_UART3_TX_COMPLETED = 20
                           000015  1142  INT_UART3_RX_FULL = 21
                           000016  1143  INT_ADC2 = 22
                           000017  1144  INT_TIM4_OVF = 23
                           000018  1145  INT_FLASH = 24
                                   1146 
                                   1147 ; Interrupt Vectors
                           008000  1148  INT_VECTOR_RESET = 0x8000
                           008004  1149  INT_VECTOR_TRAP = 0x8004
                           008008  1150  INT_VECTOR_TLI = 0x8008
                           00800C  1151  INT_VECTOR_AWU = 0x800C
                           008010  1152  INT_VECTOR_CLK = 0x8010
                           008014  1153  INT_VECTOR_EXTI0 = 0x8014
                           008018  1154  INT_VECTOR_EXTI1 = 0x8018
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 27.
Hexadecimal [24-Bits]



                           00801C  1155  INT_VECTOR_EXTI2 = 0x801C
                           008020  1156  INT_VECTOR_EXTI3 = 0x8020
                           008024  1157  INT_VECTOR_EXTI4 = 0x8024
                           008028  1158  INT_VECTOR_CAN_RX = 0x8028
                           00802C  1159  INT_VECTOR_CAN_TX = 0x802c
                           008030  1160  INT_VECTOR_SPI = 0x8030
                           008034  1161  INT_VECTOR_TIM1_OVF = 0x8034
                           008038  1162  INT_VECTOR_TIM1_CCM = 0x8038
                           00803C  1163  INT_VECTOR_TIM2_OVF = 0x803C
                           008040  1164  INT_VECTOR_TIM2_CCM = 0x8040
                           008044  1165  INT_VECTOR_TIM3_OVF = 0x8044
                           008048  1166  INT_VECTOR_TIM3_CCM = 0x8048
                           00804C  1167  INT_VECTOR_UART1_TX_COMPLETED = 0x804c
                           008050  1168  INT_VECTOR_UART1_RX_FULL = 0x8050
                           008054  1169  INT_VECTOR_I2C = 0x8054
                           008058  1170  INT_VECTOR_UART3_TX_COMPLETED = 0x8058
                           00805C  1171  INT_VECTOR_UART3_RX_FULL = 0x805C
                           008060  1172  INT_VECTOR_ADC2 = 0x8060
                           008064  1173  INT_VECTOR_TIM4_OVF = 0x8064
                           008068  1174  INT_VECTOR_FLASH = 0x8068
                                   1175 
                                   1176 ; Condition code register bits
                           000007  1177 CC_V = 7  ; overflow flag 
                           000005  1178 CC_I1= 5  ; interrupt bit 1
                           000004  1179 CC_H = 4  ; half carry 
                           000003  1180 CC_I0 = 3 ; interrupt bit 0
                           000002  1181 CC_N = 2 ;  negative flag 
                           000001  1182 CC_Z = 1 ;  zero flag  
                           000000  1183 CC_C = 0 ; carry bit 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 28.
Hexadecimal [24-Bits]



                                     65 	.include "inc/gen_macros.inc" 
                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2019 
                                      3 ; This file is part of STM8_NUCLEO 
                                      4 ;
                                      5 ;     STM8_NUCLEO is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     STM8_NUCLEO is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with STM8_NUCLEO.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 ;--------------------------------------
                                     19 ;   console Input/Output module
                                     20 ;   DATE: 2019-12-11
                                     21 ;    
                                     22 ;   General usage macros.   
                                     23 ;
                                     24 ;--------------------------------------
                                     25 
                                     26     ; microseconds delay 
                                     27     .macro usec n, ?loop 
                                     28         ldw x,#4*n 
                                     29     loop:
                                     30         decw x 
                                     31         nop 
                                     32         jrne loop
                                     33     .endm 
                                     34 
                                     35     ; reserve space on stack
                                     36     ; for local variables
                                     37     .macro _vars n 
                                     38     sub sp,#n 
                                     39     .endm 
                                     40     
                                     41     ; free space on stack
                                     42     .macro _drop n 
                                     43     addw sp,#n 
                                     44     .endm
                                     45 
                                     46     ; declare ARG_OFS for arguments 
                                     47     ; displacement on stack. This 
                                     48     ; value depend on local variables 
                                     49     ; size.
                                     50     .macro _argofs n 
                                     51     ARG_OFS=2+n 
                                     52     .endm 
                                     53 
                                     54     ; declare a function argument 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 29.
Hexadecimal [24-Bits]



                                     55     ; position relative to stack pointer 
                                     56     ; _argofs must be called before it.
                                     57     .macro _arg name ofs 
                                     58     name=ARG_OFS+ofs 
                                     59     .endm 
                                     60 
                                     61     ; increment zero page variable 
                                     62     .macro _incz v 
                                     63     .byte 0x3c, v 
                                     64     .endm 
                                     65 
                                     66     ; decrement zero page variable 
                                     67     .macro _decz v 
                                     68     .byte 0x3a,v 
                                     69     .endm 
                                     70 
                                     71     ; clear zero page variable 
                                     72     .macro _clrz v 
                                     73     .byte 0x3f, v 
                                     74     .endm 
                                     75 
                                     76     ; load A zero page variable 
                                     77     .macro _ldaz v 
                                     78     .byte 0xb6,v 
                                     79     .endm 
                                     80 
                                     81     ; store A zero page variable 
                                     82     .macro _straz v 
                                     83     .byte 0xb7,v 
                                     84     .endm 
                                     85 
                                     86     ; load x from variable in zero page 
                                     87     .macro _ldxz v 
                                     88     .byte 0xbe,v 
                                     89     .endm 
                                     90 
                                     91     ; load y from variable in zero page 
                                     92     .macro _ldyz v 
                                     93     .byte 0x90,0xbe,v 
                                     94     .endm 
                                     95 
                                     96     ; store x in zero page variable 
                                     97     .macro _strxz v 
                                     98     .byte 0xbf,v 
                                     99     .endm 
                                    100 
                                    101     ; store y in zero page variable 
                                    102     .macro _stryz v 
                                    103     .byte 0x90,0xbf,v 
                                    104     .endm 
                                    105 
                                    106     ;  increment 16 bits variable
                                    107     ;  use 10 bytes  
                                    108     .macro _incwz  v 
                                    109         _incz v+1   ; 1 cy, 2 bytes 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 30.
Hexadecimal [24-Bits]



                                    110         jrne .+4  ; 1|2 cy, 2 bytes 
                                    111         _incz v     ; 1 cy, 2 bytes  
                                    112     .endm ; 3 cy 
                                    113 
                                    114     ; xor op with zero page variable 
                                    115     .macro _xorz v 
                                    116     .byte 0xb8,v 
                                    117     .endm 
                                    118     
                                    119     ; mov memory to memory page 0 
                                    120     .macro _movz m1,m2 
                                    121     .byte 0x45,m2,m1 
                                    122     .endm 
                                    123     
                                    124     ; software reset 
                                    125     .macro _swreset
                                    126     mov WWDG_CR,#0X80
                                    127     .endm 
                                    128 
                                    129 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 31.
Hexadecimal [24-Bits]



                                     66 	.include "app_macros.inc" 
                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2023,2024  
                                      3 ; This file is part of stm8-gamepad
                                      4 ;
                                      5 ;     stm8-gamepadis free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     stm8-gamepadis distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with ntsc_tuto.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                                     19 
                                     20  
                                     21 ; boolean flags 
                           000007    22     F_GAME_TMR=7 ; game timer expired reset 
                           000006    23     F_SOUND_TMR=6 ; sound timer expired reset  
                           000005    24     F_DISP_MODE=5 ; display mode 0->text,1->graphic 
                                     25     
                                     26 ;--------------------------------------
                                     27 ;   assembler flags 
                                     28 ;-------------------------------------
                                     29 
                                     30     ; assume 16 Mhz Fcpu 
                                     31      .macro _usec_dly n 
                                     32     ldw x,#(16*n-2)/4 ; 2 cy 
                                     33     decw x  ; 1 cy 
                                     34     nop     ; 1 cy 
                                     35     jrne .-2 ; 2 cy 
                                     36     .endm 
                                     37 
                                     38 ;----------------------------------
                                     39 ; functions arguments access 
                                     40 ; from stack 
                                     41 ; caller push arguments before call
                                     42 ; and drop them after call  
                                     43 ;----------------------------------    
                                     44     ; get argument in X 
                                     45     .macro _get_arg n 
                                     46     ldw x,(2*(n+1),sp)
                                     47     .endm 
                                     48 
                                     49     ; store X in argument n 
                                     50     .macro _store_arg n 
                                     51     ldw (2*(n+1),sp),x 
                                     52     .endm 
                                     53 
                                     54     ; drop function arguments 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 32.
Hexadecimal [24-Bits]



                                     55     .macro _drop_args n 
                                     56     addw sp,#2*n
                                     57     .endm 
                                     58 
                                     59 
                                     60     ; read buttons 
                                     61     .macro _read_buttons
                                     62     ld a,#BTN_PORT+GPIO_IDR 
                                     63     and a,#ALL_KEY_UP
                                     64     .endm 
                                     65 
                                     66 
                                     67 ;-----------------------------
                                     68 ;   keypad macros 
                                     69 ;-----------------------------
                                     70 
                                     71     .macro _btn_down btn 
                                     72     ld a,BTN_IDR 
                                     73     and a,#(1<<btn)
                                     74     or a,#(1<<btn)
                                     75     .endm 
                                     76 
                                     77     .macro _btn_up 
                                     78     ld a,#BTN_IDR 
                                     79     and a,#(1<<btn)
                                     80     .endm 
                                     81 
                                     82     .macro _btn_state 
                                     83     ld a,#BTN_IDR 
                                     84     and a,#ALL_KEY_UP
                                     85     .endm 
                                     86 
                                     87     .macro _wait_key_release  ?loop 
                                     88     loop:
                                     89     ld a,BTN_IDR 
                                     90     and a,#ALL_KEY_UP 
                                     91     cp a,#ALL_KEY_UP 
                                     92     jrne loop 
                                     93     .endm 
                                     94 
                                     95 ;------------------------
                                     96 ; LED control 
                                     97 ;-----------------------
                                     98 
                                     99     .macro _led_on 
                                    100     bset LED_PORT+GPIO_ODR,#LED_BIT 
                                    101     .endm 
                                    102 
                                    103     .macro _led_off 
                                    104     bres LED_PORT+GPIO_ODR,#LED_BIT
                                    105     .endm 
                                    106 
                                    107     .macro _led_toggle 
                                    108     bcpl LED_PORT+GPIO_ODR,#LED_BIT
                                    109     .endm 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 33.
Hexadecimal [24-Bits]



                                    110 
                                    111     
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 34.
Hexadecimal [24-Bits]



                                     67 
                                     68 
                                     69 
                                     70 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 35.
Hexadecimal [24-Bits]



                                     32 
                           0017FF    33 STACK_EMPTY=RAM_SIZE-1 
                           000080    34 STACK_SIZE=128   
                                     35 ;;-----------------------------------
                                     36     .area SSEG (ABS)
                                     37 ;; working buffers and stack at end of RAM. 	
                                     38 ;;-----------------------------------
                                     39 ; video buffe
                           0012C0    40 VBUFF_SIZE=HRES*VRES/8 ; 200*192/8=4800 bytes 
      0004C0                         41     .org RAM_SIZE-STACK_SIZE-VBUFF_SIZE
      0004C0                         42 tv_buffer: .blkb  VBUFF_SIZE
                                     43 ; stack at end of RAM 
      001780                         44 stack_full:: .ds STACK_SIZE   ; control stack full 
      001800                         45 stack_unf: ; stack underflow ; RAM end +1 -> 0x1800
                                     46 
                                     47 ;;--------------------------------------
                                     48     .area HOME 
                                     49 ;; interrupt vector table at 0x8000
                                     50 ;;--------------------------------------
                                     51 
      008000 82 00 81 95             52     int cold_start			; RESET vector 
      008004 82 00 80 80             53 	int NonHandledInterrupt ; trap instruction 
      008008 82 00 80 80             54 	int NonHandledInterrupt ;int0 TLI   external top level interrupt
      00800C 82 00 80 80             55 	int NonHandledInterrupt ;int1 AWU   auto wake up from halt
      008010 82 00 80 80             56 	int NonHandledInterrupt ;int2 CLK   clock controller
      008014 82 00 80 80             57 	int NonHandledInterrupt ;int3 EXTI0 gpio A external interrupts
      008018 82 00 80 80             58 	int NonHandledInterrupt ;int4 EXTI1 gpio B external interrupts
      00801C 82 00 80 80             59 	int NonHandledInterrupt ;int5 EXTI2 gpio C external interrupts
      008020 82 00 80 80             60 	int NonHandledInterrupt ;int6 EXTI3 gpio D external interrupts
      008024 82 00 80 80             61 	int NonHandledInterrupt ;int7 EXTI4 gpio E external interrupts
      008028 82 00 80 80             62 	int NonHandledInterrupt ;int8 beCAN RX interrupt
      00802C 82 00 80 80             63 	int NonHandledInterrupt ;int9 beCAN TX/ER/SC interrupt
      008030 82 00 80 80             64 	int NonHandledInterrupt ;int10 SPI End of transfer
      008034 82 00 85 F5             65 	int ntsc_sync_interrupt ;int11 TIM1 update/overflow/underflow/trigger/break
      008038 82 00 86 D2             66 	int ntsc_video_interrupt ; int12 TIM1 capture/compare
      00803C 82 00 80 80             67 	int NonHandledInterrupt ;int13 TIM2 update /overflow
      008040 82 00 80 80             68 	int NonHandledInterrupt ;int14 TIM2 capture/compare
      008044 82 00 80 80             69 	int NonHandledInterrupt ;int15 TIM3 Update/overflow
      008048 82 00 80 80             70 	int NonHandledInterrupt ;int16 TIM3 Capture/compare
      00804C 82 00 80 80             71 	int NonHandledInterrupt ;int17 UART1 TX completed
      008050 82 00 80 80             72 	int NonHandledInterrupt ;int18 UART1 RX full  
      008054 82 00 80 80             73 	int NonHandledInterrupt ;int19 I2C 
      008058 82 00 80 80             74 	int NonHandledInterrupt ;int20 UART3 TX completed
                           000000    75 .if DEBUG 
                                     76 .if NUCLEO
                                     77 	int UartRxHandler       ; int21 UART3 RX full 
                                     78 .else 
                                     79 	int NonHandledInterrupt ;int21 UART3 RX full
                                     80 .endif ;; NUCLEO
                           000001    81 .else 
      00805C 82 00 80 80             82 	int NonHandledInterrupt ;int21 UART3 RX full
                                     83 .endif ;; DEBUG 	
      008060 82 00 80 80             84 	int NonHandledInterrupt ;int22 ADC2 end of conversion
      008064 82 00 80 80             85 	int NonHandledInterrupt ;int23 TIM4 update$overflow 
      008068 82 00 80 80             86 	int NonHandledInterrupt ;int24 flash writing EOP/WR_PG_DIS
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 36.
Hexadecimal [24-Bits]



      00806C 82 00 80 80             87 	int NonHandledInterrupt ;int25  not used
      008070 82 00 80 80             88 	int NonHandledInterrupt ;int26  not used
      008074 82 00 80 80             89 	int NonHandledInterrupt ;int27  not used
      008078 82 00 80 80             90 	int NonHandledInterrupt ;int28  not used
      00807C 82 00 80 80             91 	int NonHandledInterrupt ;int29  not used
                                     92 
                                     93 
                           000020    94 SYS_VAR_SIZE=32 
                           0000E0    95 KERNEL_VAR_ORG=256-SYS_VAR_SIZE 
                                     96 ;--------------------------------------
                                     97     .area DATA (ABS)
      0000E0                         98 	.org KERNEL_VAR_ORG 
                                     99 ;--------------------------------------	
                                    100 
      0000E0                        101 ticks: .blkw 1 ; 2 millisecond counter
      0000E2                        102 delay_timer: .blkb 1 
      0000E3                        103 sound_timer: .blkb 1 
                                    104 ; keep the following 3 variables in this order 
      0000E4                        105 acc16:: .blkb 1 ; 16 bits accumulator, acc24 high-byte
      0000E5                        106 acc8::  .blkb 1 ;  8 bits accumulator, acc24 low-byte  
      0000E6                        107 fmstr:: .blkw 1 ; frequency in Mhz of Fmaster
      0000E8                        108 ptr16::  .blkb 1 ; 16 bits pointer , farptr high-byte 
      0000E9                        109 ptr8:   .blkb 1 ; 8 bits pointer, farptr low-byte  
      0000EA                        110 flags:: .blkb 1 ; various boolean flags
      0000EB                        111 seedx: .blkw 1  ; prng seed bits 0..15
      0000ED                        112 seedy: .blkw 1  ; prng seed bits 16..31
                                    113 
                                    114 ; tvout variables 
      0000EF                        115 ntsc_flags: .blkb 1 
      0000F0                        116 ntsc_phase: .blkb 1 ; 
      0000F1                        117 scan_line: .blkw 1 ; video lines {0..262} 
                                    118 
                                    119 ; display variables 
      0000F3                        120 cy: .blkb 1 ; text cursor y coord {0..7} 
      0000F4                        121 cx: .blkb 1 ; text cursor y coord {0..15}
                                    122 
                           000001   123 .if NUCLEO 
                           000000   124 .if DEBUG 
                                    125 RX_QUEUE_SIZE=8 
                                    126 rx1_head: .blkb 1 
                                    127 rx1_tail: .blkb 1 
                                    128 rx1_queue: .blkb 8 
                                    129 .endif ;; DEBUG 
                                    130 .endif ;; NUCLEO 
                                    131 
                                    132 	.area CODE 
                                    133 
                                    134 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    135 ; non handled interrupt 
                                    136 ; reset MCU
                                    137 ;;;;;;;;;;;;;;;;;;;;;;;;;;;
      008080                        138 NonHandledInterrupt:
      000000                        139 	_swreset ; see "inc/gen_macros.inc"
      008080 35 80 50 D1      [ 1]    1     mov WWDG_CR,#0X80
                                    140 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 37.
Hexadecimal [24-Bits]



                                    141 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    142 ;    peripherals initialization
                                    143 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    144 
                                    145 ;----------------------------------------
                                    146 ; inialize MCU clock 
                                    147 ; select HSE 
                                    148 ; no CPU divisor 
                                    149 ;----------------------------------------
      008084                        150 clock_init:	
      008084 72 17 50 C5      [ 1]  151 	bres CLK_SWCR,#CLK_SWCR_SWIF 
      008088 35 B4 50 C4      [ 1]  152 	mov CLK_SWR,#CLK_SWR_HSE  
      00808C 72 07 50 C5 FB   [ 2]  153 	btjf CLK_SWCR,#CLK_SWCR_SWIF,. 
      008091 72 12 50 C5      [ 1]  154 	bset CLK_SWCR,#CLK_SWCR_SWEN
      008095                        155 2$: 
      008095 72 5F 50 C6      [ 1]  156 	clr CLK_CKDIVR   	
      008099 81               [ 4]  157 	ret
                                    158 
                                    159 ;----------------------------------
                                    160 ; TIMER3 used as audio tone output 
                                    161 ; on port D:2. pin 27
                                    162 ; channel 3 configured as PWM mode 1 
                                    163 ;-----------------------------------  
      00809A                        164 timer3_init:
      00809A 72 1C 50 C7      [ 1]  165 	bset CLK_PCKENR1,#CLK_PCKENR1_TIM3 ; enable TIMER3 clock 
      00809E 72 10 50 11      [ 1]  166  	bset SOUND_PORT+GPIO_DDR,#SOUND_BIT
      0080A2 35 60 53 26      [ 1]  167 	mov TIM3_CCMR2,#(6<<TIM3_CCMR2_OC2M) ; PWM mode 1 
      0080A6 35 08 53 2A      [ 1]  168 	mov TIM3_PSCR,#8 ; Ft2clk=fmstr/256=62500 hertz 
      0080AA 72 11 53 20      [ 1]  169 	bres TIM3_CR1,#TIM3_CR1_CEN
      0080AE 72 19 53 27      [ 1]  170 	bres TIM3_CCER1,#TIM3_CCER1_CC2E
      0080B2 81               [ 4]  171 	ret 
                                    172  
                           000000   173 .if 0
                                    174 ;--------------------------
                                    175 ; set software interrupt 
                                    176 ; priority 
                                    177 ; input:
                                    178 ;   A    priority 1,2,3 
                                    179 ;   X    vector# 
                                    180 ;---------------------------
                                    181 	SPR_ADDR=1 
                                    182 	PRIORITY=3
                                    183 	SLOT=4
                                    184 	MASKED=5  
                                    185 	VSIZE=5
                                    186 set_int_priority::
                                    187 	_vars VSIZE
                                    188 	and a,#3  
                                    189 	ld (PRIORITY,sp),a 
                                    190 ; select ITC_SPRX register 
                                    191 	ld a,#4 
                                    192 	div x,a 
                                    193 	sll a  ; slot*2 
                                    194 	ld (SLOT,sp),a
                                    195 	addw x,#ITC_SPR1 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 38.
Hexadecimal [24-Bits]



                                    196 	ldw (SPR_ADDR,sp),x 
                                    197 ; build mask
                                    198 	ldw x,#0xfffc ; slot 0 mask 	
                                    199 	ld a,(SLOT,sp)
                                    200 	jreq 2$ 
                                    201 	scf 
                                    202 1$:	rlcw x 
                                    203 	dec a 
                                    204 	jrne 1$
                                    205 2$:	ld a,xl 
                                    206 ; apply mask to slot 
                                    207 	ldw x,(SPR_ADDR,sp)
                                    208 	and a,(x)
                                    209 	ld (MASKED,sp),a 
                                    210 ; shift priority to slot 
                                    211 	ld a,(PRIORITY,sp)
                                    212 	tnz (SLOT,sp)
                                    213 	jreq 4$
                                    214 3$:	sll a  
                                    215 	dec (SLOT,sp) 
                                    216 	jrne 3$
                                    217 4$:	 
                                    218 	or a,(MASKED,sp)
                                    219 	ldw x,(SPR_ADDR,sp)
                                    220 	ld (x),a 
                                    221 	_drop VSIZE 
                                    222 	ret 
                                    223 .endif 
                                    224 
                                    225 ;------------------------
                                    226 ; suspend execution 
                                    227 ; input:
                                    228 ;   A     16.7*n msec   
                                    229 ;-------------------------
      0080B3                        230 pause:
      000033                        231 	_straz delay_timer 
      0080B3 B7 E2                    1     .byte 0xb7,delay_timer 
      0080B5 72 1E 00 EA      [ 1]  232 	bset flags,#F_GAME_TMR 
      0080B9                        233 1$: 	
      0080B9 72 0E 00 EA FB   [ 2]  234 	btjt flags,#F_GAME_TMR,1$ 
      0080BE 81               [ 4]  235 	ret 
                                    236 
                                    237 ;-----------------------
                                    238 ; tone generator 
                                    239 ; Ft2clk=62500 hertz 
                                    240 ; input:
                                    241 ;   A   duration 16.7*n msec    
                                    242 ;   X   frequency 
                                    243 ;------------------------
                           00F424   244 FR_T3_CLK=62500
      0080BF                        245 tone:
      0080BF 90 89            [ 2]  246 	pushw y 
      0080C1 88               [ 1]  247 	push a 
      0080C2 90 93            [ 1]  248 	ldw y,x 
      0080C4 AE F4 24         [ 2]  249 	ldw x,#FR_T3_CLK 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 39.
Hexadecimal [24-Bits]



      0080C7 65               [ 2]  250 	divw x,y 
      0080C8 9E               [ 1]  251 	ld a,xh 
      0080C9 C7 53 2B         [ 1]  252 	ld TIM3_ARRH,a 
      0080CC 9F               [ 1]  253 	ld a,xl 
      0080CD C7 53 2C         [ 1]  254 	ld TIM3_ARRL,a 
      0080D0 54               [ 2]  255 	srlw x 
      0080D1 9E               [ 1]  256 	ld a,xh 
      0080D2 C7 53 2F         [ 1]  257 	ld TIM3_CCR2H,a 
      0080D5 9F               [ 1]  258 	ld a,xl 
      0080D6 C7 53 30         [ 1]  259 	ld TIM3_CCR2L,a 
      0080D9 72 18 53 27      [ 1]  260 	bset TIM3_CCER1,#TIM3_CCER1_CC2E
      0080DD 72 10 53 20      [ 1]  261 	bset TIM3_CR1,#TIM3_CR1_CEN 
      0080E1 72 10 53 24      [ 1]  262 	bset TIM3_EGR,#TIM3_EGR_UG
      0080E5 84               [ 1]  263 	pop a 
      000066                        264 	_straz sound_timer  
      0080E6 B7 E3                    1     .byte 0xb7,sound_timer 
      0080E8 72 1C 00 EA      [ 1]  265 	bset flags,#F_SOUND_TMR 
      0080EC                        266 1$:  
      0080EC 72 0C 00 EA FB   [ 2]  267 	btjt flags,#F_SOUND_TMR,1$
      0080F1 72 11 53 20      [ 1]  268 	bres TIM3_CR1,#TIM3_CR1_CEN 
      0080F5 72 19 53 27      [ 1]  269 	bres TIM3_CCER1,#TIM3_CCER1_CC2E
      0080F9 90 85            [ 2]  270 	popw y 
      0080FB 81               [ 4]  271 	ret 
                                    272 
                                    273 ;-----------------
                                    274 ; 1Khz beep 
                                    275 ;-----------------
      0080FC                        276 beep:
      0080FC 88               [ 1]  277 	push a 
      0080FD 89               [ 2]  278 	pushw x 
      0080FE AE 03 E8         [ 2]  279 	ldw x,#1000 ; hertz 
      008101 A6 08            [ 1]  280 	ld a,#8
      008103 CD 80 BF         [ 4]  281 	call tone
      008106 85               [ 2]  282 	popw x 
      008107 84               [ 1]  283 	pop a   
      008108 81               [ 4]  284 	ret 
                                    285 
                                    286 	.macro _note  f,d 
                                    287 	.word f 
                                    288 	.byte d 
                                    289 	.endm 
                                    290 ;-----------------------
                                    291 ; play a tune 
                                    292 ; struct {
                                    293 ;	uint16t frequency 
                                    294 ;	utin86  duration 60*n msec 
                                    295 ;} note_t 
                                    296 ; score: note[,note],0 
                                    297 ; input:
                                    298 ;   Y   score_list 
                                    299 ;-----------------------
      008109                        300 tune:
      008109 93               [ 1]  301 	ldw x,y
      00810A FE               [ 2]  302 	ldw x,(x)
      00810B 90 E6 02         [ 1]  303 	ld a,(2,y)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 40.
Hexadecimal [24-Bits]



      00810E 27 15            [ 1]  304 	jreq 9$
      008110 5D               [ 2]  305 	tnzw x 
      008111 26 09            [ 1]  306 	jrne 2$
      008113 CD 80 B3         [ 4]  307 	call pause 
      008116 72 A9 00 03      [ 2]  308 	addw y,#3
      00811A 20 ED            [ 2]  309 	jra tune  
      00811C CD 80 BF         [ 4]  310 2$:	call tone 
      00811F 72 A9 00 03      [ 2]  311 	addw y,#3
      008123 20 E4            [ 2]  312 	jra tune  
      008125                        313 9$:
      008125 81               [ 4]  314 	ret 
                                    315 
                                    316 ;------------------------
                                    317 ; generate white noise 
                                    318 ; input:
                                    319 ;    A  duration 60*A msec.
                                    320 ;-------------------------- 
      008126                        321 noise:
      008126 89               [ 2]  322 	pushw x
      0000A7                        323 	_straz sound_timer 
      008127 B7 E3                    1     .byte 0xb7,sound_timer 
      008129 4B 00            [ 1]  324 	push #0  
      00812B 72 1C 00 EA      [ 1]  325 	bset flags,#F_SOUND_TMR
      00812F CD 82 01         [ 4]  326 1$: call prng
      008132 A6 10            [ 1]  327 	ld a,#16 
      008134 6B 01            [ 1]  328 	ld (1,sp),a  
      008136 58               [ 2]  329 2$:	sllw x 
      008137 90 11 50 0F      [ 1]  330 	bccm SOUND_PORT,#SOUND_BIT
      00813B A6 0A            [ 1]  331 	ld a,#10 
      00813D 4A               [ 1]  332 4$:	dec a 
      00813E 26 FD            [ 1]  333 	jrne 4$
      008140 0A 01            [ 1]  334 	dec (1,sp)
      008142 26 F2            [ 1]  335 	jrne 2$  
      008144 72 0C 00 EA E6   [ 2]  336 	btjt flags,#F_SOUND_TMR,1$
      0000C9                        337 	_drop 1 
      008149 5B 01            [ 2]    1     addw sp,#1 
      00814B 85               [ 2]  338 	popw x 
      00814C 81               [ 4]  339 	ret 
                                    340 
                                    341 ;------------------------
                                    342 ; reading keypad 
                                    343 ; without debouncing 
                                    344 ; output:
                                    345 ;     A   reading 
                                    346 ;-----------------------
      00814D                        347 kpad_input:
      00814D C6 50 06         [ 1]  348 	ld a,KPAD_IDR 
      008150 A4 3F            [ 1]  349 	and a,#BTN_MASK 
      008152 A8 3F            [ 1]  350 	xor a,#BTN_MASK  
      008154 81               [ 4]  351 	ret 
                                    352 
                                    353 
                                    354 ;-------------------------
                                    355 ; read keypad
                                    356 ; ouput:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 41.
Hexadecimal [24-Bits]



                                    357 ;    A 
                                    358 ;       BTN_A -> bit 0 (1)
                                    359 ;       BTN_B -> bit 3 (8)
                                    360 ;       BTN_LEFT -> bit 4 (16)
                                    361 ;       BTN_RIGHT -> bit 5 (32)
                                    362 ;       BTN_DOWN -> bit 6 (64)
                                    363 ;       BNT_UP -> bit 7  (128)
                                    364 ;    Z   set no key 
                                    365 ;-------------------------
                           000001   366 	DEBOUNCE=1
                           000003   367 	BUTTONS=DEBOUNCE+2
                           000003   368 	VAR_SIZE=BUTTONS 
      008155                        369 read_keypad:
      008155 89               [ 2]  370 	pushw x 
      0000D6                        371 	_vars VAR_SIZE
      008156 52 03            [ 2]    1     sub sp,#VAR_SIZE 
      008158 CD 81 4D         [ 4]  372 	call kpad_input 
      00815B 6B 03            [ 1]  373 1$:	ld (BUTTONS,sp),a  
      00815D CE 00 E0         [ 2]  374     ldw x,ticks 
      008160 1C 00 01         [ 2]  375 	addw x,#1
      008163 1F 01            [ 2]  376 	ldw (DEBOUNCE,sp),x 	
      008165 CD 81 4D         [ 4]  377 2$: call kpad_input 
      008168 11 03            [ 1]  378 	cp a,(BUTTONS,sp)
      00816A 26 EF            [ 1]  379 	jrne 1$
      00816C CE 00 E0         [ 2]  380 	ldw x,ticks 
      00816F 13 01            [ 2]  381 	cpw x,(DEBOUNCE,sp)
      008171 26 F2            [ 1]  382 	jrne 2$
      0000F3                        383 	_drop VAR_SIZE  
      008173 5B 03            [ 2]    1     addw sp,#VAR_SIZE 
      008175 85               [ 2]  384 	popw x
      008176 4D               [ 1]  385 	tnz a 
      008177 81               [ 4]  386 	ret 
                                    387 
                                    388 ;----------------------------
                                    389 ; wait until key pressed 
                                    390 ; output:
                                    391 ;    A    key
                                    392 ;----------------------------
      008178                        393 wait_key:
      008178 CD 81 55         [ 4]  394 	call read_keypad 
      00817B 27 FB            [ 1]  395 	jreq wait_key
      00817D 81               [ 4]  396 	ret 
                                    397 
                                    398 ;--------------------------
                                    399 ; wait for buttons released 
                                    400 ; but no more than 100msec
                                    401 ; input:
                                    402 ;    X   maximum delay, A/60 sec 
                                    403 ;--------------------------
                           000001   404     DLY=1
                           000002   405     VAR_SIZE=2
      00817E                        406 wait_key_release:
      0000FE                        407     _vars VAR_SIZE
      00817E 52 02            [ 2]    1     sub sp,#VAR_SIZE 
      008180 72 BB 00 E0      [ 2]  408     addw x,ticks
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 42.
Hexadecimal [24-Bits]



      008184 1F 01            [ 2]  409 	ldw (DLY,sp),x 
      008186                        410 1$: 
      008186 CE 00 E0         [ 2]  411     ldw x,ticks 
      008189 13 01            [ 2]  412     cpw x,(DLY,sp)
      00818B 2A 05            [ 1]  413     jrpl 9$     
      00818D CD 81 4D         [ 4]  414     call kpad_input
      008190 26 F4            [ 1]  415     jrne 1$ 
      008192                        416 9$:
      000112                        417     _drop VAR_SIZE 
      008192 5B 02            [ 2]    1     addw sp,#VAR_SIZE 
      008194 81               [ 4]  418     ret 
                                    419 
                                    420 ;-------------------------------------
                                    421 ;  initialization entry point 
                                    422 ;-------------------------------------
      008195                        423 cold_start:
                                    424 ;set stack 
      008195 9B               [ 1]  425 	sim
      008196 AE 17 FF         [ 2]  426 	ldw x,#STACK_EMPTY
      008199 94               [ 1]  427 	ldw sp,x
                                    428 ; clear all ram 
      00819A 7F               [ 1]  429 0$: clr (x)
      00819B 5A               [ 2]  430 	decw x 
      00819C 26 FC            [ 1]  431 	jrne 0$
                                    432 ; disable all peripherals clock 
      00819E 72 5F 50 C7      [ 1]  433 	clr CLK_PCKENR1 
      0081A2 72 5F 50 CA      [ 1]  434 	clr CLK_PCKENR2 
                                    435 ; activate pull up on all inputs 
                                    436 ; or push pull on output 
      0081A6 A6 FF            [ 1]  437 	ld a,#255 
      0081A8 C7 50 03         [ 1]  438 	ld PA_CR1,a 
      0081AB C7 50 08         [ 1]  439 	ld PB_CR1,a 
      0081AE C7 50 0D         [ 1]  440 	ld PC_CR1,a 
      0081B1 C7 50 12         [ 1]  441 	ld PD_CR1,a
      0081B4 C7 50 17         [ 1]  442 	ld PE_CR1,a 
      0081B7 C7 50 1C         [ 1]  443 	ld PF_CR1,a 
      0081BA C7 50 21         [ 1]  444 	ld PG_CR1,a 
      0081BD C7 50 26         [ 1]  445 	ld PH_CR1,a 
      0081C0 C7 50 2B         [ 1]  446 	ld PI_CR1,a 
      0081C3 CD 80 84         [ 4]  447 	call clock_init	
      0081C6 CD 80 9A         [ 4]  448 	call timer3_init
                           000000   449 .if DEBUG 
                                    450 .if NUCLEO
                                    451 	call uart_init
                                    452 	call uart_cls 
                                    453 .endif ;; NUCLEO  
                                    454 .endif ;; DEBUG 
      0081C9 CD 85 75         [ 4]  455 	call ntsc_init ;
      0081CC 9A               [ 1]  456 	rim ; enable interrupts 
      0081CD 5F               [ 1]  457 	clrw x 
      0081CE CD 82 23         [ 4]  458 	call set_seed
      0081D1                        459 4$:
      0081D1 CC 8B 1B         [ 2]  460 	jp main ; in tv_term.asm 
                                    461 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 43.
Hexadecimal [24-Bits]



                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2023,2024  
                                      3 ; This file is part of stm8-gamepad
                                      4 ;
                                      5 ;     stm8-gamepadis free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     stm8-gamepadis distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with ntsc_tuto.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                                     19     .area CODE 
                                     20 
                           000001    21 .if NUCLEO 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 44.
Hexadecimal [24-Bits]



                                     22     .include "inc/nucleo_8s207.inc" 
                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2019 
                                      3 ; This file is part of MONA 
                                      4 ;
                                      5 ;     MONA is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     MONA is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with MONA.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                     19 ; NUCLEO-8S208RB board specific definitions
                                     20 ; Date: 2019/10/29
                                     21 ; author: Jacques Deschênes, copyright 2018,2019
                                     22 ; licence: GPLv3
                                     23 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                     24 
                                     25 ; mcu on board is stm8s207k8
                                     26 
                                     27 ; crystal on board is 8Mhz
                                     28 ; st-link crystal 
                           7A1200    29 FHSE = 8000000
                                     30 
                                     31 ; LD3 is user LED
                                     32 ; connected to PC5 via Q2
                           00500A    33 LED_PORT = PC_BASE ;port C
                           000005    34 LED_BIT = 5
                           000020    35 LED_MASK = (1<<LED_BIT) ;bit 5 mask
                                     36 
                                     37 ; external options switches 
                                     38 
                                     39 ; select local  echo option 
                                     40 ; 0 no echo | 1 local echo 
                           005010    41 OPT_ECHO_PORT=PD_IDR 
                           000000    42 OPT_ECHO_BIT=0 
                                     43 
                                     44 ; select UART BAUD RATE 
                           005010    45 OPT_BR0_PORT=PD_IDR 
                           000002    46 OPT_BR0_BIT=2 
                           00500B    47 OPT_BR1_PORT=PC_IDR 
                           000002    48 OPT_BR1_BIT=2
                                     49 
                                     50 
                                     51 ; user interface UART via STLINK (T_VCP)
                                     52 
                           000002    53 UART=UART3 
                                     54 ; port used by  UART3 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 45.
Hexadecimal [24-Bits]



                           00500A    55 UART_PORT_ODR=PC_ODR 
                           00500C    56 UART_PORT_DDR=PC_DDR 
                           00500B    57 UART_PORT_IDR=PC_IDR 
                           00500D    58 UART_PORT_CR1=PC_CR1 
                           00500E    59 UART_PORT_CR2=PC_CR2 
                                     60 
                                     61 ; clock enable bit 
                           000003    62 UART_PCKEN=CLK_PCKENR1_UART3 
                                     63 
                                     64 ; uart3 registers 
                           005240    65 UART_SR=UART3_SR
                           005241    66 UART_DR=UART3_DR
                           005242    67 UART_BRR1=UART3_BRR1
                           005243    68 UART_BRR2=UART3_BRR2
                           005244    69 UART_CR1=UART3_CR1
                           005245    70 UART_CR2=UART3_CR2
                                     71 
                                     72 ; TX, RX pin
                           000005    73 UART_TX_PIN=UART3_TX_PIN 
                           000006    74 UART_RX_PIN=UART3_RX_PIN 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 46.
Hexadecimal [24-Bits]



                                     23     .include "uart.asm"
                                      1 ;
                                      2 ; Copyright Jacques Deschênes 2023 
                                      3 ; This file is part of stm8_terminal 
                                      4 ;
                                      5 ;     stm8_terminal is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     stm8_terminal is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with stm8_terminal.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                                     19 
                           000000    20 .if DEBUG 
                                     21 .if NUCLEO 
                                     22 ;-------------------------------
                                     23 	.area CODE 
                                     24 
                                     25 ;--------------------------
                                     26 ; UART receive character
                                     27 ; in a FIFO buffer 
                                     28 ; CTRL+C (ASCII 3)
                                     29 ; cancel program execution
                                     30 ; and fall back to command line
                                     31 ; CTRL+X reboot system 
                                     32 ;--------------------------
                                     33 UartRxHandler: ; console receive char 
                                     34 	btjf UART_SR,#UART_SR_RXNE,5$ 
                                     35 	ld a,UART_DR 
                                     36 	cp a,#CAN ; CTRL_X 
                                     37 	jrne 1$
                                     38 	_swreset 	
                                     39 1$:
                                     40 	push a 
                                     41 	ld a,#rx1_queue 
                                     42 	add a,rx1_tail 
                                     43 	clrw x 
                                     44 	ld xl,a 
                                     45 	pop a 
                                     46 	ld (x),a 
                                     47 	ld a,rx1_tail 
                                     48 	inc a 
                                     49 	and a,#RX_QUEUE_SIZE-1
                                     50 	ld rx1_tail,a 
                                     51 5$:	iret 
                                     52 
                                     53 ; values for 16Mhz Fmaster 
                                     54 B115200=0x8B   
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 47.
Hexadecimal [24-Bits]



                                     55 
                                     56 ;---------------------------------------------
                                     57 ; initialize UART, read external swtiches SW4,SW5 
                                     58 ; to determine required BAUD rate.
                                     59 ; called from cold_start in hardware_init.asm 
                                     60 ; input:
                                     61 ;	none      
                                     62 ; output:
                                     63 ;   none
                                     64 ;---------------------------------------------
                                     65 uart_init:
                                     66 ; enable UART clock
                                     67 	bset CLK_PCKENR1,#UART_PCKEN 	
                                     68 	bres UART,#UART_CR1_PIEN
                                     69 ; read external swtiches baud rate option.  
                                     70 	clr a 
                                     71 	rcf 
                                     72 	btjf OPT_BR1_PORT,#OPT_BR1_BIT, 2$ 
                                     73 	scf 
                                     74 2$:	rlc a 
                                     75     rcf 
                                     76 	btjf OPT_BR0_PORT,#OPT_BR0_BIT,3$ 
                                     77 	scf 
                                     78 3$: rlc a 
                                     79 ;  BRR value for 115200 BAUD  
                                     80 	ldw x,#B115200
                                     81 ; a little complicated because 
                                     82 ; BRR1= bits (bits 4:11) >> 4
                                     83 ; BRR2= bits  0:3 || (bits 12:15)>>8 
                                     84 ; why do simple when you can do it complicated?  
                                     85 	ld a,#(B115200&0xf)+((B115200>>8)&0XF0)
                                     86 	ld UART_BRR2,a  
                                     87 	ld a,#(B115200>>4)&0XFF 
                                     88 	ld UART_BRR1,a
                                     89     clr UART_DR
                                     90 	mov UART_CR2,#((1<<UART_CR2_TEN)|(1<<UART_CR2_REN)|(1<<UART_CR2_RIEN));
                                     91 	bset UART_CR2,#UART_CR2_SBK
                                     92     btjf UART_SR,#UART_SR_TC,.
                                     93     clr rx1_head 
                                     94 	clr rx1_tail
                                     95 	bset UART,#UART_CR1_PIEN
                                     96 	ret
                                     97 
                                     98 
                                     99 ;---------------------------------
                                    100 ; uart_putc
                                    101 ; send a character via UART
                                    102 ; input:
                                    103 ;    A  	character to send
                                    104 ;---------------------------------
                                    105 uart_putc:: 
                                    106 	btjf UART_SR,#UART_SR_TXE,.
                                    107 	ld UART_DR,a 
                                    108 	ret 
                                    109 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 48.
Hexadecimal [24-Bits]



                                    110 ;-------------------------
                                    111 ; delete character left 
                                    112 ;-------------------------
                                    113 uart_delback:
                                    114 	ld a,#BS 
                                    115 	call uart_putc  
                                    116 	ld a,#SPACE 
                                    117 	call uart_putc 
                                    118 	ld a,#BS 
                                    119 	call uart_putc 
                                    120 	ret 
                                    121 
                                    122 ;------------------------
                                    123 ; clear VT10x terminal 
                                    124 ; screeen 
                                    125 ;------------------------
                                    126 uart_cls:
                                    127 	push a 
                                    128 	ld a,#ESC 
                                    129 	call uart_putc 
                                    130 	ld a,#'c 
                                    131 	call uart_putc 
                                    132 	pop a 
                                    133 	ret 
                                    134 
                                    135 ;--------------------
                                    136 ; send blank character 
                                    137 ; to UART 
                                    138 ;---------------------
                                    139 uart_space:
                                    140 	ld a,#SPACE 
                                    141 	call uart_putc 
                                    142 	ret 
                                    143 
                                    144 ;---------------------------------
                                    145 ; Query for character in rx1_queue
                                    146 ; input:
                                    147 ;   none 
                                    148 ; output:
                                    149 ;   A     0 no charcter available
                                    150 ;   Z     1 no character available
                                    151 ;---------------------------------
                                    152 qgetc::
                                    153 uart_qgetc::
                                    154 	_ldaz rx1_head 
                                    155 	cp a,rx1_tail 
                                    156 	ret 
                                    157 
                                    158 ;---------------------------------
                                    159 ; wait character from UART 
                                    160 ; input:
                                    161 ;   none
                                    162 ; output:
                                    163 ;   A 			char  
                                    164 ;--------------------------------	
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 49.
Hexadecimal [24-Bits]



                                    165 getc:: ;console input
                                    166 uart_getc::
                                    167 	call uart_qgetc
                                    168 	jreq uart_getc 
                                    169 	pushw x 
                                    170 ;; rx1_queue must be in page 0 	
                                    171 	ld a,#rx1_queue
                                    172 	add a,rx1_head 
                                    173 	clrw x  
                                    174 	ld xl,a 
                                    175 	ld a,(x)
                                    176 	push a
                                    177 	_ldaz rx1_head 
                                    178 	inc a 
                                    179 	and a,#RX_QUEUE_SIZE-1
                                    180 	_straz rx1_head 
                                    181 	pop a  
                                    182 	popw x
                                    183 	ret 
                                    184 
                                    185 
                                    186 ;--------------------------
                                    187 ; manange control character 
                                    188 ; before calling uart_putc 
                                    189 ; input:
                                    190 ;    A    character 
                                    191 ;---------------------------
                                    192 uart_print_char:
                                    193 	cp a,#BS 
                                    194 	jrne 1$
                                    195 	call uart_delback 
                                    196 	jra 9$ 
                                    197 1$:
                                    198 	call uart_putc
                                    199 9$:
                                    200 	ret 
                                    201 
                                    202 
                                    203 ;------------------------------
                                    204 ;  send string to uart 
                                    205 ; input:
                                    206 ;    X    *string 
                                    207 ; output:
                                    208 ;    X    *after string 
                                    209 ;------------------------------
                                    210 uart_puts:
                                    211 	push a 
                                    212 1$: ld a,(x)
                                    213 	jreq 9$ 
                                    214 	call uart_print_char  
                                    215 	incw x 
                                    216 	jra 1$ 
                                    217 9$: incw x 
                                    218 	pop a 
                                    219 	ret 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 50.
Hexadecimal [24-Bits]



                                    220 
                                    221 ;-------------------------------
                                    222 ; print integer in hexadicimal
                                    223 ; input:
                                    224 ;    X 
                                    225 ;------------------------------- 
                                    226 uart_print_hex:
                                    227 	pushw x 
                                    228 	push a 
                                    229 	ld a,xh 
                                    230 	call uart_print_hex_byte 
                                    231 	ld a,xl 
                                    232 	call uart_print_hex_byte 
                                    233 	ld a,#SPACE 
                                    234 	call uart_putc 
                                    235 	pop a 
                                    236 	popw x 
                                    237 	ret 
                                    238 
                                    239 ;----------------------
                                    240 ; print hexadecimal byte 
                                    241 ; input:
                                    242 ;    A    byte to print 
                                    243 ;-----------------------
                                    244 uart_print_hex_byte:
                                    245 	push a 
                                    246 	swap a 
                                    247 	call hex_digit 
                                    248 	call uart_putc 
                                    249 	pop a 
                                    250 	call hex_digit 
                                    251 	call uart_putc 
                                    252 	ret 
                                    253 
                                    254 ;---------------------------
                                    255 ; convert to hexadecimal digit 
                                    256 ; input:
                                    257 ;    A    value to convert 
                                    258 ; output:
                                    259 ;    A    hex digit character 
                                    260 ;-----------------------------
                                    261 hex_digit:
                                    262 	and a,#15 
                                    263 	add a,#'0 
                                    264 	cp a,#'9+1 
                                    265 	jrmi 9$ 
                                    266 	add a,#7 
                                    267 9$: ret 
                                    268 .endif ;; NUCLEO 
                                    269 .endif ;; DEBUG  
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 51.
Hexadecimal [24-Bits]



                                     24 
                                     25 ;-----------------------
                                     26 ; print value in 
                                     27 ; acc16 in hexadecimal
                                     28 ; on terminal 
                                     29 ;----------------------
      0081D4                         30 dbg_print:
                           000000    31 .if DEBUG 
                                     32     pushw x 
                                     33     ldw x,acc16 
                                     34     call uart_print_hex
                                     35     popw x
                                     36 .endif ;; DEBUG      
      0081D4 81               [ 4]   37     ret 
                                     38 
                                     39 ;-----------------------
                                     40 ; print value in A 
                                     41 ; in hexadecimal on 
                                     42 ; terminal 
                                     43 ;-----------------------
      0081D5                         44 dbg_print_hex:
                           000000    45 .if DEBUG 
                                     46     push a 
                                     47     call uart_print_hex_byte
                                     48     ld a,#SPACE 
                                     49     call uart_putc 
                                     50     pop a 
                                     51 .endif ;; DEBUG 
      0081D5 81               [ 4]   52     ret 
                                     53 
                                     54 ;-------------------------
                                     55 ; send CRLF to terminal 
                                     56 ;-------------------------
      0081D6                         57 dbg_nl:
                           000000    58 .if DEBUG 
                                     59     push a 
                                     60     ld a,#CR 
                                     61     call uart_putc
                                     62     pop a  
                                     63 .endif ;; DEBUG 
      0081D6 81               [ 4]   64     ret 
                                     65 
                           000000    66  .else 
                                     67 ;---------------------
                                     68 ; print value in acc16 
                                     69 ; at coords Y,X={0,26}
                                     70 ; wait key to continue 
                                     71 ;---------------------
                                     72     CURPOS=1 
                                     73     VAR_SIZE=2
                                     74 dbg_print:
                                     75 .if DEBUG 
                                     76 	push a 
                                     77     pushw x 
                                     78     _vars VAR_SIZE 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 52.
Hexadecimal [24-Bits]



                                     79     _ldxz cy 
                                     80     ldw (CURPOS,sp),x 
                                     81     ldw x,#26
                                     82     _strxz cy 
                                     83     _ldxz acc16 
                                     84     call put_uint16
                                     85 	ld a,#SPACE 
                                     86 	call tv_putc
                                     87     ldw x,(CURPOS,sp)
                                     88     _strxz cy 
                                     89 	call wait_key 
                                     90 	ldw x,#60
                                     91 	call wait_key_release 
                                     92     _drop VAR_SIZE 
                                     93     popw x
                                     94 	pop a 
                                     95 .endif ;; DEBUG 
                                     96     ret 
                                     97 
                                     98 ;-----------------------
                                     99 ; print A in hexadecimal
                                    100 ;-----------------------
                                    101 dbg_print_hex:
                                    102 .if DEBUG 
                                    103 	_clrz cy 
                                    104 	mov cx,#26
                                    105 	push a 
                                    106 	swap a 
                                    107 	call hex_digit 
                                    108 	pop a 
                                    109 hex_digit:
                                    110 	and a,#15
                                    111 	add a,#'0 
                                    112 	cp a,#'9+1
                                    113 	jrmi 1$
                                    114 	add a,#7 
                                    115 1$: call tv_putc
                                    116 .endif  ;; DEBUG 
                                    117 	ret 
                                    118 
                                    119 .endif ;; NUCLEO 
                                    120 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 53.
Hexadecimal [24-Bits]



                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2023  
                                      3 ; This file is part of xor_prng 
                                      4 ;
                                      5 ;     xor_prng is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     xor_prng is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with xor_prng.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                                     19 
                                     20 ;---------------------------------
                                     21 ; Pseudo Random Number Generator 
                                     22 ; XORShift algorithm.
                                     23 ; 32 bits seed.
                                     24 ;---------------------------------
                                     25 
                                     26 ;---------------------------------
                                     27 ;  seedx:seedy= x:y ^ seedx:seedy
                                     28 ; output:
                                     29 ;  X:Y   seedx:seedy new value   
                                     30 ;---------------------------------
      0081D7                         31 xor_seed32:
      0081D7 9E               [ 1]   32     ld a,xh 
      000158                         33     _xorz seedx 
      0081D8 B8 EB                    1     .byte 0xb8,seedx 
      00015A                         34     _straz seedx
      0081DA B7 EB                    1     .byte 0xb7,seedx 
      0081DC 9F               [ 1]   35     ld a,xl 
      00015D                         36     _xorz seedx+1 
      0081DD B8 EC                    1     .byte 0xb8,seedx+1 
      00015F                         37     _straz seedx+1 
      0081DF B7 EC                    1     .byte 0xb7,seedx+1 
      0081E1 90 9E            [ 1]   38     ld a,yh 
      000163                         39     _xorz seedy
      0081E3 B8 ED                    1     .byte 0xb8,seedy 
      000165                         40     _straz seedy 
      0081E5 B7 ED                    1     .byte 0xb7,seedy 
      0081E7 90 9F            [ 1]   41     ld a,yl 
      000169                         42     _xorz seedy+1 
      0081E9 B8 EE                    1     .byte 0xb8,seedy+1 
      00016B                         43     _straz seedy+1 
      0081EB B7 EE                    1     .byte 0xb7,seedy+1 
      00016D                         44     _ldxz seedx  
      0081ED BE EB                    1     .byte 0xbe,seedx 
      00016F                         45     _ldyz seedy 
      0081EF 90 BE ED                 1     .byte 0x90,0xbe,seedy 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 54.
Hexadecimal [24-Bits]



      0081F2 81               [ 4]   46     ret 
                                     47 
                                     48 ;-----------------------------------
                                     49 ;   x:y= x:y << a 
                                     50 ;  input:
                                     51 ;    A     shift count 
                                     52 ;    X:Y   uint32 value 
                                     53 ;  output:
                                     54 ;    X:Y   uint32 shifted value   
                                     55 ;-----------------------------------
      0081F3                         56 sll_xy_32: 
      0081F3 90 58            [ 2]   57     sllw y 
      0081F5 59               [ 2]   58     rlcw x
      0081F6 4A               [ 1]   59     dec a 
      0081F7 26 FA            [ 1]   60     jrne sll_xy_32 
      0081F9 81               [ 4]   61     ret 
                                     62 
                                     63 ;-----------------------------------
                                     64 ;   x:y= x:y >> a 
                                     65 ;  input:
                                     66 ;    A     shift count 
                                     67 ;    X:Y   uint32 value 
                                     68 ;  output:
                                     69 ;    X:Y   uint32 shifted value   
                                     70 ;-----------------------------------
      0081FA                         71 srl_xy_32: 
      0081FA 54               [ 2]   72     srlw x 
      0081FB 90 56            [ 2]   73     rrcw y 
      0081FD 4A               [ 1]   74     dec a 
      0081FE 26 FA            [ 1]   75     jrne srl_xy_32 
      008200 81               [ 4]   76     ret 
                                     77 
                                     78 ;-------------------------------------
                                     79 ;  PRNG generator proper 
                                     80 ; input:
                                     81 ;   none 
                                     82 ; ouput:
                                     83 ;   X     bits 31...16  PRNG seed  
                                     84 ;  use: 
                                     85 ;   seedx:seedy   system variables   
                                     86 ;--------------------------------------
      008201                         87 prng::
      008201 90 89            [ 2]   88 	pushw y   
      000183                         89     _ldxz seedx
      008203 BE EB                    1     .byte 0xbe,seedx 
      000185                         90 	_ldyz seedy  
      008205 90 BE ED                 1     .byte 0x90,0xbe,seedy 
      008208 A6 0D            [ 1]   91 	ld a,#13
      00820A CD 81 F3         [ 4]   92     call sll_xy_32 
      00820D CD 81 D7         [ 4]   93     call xor_seed32
      008210 A6 11            [ 1]   94     ld a,#17 
      008212 CD 81 FA         [ 4]   95     call srl_xy_32
      008215 CD 81 D7         [ 4]   96     call xor_seed32 
      008218 A6 05            [ 1]   97     ld a,#5 
      00821A CD 81 F3         [ 4]   98     call sll_xy_32
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 55.
Hexadecimal [24-Bits]



      00821D CD 81 D7         [ 4]   99     call xor_seed32
      008220 90 85            [ 2]  100     popw y 
      008222 81               [ 4]  101     ret 
                                    102 
                                    103 
                                    104 ;---------------------------------
                                    105 ; initialize seedx:seedy 
                                    106 ; input:
                                    107 ;    X    0 -> seedx=ticks, seedy=[0x6000] 
                                    108 ;    X    !0 -> seedx=X, y=[0x6000], seedy=swapw(y)
                                    109 ;-------------------------------------------
      008223                        110 set_seed:
      008223 5D               [ 2]  111     tnzw x 
      008224 26 0B            [ 1]  112     jrne 1$ 
      008226 CE 00 E0         [ 2]  113     ldw x,ticks 
      0001A9                        114     _strxz seedx
      008229 BF EB                    1     .byte 0xbf,seedx 
      00822B AE 60 00         [ 2]  115     ldw x,#0x6000  
      0001AE                        116     _strxz seedy  
      00822E BF ED                    1     .byte 0xbf,seedy 
      008230 81               [ 4]  117     ret 
      008231                        118 1$:  
      0001B1                        119     _strxz seedx
      008231 BF EB                    1     .byte 0xbf,seedx 
      008233 90 CE 60 00      [ 2]  120     ldw y,0x6000
      008237 90 5E            [ 1]  121     swapw y 
      0001B9                        122     _stryz seedy 
      008239 90 BF ED                 1     .byte 0x90,0xbf,seedy 
      00823C 81               [ 4]  123     ret 
                                    124 
                                    125 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 56.
Hexadecimal [24-Bits]



                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2023,2024  
                                      3 ; This file is part of stm8-gamepad
                                      4 ;
                                      5 ;     stm8-gamepadis free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     stm8-gamepadis distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with ntsc_tuto.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                                     19     .area CODE
                                     20 
                           000008    21 FONT_HEIGHT=8
                           000006    22 FONT_WIDTH=6
      00823D                         23 font_6x8: 
      00823D 00 00 00 00 00 00 00    24 .byte 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00  ; space ASCII 32
             00
      008245 20 20 20 20 20 00 20    25 .byte 0x20,0x20,0x20,0x20,0x20,0x00,0x20,0x00  ; !
             00
      00824D 50 50 50 00 00 00 00    26 .byte 0x50,0x50,0x50,0x00,0x00,0x00,0x00,0x00  ; "
             00
      008255 50 50 F8 50 F8 50 50    27 .byte 0x50,0x50,0xF8,0x50,0xF8,0x50,0x50,0x00  ; #
             00
      00825D 20 78 A0 70 28 F0 20    28 .byte 0x20,0x78,0xA0,0x70,0x28,0xF0,0x20,0x00  ; $
             00
      008265 C0 C8 10 20 40 98 18    29 .byte 0xC0,0xC8,0x10,0x20,0x40,0x98,0x18,0x00  ; %
             00
      00826D 60 90 A0 40 A8 90 68    30 .byte 0x60,0X90,0xA0,0x40,0xA8,0x90,0x68,0x00  ; &
             00
      008275 60 20 40 00 00 00 00    31 .byte 0x60,0x20,0x40,0x00,0x00,0x00,0x00,0x00  ; '
             00
      00827D 10 20 40 40 40 20 10    32 .byte 0x10,0x20,0x40,0x40,0x40,0x20,0x10,0x00  ; (
             00
      008285 40 20 10 10 10 20 40    33 .byte 0x40,0x20,0x10,0x10,0x10,0x20,0x40,0x00  ; )
             00
      00828D 00 20 A8 70 A8 20 00    34 .byte 0x00,0x20,0xA8,0x70,0xA8,0x20,0x00,0x00  ; *
             00
      008295 00 20 20 F8 20 20 00    35 .byte 0x00,0x20,0x20,0xF8,0x20,0x20,0x00,0x00  ; +
             00
      00829D 00 00 00 70 70 30 60    36 .byte 0x00,0x00,0x00,0x70,0x70,0x30,0x60,0x40  ; ,
             40
      0082A5 00 00 00 F0 00 00 00    37 .byte 0x00,0x00,0x00,0xF0,0x00,0x00,0x00,0x00  ; -
             00
      0082AD 00 00 00 00 00 60 60    38 .byte 0x00,0x00,0x00,0x00,0x00,0x60,0x60,0x00  ; .
             00
      0082B5 00 06 0C 18 30 60 00    39 .byte 0x00,0x06,0x0c,0x18,0x30,0x60,0x00,0x00  ; /
             00
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 57.
Hexadecimal [24-Bits]



      0082BD 70 88 98 A8 C8 88 70    40 .byte 0x70,0x88,0x98,0xA8,0xC8,0x88,0x70,0x00  ; 0
             00
      0082C5 20 60 20 20 20 20 F8    41 .byte 0x20,0x60,0x20,0x20,0x20,0x20,0xF8,0x00  ; 1
             00
      0082CD 70 88 10 20 40 80 F8    42 .byte 0x70,0x88,0x10,0x20,0x40,0x80,0xF8,0x00  ; 2
             00
      0082D5 F0 08 08 F0 08 08 F0    43 .byte 0xF0,0x08,0x08,0xF0,0x08,0x08,0xF0,0x00  ; 3
             00
      0082DD 10 30 50 90 F8 10 10    44 .byte 0x10,0x30,0x50,0x90,0xF8,0x10,0x10,0x00  ; 4
             00
      0082E5 F8 80 80 F0 08 08 F0    45 .byte 0xF8,0x80,0x80,0xF0,0x08,0x08,0xF0,0x00  ; 5
             00
      0082ED 30 40 80 F0 88 88 70    46 .byte 0x30,0x40,0x80,0xF0,0x88,0x88,0x70,0x00  ; 6
             00
      0082F5 F8 08 10 20 40 40 40    47 .byte 0xF8,0x08,0x10,0x20,0x40,0x40,0x40,0x00  ; 7
             00
      0082FD 70 88 88 70 88 88 70    48 .byte 0x70,0x88,0x88,0x70,0x88,0x88,0x70,0x00  ; 8
             00
      008305 70 88 88 70 08 08 70    49 .byte 0x70,0x88,0x88,0x70,0x08,0x08,0x70,0x00  ; 9
             00
      00830D 00 60 60 00 60 60 00    50 .byte 0x00,0x60,0x60,0x00,0x60,0x60,0x00,0x00  ; :
             00
      008315 00 60 60 00 60 60 20    51 .byte 0x00,0x60,0x60,0x00,0x60,0x60,0x20,0x40  ; ;
             40
      00831D 10 20 40 80 40 20 10    52 .byte 0x10,0x20,0x40,0x80,0x40,0x20,0x10,0x00  ; <
             00
      008325 00 00 F8 00 F8 00 00    53 .byte 0x00,0x00,0xF8,0x00,0xF8,0x00,0x00,0x00  ; =
             00
      00832D 40 20 10 08 10 20 40    54 .byte 0x40,0x20,0x10,0x08,0x10,0x20,0x40,0x00  ; >
             00
      008335 70 88 08 10 20 00 20    55 .byte 0x70,0x88,0x08,0x10,0x20,0x00,0x20,0x00  ; ?
             00
      00833D 70 88 08 68 A8 A8 70    56 .byte 0x70,0x88,0x08,0x68,0xA8,0xA8,0x70,0x00  ; @
             00
      008345 70 88 88 F8 88 88 88    57 .byte 0x70,0x88,0x88,0xF8,0x88,0x88,0x88,0x00  ; A
             00
      00834D F0 88 88 F0 88 88 F0    58 .byte 0xF0,0x88,0x88,0xF0,0x88,0x88,0xF0,0x00  ; B
             00
      008355 78 80 80 80 80 80 78    59 .byte 0x78,0x80,0x80,0x80,0x80,0x80,0x78,0x00  ; C
             00
      00835D F0 88 88 88 88 88 F0    60 .byte 0xF0,0x88,0x88,0x88,0x88,0x88,0xF0,0x00  ; D
             00
      008365 F8 80 80 F8 80 80 F8    61 .byte 0xF8,0x80,0x80,0xF8,0x80,0x80,0xF8,0x00  ; E
             00
      00836D F8 80 80 F8 80 80 80    62 .byte 0xF8,0x80,0x80,0xF8,0x80,0x80,0x80,0x00  ; F
             00
      008375 78 80 80 B0 88 88 70    63 .byte 0x78,0x80,0x80,0xB0,0x88,0x88,0x70,0x00  ; G
             00
      00837D 88 88 88 F8 88 88 88    64 .byte 0x88,0x88,0x88,0xF8,0x88,0x88,0x88,0x00  ; H
             00
      008385 70 20 20 20 20 20 70    65 .byte 0x70,0x20,0x20,0x20,0x20,0x20,0x70,0x00  ; I
             00
      00838D 78 08 08 08 08 90 60    66 .byte 0x78,0x08,0x08,0x08,0x08,0x90,0x60,0x00  ; J
             00
      008395 88 90 A0 C0 A0 90 88    67 .byte 0x88,0x90,0xA0,0xC0,0xA0,0x90,0x88,0x00  ; K
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 58.
Hexadecimal  00-Bits]



             00
      00839D 80 80 80 80 80 80 F8    68 .byte 0x80,0x80,0x80,0x80,0x80,0x80,0xF8,0x00  ; L
             00
      0083A5 88 D8 A8 88 88 88 88    69 .byte 0x88,0xD8,0xA8,0x88,0x88,0x88,0x88,0x00  ; M
             00
      0083AD 88 88 C8 A8 98 88 88    70 .byte 0x88,0x88,0xC8,0xA8,0x98,0x88,0x88,0x00  ; N
             00
      0083B5 70 88 88 88 88 88 70    71 .byte 0x70,0x88,0x88,0x88,0x88,0x88,0x70,0x00  ; O
             00
      0083BD F0 88 88 F0 80 80 80    72 .byte 0xF0,0x88,0x88,0xF0,0x80,0x80,0x80,0x00  ; P
             00
      0083C5 70 88 88 88 A8 90 68    73 .byte 0x70,0x88,0x88,0x88,0xA8,0x90,0x68,0x00  ; Q
             00
      0083CD F0 88 88 F0 A0 90 88    74 .byte 0xF0,0x88,0x88,0xF0,0xA0,0x90,0x88,0x00  ; R
             00
      0083D5 78 80 80 70 08 08 F0    75 .byte 0x78,0x80,0x80,0x70,0x08,0x08,0xF0,0x00  ; S
             00
      0083DD F8 20 20 20 20 20 20    76 .byte 0xF8,0x20,0x20,0x20,0x20,0x20,0x20,0x00  ; T
             00
      0083E5 88 88 88 88 88 88 70    77 .byte 0x88,0x88,0x88,0x88,0x88,0x88,0x70,0x00  ; U
             00
      0083ED 88 88 88 88 88 50 20    78 .byte 0x88,0x88,0x88,0x88,0x88,0x50,0x20,0x00  ; V
             00
      0083F5 88 88 88 A8 A8 D8 88    79 .byte 0x88,0x88,0x88,0xA8,0xA8,0xD8,0x88,0x00  ; W
             00
      0083FD 88 88 50 20 50 88 88    80 .byte 0x88,0x88,0x50,0x20,0x50,0x88,0x88,0x00  ; X
             00
      008405 88 88 88 50 20 20 20    81 .byte 0x88,0x88,0x88,0x50,0x20,0x20,0x20,0x00  ; Y
             00
      00840D F8 10 20 40 80 80 F8    82 .byte 0xF8,0x10,0x20,0x40,0x80,0x80,0xF8,0x00  ; Z
             00
      008415 60 40 40 40 40 40 60    83 .byte 0x60,0x40,0x40,0x40,0x40,0x40,0x60,0x00  ; [
             00
      00841D 00 80 40 20 10 08 00    84 .byte 0x00,0x80,0x40,0x20,0x10,0x08,0x00,0x00  ; '\'
             00
      008425 18 08 08 08 08 08 18    85 .byte 0x18,0x08,0x08,0x08,0x08,0x08,0x18,0x00  ; ]
             00
      00842D 20 50 88 00 00 00 00    86 .byte 0x20,0x50,0x88,0x00,0x00,0x00,0x00,0x00  ; ^
             00
      008435 00 00 00 00 00 00 00    87 .byte 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFE  ; _
             FE
      00843D 40 20 10 00 00 00 00    88 .byte 0x40,0x20,0x10,0x00,0x00,0x00,0x00,0x00  ; `
             00
      008445 00 00 70 08 78 88 78    89 .byte 0x00,0x00,0x70,0x08,0x78,0x88,0x78,0x00  ; a
             00
      00844D 80 80 80 B0 C8 88 F0    90 .byte 0x80,0x80,0x80,0xB0,0xC8,0x88,0xF0,0x00  ; b
             00
      008455 00 00 70 80 80 88 70    91 .byte 0x00,0x00,0x70,0x80,0x80,0x88,0x70,0x00  ; c
             00
      00845D 08 08 08 68 98 88 78    92 .byte 0x08,0x08,0x08,0x68,0x98,0x88,0x78,0x00  ; d
             00
      008465 00 00 70 88 F8 80 70    93 .byte 0x00,0x00,0x70,0x88,0xF8,0x80,0x70,0x00  ; e
             00
      00846D 30 48 40 E0 40 40 40    94 .byte 0x30,0x48,0x40,0xE0,0x40,0x40,0x40,0x00  ; f
             00
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 59.
Hexadecimal [24-Bits]



      008475 00 00 78 88 88 78 08    95 .byte 0x00,0x00,0x78,0x88,0x88,0x78,0x08,0x70  ; g
             70
      00847D 80 80 B0 C8 88 88 88    96 .byte 0x80,0x80,0xB0,0xC8,0x88,0x88,0x88,0x00  ; h
             00
      008485 00 20 00 20 20 20 20    97 .byte 0x00,0x20,0x00,0x20,0x20,0x20,0x20,0x00  ; i
             00
      00848D 10 00 30 10 10 90 60    98 .byte 0x10,0x00,0x30,0x10,0x10,0x90,0x60,0x00  ; j
             00
      008495 80 80 90 A0 C0 A0 90    99 .byte 0x80,0x80,0x90,0xA0,0xC0,0xA0,0x90,0x00  ; k
             00
      00849D 60 20 20 20 20 20 70   100 .byte 0x60,0x20,0x20,0x20,0x20,0x20,0x70,0x00  ; l
             00
      0084A5 00 00 D0 A8 A8 88 88   101 .byte 0x00,0x00,0xD0,0xA8,0xA8,0x88,0x88,0x00  ; m
             00
      0084AD 00 00 B0 C8 88 88 88   102 .byte 0x00,0x00,0xB0,0xC8,0x88,0x88,0x88,0x00  ; n
             00
      0084B5 00 00 70 88 88 88 70   103 .byte 0x00,0x00,0x70,0x88,0x88,0x88,0x70,0x00  ; o
             00
      0084BD 00 00 F0 88 88 F0 80   104 .byte 0x00,0x00,0xF0,0x88,0x88,0xF0,0x80,0x80  ; p
             80
      0084C5 00 00 68 90 90 B0 50   105 .byte 0x00,0x00,0x68,0x90,0x90,0xB0,0x50,0x18  ; q
             18
      0084CD 00 00 B0 C8 80 80 80   106 .byte 0x00,0x00,0xB0,0xC8,0x80,0x80,0x80,0x00  ; r
             00
      0084D5 00 00 70 80 70 08 F0   107 .byte 0x00,0x00,0x70,0x80,0x70,0x08,0xF0,0x00  ; s
             00
      0084DD 40 40 E0 40 40 48 30   108 .byte 0x40,0x40,0xE0,0x40,0x40,0x48,0x30,0x00  ; t
             00
      0084E5 00 00 88 88 88 98 68   109 .byte 0x00,0x00,0x88,0x88,0x88,0x98,0x68,0x00  ; u
             00
      0084ED 00 00 88 88 88 50 20   110 .byte 0x00,0x00,0x88,0x88,0x88,0x50,0x20,0x00  ; v
             00
      0084F5 00 00 88 88 A8 A8 50   111 .byte 0x00,0x00,0x88,0x88,0xA8,0xA8,0x50,0x00  ; w
             00
      0084FD 00 00 88 50 20 50 88   112 .byte 0x00,0x00,0x88,0x50,0x20,0x50,0x88,0x00  ; x
             00
      008505 00 00 88 88 88 78 08   113 .byte 0x00,0x00,0x88,0x88,0x88,0x78,0x08,0x70  ; y
             70
      00850D 00 00 F8 10 20 40 F8   114 .byte 0x00,0x00,0xF8,0x10,0x20,0x40,0xF8,0x00  ; z
             00
      008515 20 40 40 80 40 40 20   115 .byte 0x20,0x40,0x40,0x80,0x40,0x40,0x20,0x00  ; {
             00
      00851D 20 20 20 20 20 20 20   116 .byte 0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x00  ; |
             00
      008525 40 20 20 10 20 20 40   117 .byte 0x40,0x20,0x20,0x10,0x20,0x20,0x40,0x00  ; }
             00
      00852D 00 00 40 A8 10 00 00   118 .byte 0x00,0x00,0x40,0xA8,0x10,0x00,0x00,0x00  ; ~  ASCII 126 
             00
      008535 FC FC FC FC FC FC FC   119 .byte 0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC  ; block cursor  127
             FC
      00853D 40 20 10 F8 10 20 40   120 .byte 0x40,0x20,0x10,0xF8,0x10,0x20,0x40,0x00  ; flèche droite 128 
             00
      008545 10 20 40 F8 40 20 10   121 .byte 0x10,0x20,0x40,0xF8,0x40,0x20,0x10,0x00  ; flèche gauche 129
             00
      00854D 20 70 A8 20 20 20 00   122 .byte 0x20,0x70,0xA8,0x20,0x20,0x20,0x00,0x00  ; flèche haut   130
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 60.
Hexadecimal  00-Bits]



             00
      008555 00 20 20 20 A8 70 20   123 .byte 0x00,0x20,0x20,0x20,0xA8,0x70,0x20,0x00  ; flèche bas    131
             00
      00855D 00 70 F8 F8 F8 70 00   124 .byte 0x00,0x70,0xF8,0xF8,0xF8,0x70,0x00,0x00  ; rond		  132 
             00
      008565 00 00 00 00 00 00 00   125 .byte 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xff  ; underline cursor 133
             FF
      00856D 80 80 80 80 80 80 80   126 .byte 0x80,0x80,0x80,0x80,0x80,0x80,0x80,0x80  ; insert cursor 134
             80
      008575                        127 font_end:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 61.
Hexadecimal [24-Bits]



                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2023,2024  
                                      3 ; This file is part of stm8-gamepad
                                      4 ;
                                      5 ;     stm8-gamepad is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     stm8-gamepad is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with ntsc_tuto.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                                     19 
                                     20 ; display resolution in pixels 
                           0000C8    21 HRES=200
                           0000C0    22 VRES=192
                           000019    23 BYTES_PER_LINE=25
                                     24 
                                     25 
                                     26 ; values based on 16 Mhz crystal
                                     27 
                           003D76    28 FR_HORZ=15734
                           0003F8    29 HLINE=(FMSTR/FR_HORZ); horizontal line duration 
                           0001FC    30 HALF_LINE=HLINE/2 ; half-line during sync. 
                           000025    31 EPULSE=37 ; pulse width during pre and post equalization
                           0001B4    32 VPULSE=436 ; pulse width during vertical sync. 
                           00004B    33 HPULSE=75 ; 4.7µSec horizontal line sync pulse width. 
                           000082    34 LINE_DELAY=(130) 
                                     35 
                                     36 ; ntsc synchro phases 
                           000000    37 PH_VSYNC=0 
                           000001    38 PH_PRE_VIDEO=1
                           000002    39 PH_VIDEO=2 
                           000003    40 PH_POST_VIDEO=3 
                                     41 
                           000037    42 FIRST_VIDEO_LINE=55 
                           0000C0    43 VIDEO_LINES=192
                                     44 
                                     45 ;ntsc flags 
                           000000    46 F_EVEN=0 ; odd/even field flag 
                           000001    47 F_CURSOR=1 ; tv cursor active 
                           000002    48 F_CUR_VISI=2 ; tv cursor state, 1 visible 
                           000004    49 F_VIDEO=4 ; enable video output 
                                     50 
                                     51 ;-------------------------------
                                     52     .area CODE 
                                     53 ;------------------------------
                                     54 
                                     55 ;------------------------------
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 62.
Hexadecimal [24-Bits]



                                     56 ; initialize TIMER1 for 
                                     57 ; NTSC synchronisation 
                                     58 ; signal 
                                     59 ;------------------------------
      008575                         60 ntsc_init:
      0004F5                         61     _clrz ntsc_flags 
      008575 3F EF                    1     .byte 0x3f, ntsc_flags 
      0004F7                         62     _clrz ntsc_phase 
      008577 3F F0                    1     .byte 0x3f, ntsc_phase 
                                     63 ; enable TIMER1 and SPI clock 
      008579 72 1E 50 C7      [ 1]   64     bset CLK_PCKENR1,#CLK_PCKENR1_TIM1
      00857D 72 12 50 C7      [ 1]   65     bset CLK_PCKENR1,#CLK_PCKENR1_SPI
                                     66 ; set MOSI pin as output high-speed push-pull 
      008581 72 1C 50 0C      [ 1]   67     bset PC_DDR,#6 
      008585 72 1D 50 0A      [ 1]   68     bres PC_ODR,#6
      008589 72 1C 50 0D      [ 1]   69     bset PC_CR1,#6
      00858D 72 1C 50 0E      [ 1]   70     bset PC_CR2,#6
      008591 72 5F 52 03      [ 1]   71     clr SPI_SR 
      008595 72 5F 52 04      [ 1]   72     clr SPI_DR 
      008599 35 4C 52 00      [ 1]   73     mov SPI_CR1,#(1<<SPI_CR1_SPE)|(1<<SPI_CR1_MSTR)|(1<<SPI_CR1_BR)
                                     74 ; initialize timer1 for pwm
                                     75 ; generate NTSC sync signal  on CH3 
      00859D 35 01 52 54      [ 1]   76     mov TIM1_IER,#1 ; UIE set 
      0085A1 72 1E 52 50      [ 1]   77     bset TIM1_CR1,#TIM1_CR1_ARPE ; auto preload enabled 
      0085A5 35 78 52 5A      [ 1]   78     mov TIM1_CCMR3,#(7<<TIM1_CCMR3_OC3MODE)  |(1<<TIM1_CCMR3_OC3PE)
      0085A9 72 10 52 5D      [ 1]   79     bset TIM1_CCER2,#0
      0085AD 72 1E 52 6D      [ 1]   80     bset TIM1_BKR,#TIM1_BKR_MOE
                                     81 ; use channel 2 for video stream trigger 
                                     82 ; set pixel out delay   
      0085B1 35 60 52 59      [ 1]   83     mov TIM1_CCMR2,#(6<<TIM1_CCMR2_OC2MODE) 
      0085B5 35 00 52 67      [ 1]   84     mov TIM1_CCR2H,#LINE_DELAY>>8 
      0085B9 35 82 52 68      [ 1]   85     mov TIM1_CCR2L,#LINE_DELAY&0xFF
                                     86 ; begin with PH_PRE_EQU odd field 
      00053D                         87     _clrz ntsc_phase 
      0085BD 3F F0                    1     .byte 0x3f, ntsc_phase 
      0085BF 35 03 52 62      [ 1]   88     mov TIM1_ARRH,#HLINE>>8
      0085C3 35 F8 52 63      [ 1]   89     mov TIM1_ARRL,#HLINE&0XFF
      0085C7 35 00 52 69      [ 1]   90     mov TIM1_CCR3H,#HPULSE>>8 
      0085CB 35 4B 52 6A      [ 1]   91     mov TIM1_CCR3L,#HPULSE&0XFF
      0085CF CD 87 35         [ 4]   92     call tv_cls 
      0085D2 72 10 52 50      [ 1]   93     bset TIM1_CR1,#TIM1_CR1_CEN 
      0085D6 A6 01            [ 1]   94     ld a,#1
      0085D8 CD 85 DC         [ 4]   95     call video_on_off 
      0085DB 81               [ 4]   96     ret 
                                     97 
                                     98 ;--------------------
                                     99 ; enable|disable 
                                    100 ; video output 
                                    101 ; input:
                                    102 ;   A    0->off 
                                    103 ;        1->on
                                    104 ;--------------------
      0085DC                        105 video_on_off:
      0085DC 4D               [ 1]  106     tnz a 
      0085DD 27 09            [ 1]  107     jreq 1$ 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 63.
Hexadecimal [24-Bits]



                                    108 ; enable video 
      0085DF 72 18 00 EF      [ 1]  109     bset ntsc_flags,#F_VIDEO 
      0085E3 72 10 52 54      [ 1]  110     bset TIM1_IER,#TIM1_IER_UIE 
      0085E7 81               [ 4]  111     ret     
      0085E8                        112 1$: ; disable video 
      0085E8 72 19 00 EF      [ 1]  113     bres ntsc_flags,#F_VIDEO 
      0085EC 72 15 52 54      [ 1]  114     bres TIM1_IER,#TIM1_IER_CC2IE 
      0085F0 72 10 52 54      [ 1]  115     bset TIM1_IER,#TIM1_IER_UIE 
      0085F4 81               [ 4]  116     ret 
                                    117 
                                    118 
                                    119 ;-------------------------------
                                    120 ; TIMER1 update interrupt handler 
                                    121 ; interrupt happend at end 
                                    122 ; of each phase and and pwm 
                                    123 ; is set for next phase 
                                    124 ;-------------------------------
      0085F5                        125 ntsc_sync_interrupt:
      0085F5 72 5F 52 55      [ 1]  126     clr TIM1_SR1 
      000579                        127     _ldxz scan_line 
      0085F9 BE F1                    1     .byte 0xbe,scan_line 
      0085FB 5C               [ 1]  128     incw x 
      00057C                        129     _strxz scan_line 
      0085FC BF F1                    1     .byte 0xbf,scan_line 
      00057E                        130     _ldaz ntsc_phase 
      0085FE B6 F0                    1     .byte 0xb6,ntsc_phase 
      008600 A1 00            [ 1]  131     cp a,#PH_VSYNC  
      008602 26 5D            [ 1]  132     jrne test_pre_video 
      008604 A3 00 01         [ 2]  133     cpw x,#1 
      008607 26 13            [ 1]  134     jrne  1$ 
      008609 35 01 52 62      [ 1]  135     mov TIM1_ARRH,#HALF_LINE>>8 
      00860D 35 FC 52 63      [ 1]  136     mov TIM1_ARRL,#HALF_LINE & 0xff 
      008611 35 00 52 69      [ 1]  137     mov TIM1_CCR3H,#EPULSE>>8 
      008615 35 25 52 6A      [ 1]  138     mov TIM1_CCR3L,#EPULSE&0xff 
      008619 CC 86 CF         [ 2]  139     jp sync_exit 
      00861C A3 00 07         [ 2]  140 1$: cpw x,#7 
      00861F 26 0B            [ 1]  141     jrne 2$ 
      008621 35 01 52 69      [ 1]  142     mov TIM1_CCR3H,#VPULSE>>8 
      008625 35 B4 52 6A      [ 1]  143     mov TIM1_CCR3L,#VPULSE&0xff 
      008629 CC 86 CF         [ 2]  144     jp sync_exit 
      00862C                        145 2$:
      00862C A3 00 0D         [ 2]  146     cpw x,#13 
      00862F 26 0B            [ 1]  147     jrne 3$ 
      008631 35 00 52 69      [ 1]  148     mov TIM1_CCR3H,#EPULSE>>8 
      008635 35 25 52 6A      [ 1]  149     mov TIM1_CCR3L,#EPULSE&0xff 
      008639 CC 86 CF         [ 2]  150     jp sync_exit 
      00863C                        151 3$: 
      00863C A3 00 12         [ 2]  152     cpw x,#18 
      00863F 26 19            [ 1]  153     jrne 5$ 
      008641 72 00 00 EF 11   [ 2]  154     btjt ntsc_flags,#F_EVEN,44$ 
      008646                        155 4$:
      008646 35 03 52 62      [ 1]  156     mov TIM1_ARRH,#HLINE>>8 
      00864A 35 F8 52 63      [ 1]  157     mov TIM1_ARRL,#HLINE & 0xff 
      00864E 35 00 52 69      [ 1]  158     mov TIM1_CCR3H,#HPULSE>>8 
      008652 35 4B 52 6A      [ 1]  159     mov TIM1_CCR3L,#HPULSE&0xff 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 64.
Hexadecimal [24-Bits]



      008656 4C               [ 1]  160     inc a 
      008657                        161 44$:
      008657 CC 86 CF         [ 2]  162     jp sync_exit 
      00865A                        163 5$: 
      00865A A3 00 13         [ 2]  164     cpw x,#19 
      00865D 27 E7            [ 1]  165     jreq 4$ 
      00865F 20 6E            [ 2]  166     jra sync_exit 
      008661                        167 test_pre_video:
      008661 A1 01            [ 1]  168     cp a,#PH_PRE_VIDEO 
      008663 26 49            [ 1]  169     jrne post_video  
      008665 A3 00 14         [ 2]  170     cpw x,#20 
      008668 26 07            [ 1]  171     jrne 1$ 
      0005EA                        172     _ldxz ticks 
      00866A BE E0                    1     .byte 0xbe,ticks 
      00866C 5C               [ 1]  173     incw x 
      0005ED                        174     _strxz ticks 
      00866D BF E0                    1     .byte 0xbf,ticks 
      00866F 20 5E            [ 2]  175     jra sync_exit 
      008671 A3 00 15         [ 2]  176 1$: cpw x,#21 
      008674 26 0F            [ 1]  177     jrne 2$ 
      008676 72 0F 00 EA 54   [ 2]  178     btjf flags,#F_GAME_TMR,sync_exit 
      0005FB                        179     _decz delay_timer 
      00867B 3A E2                    1     .byte 0x3a,delay_timer 
      00867D 26 50            [ 1]  180     jrne sync_exit 
      00867F 72 1F 00 EA      [ 1]  181     bres flags,#F_GAME_TMR
      008683 20 4A            [ 2]  182     jra sync_exit 
      008685 A3 00 16         [ 2]  183 2$: cpw x,#22 
      008688 26 0F            [ 1]  184     jrne 3$ 
      00868A 72 0D 00 EA 40   [ 2]  185     btjf flags,#F_SOUND_TMR,sync_exit 
      00060F                        186     _decz sound_timer
      00868F 3A E3                    1     .byte 0x3a,sound_timer 
      008691 26 3C            [ 1]  187     jrne sync_exit 
      008693 72 1D 00 EA      [ 1]  188     bres flags,#F_SOUND_TMR
      008697 20 36            [ 2]  189     jra sync_exit 
      008699                        190 3$:
      008699 A3 00 37         [ 2]  191     cpw x,#FIRST_VIDEO_LINE
      00869C 26 31            [ 1]  192     jrne sync_exit 
      00869E 4C               [ 1]  193     inc a 
      00869F 72 09 00 EF 2B   [ 2]  194     btjf ntsc_flags,#F_VIDEO,sync_exit
      0086A4 72 11 52 54      [ 1]  195     bres TIM1_IER,#TIM1_IER_UIE 
      0086A8 72 14 52 54      [ 1]  196     bset TIM1_IER,#TIM1_IER_CC2IE
      0086AC 20 21            [ 2]  197     jra sync_exit
      0086AE                        198 post_video:
      0086AE A3 01 0F         [ 2]  199     cpw x,#271
      0086B1 26 07            [ 1]  200     jrne 2$ 
      0086B3 72 01 00 EF 0F   [ 2]  201     btjf ntsc_flags,#F_EVEN,#3$  
      0086B8 20 15            [ 2]  202     jra sync_exit  
      0086BA                        203 2$: 
      0086BA A3 01 10         [ 2]  204     cpw x,#272 
      0086BD 26 10            [ 1]  205     jrne sync_exit 
      0086BF 35 01 52 62      [ 1]  206     mov TIM1_ARRH,#HALF_LINE>>8
      0086C3 35 FC 52 63      [ 1]  207     mov TIM1_ARRL,#HALF_LINE & 0xff 
      0086C7                        208 3$: ;field end     
      0086C7 4F               [ 1]  209     clr a 
      0086C8 5F               [ 1]  210     clrw x 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 65.
Hexadecimal [24-Bits]



      000649                        211     _strxz scan_line
      0086C9 BF F1                    1     .byte 0xbf,scan_line 
      0086CB 90 10 00 EF      [ 1]  212     bcpl ntsc_flags,#F_EVEN
      0086CF                        213 sync_exit:
      00064F                        214     _straz ntsc_phase
      0086CF B7 F0                    1     .byte 0xb7,ntsc_phase 
      0086D1 80               [11]  215     iret 
                                    216 
                                    217 
                                    218 
                                    219 ;----------------------------------
                                    220 ; TIMER1 compare interrupt handler
                                    221 ;----------------------------------
                           000001   222     BPL=1 ; bytes per scan line 
                           000001   223     VAR_SIZE=1
      0086D2                        224 ntsc_video_interrupt:
      000652                        225     _vars VAR_SIZE
      0086D2 52 01            [ 2]    1     sub sp,#VAR_SIZE 
      0086D4 72 5F 52 55      [ 1]  226     clr TIM1_SR1
      0086D8 C6 52 5F         [ 1]  227     ld a,TIM1_CNTRL 
      0086DB A4 07            [ 1]  228     and a,#7 
      0086DD 88               [ 1]  229     push a 
      0086DE 4B 00            [ 1]  230     push #0 
      0086E0 AE 86 E9         [ 2]  231     ldw x,#jitter_cancel 
      0086E3 72 FB 01         [ 2]  232     addw x,(1,sp)
      000666                        233     _drop 2 
      0086E6 5B 02            [ 2]    1     addw sp,#2 
      0086E8 FC               [ 2]  234     jp (x)
      0086E9                        235 jitter_cancel:
      0086E9 9D               [ 1]  236     nop 
      0086EA 9D               [ 1]  237     nop 
      0086EB 9D               [ 1]  238     nop 
      0086EC 9D               [ 1]  239     nop 
      0086ED 9D               [ 1]  240     nop 
      0086EE 9D               [ 1]  241     nop 
      0086EF 9D               [ 1]  242     nop 
      0086F0 9D               [ 1]  243     nop 
                                    244 ; compute postion in buffer 
                                    245 ; 1 scan line/video buffer line 
                                    246 ; ofs=scan_line-FIRST_VIDEO_LINE*BYTES_PER_LINE+tv_buffer       
      000671                        247     _ldxz scan_line 
      0086F1 BE F1                    1     .byte 0xbe,scan_line 
      0086F3 1D 00 37         [ 2]  248     subw x,#FIRST_VIDEO_LINE
      0086F6 A6 19            [ 1]  249     ld a,#BYTES_PER_LINE  
      0086F8 42               [ 4]  250     mul x,a  ; tv_buffer line  
      0086F9 1C 04 C0         [ 2]  251     addw x,#tv_buffer
      0086FC A6 19            [ 1]  252     ld a,#BYTES_PER_LINE
      0086FE 6B 01            [ 1]  253     ld (BPL,sp),a
      008700 72 5F 52 04      [ 1]  254     clr SPI_DR  
      008704 F6               [ 1]  255 1$: ld a,(x)
      008705 5C               [ 1]  256     incw x 
      008706 C7 52 04         [ 1]  257     ld SPI_DR,a 
      008709 72 03 52 03 FB   [ 2]  258     btjf SPI_SR,#SPI_SR_TXE,. 
      00870E 0A 01            [ 1]  259     dec (BPL,sp)
      008710 26 F2            [ 1]  260     jrne 1$ 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 66.
Hexadecimal [24-Bits]



      008712 72 5F 52 04      [ 1]  261     clr SPI_DR
      008716 72 03 52 03 FB   [ 2]  262     btjf SPI_SR,#SPI_SR_TXE,. 
      00871B 72 0E 52 03 FB   [ 2]  263     btjt SPI_SR,#SPI_SR_BSY,.
                                    264 ;    bres SPI_CR1,#SPI_CR1_SPE  
      0006A0                        265     _ldxz scan_line 
      008720 BE F1                    1     .byte 0xbe,scan_line 
      008722 5C               [ 1]  266     incw x 
      0006A3                        267     _strxz scan_line 
      008723 BF F1                    1     .byte 0xbf,scan_line 
      008725 A3 00 F7         [ 2]  268     cpw x,#FIRST_VIDEO_LINE+VIDEO_LINES
      008728 2B 08            [ 1]  269     jrmi 4$ 
      00872A 72 15 52 54      [ 1]  270     bres TIM1_IER,#TIM1_IER_CC2IE
      00872E 72 10 52 54      [ 1]  271     bset TIM1_IER,#TIM1_IER_UIE
      0006B2                        272 4$: _drop VAR_SIZE
      008732 5B 01            [ 2]    1     addw sp,#VAR_SIZE 
      008734 80               [11]  273     iret 
                                    274 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 67.
Hexadecimal [24-Bits]



                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2023,2024  
                                      3 ; This file is part of stm8-gamepad
                                      4 ;
                                      5 ;     stm8-gamepadis free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     stm8-gamepadis distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with ntsc_tuto.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                                     19 
                           000021    20 CHAR_PER_LINE=33
                           000018    21 LINE_PER_SCREEN=24
                                     22 
                                     23     .macro _curpos x,y 
                                     24     ldw x,#(y<<8)+x 
                                     25     _strxz cy 
                                     26     .endm 
                                     27     
                                     28 ;--------------------------
                                     29 ; clear tv display 
                                     30 ;--------------------------
      008735                         31 tv_cls:
      008735 90 89            [ 2]   32     pushw y 
      008737 AE 12 C0         [ 2]   33     ldw x,#VBUFF_SIZE 
      00873A 90 AE 04 C0      [ 2]   34     ldw y,#tv_buffer
      00873E 90 7F            [ 1]   35 1$: clr (y)
      008740 90 5C            [ 1]   36     incw y 
      008742 5A               [ 2]   37     decw x 
      008743 26 F9            [ 1]   38     jrne 1$
      0006C5                         39     _clrz cx 
      008745 3F F4                    1     .byte 0x3f, cx 
      0006C7                         40     _clrz cy   
      008747 3F F3                    1     .byte 0x3f, cy 
      008749 90 85            [ 2]   41     popw y 
      00874B 81               [ 4]   42     ret 
                                     43 
                                     44 ;------------------------
                                     45 ; build bitmask from 
                                     46 ; bit position 
                                     47 ; input:
                                     48 ;    A    position {0..7}
                                     49 ;------------------------
      00874C                         50 bit_mask:
      00874C 88               [ 1]   51     push a 
      00874D A6 80            [ 1]   52     ld a,#128 
      00874F 0D 01            [ 1]   53 1$: tnz (1,sp)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 68.
Hexadecimal [24-Bits]



      008751 27 05            [ 1]   54     jreq 9$ 
      008753                         55 2$:
      008753 44               [ 1]   56     srl a 
      008754 0A 01            [ 1]   57     dec (1,sp)
      008756 26 FB            [ 1]   58     jrne 2$
      0006D8                         59 9$: _drop 1 
      008758 5B 01            [ 2]    1     addw sp,#1 
      00875A 81               [ 4]   60     ret 
                                     61 
                                     62 ;------------------------
                                     63 ; compute pixel address 
                                     64 ; and bit mask from 
                                     65 ; from coordinates 
                                     66 ; input:
                                     67 ;     XH   y coord 
                                     68 ;     XL   x coord 
                                     69 ; output:
                                     70 ;     A    bit mask 
                                     71 ;     X    byte address 
                                     72 ;------------------------
                           000001    73     YCOOR=1
                           000002    74     XCOOR=2 
                           000003    75     BOFS=3  ; byte offset 
                           000004    76     BOFSL=4  ; xcoord/8
                           000005    77     BPOS=5   ; bit position xcoord%8
                           000005    78     VAR_SIZE=5
      00875B                         79 pixel_addr:
      0006DB                         80     _vars VAR_SIZE
      00875B 52 05            [ 2]    1     sub sp,#VAR_SIZE 
      00875D 1F 01            [ 2]   81     ldw (YCOOR,sp),x 
      00875F 5F               [ 1]   82     clrw x 
      008760 1F 03            [ 2]   83     ldw (BOFS,sp),x 
      008762 7B 02            [ 1]   84     ld a,(XCOOR,sp)
      008764 97               [ 1]   85     ld xl,a 
      008765 A6 08            [ 1]   86     ld a,#8 
      008767 62               [ 2]   87     div x,a 
                                     88 ;    sub a,#7 
                                     89 ;    neg a 
      008768 6B 05            [ 1]   90     ld (BPOS,sp),a
      00876A 9F               [ 1]   91     ld a,xl 
      00876B 6B 04            [ 1]   92     ld (BOFSL,sp),a 
      00876D 7B 01            [ 1]   93     ld a,(YCOOR,sp)
      00876F AE 00 19         [ 2]   94     ldw x,#BYTES_PER_LINE 
      008772 42               [ 4]   95     mul x,a 
      008773 1C 04 C0         [ 2]   96     addw x,#tv_buffer
      008776 72 FB 03         [ 2]   97     addw x,(BOFS,sp)
      008779 7B 05            [ 1]   98     ld a,(BPOS,sp)
      00877B CD 87 4C         [ 4]   99     call bit_mask 
      0006FE                        100     _drop VAR_SIZE  
      00877E 5B 05            [ 2]    1     addw sp,#VAR_SIZE 
      008780 81               [ 4]  101     ret 
                                    102 
                                    103 ;-------------------------
                                    104 ; set pixel 
                                    105 ; input:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 69.
Hexadecimal [24-Bits]



                                    106 ;     XH    y coord {0..63}
                                    107 ;     XL    x coord (0..95)
                                    108 ;---------------------------
      008781                        109 set_pixel:
      008781 CD 87 5B         [ 4]  110     call pixel_addr
      008784 FA               [ 1]  111     or a,(x)
      008785 F7               [ 1]  112     ld (x),a 
      008786 81               [ 4]  113     ret 
                                    114 
                                    115 ;-------------------------
                                    116 ; reset pixel 
                                    117 ; input:
                                    118 ;     XH    y coord {0..63}
                                    119 ;     XL    x coord (0..95)
                                    120 ;---------------------------
      008787                        121 reset_pixel:
      008787 CD 87 5B         [ 4]  122     call pixel_addr
      00878A 43               [ 1]  123     cpl a 
      00878B F4               [ 1]  124     and a,(x)
      00878C F7               [ 1]  125     ld (x),a 
      00878D 81               [ 4]  126     ret 
                                    127 
                                    128 ;-------------------------
                                    129 ; invert pixel 
                                    130 ; input:
                                    131 ;     XH    y coord {0..63}
                                    132 ;     XL    x coord (0..95)
                                    133 ;---------------------------
      00878E                        134 invert_pixel:
      00878E CD 87 5B         [ 4]  135     call pixel_addr 
      008791 F8               [ 1]  136     xor a,(x)
      008792 F7               [ 1]  137     ld (x),a 
      008793 81               [ 4]  138     ret 
                                    139 
                                    140 
                                    141 ;-----------------------------
                                    142 ; move text 1 line up 
                                    143 ; clear bottom line 
                                    144 ;-----------------------------
      008794                        145 scroll_text_up:
      008794 88               [ 1]  146     push a 
      008795 89               [ 2]  147     pushw x 
      008796 90 89            [ 2]  148     pushw y 
                                    149 ; count bytes to copy     
      008798 AE 11 F8         [ 2]  150     ldw x,#(VRES-FONT_HEIGHT)*BYTES_PER_LINE
      00071B                        151     _strxz acc16  
      00879B BF E4                    1     .byte 0xbf,acc16 
                                    152 ; destination address     
      00879D AE 04 C0         [ 2]  153     ldw x,#tv_buffer 
      0087A0 90 93            [ 1]  154     ldw y,x 
                                    155 ; source address     
      0087A2 72 A9 00 C8      [ 2]  156     addw y,#BYTES_PER_LINE*FONT_HEIGHT 
      0087A6 CD 8A 35         [ 4]  157     call move 
                                    158 ; clear bottom text line 
      0087A9 4F               [ 1]  159     clr a 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 70.
Hexadecimal [24-Bits]



      0087AA AE 00 C8         [ 2]  160     ldw x,#(FONT_HEIGHT*BYTES_PER_LINE) 
      0087AD 90 AE 04 C0      [ 2]  161     ldw y,#tv_buffer 
      0087B1 72 A2 11 F8      [ 2]  162     subw y,#VBUFF_SIZE-(FONT_HEIGHT*BYTES_PER_LINE)
      0087B5 CD 8A 79         [ 4]  163     call fill 
      0087B8 90 85            [ 2]  164     popw y 
      0087BA 85               [ 2]  165     popw x 
      0087BB 84               [ 1]  166     pop a 
      0087BC 81               [ 4]  167     ret 
                                    168 
                                    169 ;----------------------------
                                    170 ; move text cursor to 
                                    171 ; next line 
                                    172 ;----------------------------
      0087BD                        173 crlf:
      00073D                        174     _clrz cx 
      0087BD 3F F4                    1     .byte 0x3f, cx 
      00073F                        175     _ldaz cy 
      0087BF B6 F3                    1     .byte 0xb6,cy 
      0087C1 4C               [ 1]  176     inc a
      0087C2 A1 18            [ 1]  177     cp a,#LINE_PER_SCREEN
      0087C4 2B 04            [ 1]  178     jrmi 1$
      0087C6 CD 87 94         [ 4]  179     call scroll_text_up
      0087C9 81               [ 4]  180     ret  
      0087CA                        181 1$: 
      00074A                        182     _straz cy 
      0087CA B7 F3                    1     .byte 0xb7,cy 
      0087CC 81               [ 4]  183     ret 
                                    184 
                                    185 ;------------------------------
                                    186 ; move text cursor right 
                                    187 ;------------------------------
      0087CD                        188 cursor_right:
      00074D                        189     _incz cx 
      0087CD 3C F4                    1     .byte 0x3c, cx 
      00074F                        190     _ldaz cx 
      0087CF B6 F4                    1     .byte 0xb6,cx 
      0087D1 A1 21            [ 1]  191     cp a,#CHAR_PER_LINE  
      0087D3 2A E8            [ 1]  192     jrpl crlf 
      0087D5 81               [ 4]  193     ret 
                                    194 
                                    195 ;-------------------------
                                    196 ; put character on tv 
                                    197 ; input:
                                    198 ;    A    character 
                                    199 ;------------------------
                           000001   200     XCOORH=1
                           000002   201     XCOOR=XCOORH+1
                           000003   202     BYTECNT=XCOOR+1
                           000004   203     SHIFT=BYTECNT+1
                           000005   204     MASK=SHIFT+1
                           000007   205     ROW=MASK+2
                           000008   206     VAR_SIZE=ROW+1  
      0087D6                        207 tv_putc:
      0087D6 90 89            [ 2]  208     pushw y 
      0087D8 89               [ 2]  209     pushw x 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 71.
Hexadecimal [24-Bits]



      000759                        210     _vars VAR_SIZE 
      0087D9 52 08            [ 2]    1     sub sp,#VAR_SIZE 
      0087DB A1 0D            [ 1]  211     cp a,#CR 
      0087DD 26 06            [ 1]  212     jrne 1$ 
      0087DF CD 87 BD         [ 4]  213     call crlf 
      0087E2 CC 88 4C         [ 2]  214     jp 9$
      0087E5                        215  1$:
      0087E5 A0 20            [ 1]  216     sub a,#SPACE 
      0087E7 AE 00 08         [ 2]  217     ldw x,#FONT_HEIGHT
      0087EA 42               [ 4]  218     mul x,a 
      0087EB 1C 82 3D         [ 2]  219     addw x,#font_6x8
      0087EE 90 93            [ 1]  220     ldw y,x 
      0087F0 AE 03 FF         [ 2]  221     ldw x,#0x03ff
      0087F3 1F 05            [ 2]  222     ldw (MASK,sp),x 
      0087F5 A6 08            [ 1]  223     ld a,#FONT_HEIGHT
      0087F7 6B 03            [ 1]  224     ld (BYTECNT,sp),a 
      000779                        225     _ldaz cx 
      0087F9 B6 F4                    1     .byte 0xb6,cx 
      0087FB AE 00 06         [ 2]  226     ldw x,#FONT_WIDTH  
      0087FE 42               [ 4]  227     mul x,a
      0087FF A6 08            [ 1]  228     ld a,#8 
      008801 62               [ 2]  229     div x,a 
      008802 6B 04            [ 1]  230     ld (SHIFT,sp),a 
      008804 1F 01            [ 2]  231     ldw (XCOORH,sp),x     
      000786                        232     _ldaz cy 
      008806 B6 F3                    1     .byte 0xb6,cy 
      008808 AE 00 08         [ 2]  233     ldw x,#FONT_HEIGHT
      00880B 42               [ 4]  234     mul x,a 
      00880C A6 19            [ 1]  235     ld a,#BYTES_PER_LINE
      00880E 42               [ 4]  236     mul x,a 
      00880F 72 FB 01         [ 2]  237     addw x,(XCOORH,sp)
      008812 1C 04 C0         [ 2]  238     addw x,#tv_buffer 
                                    239 ; shift MASK 
      008815 7B 04            [ 1]  240     ld a,(SHIFT,sp)
      008817 27 08            [ 1]  241     jreq 4$
      008819 99               [ 1]  242     scf 
      00881A 06 05            [ 1]  243 3$: rrc (MASK,sp)
      00881C 06 06            [ 1]  244     rrc (MASK+1,sp)
      00881E 4A               [ 1]  245     dec a 
      00881F 26 F9            [ 1]  246     jrne 3$
                                    247 ; get font row 
                                    248 ; and shift it 
      008821                        249 4$:     
      008821 90 F6            [ 1]  250     ld a,(y)
      008823 90 5C            [ 1]  251     incw y 
      008825 6B 07            [ 1]  252     ld (ROW,sp),a 
      008827 0F 08            [ 1]  253     clr (ROW+1,sp)
      008829 7B 04            [ 1]  254     ld a,(SHIFT,sp)
      00882B 27 07            [ 1]  255     jreq 6$ 
      00882D                        256 5$:  
      00882D 04 07            [ 1]  257     srl (ROW,sp)
      00882F 06 08            [ 1]  258     rrc (ROW+1,sp)
      008831 4A               [ 1]  259     dec a 
      008832 26 F9            [ 1]  260     jrne 5$ 
      008834                        261 6$: 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 72.
Hexadecimal [24-Bits]



      008834 7B 05            [ 1]  262     ld a,(MASK,sp)
      008836 F4               [ 1]  263     and a,(x)
      008837 1A 07            [ 1]  264     or a,(ROW,sp)
      008839 F7               [ 1]  265     ld (x),a 
      00883A E6 01            [ 1]  266     ld a,(1,x)
      00883C 14 06            [ 1]  267     and a,(MASK+1,sp)
      00883E 1A 08            [ 1]  268     or a,(ROW+1,sp)
      008840 E7 01            [ 1]  269     ld (1,x),a 
      008842 1C 00 19         [ 2]  270     addw x,#BYTES_PER_LINE
      008845 0A 03            [ 1]  271     dec (BYTECNT,sp)
      008847 26 D8            [ 1]  272     jrne 4$ 
      008849 CD 87 CD         [ 4]  273     call cursor_right
      00884C                        274 9$:
      0007CC                        275     _drop VAR_SIZE 
      00884C 5B 08            [ 2]    1     addw sp,#VAR_SIZE 
      00884E 85               [ 2]  276     popw x 
      00884F 90 85            [ 2]  277     popw y
      008851 81               [ 4]  278     ret 
                                    279 
                                    280 ;--------------------------
                                    281 ; put string on tv 
                                    282 ; input:
                                    283 ;   Y     *asciz 
                                    284 ;--------------------------
      008852                        285 tv_puts:
      008852 90 F6            [ 1]  286     ld a,(y)
      008854 27 07            [ 1]  287     jreq 9$
      008856 90 5C            [ 1]  288     incw y 
      008858 CD 87 D6         [ 4]  289     call tv_putc 
      00885B 20 F5            [ 2]  290     jra tv_puts 
      00885D                        291 9$:
      00885D 81               [ 4]  292     ret
                                    293 
                                    294 ;----------------------------
                                    295 ; print unsigned integer 
                                    296 ; input:
                                    297 ;    X uint16_t 
                                    298 ;-----------------------------
                           000001   299     UINT=1
                           000003   300     ISTR=UINT+2 
                           000008   301     VAR_SIZE=ISTR+5
      00885E                        302 put_uint16:
      00885E 90 89            [ 2]  303     pushw y 
      0007E0                        304     _vars VAR_SIZE 
      008860 52 08            [ 2]    1     sub sp,#VAR_SIZE 
      008862 1F 01            [ 2]  305     ldw (UINT,sp),x 
      008864 96               [ 1]  306     ldw x,sp 
      008865 1C 00 08         [ 2]  307     addw x,#ISTR+5
      008868 90 93            [ 1]  308     ldw y,x 
      00886A 90 7F            [ 1]  309     clr (y)
      00886C 1E 01            [ 2]  310     ldw x,(UINT,sp) 
      00886E 90 5A            [ 2]  311 1$: decw y 
      008870 A6 0A            [ 1]  312     ld a,#10 
      008872 62               [ 2]  313     div x,a 
      008873 AB 30            [ 1]  314     add a,#'0 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 73.
Hexadecimal [24-Bits]



      008875 90 F7            [ 1]  315     ld (y),a
      008877 5D               [ 2]  316     tnzw x 
      008878 26 F4            [ 1]  317     jrne 1$ 
      00887A CD 88 52         [ 4]  318     call tv_puts 
      0007FD                        319     _drop VAR_SIZE 
      00887D 5B 08            [ 2]    1     addw sp,#VAR_SIZE 
      00887F 90 85            [ 2]  320     popw y 
      008881 81               [ 4]  321     ret 
                                    322 
                                    323 ;-------------------------------
                                    324 ; line drawing 
                                    325 ;  X0<=X1 
                                    326 ;  Y0<=Y1 
                                    327 ; input:
                                    328 ;     XH  x0 
                                    329 ;     XL  x1 
                                    330 ;     YH  y0 
                                    331 ;     YL  y1 
                                    332 ;--------------------------------
                           000001   333     X0=1  ; int8 
                           000002   334     X1=2  ; int8 
                           000003   335     Y0=3  ; int8 
                           000004   336     Y1=4  ; int8 
                           000005   337     DX=5   ; int16 
                           000007   338     DY=7   ; int16 
                           000009   339     DELTA=9 ; int16 
                           00000A   340     VAR_SIZE=10
      008882                        341 line:
      000802                        342     _vars VAR_SIZE 
      008882 52 0A            [ 2]    1     sub sp,#VAR_SIZE 
      008884 1F 01            [ 2]  343     ldw (X0,sp),x
      008886 17 03            [ 2]  344     ldw (Y0,sp),y
      008888 9E               [ 1]  345     ld a,xh 
      008889 11 02            [ 1]  346     cp a,(X1,sp)
      00888B 27 41            [ 1]  347     jreq 3$ ; vertical line 
      00888D 90 9E            [ 1]  348     ld a,yh 
      00888F 11 04            [ 1]  349     cp a,(Y1,sp)
      008891 27 4E            [ 1]  350     jreq 4$ ; horizontal line
      008893 7B 02            [ 1]  351     ld a,(X1,sp)
      008895 10 01            [ 1]  352     sub a,(X0,sp)
      008897 5F               [ 1]  353     clrw x 
      008898 97               [ 1]  354     ld xl,a 
      008899 1F 05            [ 2]  355     ldw (DX,sp),x 
      00889B 7B 04            [ 1]  356     ld a,(Y1,sp)
      00889D 10 03            [ 1]  357     sub a,(Y0,sp)
      00889F 97               [ 1]  358     ld xl,a 
      0088A0 1F 07            [ 2]  359     ldw (DY,sp),x 
      0088A2 58               [ 2]  360     sllw x 
      0088A3 72 F0 05         [ 2]  361     subw x,(DX,sp)
      0088A6 1F 09            [ 2]  362     ldw (DELTA,sp),x 
      0088A8                        363 1$:  
      0088A8 7B 01            [ 1]  364     ld a,(X0,sp)
      0088AA 11 02            [ 1]  365     cp a,(X1,sp)
      0088AC 27 44            [ 1]  366     jreq 9$ 
      0088AE 97               [ 1]  367     ld xl,a 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 74.
Hexadecimal [24-Bits]



      0088AF 7B 03            [ 1]  368     ld a,(Y0,sp)
      0088B1 95               [ 1]  369     ld xh,a
      0088B2 CD 87 81         [ 4]  370     call set_pixel 
      0088B5 1E 09            [ 2]  371     ldw x,(DELTA,sp)
      0088B7 5D               [ 2]  372     tnzw x
      0088B8 2B 08            [ 1]  373     jrmi 2$
      0088BA 0C 03            [ 1]  374     inc (Y0,sp)
      0088BC 72 F0 05         [ 2]  375     subw x,(DX,sp)
      0088BF 72 F0 05         [ 2]  376     subw x,(DX,sp)
      0088C2                        377 2$: 
      0088C2 72 FB 07         [ 2]  378     addw x,(DY,sp)
      0088C5 72 FB 07         [ 2]  379     addw x,(DY,sp)
      0088C8 1F 09            [ 2]  380     ldw (DELTA,sp),x  
      0088CA 0C 01            [ 1]  381     inc (X0,sp)
      0088CC 20 DA            [ 2]  382     jra 1$
      0088CE                        383 3$: ; vertical line 
      0088CE 7B 01            [ 1]  384     ld a,(X0,sp)
      0088D0 97               [ 1]  385     ld xl,a 
      0088D1 7B 03            [ 1]  386     ld a,(Y0,sp)
      0088D3 95               [ 1]  387     ld xh,a 
      0088D4 CD 87 81         [ 4]  388     call set_pixel 
      0088D7 0C 03            [ 1]  389     inc (Y0,sp)
      0088D9 7B 03            [ 1]  390     ld a,(Y0,sp)
      0088DB 11 04            [ 1]  391     cp a,(Y1,sp)
      0088DD 25 EF            [ 1]  392     jrult 3$ 
      0088DF 20 11            [ 2]  393     jra 9$ 
      0088E1                        394 4$: ; horizontal line 
      0088E1 7B 01            [ 1]  395     ld a,(X0,sp)
      0088E3 97               [ 1]  396     ld xl, a 
      0088E4 7B 03            [ 1]  397     ld a,(Y0,sp)
      0088E6 95               [ 1]  398     ld xh,a 
      0088E7 CD 87 81         [ 4]  399     call set_pixel
      0088EA 0C 01            [ 1]  400     inc (X0,sp)
      0088EC 7B 01            [ 1]  401     ld a,(X0,sp)
      0088EE 11 02            [ 1]  402     cp a,(X1,sp)
      0088F0 25 EF            [ 1]  403     jrult 4$  
      0088F2                        404 9$:
      000872                        405     _drop VAR_SIZE 
      0088F2 5B 0A            [ 2]    1     addw sp,#VAR_SIZE 
      0088F4 81               [ 4]  406     ret 
                                    407 
                                    408 ;--------------------------------------
                                    409 ; use invert_pixel 
                                    410 ; to put sprite on screen 
                                    411 ; normal sprite are 8 bits wide 
                                    412 ; n rows 
                                    413 ; input:
                                    414 ;     A     row count 
                                    415 ;     XH    ycoord 
                                    416 ;     XL    xcoord
                                    417 ;     Y     sprite address  
                                    418 ; output:
                                    419 ;     A     collision if not null
                                    420 ;     Z     if not zero the collision  
                                    421 ;-------------------------------------
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 75.
Hexadecimal [24-Bits]



                           000001   422     ROWS=1
                           000002   423     SPRITE=ROWS+1 
                           000004   424     SHIFT=SPRITE+2
                           000005   425     COLL=SHIFT+1
                           000006   426     EDGE=COLL+1
                           000006   427     VAR_SIZE=EDGE
      0088F5                        428 put_sprite:
      000875                        429     _vars VAR_SIZE 
      0088F5 52 06            [ 2]    1     sub sp,#VAR_SIZE 
      0088F7 0F 05            [ 1]  430     clr (COLL,sp) 
      0088F9 6B 01            [ 1]  431     ld (ROWS,sp),a
      0088FB 0F 06            [ 1]  432     clr (EDGE,sp)
      0088FD 9F               [ 1]  433     ld a,xl  
      0088FE 44               [ 1]  434     srl a 
      0088FF 44               [ 1]  435     srl a  
      008900 44               [ 1]  436     srl a 
      008901 A1 18            [ 1]  437     cp a,#BYTES_PER_LINE-1
      008903 2B 02            [ 1]  438     jrmi 0$ 
      008905 03 06            [ 1]  439     cpl (EDGE,sp) 
      008907                        440 0$:  
      008907 CD 87 5B         [ 4]  441     call pixel_addr 
      00890A 6B 04            [ 1]  442     ld (SHIFT,sp),a
      00890C                        443 1$:    
      00890C 0F 03            [ 1]  444     clr (SPRITE+1,sp)
      00890E 90 F6            [ 1]  445     ld a,(y)
      008910 90 5C            [ 1]  446     incw y 
      008912 6B 02            [ 1]  447     ld (SPRITE,sp),a 
      008914 7B 04            [ 1]  448     ld a,(SHIFT,sp)
      008916 2B 07            [ 1]  449 2$: jrmi 4$
      008918                        450 3$: ; shift sprite and mask
      008918 04 02            [ 1]  451     srl (SPRITE,sp)
      00891A 06 03            [ 1]  452     rrc (SPRITE+1,sp)
      00891C 48               [ 1]  453     sll a
      00891D 2A F9            [ 1]  454     jrpl 3$ 
      00891F                        455 4$: 
      00891F 7B 02            [ 1]  456     ld a,(SPRITE,sp)
      008921 F8               [ 1]  457     xor a,(x)
      008922 F7               [ 1]  458     ld (x),a
      008923 14 02            [ 1]  459     and a,(SPRITE,sp)
      008925 11 02            [ 1]  460     cp a,(SPRITE,sp)
      008927 27 02            [ 1]  461     jreq 5$
      008929 0C 05            [ 1]  462     inc (COLL,sp)
      00892B 0D 06            [ 1]  463 5$: tnz (EDGE,sp) 
      00892D 26 0E            [ 1]  464     jrne 6$ 
      00892F 7B 03            [ 1]  465     ld a,(SPRITE+1,sp)
      008931 E8 01            [ 1]  466     xor a,(1,x)
      008933 E7 01            [ 1]  467     ld (1,x),a 
      008935 14 03            [ 1]  468     and a,(SPRITE+1,sp) 
      008937 11 03            [ 1]  469     cp a,(SPRITE+1,sp)
      008939 27 02            [ 1]  470     jreq 6$
      00893B 0C 05            [ 1]  471     inc (COLL,sp)
      00893D 1C 00 19         [ 2]  472 6$: addw x,#BYTES_PER_LINE 
      008940 0A 01            [ 1]  473     dec (ROWS,sp)
      008942 26 C8            [ 1]  474     jrne 1$
      008944 7B 05            [ 1]  475     ld a,(COLL,sp)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 76.
Hexadecimal [24-Bits]



      0008C6                        476     _drop VAR_SIZE 
      008946 5B 06            [ 2]    1     addw sp,#VAR_SIZE 
      008948 81               [ 4]  477     ret 
                                    478 
                                    479 
                                    480 ;---------------------
                                    481 ; scroll up 1 line 
                                    482 ; from [XL..XH[
                                    483 ; input: 
                                    484 ;   XL  first line 
                                    485 ;   XH  last line 
                                    486 ;---------------------
      008949                        487 scroll_up:
      008949 88               [ 1]  488     push a 
      00894A 90 89            [ 2]  489     pushw y 
      00894C 89               [ 2]  490     pushw x 
                                    491 ; move bytes count     
      00894D 9E               [ 1]  492     ld a,xh 
      00894E 10 02            [ 1]  493     sub a,(2,sp)
      008950 AE 00 19         [ 2]  494     ldw x,#BYTES_PER_LINE
      008953 42               [ 4]  495     mul x,a 
      008954 1D 00 19         [ 2]  496     subw x,#BYTES_PER_LINE 
      0008D7                        497     _strxz acc16 
      008957 BF E4                    1     .byte 0xbf,acc16 
                                    498 ; dest addr 
      008959 7B 02            [ 1]  499     ld a,(2,sp)
      00895B AE 00 19         [ 2]  500     ldw x,#BYTES_PER_LINE
      00895E 42               [ 4]  501     mul x, a 
      00895F 1C 04 C0         [ 2]  502     addw x,#tv_buffer
                                    503 ; source addr 
      008962 90 93            [ 1]  504     ldw y,x 
      008964 72 A9 00 19      [ 2]  505     addw y,#BYTES_PER_LINE
      008968 CD 8A 35         [ 4]  506     call move 
                                    507 ; clear line XH-1 
      00896B 7B 01            [ 1]  508     ld a,(1,sp)
      00896D 4A               [ 1]  509     dec a 
      00896E AE 00 19         [ 2]  510     ldw x,#BYTES_PER_LINE
      008971 90 93            [ 1]  511     ldw y,x 
      008973 90 42            [ 4]  512     mul y,a 
      008975 72 A9 04 C0      [ 2]  513     addw y,#tv_buffer
      008979 4F               [ 1]  514     clr a 
      00897A CD 8A 79         [ 4]  515     call fill  
      00897D 85               [ 2]  516     popw x  
      00897E 90 85            [ 2]  517     popw y 
      008980 84               [ 1]  518     pop a 
      008981 81               [ 4]  519     ret 
                                    520 
                                    521 ;----------------------
                                    522 ; scroll down 1 line 
                                    523 ; from [XL..XH[
                                    524 ; input:
                                    525 ;    XL   first line 
                                    526 ;    XH   last line 
                                    527 ;----------------------
      008982                        528 scroll_down: 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 77.
Hexadecimal [24-Bits]



      008982 88               [ 1]  529     push a 
      008983 90 89            [ 2]  530     pushw y 
      008985 89               [ 2]  531     pushw x 
                                    532 ; move bytes count 
      008986 9E               [ 1]  533     ld a,xh 
      008987 10 02            [ 1]  534     sub a,(2,sp) ; XL 
      008989 AE 00 19         [ 2]  535     ldw x,#BYTES_PER_LINE
      00898C 42               [ 4]  536     mul x,a
      00898D 1D 00 19         [ 2]  537     subw x,#BYTES_PER_LINE  
      000910                        538     _strxz acc16 
      008990 BF E4                    1     .byte 0xbf,acc16 
                                    539 ; source addr 
      008992 7B 02            [ 1]  540     ld a,(2,sp) ; XL 
      008994 90 AE 00 19      [ 2]  541     ldw y,#BYTES_PER_LINE
      008998 90 42            [ 4]  542     mul y,a 
      00899A 72 A9 04 C0      [ 2]  543     addw Y,#tv_buffer
                                    544 ; destinaton addr     
      00899E 93               [ 1]  545     ldw x,y 
      00899F 1C 00 19         [ 2]  546     addw x,#BYTES_PER_LINE 
      0089A2 CD 8A 35         [ 4]  547     call move 
                                    548 ; clear line XL 
      0089A5 7B 02            [ 1]  549     ld a,(2,sp) ; XL  
      0089A7 AE 00 19         [ 2]  550     ldw x,#BYTES_PER_LINE
      0089AA 90 93            [ 1]  551     ldw y,x 
      0089AC 90 42            [ 4]  552     mul y,a 
      0089AE 72 A9 04 C0      [ 2]  553     addw y,#tv_buffer
      0089B2 4F               [ 1]  554     clr a 
      0089B3 CD 8A 79         [ 4]  555     call fill  
      0089B6 85               [ 2]  556     popw x  
      0089B7 90 85            [ 2]  557     popw y 
      0089B9 84               [ 1]  558     pop a 
      0089BA 81               [ 4]  559     ret 
                                    560 
                                    561 ;------------------------------
                                    562 ; shift video line 
                                    563 ; 4 pixels left 
                                    564 ; input:
                                    565 ;    A   video line {0..VRES-1}
                                    566 ;-------------------------------
                                    567 
      0089BB                        568 left_4pixels:
      0089BB 89               [ 2]  569     pushw x 
      0089BC 90 89            [ 2]  570     pushw y 
      0089BE AE 00 19         [ 2]  571     ldw x,#BYTES_PER_LINE
      0089C1 90 93            [ 1]  572     ldw y,x 
      0089C3 42               [ 4]  573     mul x,a 
      0089C4 1C 04 C0         [ 2]  574     addw x,#tv_buffer
      0089C7                        575 1$:
      0089C7 F6               [ 1]  576     ld a,(x)
      0089C8 4E               [ 1]  577     swap a 
      0089C9 A4 F0            [ 1]  578     and a,#0xf0 
      0089CB 88               [ 1]  579     push a 
      0089CC E6 01            [ 1]  580     ld a,(1,x)
      0089CE 4E               [ 1]  581     swap a 
      0089CF A4 0F            [ 1]  582     and a,#0xf 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 78.
Hexadecimal [24-Bits]



      0089D1 1A 01            [ 1]  583     or a,(1,sp)
      000953                        584     _drop 1 
      0089D3 5B 01            [ 2]    1     addw sp,#1 
      0089D5 90 5A            [ 2]  585     decw y 
      0089D7 27 04            [ 1]  586     jreq 2$
      0089D9 F7               [ 1]  587     ld (x),a 
      0089DA 5C               [ 1]  588     incw x
      0089DB 20 EA            [ 2]  589     jra 1$
      0089DD A4 F0            [ 1]  590 2$: and a,#0xf0
      0089DF F7               [ 1]  591     ld (x),a 
      0089E0 90 85            [ 2]  592     popw y 
      0089E2 85               [ 2]  593     popw x 
      0089E3 81               [ 4]  594     ret 
                                    595 
                                    596 ;-------------------
                                    597 ; scroll left  4 pixels
                                    598 ; from [XL..XH[ 
                                    599 ; input:
                                    600 ;   XL   first line 
                                    601 ;   XH   last line 
                                    602 ;-------------------
      0089E4                        603 scroll_left:
      0089E4 89               [ 2]  604     pushw x 
      0089E5 7B 02            [ 1]  605     ld a,(2,sp)
      0089E7                        606 1$:
      0089E7 CD 89 BB         [ 4]  607     call left_4pixels 
      0089EA 0C 02            [ 1]  608     inc (2,sp)
      0089EC 7B 02            [ 1]  609     ld a,(2,sp)
      0089EE 11 01            [ 1]  610     cp a,(1,sp)
      0089F0 2B F5            [ 1]  611     jrmi 1$
      0089F2 85               [ 2]  612     popw x 
      0089F3 81               [ 4]  613     ret 
                                    614 
                                    615 ;-------------------
                                    616 ; shift video line 
                                    617 ; 4 pixels right 
                                    618 ; input:
                                    619 ;     A   line 
                                    620 ;-------------------
      0089F4                        621 right_4pixels:
      0089F4 90 89            [ 2]  622     pushw y 
      0089F6 89               [ 2]  623     pushw x 
      0089F7 4C               [ 1]  624     inc a 
      0089F8 AE 00 19         [ 2]  625     ldw x,#BYTES_PER_LINE
      0089FB 90 93            [ 1]  626     ldw y,x 
      0089FD 42               [ 4]  627     mul x,a
      0089FE 1D 00 02         [ 2]  628     subw x,#2  
      008A01 1C 04 C0         [ 2]  629     addw x,#tv_buffer 
      008A04 E6 01            [ 1]  630 1$: ld a,(1,x)
      008A06 A4 F0            [ 1]  631     and a,#0xf0
      008A08 4E               [ 1]  632     swap a 
      008A09 88               [ 1]  633     push a
      008A0A F6               [ 1]  634     ld a,(x)
      008A0B A4 0F            [ 1]  635     and a,#0xf 
      008A0D 4E               [ 1]  636     swap a 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 79.
Hexadecimal [24-Bits]



      008A0E 1A 01            [ 1]  637     or a,(1,sp)
      008A10 E7 01            [ 1]  638     ld (1,x),a
      000992                        639     _drop 1
      008A12 5B 01            [ 2]    1     addw sp,#1 
      008A14 90 5A            [ 2]  640     decw y 
      008A16 27 03            [ 1]  641     jreq 2$ 
      008A18 5A               [ 2]  642     decw x 
      008A19 20 E9            [ 2]  643     jra 1$
      008A1B A6 0F            [ 1]  644 2$: ld a,#0xf 
      008A1D E4 01            [ 1]  645     and a,(1,x)
      008A1F E7 01            [ 1]  646     ld (1,x),a 
      008A21 85               [ 2]  647     popw x 
      008A22 90 85            [ 2]  648     popw y 
      008A24 81               [ 4]  649     ret 
                                    650 
                                    651 ;-------------------
                                    652 ; scroll right 
                                    653 ; 4 pixels 
                                    654 ; input:
                                    655 ;   XL   first line 
                                    656 ;   XH   last line 
                                    657 ;-------------------
      008A25                        658 scroll_right:
      008A25 89               [ 2]  659     pushw x 
      008A26 7B 02            [ 1]  660     ld a,(2,sp)
      008A28                        661 1$: 
      008A28 CD 89 F4         [ 4]  662     call right_4pixels 
      008A2B 0C 02            [ 1]  663     inc (2,sp)
      008A2D 7B 02            [ 1]  664     ld a,(2,sp)
      008A2F 11 01            [ 1]  665     cp a,(1,sp)
      008A31 2B F5            [ 1]  666     jrmi 1$
      008A33 85               [ 2]  667     popw x 
      008A34 81               [ 4]  668     ret 
                                    669 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 80.
Hexadecimal [24-Bits]



                                      1 ;---------------------------------------
                                      2 ; move memory block 
                                      3 ; input:
                                      4 ;   X 		destination 
                                      5 ;   Y 	    source 
                                      6 ;   acc16	bytes count 
                                      7 ; output:
                                      8 ;   X       destination 
                                      9 ;--------------------------------------
                           000001    10 	INCR=1 ; incrament high byte 
                           000002    11 	LB=2 ; increment low byte 
                           000002    12 	VSIZE=2
      008A35                         13 move::
      008A35 88               [ 1]   14 	push a 
      008A36 89               [ 2]   15 	pushw x 
      0009B7                         16 	_vars VSIZE 
      008A37 52 02            [ 2]    1     sub sp,#VSIZE 
      008A39 0F 01            [ 1]   17 	clr (INCR,sp)
      008A3B 0F 02            [ 1]   18 	clr (LB,sp)
      008A3D 90 89            [ 2]   19 	pushw y 
      008A3F 13 01            [ 2]   20 	cpw x,(1,sp) ; compare DEST to SRC 
      008A41 90 85            [ 2]   21 	popw y 
      008A43 27 2F            [ 1]   22 	jreq move_exit ; x==y 
      008A45 2B 0E            [ 1]   23 	jrmi move_down
      008A47                         24 move_up: ; start from top address with incr=-1
      008A47 72 BB 00 E4      [ 2]   25 	addw x,acc16
      008A4B 72 B9 00 E4      [ 2]   26 	addw y,acc16
      008A4F 03 01            [ 1]   27 	cpl (INCR,sp)
      008A51 03 02            [ 1]   28 	cpl (LB,sp)   ; increment = -1 
      008A53 20 05            [ 2]   29 	jra move_loop  
      008A55                         30 move_down: ; start from bottom address with incr=1 
      008A55 5A               [ 2]   31     decw x 
      008A56 90 5A            [ 2]   32 	decw y
      008A58 0C 02            [ 1]   33 	inc (LB,sp) ; incr=1 
      008A5A                         34 move_loop:	
      0009DA                         35     _ldaz acc16 
      008A5A B6 E4                    1     .byte 0xb6,acc16 
      008A5C CA 00 E5         [ 1]   36 	or a, acc8
      008A5F 27 13            [ 1]   37 	jreq move_exit 
      008A61 72 FB 01         [ 2]   38 	addw x,(INCR,sp)
      008A64 72 F9 01         [ 2]   39 	addw y,(INCR,sp) 
      008A67 90 F6            [ 1]   40 	ld a,(y)
      008A69 F7               [ 1]   41 	ld (x),a 
      008A6A 89               [ 2]   42 	pushw x 
      0009EB                         43 	_ldxz acc16 
      008A6B BE E4                    1     .byte 0xbe,acc16 
      008A6D 5A               [ 2]   44 	decw x 
      008A6E CF 00 E4         [ 2]   45 	ldw acc16,x 
      008A71 85               [ 2]   46 	popw x 
      008A72 20 E6            [ 2]   47 	jra move_loop
      008A74                         48 move_exit:
      0009F4                         49 	_drop VSIZE
      008A74 5B 02            [ 2]    1     addw sp,#VSIZE 
      008A76 85               [ 2]   50 	popw x 
      008A77 84               [ 1]   51 	pop a 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 81.
Hexadecimal [24-Bits]



      008A78 81               [ 4]   52 	ret 	
                                     53 
                                     54 ;--------------------
                                     55 ; fill memory block 
                                     56 ; input: 
                                     57 ;     A   fill value 
                                     58 ;     X   count 
                                     59 ;     Y   addr (incr)
                                     60 ;---------------------
      008A79                         61 fill:
      008A79 90 F7            [ 1]   62 	ld (y),a 
      008A7B 90 5C            [ 1]   63 	incw y 
      008A7D 5A               [ 2]   64 	decw x 
      008A7E 26 F9            [ 1]   65 	jrne fill
      008A80 81               [ 4]   66 	ret 
                                     67 
                                     68 ;------------------------
                                     69 ; load bitmap data in 
                                     70 ; tv_buffer 
                                     71 ; image is upside down 
                                     72 ; input:
                                     73 ;    A   byte per ROW
                                     74 ;    X   data size 
                                     75 ;    Y   data address 
                                     76 ;------------------------
                           000001    77 	YCOOR=1 ; video graphic row 
                           000003    78 	COUNT=YCOOR+2 ; data size 
                           000005    79 	ROW_CNTR=COUNT+2 ; bytes per row 
                           000006    80 	VAR_SIZE=ROW_CNTR+1
      008A81                         81 load_bmp:
      000A01                         82 	_vars VAR_SIZE
      008A81 52 06            [ 2]    1     sub sp,#VAR_SIZE 
      008A83 0F 05            [ 1]   83 	clr (ROW_CNTR,sp)
      008A85 6B 06            [ 1]   84 	ld (ROW_CNTR+1,sp),a  
      008A87 1F 03            [ 2]   85 	ldw (COUNT,sp),x
      008A89 AE 00 C0         [ 2]   86 	ldw x,#VRES 
      008A8C 1F 01            [ 2]   87 	ldw (YCOOR,sp),x 
      008A8E                         88 1$: ; copy ROW_CNTR bytes 
      008A8E 0A 02            [ 1]   89 	dec (YCOOR+1,sp)
      008A90 27 1D            [ 1]   90 	jreq 9$
      008A92 1E 01            [ 2]   91 	ldw x,(YCOOR,sp) 
      008A94 7B 06            [ 1]   92 	ld a,(ROW_CNTR+1,sp)
      000A16                         93 	_straz acc8 
      008A96 B7 E5                    1     .byte 0xb7,acc8 
      008A98 42               [ 4]   94 	mul x,a 
      008A99 1C 04 C0         [ 2]   95 	addw x,#tv_buffer
      008A9C 90 F6            [ 1]   96 2$: ld a,(y)
      008A9E F7               [ 1]   97 	ld (x),a 
      008A9F 5C               [ 1]   98 	incw x 
      008AA0 90 5C            [ 1]   99 	incw y 
      000A22                        100 	_decz acc8 
      008AA2 3A E5                    1     .byte 0x3a,acc8 
      008AA4 26 F6            [ 1]  101 	jrne 2$
      008AA6 1E 03            [ 2]  102 	ldw x,(COUNT,sp)
      008AA8 72 F0 05         [ 2]  103 	subw x,(ROW_CNTR,sp)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 82.
Hexadecimal [24-Bits]



      008AAB 1F 03            [ 2]  104 	ldw (COUNT,sp),x
      008AAD 22 DF            [ 1]  105 	jrugt 1$ 
      000A2F                        106 9$:	_drop VAR_SIZE
      008AAF 5B 06            [ 2]    1     addw sp,#VAR_SIZE 
      008AB1 81               [ 4]  107 	ret 
                                    108 
                           000001   109 SCROLL_DLY=1
                                    110 ;------------------------
                                    111 ; scroll up 8 row 
                                    112 ; with 1/3 second delay 
                                    113 ;------------------------
      008AB2                        114 scroll_8:
      008AB2 4B 08            [ 1]  115 	push #8 
      008AB4 A6 01            [ 1]  116 1$: ld a,#SCROLL_DLY 
      008AB6 CD 80 B3         [ 4]  117 	call pause 
      008AB9 AE C0 00         [ 2]  118 	ldw x,#VRES<<8
      008ABC CD 89 49         [ 4]  119 	call scroll_up 
      008ABF 0A 01            [ 1]  120 	dec (1,sp)
      008AC1 26 F1            [ 1]  121 	jrne 1$ 
      000A43                        122 	_drop 1 
      008AC3 5B 01            [ 2]    1     addw sp,#1 
      008AC5 81               [ 4]  123 	ret 
                                    124 
                                    125 ;------------------------
                                    126 ; print version string 
                                    127 ;-----------------------
      008AC6                        128 put_version:
      008AC6 A6 56            [ 1]  129 	ld a,#'V 
      008AC8 CD 87 D6         [ 4]  130 	call tv_putc
      008ACB AE 00 01         [ 2]  131 	ldw x,#MAJOR 
      008ACE CD 88 5E         [ 4]  132 	call put_uint16
      008AD1 A6 2E            [ 1]  133 	ld a,#'. 
      008AD3 CD 87 D6         [ 4]  134 	call tv_putc 
      008AD6 AE 00 01         [ 2]  135 	ldw x,#MINOR
      008AD9 CD 88 5E         [ 4]  136 	call put_uint16
      008ADC A6 52            [ 1]  137 	ld a,#'R 
      008ADE CD 87 D6         [ 4]  138 	call tv_putc 
      008AE1 AE 00 00         [ 2]  139 	ldw x,#REV 
      008AE4 CD 88 5E         [ 4]  140 	call put_uint16
      008AE7 81               [ 4]  141 	ret 
                                    142 
      008AE8 53 54 4D 38 20 67 61   143 version_str: .asciz "STM8 game console, "
             6D 65 20 63 6F 6E 73
             6F 6C 65 2C 20 00
      008AFC 28 43 29 20 4A 61 63   144 cright: .asciz "(C) Jacques Deschenes, 2023,24"
             71 75 65 73 20 44 65
             73 63 68 65 6E 65 73
             2C 20 32 30 32 33 2C
             32 34 00
                                    145 
                                    146 ;--------------------------
                                    147 ; application entry point 
                                    148 ;--------------------------
      008B1B                        149 main:
                           000000   150 .if DEBUG 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 83.
Hexadecimal [24-Bits]



                                    151 .if NUCLEO
                                    152 	call uart_cls 
                                    153 	ldw x,#version_str 
                                    154 	call uart_puts
                                    155 	ld a,#CR 
                                    156 	call uart_putc
                                    157 .endif ;; NUCLEO 
                                    158 .endif ;; DEBUG 
      008B1B CD 80 FC         [ 4]  159 	call beep
      008B1E CD 87 35         [ 4]  160 	call tv_cls
                                    161 ; show splash screen 
      008B21 A6 19            [ 1]  162 	ld a,#BYTES_PER_IMG_ROW
      008B23 AE 12 C0         [ 2]  163 	ldw x,#IMG_DATA_SIZE
      008B26 90 AE 8C 22      [ 2]  164 	ldw y,#img_data
      008B2A CD 8A 81         [ 4]  165 	call load_bmp
      008B2D CD 8A B2         [ 4]  166 	call scroll_8 
      008B30 CD 8A B2         [ 4]  167 	call scroll_8
      008B33 A6 17            [ 1]  168 	ld a,#LINE_PER_SCREEN-1 
      000AB5                        169 	_straz cy 
      008B35 B7 F3                    1     .byte 0xb7,cy 
      000AB7                        170 	_clrz cx 
      008B37 3F F4                    1     .byte 0x3f, cx 
      008B39 90 AE 8A E8      [ 2]  171 	ldw y,#version_str 
      008B3D CD 88 52         [ 4]  172 	call tv_puts
      008B40 CD 8A C6         [ 4]  173 	call put_version
      008B43 CD 8A B2         [ 4]  174 	call scroll_8 
      008B46 A6 17            [ 1]  175 	ld a,#LINE_PER_SCREEN-1
      000AC8                        176 	_straz cy 
      008B48 B7 F3                    1     .byte 0xb7,cy 
      000ACA                        177 	_clrz cx 
      008B4A 3F F4                    1     .byte 0x3f, cx 
      008B4C 90 AE 8A FC      [ 2]  178 	ldw y,#cright 
      008B50 CD 88 52         [ 4]  179 	call tv_puts
      008B53 4B C0            [ 1]  180 	push #VRES 
      008B55 A6 01            [ 1]  181 1$: ld a,#SCROLL_DLY
      008B57 CD 80 B3         [ 4]  182 	call pause 
      008B5A CD 81 4D         [ 4]  183 	call kpad_input 
      008B5D 26 0D            [ 1]  184 	jrne 2$ 
      008B5F 90 AE C0 00      [ 2]  185 	ldw y,#VRES<<8 
      008B63 CD 89 49         [ 4]  186 	call scroll_up
      008B66 0A 01            [ 1]  187 	dec (1,sp)
      008B68 26 EB            [ 1]  188 	jrne 1$ 
      000AEA                        189 	_drop 1
      008B6A 5B 01            [ 2]    1     addw sp,#1 
      008B6C                        190 2$:
      008B6C 90 AE 8C 08      [ 2]  191 	ldw y,#prog_list
      008B70 CD 8B 76         [ 4]  192     call menu 
      008B73 FD               [ 4]  193     call (x)
      008B74 20 F6            [ 2]  194     jra 2$ 
                                    195 
                                    196 ;---------------------------
                                    197 ; display list of games
                                    198 ; input:
                                    199 ;    Y   menu items 
                                    200 ;--------------------------
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 84.
Hexadecimal [24-Bits]



                           000001   201 	GAM_ADR=1
                           000011   202 	KPAD=GAM_ADR+16
                           000012   203 	SEL=KPAD+1 
                           000013   204 	COUNT=SEL+1
                           000013   205 	VAR_SIZE=COUNT 	
      008B76                        206 menu:
      000AF6                        207 	_vars VAR_SIZE 
      008B76 52 13            [ 2]    1     sub sp,#VAR_SIZE 
      008B78 0F 12            [ 1]  208 	clr (SEL,sp)
      008B7A 0F 13            [ 1]  209 	clr (COUNT,sp)
      008B7C 96               [ 1]  210 	ldw x,sp 
      008B7D 5C               [ 1]  211 	incw x 
      000AFE                        212 	_strxz ptr16 
      008B7E BF E8                    1     .byte 0xbf,ptr16 
      008B80 CD 87 35         [ 4]  213 	call tv_cls  
                                    214 ; build games list on stack     
      008B83 90 F6            [ 1]  215 1$: ld a,(y)
      008B85 27 27            [ 1]  216     jreq user_select 
      008B87 7B 13            [ 1]  217 	ld a,(COUNT,sp)
      008B89 95               [ 1]  218 	ld xh,a 
      008B8A A6 20            [ 1]  219 	ld a,#SPACE  
      008B8C CD 8B FE         [ 4]  220 	call select_mark 
      008B8F CD 88 52         [ 4]  221 	call tv_puts  
      008B92 90 5C            [ 1]  222 	incw y 
      008B94 7B 13            [ 1]  223 	ld a,(COUNT,sp)
      008B96 48               [ 1]  224 	sll a 
      008B97 5F               [ 1]  225 	clrw x 
      008B98 97               [ 1]  226 	ld xl,a 
      008B99 90 F6            [ 1]  227 	ld a,(y)
      008B9B 90 5C            [ 1]  228 	incw y 
      008B9D 72 D7 00 E8      [ 4]  229 	ld ([ptr16],X),a 
      008BA1 5C               [ 1]  230 	incw x 
      008BA2 90 F6            [ 1]  231 	ld a,(y)
      008BA4 90 5C            [ 1]  232 	incw y 
      008BA6 72 D7 00 E8      [ 4]  233 	ld ([ptr16],x),a
      008BAA 0C 13            [ 1]  234 	inc (COUNT,sp)
      008BAC 20 D5            [ 2]  235 	jra 1$ 
                                    236 ; display selection cursor and 
                                    237 ; wait for user input    
      008BAE                        238 user_select:
      008BAE AE 02 00         [ 2]  239     ldw x,#0x200 
      008BB1 CD 81 7E         [ 4]  240 	call wait_key_release
      008BB4 7B 12            [ 1]  241 	ld a,(SEL,sp)
      008BB6 95               [ 1]  242 	ld xh,a 
      008BB7 A6 3E            [ 1]  243 	ld a,#'>
      008BB9 CD 8B FE         [ 4]  244 	call select_mark
      008BBC CD 81 78         [ 4]  245 	call wait_key 
      008BBF 6B 11            [ 1]  246 	ld (KPAD,sp),a
      008BC1 7B 12            [ 1]  247 	ld a,(SEL,sp)
      008BC3 95               [ 1]  248 	ld xh,a
      008BC4 A6 20            [ 1]  249 	ld a,#SPACE 
      008BC6 CD 8B FE         [ 4]  250 	call select_mark
      008BC9 7B 11            [ 1]  251 	ld a,(KPAD,sp)
      008BCB A4 02            [ 1]  252 	and a,#BTN_DOWN ; down button? 
      008BCD 27 0B            [ 1]  253 	jreq 4$ 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 85.
Hexadecimal [24-Bits]



                                    254 ; down button 
      008BCF 7B 12            [ 1]  255 	ld a,(SEL,sp)
      008BD1 4C               [ 1]  256 	inc a 
      008BD2 11 13            [ 1]  257 	cp a,(COUNT,sp)
      008BD4 27 D8            [ 1]  258 	jreq user_select
      008BD6 6B 12            [ 1]  259 	ld (SEL,sp),a 
      008BD8 20 D4            [ 2]  260 	jra user_select 
                                    261 ; up button ?
      008BDA                        262 4$: 
      008BDA 7B 11            [ 1]  263 	ld a,(KPAD,sp)
      008BDC A4 08            [ 1]  264 	and a,#BTN_UP
      008BDE 27 09            [ 1]  265 	jreq 6$ 
      008BE0 7B 12            [ 1]  266 	ld a,(SEL,sp)
      008BE2 4A               [ 1]  267 	dec a 
      008BE3 2B C9            [ 1]  268 	jrmi user_select 
      008BE5 6B 12            [ 1]  269 	ld (SEL,sp),a 
      008BE7 20 C5            [ 2]  270 	jra user_select 
      008BE9                        271 6$:
      008BE9 7B 11            [ 1]  272 	ld a,(KPAD,sp)
      008BEB A4 20            [ 1]  273 	and a,#BTN_A
      008BED 27 BF            [ 1]  274 	jreq user_select
      008BEF CD 81 7E         [ 4]  275 	call wait_key_release 
      008BF2 7B 12            [ 1]  276 	ld a,(SEL,sp)
      008BF4 48               [ 1]  277 	sll a 
      008BF5 5F               [ 1]  278 	clrw x 
      008BF6 97               [ 1]  279 	ld xl,a 
      008BF7 72 DE 00 E8      [ 5]  280 	ldw x,([ptr16],x)
      000B7B                        281 	_drop VAR_SIZE 
      008BFB 5B 13            [ 2]    1     addw sp,#VAR_SIZE 
      008BFD 81               [ 4]  282 	ret 
                                    283 
                                    284 ;-------------------------------
                                    285 ; display or erase 
                                    286 ; selection marker 
                                    287 ; input:
                                    288 ;    A    char to diplay 
                                    289 ;    XH   selected item {0..7}
                                    290 ;------------------------------
      008BFE                        291 select_mark:
      008BFE 88               [ 1]  292     push a 
      008BFF 4F               [ 1]  293     clr a 
      008C00 97               [ 1]  294     ld xl,a 
      000B81                        295 	_strxz cy 
      008C01 BF F3                    1     .byte 0xbf,cy 
      008C03 84               [ 1]  296     pop a 
      008C04 CD 87 D6         [ 4]  297 	call tv_putc 
      008C07 81               [ 4]  298 	ret 
                                    299 
                                    300 
      008C08                        301 prog_list:
                                    302 ; a snake game variation
      008C08 53 4E 41 4B 45 00      303 .asciz "SNAKE"
      008C0E A2 1D                  304 .word snake
                                    305 ; John Conway game of life simulation
      008C10 43 4F 4E 57 41 59 00   306 .asciz "CONWAY"
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 86.
Hexadecimal  A5-Bits]



      008C18 D8 46                  307 .word game_of_life
                                    308 ; tetris like game 
      008C1A 41 4C 4C 00 A3         309 .asciz "FALL"
      008C1F 62 00                  310 .word fall
      008C21 00 00                  311 .word 0 
                                    312 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 87.
Hexadecimal [24-Bits]



                                      1 ;----------------------
                                      2 ;  splash screen
                                      3 ;----------------------
                           000019     4 BYTES_PER_IMG_ROW=25
                           0012C0     5 IMG_DATA_SIZE=4800
                                      6 	.area CODE
                                      7 
      008C22                          8 img_data:
      008C22 BF F5 57 50 00 05 80     9 	.byte 0xBF, 0xF5, 0x57, 0x50, 0x00, 0x05, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00, 0x04, 0xD5, 0xEB, 0xFD, 0xFF, 0xDD, 0xFF
             00 00 00 00 00 00 00
             03 00 00 00 04 D5 EB
             FD FF DD FF
      008C3B D5 5F F9 00 00 08 20    10 	.byte 0xD5, 0x5F, 0xF9, 0x00, 0x00, 0x08, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x02, 0xBE, 0xAA, 0xFF, 0xFF, 0xFF, 0xEB
             00 00 00 00 00 00 00
             02 00 00 00 02 BE AA
             FF FF FF EB
      008C54 7F F5 6E A0 00 02 80    11 	.byte 0x7F, 0xF5, 0x6E, 0xA0, 0x00, 0x02, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x4B, 0xD7, 0xB7, 0xB5, 0x77, 0x7F
             00 00 00 00 00 00 00
             01 00 00 00 00 4B D7
             B7 B5 77 7F
      008C6D D5 5F DA 00 00 00 00    12 	.byte 0xD5, 0x5F, 0xDA, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x35, 0x6B, 0xFE, 0xFF, 0xFD, 0xDF
             00 00 00 00 00 00 00
             02 00 00 00 00 35 6B
             FE FF FD DF
      008C86 BF FB 76 80 00 00 00    13 	.byte 0xBF, 0xFB, 0x76, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0F, 0xD5, 0xFF, 0xFF, 0xDF, 0xFB
             00 00 00 00 00 00 00
             00 00 00 00 00 0F D5
             FF FF DF FB
      008C9F D5 5E DA 00 00 00 00    14 	.byte 0xD5, 0x5E, 0xDA, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x2A, 0xD7, 0x5B, 0xDB, 0x77, 0xBF
             00 00 00 00 00 00 00
             00 00 00 00 00 2A D7
             5B DB 77 BF
      008CB8 7F FB 6A 80 00 00 00    15 	.byte 0x7F, 0xFB, 0x6A, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x07, 0xA1, 0xFF, 0x7F, 0xFE, 0xFF
             00 00 00 00 00 00 00
             00 00 00 00 00 07 A1
             FF 7F FE FF
      008CD1 D5 57 D2 00 00 00 00    16 	.byte 0xD5, 0x57, 0xD2, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x15, 0x56, 0xFF, 0xFD, 0xDF, 0xEB
             00 00 00 00 00 00 00
             00 00 00 00 00 15 56
             FF FD DF EB
      008CEA BF FD 74 00 00 00 00    17 	.byte 0xBF, 0xFD, 0x74, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x81, 0xB7, 0xDF, 0xFD, 0xBF
             00 00 00 00 00 00 00
             00 00 00 00 00 02 81
             B7 DF FD BF
      008D03 EA AF D8 00 00 00 00    18 	.byte 0xEA, 0xAF, 0xD8, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x04, 0x45, 0xFE, 0xF7, 0x77, 0xFF
             00 00 00 00 00 00 00
             00 00 00 00 00 04 45
             FE F7 77 FF
      008D1C 5F FD 6A 00 00 00 00    19 	.byte 0x5F, 0xFD, 0x6A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x00, 0x00, 0x01, 0x00, 0xBF, 0xFF, 0xFF, 0xEF
             00 00 00 00 00 00 00
             00 00 80 00 00 01 00
             BF FF FF EF
      008D35 EA AF D4 00 00 00 00    20 	.byte 0xEA, 0xAF, 0xD4, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0xFB, 0xEE, 0xEE, 0xBB
             00 00 00 00 00 00 00
             00 00 00 00 00 00 01
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 88.
Hexadecimal  FB-Bits]



             FB EE EE BB
      008D4B EE EE BB BF FD B8 00    21 	.byte 0xBF, 0xFD, 0xB8, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x2F, 0x7F, 0xFF, 0xFF
             00 00 00 00 00 00 00
             00 00 00 00 00 00 00
             00 00 00 2F
      008D64 7F FF FF D5 6F 64 00    22 	.byte 0xD5, 0x6F, 0x64, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0xFF, 0xFB, 0xBB, 0xF7
             00 00 00 00 00 00 00
             00 00 00 00 00 00 00
             00 00 01 FF
      008D7D FB BB F7 7F B5 D8 00    23 	.byte 0x7F, 0xB5, 0xD8, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x37, 0xDF, 0xFF, 0x7F
             00 00 00 00 00 00 00
             00 00 01 00 00 00 00
             00 00 00 37
      008D96 DF FF 7F AB FE A2 00    24 	.byte 0xAB, 0xFE, 0xA2, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFE, 0xF7, 0x77, 0xDF
             00 00 00 00 00 00 00
             00 40 00 00 00 00 00
             00 00 00 FE
      008DAF F7 77 DF FD 55 A8 00    25 	.byte 0xFD, 0x55, 0xA8, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x5F, 0xFF, 0xFF, 0xF7
             00 00 00 00 00 00 00
             00 00 00 80 00 00 00
             00 00 01 5F
      008DC8 FF FF F7 AF FF 40 00    26 	.byte 0xAF, 0xFF, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x14, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFB, 0xDE, 0xEE, 0xFF
             00 00 00 00 00 00 00
             00 00 14 00 00 00 00
             00 00 00 FB
      008DE1 DE EE FF FB AD 68 00    27 	.byte 0xFB, 0xAD, 0x68, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x2F, 0xFF, 0xFF, 0xBB
             00 00 00 00 00 00 00
             00 00 01 00 00 00 00
             00 00 00 2F
      008DFA FF FF BB AE FA 80 00    28 	.byte 0xAE, 0xFA, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x77, 0xBB, 0xFF
             00 00 00 00 00 00 00
             00 00 0A 00 00 00 00
             00 00 00 FF
      008E13 77 BB FF FB 77 50 00    29 	.byte 0xFB, 0x77, 0x50, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1B, 0xFD, 0xFF, 0x6F
             00 00 00 00 00 00 00
             00 00 00 08 00 00 00
             00 00 00 1B
      008E2C FD FF 6F BF DD 00 00    30 	.byte 0xBF, 0xDD, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x04, 0xA0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0xDF, 0x77, 0xFF
             00 00 00 00 00 00 00
             00 01 04 A0 00 00 00
             00 00 00 FF
      008E45 DF 77 FF ED 7B 40 00    31 	.byte 0xED, 0x7B, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x15, 0x52, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x2E, 0xFF, 0xFF, 0xF7
             00 00 00 00 00 00 00
             00 00 15 52 00 00 00
             00 00 00 2E
      008E5E FF FF F7 BB DE 80 00    32 	.byte 0xBB, 0xDE, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x05, 0x36, 0xA0, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x7F, 0xFD, 0xEE, 0xBD
             00 00 00 00 00 00 00
             00 05 36 A0 40 00 00
             00 00 00 7F
      008E77 FD EE BD EF 6B A0 00    33 	.byte 0xEF, 0x6B, 0xA0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x2D, 0xD5, 0x50, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1B, 0xB7, 0xBF, 0xFF
             00 00 00 00 00 00 00
             00 00 2D D5 50 00 00
             00 00 00 1B
      008E90 B7 BF FF BB FE 00 00    34 	.byte 0xBB, 0xFE, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x05, 0x5A, 0xBB, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0xFD, 0xF7
             00 00 00 00 00 00 00
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 89.
Hexadecimal  00-Bits]



             BB 40 00 00 00 00 00
             FF FF FD F7
      008E9F 05 5A BB 40 00 00 00    35 	.byte 0xEF, 0xAD, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x6F, 0xD6, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x2E, 0xFD, 0xEF, 0xBF
             00 00 FF FF FD F7 EF
             AD C0 00 00 00 00 00
             00 00 00 00
      008EB8 00 6F D6 80 00 00 00    36 	.byte 0xBA, 0xFA, 0xA0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x05, 0x5A, 0xBB, 0x00, 0x00, 0x00, 0x00, 0x40, 0x00, 0xFF, 0xDF, 0xFB, 0xEF
             00 00 2E FD EF BF BA
             FA A0 00 00 00 00 00
             00 00 00 00
      008ED1 05 5A BB 00 00 00 00    37 	.byte 0xEF, 0x6F, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x12, 0xEE, 0xAC, 0x00, 0x00, 0x00, 0x1B, 0xB4, 0x00, 0x2F, 0xF7, 0xBF, 0xFF
             40 00 FF DF FB EF EF
             6F 40 00 00 00 00 00
             00 00 00 00
      008EEA 12 EE AC 00 00 00 1B    38 	.byte 0xBB, 0xFA, 0x90, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x06, 0xB5, 0x52, 0x05, 0x00, 0x05, 0xFF, 0xFE, 0x80, 0xBB, 0x7E, 0xEE, 0xDB
             B4 00 2F F7 BF FF BB
             FA 90 00 00 00 00 00
             00 00 00 00
      008F03 06 B5 52 05 00 05 FF    39 	.byte 0xEF, 0xAF, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x11, 0x5A, 0xAD, 0x5A, 0x80, 0x57, 0xEC, 0x02, 0x80, 0x2F, 0xFF, 0xFF, 0xFF
             FE 80 BB 7E EE DB EF
             AF 40 00 00 00 00 00
             00 00 00 00
      008F1C 11 5A AD 5A 80 57 EC    40 	.byte 0xBA, 0xFA, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x25, 0x6A, 0xAA, 0xEA, 0x20, 0xBF, 0x52, 0x17, 0xE0, 0x7F, 0xF7, 0xDB, 0xBF
             02 80 2F FF FF FF BA
             FA 00 00 00 00 00 00
             00 00 00 00
      008F35 25 6A AA EA 20 BF 52    41 	.byte 0xEF, 0xD7, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x8A, 0xDA, 0xAB, 0x55, 0x43, 0xF5, 0x60, 0x4A, 0xB4, 0x55, 0xBD, 0xFF, 0xF7
             17 E0 7F F7 DB BF EF
             D7 80 00 00 00 00 00
             00 00 00 00
      008F4E 8A DA AB 55 43 F5 60    42 	.byte 0xBA, 0xFD, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x6A, 0xB6, 0xDA, 0xAA, 0xAD, 0xFD, 0x08, 0x01, 0x7C, 0x3F, 0xFF, 0x7E, 0xFF
             4A B4 55 BD FF F7 BA
             FD 20 00 00 00 00 00
             00 00 00 00
      008F67 6A B6 DA AA AD FD 08    43 	.byte 0xEF, 0xD6, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x17, 0xD5, 0xB5, 0x6A, 0xAF, 0x5B, 0xF2, 0x04, 0x0F, 0x5F, 0xEF, 0xFB, 0xDB
             01 7C 3F FF 7E FF EF
             D6 80 00 00 00 00 00
             00 00 00 01
      008F80 17 D5 B5 6A AF 5B F2    44 	.byte 0xBA, 0xFC, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x5D, 0x7A, 0xEE, 0xA9, 0x7F, 0xF6, 0xDA, 0x40, 0x07, 0x37, 0x7D, 0xDF, 0xFF
             04 0F 5F EF FB DB BA
             FC 80 00 00 00 00 00
             00 00 00 10
      008F99 5D 7A EE A9 7F F6 DA    45 	.byte 0xEF, 0xF7, 0xA0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x04, 0x37, 0xD7, 0xDD, 0x5A, 0xB6, 0xDF, 0x7A, 0xA0, 0x20, 0xDB, 0xFF, 0xF6, 0xFF
             40 07 37 7D DF FF EF
             F7 A0 00 00 00 00 00
             00 00 00 04
      008FB2 37 D7 DD 5A B6 DF 7A    46 	.byte 0xBB, 0xBD, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x5D, 0x7A, 0xF7, 0xEB, 0xFF, 0xFB, 0xC5, 0x00, 0x02, 0xDF, 0xF7, 0x7F, 0xAF
             A0 20 DB FF F6 FF BB
             BD 00 00 00 00 00 00
             00 00 00 01
      008FCB 5D 7A F7 EB FF FB C5    47 	.byte 0xEE, 0xD7, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x05, 0x77, 0xEF, 0xBE, 0xDF, 0xDB, 0x6F, 0x7C, 0x00, 0x00, 0x6D, 0xBF, 0xFF, 0xFB
             00 02 DF F7 7F AF EE
             D7 40 00 00 00 00 00
             00 00 00 05
      008FE4 77 EF BE DF DB 6F 7C    48 	.byte 0xBB, 0xFD, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x2A, 0xDD, 0x7B, 0x6B, 0xFB, 0x7F, 0xFB, 0xD1, 0x00, 0x00, 0x3F, 0xFD, 0xF6, 0xFF
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 90.
Hexadecimal  00-Bits]



             00 00 00 00 2A DD 7B
             6B FB 7F FB D1 00 00
             3F FD F6 FF
      008FEC 00 6D BF FF FB BB FD    49 	.byte 0xEF, 0x77, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x17, 0x77, 0xAD, 0xFF, 0x6F, 0xFE, 0xDF, 0x54, 0x00, 0x02, 0x37, 0xEF, 0xDF, 0xBF
             00 00 00 00 00 00 00
             00 00 2A DD 7B 6B FB
             7F FB D1 00
      009005 00 3F FD F6 FF EF 77    50 	.byte 0xBB, 0xDD, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xAD, 0xAD, 0xFF, 0x5F, 0xFB, 0xEF, 0xFB, 0xD8, 0x00, 0x00, 0x1E, 0xFF, 0x7F, 0xF7
             40 00 00 00 00 00 00
             00 00 17 77 AD FF 6F
             FE DF 54 00
      00901E 02 37 EF DF BF BB DD    51 	.byte 0xED, 0x7F, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0A, 0xDB, 0x7E, 0xEB, 0xF5, 0xEF, 0x7B, 0x6E, 0xF4, 0x00, 0x00, 0x0B, 0xFB, 0xF6, 0xFF
             80 00 00 00 00 00 00
             00 00 AD AD FF 5F FB
             EF FB D8 00
      009037 00 1E FF 7F F7 ED 7F    52 	.byte 0xBF, 0xEA, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x06, 0xFF, 0xDB, 0xBE, 0xFF, 0x5B, 0xDF, 0xFF, 0xA0, 0x00, 0x00, 0x0F, 0xDF, 0xFF, 0xBF
             40 00 00 00 00 00 00
             00 0A DB 7E EB F5 EF
             7B 6E F4 00
      009050 00 0B FB F6 FF BF EA    53 	.byte 0xEB, 0xBF, 0xE0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0B, 0xAD, 0x6E, 0xDB, 0x7F, 0xFF, 0xFD, 0xBB, 0x68, 0x00, 0x00, 0x06, 0xFF, 0x6F, 0xEB
             80 00 00 00 00 00 00
             00 06 FF DB BE FF 5B
             DF FF A0 00
      009069 00 0F DF FF BF EB BF    54 	.byte 0xBE, 0xEE, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20, 0x05, 0xFF, 0xFB, 0xFF, 0xEE, 0xAF, 0x7F, 0xEE, 0xD0, 0x00, 0x00, 0x07, 0xFD, 0xFD, 0xFF
             E0 00 00 00 00 00 00
             00 0B AD 6E DB 7F FF
             FD BB 68 00
      009082 00 06 FF 6F EB BE EE    55 	.byte 0xFB, 0x7B, 0xF0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x2B, 0x77, 0x5F, 0x6D, 0xBB, 0xF7, 0xDB, 0x7F, 0xD0, 0x00, 0x00, 0x07, 0xBF, 0xFF, 0x7F
             80 00 00 00 00 00 00
             20 05 FF FB FF EE AF
             7F EE D0 00
      00909B 00 07 FD FD FF FB 7B    56 	.byte 0xAF, 0xDF, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1D, 0xDD, 0xEB, 0xFF, 0xFE, 0xBD, 0xFF, 0xED, 0xA0, 0x00, 0x00, 0x0F, 0xF7, 0xB7, 0xDB
             F0 00 00 00 00 00 00
             00 2B 77 5F 6D BB F7
             DB 7F D0 00
      0090B4 00 07 BF FF 7F AF DF    57 	.byte 0xFA, 0xFD, 0xB0, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x17, 0x77, 0xBF, 0xAE, 0xED, 0xFF, 0xFB, 0xBF, 0xF8, 0x00, 0x00, 0x05, 0xFF, 0xFF, 0xFF
             40 00 00 00 00 00 00
             00 1D DD EB FF FE BD
             FF ED A0 00
      0090CD 00 0F F7 B7 DB FA FD    58 	.byte 0xAF, 0xAF, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x2B, 0xDD, 0x76, 0xFB, 0xFA, 0xB7, 0xBF, 0xEE, 0xE0, 0x00, 0x00, 0x0F, 0x7D, 0xFD, 0xBF
             B0 00 00 00 00 10 00
             00 17 77 BF AE ED FF
             FB BF F8 00
      0090E6 00 05 FF FF FF AF AF    59 	.byte 0xFE, 0xFB, 0x50, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x05, 0x77, 0xDF, 0xBF, 0xB5, 0xFD, 0xEE, 0xFF, 0xBD, 0x00, 0x00, 0x15, 0xDF, 0xEF, 0xF7
             C0 00 00 00 00 00 00
             00 2B DD 76 FB FA B7
             BF EE E0 00
      0090FF 00 0F 7D FD BF FE FB    60 	.byte 0xBB, 0xBF, 0xE0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x2B, 0xDD, 0xF5, 0xED, 0xFA, 0xDF, 0xFF, 0xDB, 0xEA, 0x10, 0x00, 0x37, 0xFF, 0xBF, 0xFF
             50 00 00 00 00 00 00
             00 05 77 DF BF B5 FD
             EE FF BD 00
      009118 00 15 DF EF F7 BB BF    61 	.byte 0xED, 0xFD, 0xA8, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x92, 0x77, 0x5F, 0xB7, 0xEF, 0xFF, 0x7B, 0x7F, 0x7E, 0x84, 0x00, 0x2A, 0xFD, 0xFB, 0x7F
             E0 00 00 00 00 00 00
             00 2B DD F5 ED FA DF
             FF DB EA 10
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 91.
Hexadecimal [24-Bits]



      009131 00 37 FF BF FF ED FD    62 	.byte 0xBF, 0x57, 0xF0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x2F, 0xDD, 0xEB, 0xFF, 0xBA, 0xBB, 0xDF, 0xFF, 0xDA, 0x00, 0x12, 0xE3, 0xEF, 0xFF, 0xDB
             A8 00 00 00 00 00 00
             00 92 77 5F B7 EF FF
             7B 7F 7E 84
      00914A 00 2A FD FB 7F BF 57    63 	.byte 0xF5, 0xFF, 0x68, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x5A, 0xB7, 0xBD, 0x5B, 0xFF, 0xFF, 0xFF, 0xB7, 0xFF, 0x20, 0x01, 0x75, 0x7F, 0xDF, 0xFF
             F0 00 00 00 00 00 00
             00 2F DD EB FF BA BB
             DF FF DA 00
      009163 12 E3 EF FF DB F5 FF    64 	.byte 0xAF, 0x6D, 0xE8, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x17, 0xDA, 0xEF, 0xFF, 0x6B, 0x77, 0x77, 0xFE, 0xD1, 0xD2, 0x4D, 0xE3, 0xFF, 0x7B, 0x6F
             68 00 00 00 00 00 00
             00 5A B7 BD 5B FF FF
             FF B7 FF 20
      00917C 01 75 7F DF FF AF 6D    65 	.byte 0xFD, 0xFF, 0xB8, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x16, 0xAF, 0xBD, 0xBF, 0xFF, 0xFF, 0xFD, 0xFF, 0xFA, 0xAD, 0x3B, 0xE1, 0x5B, 0xFF, 0xFF
             E8 00 00 00 00 00 00
             00 17 DA EF FF 6B 77
             77 FE D1 D2
      009195 4D E3 FF 7B 6F FD FF    66 	.byte 0xAF, 0x5B, 0xE0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x2B, 0xF5, 0xEF, 0xED, 0xFE, 0xDD, 0xDF, 0xB7, 0xA7, 0xF3, 0xEE, 0xC5, 0xFF, 0xEF, 0xFB
             B8 00 00 00 00 00 00
             00 16 AF BD BF FF FF
             FD FF FA AD
      0091AE 3B E1 5B FF FF AF 5B    67 	.byte 0xFD, 0xFE, 0xDC, 0x00, 0x01, 0x00, 0x00, 0x01, 0x00, 0x00, 0x15, 0x5F, 0x55, 0x7F, 0xD7, 0xFF, 0xFF, 0xFD, 0x7E, 0xDD, 0xB7, 0xC0, 0xFF, 0x7D, 0xBF
             E0 00 00 00 00 00 00
             00 2B F5 EF ED FE DD
             DF B7 A7 F3
      0091C7 EE C5 FF EF FB FD FE    68 	.byte 0xDB, 0x6F, 0xF0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x07, 0xF5, 0xFF, 0xFF, 0x7D, 0xFF, 0x76, 0xDF, 0xDB, 0xF6, 0xFF, 0xC1, 0xB7, 0xFF, 0xEF
             DC 00 01 00 00 01 00
             00 15 5F 55 7F D7 FF
             FF FD 7E DD
      0091E0 B7 C0 FF 7D BF DB 6F    69 	.byte 0x7F, 0xFA, 0xEC, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x5F, 0x55, 0xAB, 0xFF, 0xAB, 0xFF, 0xFF, 0xFF, 0xAB, 0xDB, 0xC0, 0x5F, 0xDF, 0xFF
             F0 00 00 00 00 00 00
             00 07 F5 FF FF 7D FF
             76 DF DB F6
      0091F9 FF C1 B7 FF EF 7F FA    70 	.byte 0xD5, 0x5F, 0xD8, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0xF5, 0xFF, 0xFE, 0xF7, 0xFF, 0xDB, 0xF6, 0xFE, 0xFE, 0xBF, 0x40, 0x7D, 0xFE, 0xDF
             EC 00 00 00 00 00 00
             00 03 5F 55 AB FF AB
             FF FF FF AB
      009212 DB C0 5F DF FF D5 5F    71 	.byte 0x7F, 0xFF, 0x7A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xDF, 0x56, 0xFF, 0xDD, 0xFE, 0xFF, 0xBF, 0xB7, 0xD5, 0xFF, 0x80, 0xAF, 0xFB, 0xFB
             D8 00 00 00 00 00 00
             00 02 F5 FF FE F7 FF
             DB F6 FE FE
      00922B BF 40 7D FE DF 7F FF    72 	.byte 0xD5, 0x75, 0xEC, 0x00, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x05, 0x6B, 0xFF, 0xDB, 0xFF, 0xDB, 0xFE, 0xFF, 0xFE, 0xFF, 0x77, 0x80, 0x7F, 0x6F, 0xFF
             7A 00 00 00 00 00 00
             00 00 DF 56 FF DD FE
             FF BF B7 D5
      009244 FF 80 AF FB FB D5 75    73 	.byte 0xBF, 0xDF, 0xBD, 0x00, 0x00, 0x00, 0x00, 0x20, 0x00, 0x00, 0x01, 0x5E, 0xDD, 0x7F, 0x77, 0x7F, 0xB7, 0xFB, 0xDB, 0xD5, 0xDF, 0x00, 0x1B, 0xFE, 0xDF
             EC 00 00 00 00 40 00
             00 05 6B FF DB FF DB
             FE FF FE FF
      00925D 77 80 7F 6F FF BF DF    74 	.byte 0xEA, 0xF7, 0xEA, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0xF7, 0xF7, 0xEF, 0xFF, 0xFF, 0xFD, 0xAE, 0xFF, 0x7F, 0xFE, 0x80, 0x7F, 0xFF, 0xF7
             BD 00 00 00 00 20 00
             00 01 5E DD 7F 77 7F
             B7 FB DB D5
      009276 DF 00 1B FE DF EA F7    75 	.byte 0xBF, 0xDD, 0x7D, 0x00, 0x00, 0x00, 0x00, 0x00, 0x04, 0x00, 0x0A, 0xDE, 0xDF, 0x7D, 0xDD, 0xB7, 0x7F, 0xFF, 0xED, 0xD6, 0xEF, 0x60, 0x0E, 0xDD, 0xFF
             EA 00 00 00 00 00 00
             00 03 F7 F7 EF FF FF
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 92.
Hexadecimal  FD-Bits]



             60 0E DD FF
      00928C AE FF 7F FE 80 7F FF    76 	.byte 0xD5, 0x77, 0xDE, 0x00, 0x00, 0x40, 0x00, 0x02, 0x00, 0x00, 0x03, 0xFB, 0xF7, 0xDF, 0xFF, 0xFD, 0xEB, 0x7D, 0xFF, 0x7F, 0xBD, 0x80, 0x3B, 0xFF, 0xDF
             F7 BF DD 7D 00 00 00
             00 00 04 00 0A DE DF
             7D DD B7 7F
      0092A5 FF ED D6 EF 60 0E DD    77 	.byte 0x7F, 0xDE, 0xFB, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x05, 0x6F, 0x5D, 0xFF, 0x77, 0xFF, 0xFF, 0xEF, 0xFD, 0xEB, 0xFF, 0x40, 0x0F, 0xF7, 0x7B
             FF D5 77 DE 00 00 40
             00 02 00 00 03 FB F7
             DF FF FD EB
      0092BE 7D FF 7F BD 80 3B FF    78 	.byte 0xD5, 0x77, 0xB6, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xDB, 0xFF, 0xBB, 0xFE, 0xDB, 0xDF, 0x7F, 0x57, 0x7E, 0xFB, 0x90, 0x2F, 0xBF, 0xFF
             DF 7F DE FB 00 00 00
             00 02 00 00 05 6F 5D
             FF 77 FF FF
      0092D7 EF FD EB FF 40 0F F7    79 	.byte 0xBF, 0xDE, 0xFE, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x15, 0xBF, 0xED, 0xFF, 0xDF, 0xFF, 0x7D, 0xF5, 0xFF, 0xFF, 0xBF, 0x40, 0x02, 0xFD, 0xEF
             7B D5 77 B6 80 00 00
             00 00 00 00 00 DB FF
             BB FE DB DF
      0092F0 7F 57 7E FB 90 2F BF    80 	.byte 0xED, 0xF7, 0xB7, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x4B, 0x6D, 0xBF, 0x6F, 0xFB, 0xFF, 0xF7, 0xBF, 0xFD, 0x6D, 0xFD, 0x80, 0x0F, 0xFF, 0xBF
             FF BF DE FE 80 00 00
             00 00 00 40 15 BF ED
             FF DF FF 7D
      009309 F5 FF FF BF 40 02 FD    81 	.byte 0xB7, 0x5E, 0xFD, 0xA0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x07, 0xFF, 0xED, 0xFF, 0x7F, 0x7B, 0xBE, 0xFE, 0xEF, 0xFF, 0xEF, 0x50, 0x05, 0xB7, 0xFB
             EF ED F7 B7 40 00 00
             00 00 00 00 4B 6D BF
             6F FB FF F7
      009322 BF FD 6D FD 80 0F FF    82 	.byte 0xDD, 0xEB, 0xAF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x1A, 0xED, 0x7F, 0xFD, 0xEF, 0xEF, 0xEF, 0xEF, 0xBB, 0xBB, 0xFE, 0xC0, 0x17, 0xFE, 0xFF
             BF B7 5E FD A0 00 00
             00 00 00 00 07 FF ED
             FF 7F 7B BE
      00933B FE EF FF EF 50 05 B7    83 	.byte 0x76, 0xBE, 0xFD, 0xC0, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x17, 0xBF, 0xF5, 0x5F, 0xFF, 0xFE, 0xFE, 0xBB, 0xFF, 0xFF, 0x7B, 0xB4, 0x82, 0xFF, 0xEF
             FB DD EB AF 00 00 00
             00 00 00 08 1A ED 7F
             FD EF EF EF
      009354 EF BB BB FE C0 17 FE    84 	.byte 0xDD, 0xEF, 0xBB, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0xFF, 0xF7, 0xFF, 0xF7, 0x7B, 0x7F, 0xB7, 0xFF, 0x6D, 0xEF, 0xFF, 0xEA, 0x07, 0xDB, 0xBF
             FF 76 BE FD C0 00 00
             00 08 00 00 17 BF F5
             5F FF FE FE
      00936D BB FF FF 7B B4 82 FF    85 	.byte 0x77, 0xBA, 0xDF, 0xD0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x15, 0xBE, 0xAF, 0xFF, 0xDF, 0xDF, 0xFF, 0xED, 0xFF, 0x7F, 0xED, 0xBC, 0x0B, 0xFF, 0xFB
             EF DD EF BB 40 00 00
             00 00 00 02 FF F7 FF
             F7 7B 7F B7
      009386 FF 6D EF FF EA 07 DB    86 	.byte 0xAD, 0x6F, 0xF6, 0xA0, 0x00, 0x00, 0x00, 0x20, 0x00, 0x00, 0x5F, 0x6B, 0xFA, 0xAE, 0xFF, 0xF6, 0xFE, 0xBF, 0xFF, 0xFB, 0xBF, 0xF5, 0x96, 0xFE, 0xFF
             BF 77 BA DF D0 00 00
             00 00 00 00 15 BE AF
             FF DF DF FF
      00939F ED FF 7F ED BC 0B FF    87 	.byte 0xF7, 0xDD, 0x5F, 0xE8, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20, 0x07, 0xFF, 0xEF, 0xFF, 0xFB, 0x7F, 0xB7, 0xEF, 0x6D, 0xDF, 0xFB, 0xDB, 0x4B, 0xB7, 0xEF
             FB AD 6F F6 A0 00 00
             00 20 00 00 5F 6B FA
             AE FF F6 FE
      0093B8 BF FF FB BF F5 96 FE    88 	.byte 0xBA, 0xF7, 0xF6, 0xA0, 0x00, 0x00, 0x00, 0x20, 0x00, 0x00, 0x3A, 0xEE, 0xBB, 0x7D, 0xEF, 0xEF, 0xFF, 0x7D, 0xFF, 0xFE, 0xFF, 0x7D, 0x45, 0xFF, 0x7F
             FF F7 DD 5F E8 00 00
             00 00 00 20 07 FF EF
             FF FB 7F B7
      0093D1 EF 6D DF FB DB 4B B7    89 	.byte 0xD7, 0x5D, 0x5B, 0xF0, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x07, 0x7B, 0xFF, 0xEF, 0xBE, 0xFB, 0xDD, 0xF7, 0xFB, 0x77, 0xFB, 0xF7, 0x87, 0xFB, 0xDB
             EF BA F7 F6 A0 00 00
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 93.
Hexadecimal  00-Bits]



             BE FB DD F7 FB 77 FB
             F7 87 FB DB
      0093E0 20 00 00 3A EE BB 7D    90 	.byte 0xBD, 0xEF, 0xFE, 0xA4, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x5B, 0xDF, 0xED, 0xBB, 0xFF, 0xBF, 0x77, 0x5D, 0xBF, 0xFF, 0xDE, 0xEC, 0x0B, 0x5E, 0xFF
             EF EF FF 7D FF FE FF
             7D 45 FF 7F D7 5D 5B
             F0 00 00 00
      0093F9 10 00 00 07 7B FF EF    91 	.byte 0xEB, 0xBA, 0xAB, 0xF0, 0x00, 0x00, 0x20, 0x08, 0x00, 0x00, 0x05, 0x7A, 0xBF, 0xFF, 0x6F, 0xFD, 0xDD, 0xEF, 0xEF, 0xFD, 0xFF, 0xF9, 0x15, 0xFB, 0xB7
             BE FB DD F7 FB 77 FB
             F7 87 FB DB BD EF FE
             A4 00 01 00
      009412 00 00 00 5B DF ED BB    92 	.byte 0xBD, 0x6F, 0xFE, 0xA8, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0B, 0xDF, 0xFD, 0xD7, 0xFB, 0x6F, 0xE3, 0x57, 0xFD, 0xBF, 0x7D, 0xAA, 0x8F, 0x76, 0xED
             FF BF 77 5D BF FF DE
             EC 0B 5E FF EB BA AB
             F0 00 00 20
      00942B 08 00 00 05 7A BF FF    93 	.byte 0xD7, 0xBA, 0xAB, 0xF4, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x75, 0xEF, 0x7F, 0xBF, 0xFE, 0xD2, 0xEB, 0x7F, 0xFB, 0xFF, 0xF8, 0x2B, 0xDD, 0x57
             6F FD DD EF EF FD FF
             F9 15 FB B7 BD 6F FE
             A8 00 00 00
      009444 00 00 00 0B DF FD D7    94 	.byte 0xBA, 0xEF, 0xFE, 0xB8, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x05, 0x3F, 0x7F, 0xFB, 0xF6, 0xDB, 0xE1, 0x5F, 0xEF, 0xE6, 0xEF, 0x69, 0x16, 0xF6, 0xBB
             FB 6F E3 57 FD BF 7D
             AA 8F 76 ED D7 BA AB
             F4 00 00 00
      00945D 00 00 00 00 75 EF 7F    95 	.byte 0x77, 0xBA, 0xAB, 0xEE, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00, 0x8B, 0xDB, 0x5E, 0xFF, 0xFC, 0x01, 0x55, 0xFF, 0xFB, 0xFB, 0xF4, 0x0B, 0xA9, 0x03
             BF FE D2 EB 7F FB FF
             F8 2B DD 57 BA EF FE
             B8 00 00 02
      009476 00 00 00 05 3F 7F FB    96 	.byte 0xDA, 0xD7, 0xFE, 0xD8, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x5E, 0xFE, 0xF7, 0xDF, 0x80, 0x00, 0x6F, 0xBB, 0xA2, 0xFF, 0xA0, 0x1F, 0xF4, 0x51
             F6 DB E1 5F EF E6 EF
             69 16 F6 BB 77 BA AB
             EE 00 00 04
      00948F 00 00 00 00 8B DB 5E    97 	.byte 0x6F, 0x7E, 0xAB, 0xF6, 0x80, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x2B, 0xFF, 0xDF, 0xFF, 0x00, 0x00, 0xB7, 0xFE, 0xF0, 0x3E, 0xE0, 0x2E, 0xAA, 0x00
             FF FC 01 55 FF FB FB
             F4 0B A9 03 DA D7 FE
             D8 00 00 00
      0094A8 00 00 00 00 5E FE F7    98 	.byte 0xD5, 0xAB, 0xFE, 0xBC, 0x00, 0x00, 0x00, 0x00, 0x40, 0x10, 0x00, 0x0E, 0xDA, 0xFB, 0x78, 0x00, 0x01, 0x5E, 0xFF, 0xD0, 0x3F, 0xA0, 0x1B, 0xF0, 0x00
             DF 80 00 6F BB A2 FF
             A0 1F F4 51 6F 7E AB
             F6 80 00 00
      0094C1 02 00 00 00 2B FF DF    99 	.byte 0xBE, 0xFE, 0xAB, 0xF7, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x0B, 0xFF, 0xAF, 0xFC, 0x00, 0x80, 0x6B, 0xB7, 0xD0, 0x0F, 0xC0, 0x2F, 0xAA, 0x00
             FF 00 00 B7 FE F0 3E
             E0 2E AA 00 D5 AB FE
             BC 00 00 00
      0094DA 00 40 10 00 0E DA FB   100 	.byte 0xD7, 0x57, 0xFE, 0xFD, 0x00, 0x00, 0x00, 0x00, 0x20, 0x00, 0x00, 0x02, 0xF6, 0xFF, 0xE0, 0x00, 0x00, 0xFF, 0xFE, 0x80, 0x07, 0x40, 0x1F, 0xF0, 0x00
             78 00 01 5E FF D0 3F
             A0 1B F0 00 BE FE AB
             F7 00 00 10
      0094F3 00 00 00 00 0B FF AF   101 	.byte 0xBD, 0xFA, 0xAB, 0xAE, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xBF, 0x5D, 0xB0, 0xB0, 0x01, 0xDD, 0xFF, 0xD0, 0x07, 0xE0, 0x97, 0x6C, 0x00
             FC 00 80 6B B7 D0 0F
             C0 2F AA 00 D7 57 FE
             FD 00 00 00
      00950C 00 20 00 00 02 F6 FF   102 	.byte 0xEB, 0x5F, 0xFE, 0xFB, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x09, 0xF7, 0xC0, 0x04, 0x05, 0x77, 0xDB, 0xF4, 0x03, 0x80, 0x3F, 0xD0, 0x00
             E0 00 00 FF FE 80 07
             40 1F F0 00 BD FA AB
             AE 80 00 00
      009525 00 00 00 00 00 BF 5D   103 	.byte 0x5E, 0xF5, 0x5B, 0xEE, 0x80, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x02, 0x5F, 0x40, 0x92, 0x17, 0xFE, 0xFF, 0x5C, 0x03, 0xE0, 0x3D, 0xEA, 0x00
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 94.
Hexadecimal  B0-Bits]



             00 10 00 00 00 02 5F
             40 92 17 FE FF 5C 03
             E0 3D EA 00
      00952D B0 01 DD FF D0 07 E0   104 	.byte 0xEB, 0xAF, 0xF6, 0xBD, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x7F, 0xC0, 0xA0, 0xB5, 0xF7, 0xEF, 0xF7, 0x17, 0x40, 0xFF, 0x50, 0x00
             97 6C 00 EB 5F FE FB
             00 00 00 00 00 00 00
             00 09 F7 C0
      009546 04 05 77 DB F4 03 80   105 	.byte 0x5D, 0x7D, 0x5F, 0xF7, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xBB, 0xF6, 0x43, 0xDF, 0xBE, 0xFF, 0x5D, 0xA9, 0xC1, 0x2F, 0xE8, 0x00
             3F D0 00 5E F5 5B EE
             80 00 00 00 10 00 00
             00 02 5F 40
      00955F 92 17 FE FF 5C 03 E0   106 	.byte 0xEB, 0xD7, 0xF5, 0x6D, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x2F, 0xDF, 0xBE, 0xF9, 0xFF, 0xDD, 0xF7, 0xD7, 0xC0, 0xFA, 0xA2, 0x00
             3D EA 00 EB AF F6 BD
             80 00 00 00 00 00 00
             00 00 7F C0
      009578 A0 B5 F7 EF F7 17 40   107 	.byte 0x5E, 0xBD, 0xAF, 0xFF, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x5E, 0xFB, 0xFF, 0x66, 0xDF, 0x7F, 0xDE, 0xFD, 0x80, 0x1F, 0xD4, 0x00
             FF 50 00 5D 7D 5F F7
             40 00 00 00 00 00 00
             00 00 BB F6
      009591 43 DF BE FF 5D A9 C1   108 	.byte 0xEB, 0x6B, 0x7A, 0xD5, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x07, 0xFF, 0xFB, 0xFB, 0x77, 0xFB, 0x77, 0xFF, 0xC0, 0xD6, 0xA0, 0x00
             2F E8 00 EB D7 F5 6D
             80 00 00 00 00 00 00
             00 00 2F DF
      0095AA BE F9 FF DD F7 D7 C0   109 	.byte 0x55, 0xDE, 0xEF, 0x7F, 0xA0, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x11, 0x00, 0x12, 0xBF, 0x6F, 0xB6, 0xFF, 0xDF, 0xFF, 0xBF, 0xA0, 0x3B, 0x40, 0x00
             FA A2 00 5E BD AF FF
             40 00 00 00 00 00 00
             00 00 5E FB
      0095C3 FF 66 DF 7F DE FD 80   110 	.byte 0xBE, 0xB7, 0xBB, 0xAD, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x05, 0x7F, 0xFF, 0x6D, 0x6E, 0xF6, 0xEE, 0xF7, 0xC0, 0x2D, 0x50, 0x00
             1F D4 00 EB 6B 7A D5
             80 00 00 00 00 00 00
             00 00 07 FF
      0095DC FB FB 77 FB 77 FF C0   111 	.byte 0xD5, 0xDA, 0xEE, 0xF7, 0xA0, 0x00, 0x00, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0B, 0xF5, 0xFF, 0xFF, 0xFF, 0xBB, 0xFF, 0xC0, 0x56, 0x84, 0x00
             D6 A0 00 55 DE EF 7F
             A0 00 00 00 10 00 00
             11 00 12 BF
      0095F5 6F B6 FF DF FF BF A0   112 	.byte 0x5A, 0xB7, 0x5B, 0xBA, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xA6, 0x8F, 0xDA, 0xDD, 0xAD, 0xFF, 0xDD, 0x00, 0xA9, 0x40, 0x00
             3B 40 00 BE B7 BB AD
             40 00 00 00 00 00 04
             00 00 05 7F
      00960E FF 6D 6E F6 EE F7 C0   113 	.byte 0xF7, 0x6D, 0xEE, 0xD7, 0xD0, 0x00, 0x00, 0x00, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x09, 0x5D, 0x7F, 0xFF, 0xFF, 0xDD, 0xFF, 0x80, 0x26, 0x10, 0x00
             2D 50 00 D5 DA EE F7
             A0 00 00 20 00 00 00
             00 00 00 0B
      009627 F5 FF FF FF BB FF C0   114 	.byte 0x5A, 0xDB, 0x7B, 0x7A, 0xA0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x13, 0xEB, 0xB6, 0xDB, 0x7F, 0x7A, 0x00, 0x59, 0x00, 0x00
             56 84 00 5A B7 5B BA
             40 00 00 00 00 00 00
             00 00 00 A6
      009640 8F DA DD AD FF DD 00   115 	.byte 0xA7, 0x6D, 0xAD, 0x95, 0xA8, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x80, 0x00, 0x00, 0x00, 0x02, 0xBF, 0xFF, 0xFF, 0xEF, 0xEF, 0x40, 0x42, 0x40, 0x00
             A9 40 00 F7 6D EE D7
             D0 00 00 00 80 00 00
             00 00 00 09
      009659 5D 7F FF FF DD FF 80   116 	.byte 0xFA, 0xDB, 0x76, 0xF6, 0xD0, 0x00, 0x00, 0x09, 0x00, 0x01, 0x41, 0x00, 0x00, 0x00, 0x0A, 0x6B, 0xFE, 0xB6, 0xB6, 0xFD, 0xFB, 0x00, 0x29, 0x00, 0x00
             26 10 00 5A DB 7B 7A
             A0 00 00 00 00 00 00
             00 00 00 00
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 95.
Hexadecimal [24-Bits]



      009672 13 EB B6 DB 7F 7A 00   117 	.byte 0x55, 0xAD, 0xDB, 0xAD, 0x54, 0x00, 0x00, 0x00, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x05, 0x57, 0xFF, 0xFF, 0xFF, 0xF4, 0x00, 0x54, 0x24, 0x00
             59 00 00 A7 6D AD 95
             A8 00 00 00 00 02 00
             80 00 00 00
      00968B 02 BF FF FF EF EF 40   118 	.byte 0xEB, 0x76, 0xEC, 0xD5, 0x68, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0xD5, 0x7D, 0x6B, 0x6D, 0xB7, 0xDA, 0x80, 0x12, 0x80, 0x00
             42 40 00 FA DB 76 F6
             D0 00 00 09 00 01 41
             00 00 00 0A
      0096A4 6B FE B6 B6 FD FB 00   119 	.byte 0x5E, 0xDB, 0xB7, 0xAA, 0xD5, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xD7, 0xFF, 0xFF, 0xFF, 0x74, 0x00, 0x2A, 0x00, 0x00
             29 00 00 55 AD DB AD
             54 00 00 00 80 00 00
             00 00 00 00
      0096BD 05 57 FF FF FF F4 00   120 	.byte 0xEB, 0x6D, 0x6A, 0xB5, 0x68, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0xBD, 0xAE, 0xF6, 0xDF, 0xE9, 0x00, 0x24, 0x90, 0x00
             54 24 00 EB 76 EC D5
             68 00 00 00 00 00 00
             00 00 00 02
      0096D6 D5 7D 6B 6D B7 DA 80   121 	.byte 0x5D, 0xB7, 0xBD, 0xAB, 0x5A, 0x00, 0x00, 0x01, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x52, 0xD7, 0x7F, 0xDF, 0xFD, 0xD4, 0xA0, 0x2B, 0x00, 0x00
             12 80 00 5E DB B7 AA
             D5 00 00 00 00 00 00
             00 00 00 00
      0096EF 00 D7 FF FF FF 74 00   122 	.byte 0xEA, 0xED, 0xD6, 0xD5, 0x68, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x5B, 0xFF, 0xF7, 0xAA, 0x20, 0x08, 0x40, 0x00
             2A 00 00 EB 6D 6A B5
             68 00 00 00 00 00 00
             00 00 00 00
      009708 02 BD AE F6 DF E9 00   123 	.byte 0x5F, 0xB6, 0xBB, 0x5A, 0xD5, 0x00, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x24, 0x7E, 0xED, 0x5E, 0xB7, 0x54, 0x52, 0x94, 0x00
             24 90 00 5D B7 BD AB
             5A 00 00 01 02 00 00
             00 00 00 00
      009721 52 D7 7F DF FD D4 A0   124 	.byte 0xEA, 0xDD, 0xEA, 0xD6, 0xB4, 0x00, 0x00, 0x00, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x85, 0xEF, 0xFF, 0xF5, 0x4A, 0xB1, 0x09, 0x00, 0x00
             2B 00 00 EA ED D6 D5
             68 00 00 00 00 00 10
             00 00 00 00
      00973A 00 08 5B FF F7 AA 20   125 	.byte 0x5F, 0x77, 0x5F, 0x6D, 0xDA, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00, 0x01, 0x40, 0x00, 0x00, 0x00, 0x08, 0xB7, 0x7F, 0xBC, 0x00, 0x00, 0x54, 0x40, 0x00
             08 40 00 5F B6 BB 5A
             D5 00 00 00 00 40 00
             00 00 00 00
      009753 00 24 7E ED 5E B7 54   126 	.byte 0xEB, 0xDA, 0xEA, 0xB6, 0xAC, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x40, 0x00, 0x00, 0x15, 0x7F, 0xD5, 0xE8, 0x51, 0x41, 0x12, 0x00, 0x00
             52 94 00 EA DD EA D6
             B4 00 00 00 80 00 00
             00 00 00 00
      00976C 00 85 EF FF F5 4A B1   127 	.byte 0x5D, 0x6F, 0xAD, 0xDD, 0x75, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x42, 0xAD, 0xFF, 0xDA, 0x08, 0x00, 0x55, 0x10, 0x00
             09 00 00 5F 77 5F 6D
             DA 00 00 00 00 10 00
             01 40 00 00
      009785 00 08 B7 7F BC 00 00   128 	.byte 0xEB, 0xDA, 0xFA, 0xAB, 0xAC, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x05, 0x7F, 0x7F, 0xE8, 0x00, 0x05, 0x44, 0x40, 0x00
             54 40 00 EB DA EA B6
             AC 00 00 00 00 00 08
             00 00 40 00
      00979E 00 15 7F D5 E8 51 41   129 	.byte 0x5E, 0xB7, 0x56, 0xDD, 0x7A, 0x80, 0x00, 0x10, 0x00, 0x00, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0xAF, 0xEE, 0xBD, 0x00, 0x00, 0x29, 0x00, 0x00
             12 00 00 5D 6F AD DD
             75 00 00 08 00 00 00
             00 00 00 00
      0097B7 00 42 AD FF DA 08 00   130 	.byte 0xAB, 0x6A, 0xEB, 0x6B, 0x56, 0x00, 0x00, 0x04, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0D, 0x7D, 0xBB, 0xE4, 0x00, 0x0A, 0x94, 0x80, 0x00
             55 10 00 EB DA FA AB
             AC 00 00 00 00 02 00
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 96.
Hexadecimal  00-Bits]



             0A 94 80 00
      0097CD 00 00 08 00 05 7F 7F   131 	.byte 0x56, 0xDB, 0x5A, 0xAD, 0xBD, 0xC0, 0x00, 0x01, 0x00, 0x08, 0x08, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x37, 0xFF, 0xBC, 0x84, 0x25, 0x4A, 0x20, 0x00
             E8 00 05 44 40 00 5E
             B7 56 DD 7A 80 00 10
             00 00 80 00
      0097E6 00 00 00 00 02 AF EE   132 	.byte 0xAA, 0xAD, 0xAA, 0xAA, 0xD6, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x05, 0xDF, 0x75, 0xD0, 0x00, 0x09, 0x32, 0x80, 0x00
             BD 00 00 29 00 00 AB
             6A EB 6B 56 00 00 04
             00 02 00 00
      0097FF 00 00 00 00 0D 7D BB   133 	.byte 0x2A, 0xAA, 0xAA, 0xB5, 0xAD, 0xD0, 0x00, 0x00, 0x00, 0x02, 0x88, 0x00, 0x00, 0x00, 0x00, 0x04, 0x40, 0xBB, 0xFF, 0x6A, 0x00, 0x92, 0x44, 0x10, 0x00
             E4 00 0A 94 80 00 56
             DB 5A AD BD C0 00 01
             00 08 08 00
      009818 00 10 00 00 00 37 FF   134 	.byte 0x45, 0x55, 0x2A, 0xAD, 0x76, 0x48, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x5E, 0xD5, 0x90, 0x00, 0x09, 0x2A, 0x80, 0x00
             BC 84 25 4A 20 00 AA
             AD AA AA D6 20 00 00
             00 00 00 00
      009831 00 00 00 00 05 DF 75   135 	.byte 0x14, 0x49, 0x52, 0x92, 0xAD, 0xB4, 0x00, 0x00, 0x00, 0x01, 0x14, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20, 0x2F, 0xFA, 0xA8, 0x00, 0x12, 0x54, 0x00, 0x00
             D0 00 09 32 80 00 2A
             AA AA B5 AD D0 00 00
             00 02 88 00
      00984A 00 00 00 04 40 BB FF   136 	.byte 0x42, 0xA6, 0xAA, 0x4A, 0xDA, 0x80, 0x00, 0x10, 0x0A, 0xA2, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xB5, 0xAC, 0x00, 0x00, 0x24, 0x92, 0x90, 0x00
             6A 00 92 44 10 00 45
             55 2A AD 76 48 00 00
             00 00 01 00
      009863 00 00 00 00 01 5E D5   137 	.byte 0x08, 0x10, 0x00, 0xAA, 0xAA, 0xA8, 0x00, 0x00, 0x00, 0x0A, 0x12, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0E, 0xE5, 0x48, 0x01, 0x12, 0x4A, 0x00, 0x00
             90 00 09 2A 80 00 14
             49 52 92 AD B4 00 00
             00 01 14 00
      00987C 00 00 00 00 20 2F FA   138 	.byte 0x02, 0x4A, 0xA9, 0x09, 0x55, 0x50, 0x00, 0x01, 0x05, 0x40, 0x88, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x13, 0x48, 0x00, 0x04, 0x44, 0x90, 0x80, 0x00
             A8 00 12 54 00 00 42
             A6 AA 4A DA 80 00 10
             0A A2 40 00
      009895 00 00 00 00 00 B5 AC   139 	.byte 0x00, 0x00, 0x04, 0x22, 0xAA, 0xAA, 0x80, 0x00, 0x12, 0xB2, 0x60, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x4C, 0xA1, 0x00, 0x00, 0x09, 0x2D, 0x00, 0x00
             00 00 24 92 90 00 08
             10 00 AA AA A8 00 00
             00 0A 12 00
      0098AE 00 00 00 00 00 0E E5   140 	.byte 0x08, 0x89, 0x41, 0x48, 0xAA, 0x40, 0x00, 0x00, 0x05, 0x41, 0x28, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x01, 0x02, 0x40, 0x20, 0x00
             48 01 12 4A 00 00 02
             4A A9 09 55 50 00 01
             05 40 88 00
      0098C7 00 02 00 00 00 13 48   141 	.byte 0x00, 0x20, 0x12, 0x05, 0x12, 0x94, 0x00, 0x00, 0x1D, 0xB9, 0x00, 0x40, 0x00, 0x00, 0x40, 0x00, 0x00, 0x14, 0x20, 0x00, 0x10, 0x28, 0x94, 0x80, 0x00
             00 04 44 90 80 00 00
             00 04 22 AA AA 80 00
             12 B2 60 40
      0098E0 00 00 00 00 00 4C A1   142 	.byte 0x00, 0x02, 0x00, 0x20, 0xA9, 0x41, 0x00, 0x00, 0x57, 0x44, 0x50, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x49, 0x00, 0x00
             00 00 09 2D 00 00 08
             89 41 48 AA 40 00 00
             05 41 28 00
      0098F9 00 08 00 00 00 01 00   143 	.byte 0x00, 0x08, 0x92, 0x89, 0x04, 0x14, 0x00, 0x00, 0x1D, 0x5A, 0x41, 0x40, 0x0A, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x13, 0x55, 0x24, 0x20, 0x00
             00 01 02 40 20 00 00
             20 12 05 12 94 00 00
             1D B9 00 40
      009912 00 00 40 00 00 14 20   144 	.byte 0x02, 0x00, 0x00, 0x02, 0x51, 0x40, 0x00, 0x00, 0x37, 0xA0, 0x82, 0x00, 0x00, 0x50, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xD0, 0x91, 0x00, 0x00
             00 10 28 94 80 00 00
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 97.
Hexadecimal  02-Bits]



             00 00 00 00 00 00 00
             D0 91 00 00
      009921 00 20 A9 41 00 00 57   145 	.byte 0x00, 0x24, 0x90, 0x20, 0x04, 0x08, 0x80, 0x00, 0x1E, 0xA8, 0x0A, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x05, 0x24, 0x00, 0x00
             44 50 00 00 00 00 00
             00 00 00 00 00 02 49
             00 00 00 08
      00993A 92 89 04 14 00 00 1D   146 	.byte 0x00, 0x00, 0x04, 0x09, 0x41, 0x00, 0x00, 0x80, 0x37, 0xA1, 0x1A, 0x00, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00, 0x00, 0x1D, 0x48, 0x92, 0x40, 0x00
             5A 41 40 0A 20 00 00
             00 00 00 00 13 55 24
             20 00 02 00
      009953 00 02 51 40 00 00 37   147 	.byte 0x00, 0x02, 0x41, 0x00, 0x08, 0x20, 0x00, 0x00, 0x1B, 0x50, 0x2A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x05, 0x52, 0x48, 0x00, 0x00
             A0 82 00 00 50 00 00
             00 00 00 00 00 D0 91
             00 00 00 24
      00996C 90 20 04 08 80 00 1E   148 	.byte 0x10, 0x80, 0x08, 0x40, 0x00, 0x00, 0x00, 0x00, 0x2E, 0xA0, 0x34, 0x80, 0x00, 0x60, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x95, 0x2A, 0x80, 0x00
             A8 0A 80 00 00 00 00
             00 00 00 00 01 05 24
             00 00 00 00
      009985 04 09 41 00 00 80 37   149 	.byte 0x00, 0x08, 0x20, 0x04, 0x42, 0x00, 0x20, 0x00, 0x1A, 0x90, 0xAA, 0x00, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x04, 0x20, 0x40, 0x00, 0x00
             A1 1A 00 00 00 00 40
             00 00 00 00 1D 48 92
             40 00 00 02
      00999E 41 00 08 20 00 00 1B   150 	.byte 0x04, 0x21, 0x01, 0x00, 0x00, 0x02, 0x00, 0x00, 0x14, 0x40, 0x55, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x95, 0x29, 0x00, 0x00
             50 2A 00 00 00 00 00
             00 00 00 00 05 52 48
             00 00 10 80
      0099B7 08 40 00 00 00 00 2E   151 	.byte 0x00, 0x00, 0x08, 0x10, 0x00, 0x10, 0x84, 0x00, 0x0A, 0xA9, 0x3A, 0x02, 0x08, 0x00, 0x04, 0xC0, 0x00, 0x80, 0x00, 0x00, 0x02, 0x00, 0xA4, 0x20, 0x00
             A0 34 80 00 60 00 00
             00 00 00 00 00 95 2A
             80 00 00 08
      0099D0 20 04 42 00 20 00 1A   152 	.byte 0x00, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1A, 0xA0, 0x55, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xAA, 0x09, 0x00, 0x00
             90 AA 00 08 00 00 00
             00 00 00 80 04 20 40
             00 00 04 21
      0099E9 01 00 00 02 00 00 14   153 	.byte 0x00, 0x00, 0x41, 0x01, 0x00, 0x04, 0x20, 0x00, 0x0F, 0x49, 0x6D, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x04, 0x00, 0x00, 0x08, 0x00, 0x54, 0x00, 0x00
             40 55 00 00 00 00 00
             00 00 00 00 00 95 29
             00 00 00 00
      009A02 08 10 00 10 84 00 0A   154 	.byte 0x08, 0x10, 0x04, 0x08, 0x10, 0x21, 0x00, 0x00, 0x36, 0xA0, 0x5A, 0x00, 0x00, 0x00, 0x0C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x95, 0x01, 0x00, 0x00
             A9 3A 02 08 00 04 C0
             00 80 00 00 02 00 A4
             20 00 00 84
      009A1B 00 00 00 00 00 00 1A   155 	.byte 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x08, 0x00, 0x2D, 0x92, 0xB5, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x05, 0x00, 0x54, 0x00, 0x00
             A0 55 00 00 00 00 00
             00 00 00 00 00 AA 09
             00 00 00 00
      009A34 41 01 00 04 20 00 0F   156 	.byte 0x00, 0x80, 0x10, 0x00, 0x00, 0x92, 0x40, 0x00, 0x35, 0x40, 0xAD, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x52, 0x00, 0x20, 0x00
             49 6D 00 00 00 40 00
             00 04 00 00 08 00 54
             00 00 08 10
      009A4D 04 08 10 21 00 00 36   157 	.byte 0x00, 0x04, 0x80, 0x08, 0x84, 0x00, 0x00, 0x00, 0x57, 0x6A, 0xB7, 0x60, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x55, 0x00, 0x00
             A0 5A 00 00 00 0C 00
             00 00 00 00 02 95 01
             00 00 00 00
      009A66 00 40 00 00 08 00 2D   158 	.byte 0x00, 0x00, 0x02, 0x40, 0x00, 0x00, 0x00, 0x00, 0x1A, 0x80, 0x5A, 0x84, 0x04, 0x00, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x2C, 0x48, 0x80, 0x00, 0x00
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 98.
Hexadecimal  92-Bits]



             00 1A 80 5A 84 04 00
             00 00 00 04 00 00 2C
             48 80 00 00
      009A6E B5 40 00 00 00 00 00   159 	.byte 0x00, 0x00, 0x00, 0x00, 0x01, 0x24, 0x80, 0x00, 0x27, 0x42, 0xAE, 0x90, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x02, 0x14, 0x80, 0x00
             00 00 00 05 00 54 00
             00 00 80 10 00 00 92
             40 00 35 40
      009A87 AD 00 00 00 00 00 00   160 	.byte 0x00, 0x00, 0x20, 0x09, 0x10, 0x00, 0x00, 0x00, 0x1C, 0xA8, 0x0B, 0x40, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x74, 0x88, 0x80, 0x00, 0x00
             00 00 00 08 52 00 20
             00 00 04 80 08 84 00
             00 00 57 6A
      009AA0 B7 60 00 00 00 00 00   161 	.byte 0x00, 0x00, 0x04, 0x80, 0x00, 0x00, 0x00, 0x00, 0x47, 0x80, 0x36, 0xA0, 0x21, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xAA, 0x00, 0x12, 0x00, 0x00
             00 00 00 01 00 55 00
             00 00 00 02 40 00 00
             00 00 1A 80
      009AB9 5A 84 04 00 00 00 00   162 	.byte 0x00, 0x00, 0x00, 0x20, 0x02, 0x40, 0x00, 0x00, 0x1D, 0x52, 0x4B, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00, 0x01, 0x70, 0x51, 0x00, 0x00, 0x00
             04 00 00 2C 48 80 00
             00 00 00 00 00 01 24
             80 00 27 42
      009AD2 AE 90 00 00 00 00 00   163 	.byte 0x00, 0x00, 0x00, 0x09, 0x10, 0x08, 0x00, 0x00, 0x06, 0x80, 0x16, 0xC0, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xED, 0x02, 0xA9, 0x00, 0x00
             00 00 00 01 02 14 80
             00 00 00 20 09 10 00
             00 00 1C A8
      009AEB 0B 40 01 00 00 00 00   164 	.byte 0x00, 0x00, 0x92, 0x80, 0x00, 0x00, 0x00, 0x00, 0x2D, 0x40, 0x95, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xF0, 0x00, 0x00, 0x00, 0x00
             00 00 00 74 88 80 00
             00 00 00 04 80 00 00
             00 00 47 80
      009B04 36 A0 21 00 00 00 00   165 	.byte 0x00, 0x00, 0x00, 0x12, 0x42, 0x40, 0x00, 0x00, 0x86, 0xA0, 0x2B, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x78, 0x49, 0x08, 0x00, 0x00
             00 00 00 AA 00 12 00
             00 00 00 00 20 02 40
             00 00 1D 52
      009B1D 4B 00 00 00 00 00 00   166 	.byte 0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x0B, 0x48, 0x2A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0xEA, 0x00, 0x40, 0x80, 0x00
             10 00 01 70 51 00 00
             00 00 00 00 09 10 08
             00 00 06 80
      009B36 16 C0 04 00 00 00 00   167 	.byte 0x00, 0x00, 0x01, 0x24, 0xA0, 0x10, 0x00, 0x00, 0x46, 0xA2, 0x57, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x38, 0x82, 0x04, 0x00, 0x00
             00 00 00 ED 02 A9 00
             00 00 00 92 80 00 00
             00 00 2D 40
      009B4F 95 00 00 00 00 00 00   168 	.byte 0x00, 0x00, 0x24, 0x00, 0x00, 0x80, 0x00, 0x00, 0x15, 0x4C, 0xAA, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x62, 0x08, 0x90, 0x00, 0x00
             00 00 00 F0 00 00 00
             00 00 00 00 12 42 40
             00 00 86 A0
      009B68 2B 80 00 00 00 00 00   169 	.byte 0x00, 0x00, 0x00, 0x12, 0x14, 0x00, 0x00, 0x00, 0x43, 0xA1, 0x16, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x38, 0x20, 0x02, 0x00, 0x00
             00 00 00 78 49 08 00
             00 00 00 00 00 08 00
             00 00 0B 48
      009B81 2A 00 00 00 00 00 00   170 	.byte 0x00, 0x00, 0x00, 0x80, 0x41, 0x04, 0x00, 0x22, 0x85, 0x52, 0xAC, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x14, 0x02, 0x10, 0x00, 0x00
             10 00 00 EA 00 40 80
             00 00 00 01 24 A0 10
             00 00 46 A2
      009B9A 57 80 00 00 00 00 00   171 	.byte 0x00, 0x00, 0x00, 0x09, 0x08, 0x00, 0x00, 0x00, 0x23, 0x48, 0x5A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x29, 0x48, 0x80, 0x00, 0x00
             00 00 00 38 82 04 00
             00 00 00 24 00 00 80
             00 00 15 4C
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 99.
Hexadecimal [24-Bits]



      009BB3 AA 00 00 00 00 00 00   172 	.byte 0x00, 0x00, 0x04, 0x00, 0x42, 0x40, 0x00, 0x04, 0x85, 0xA0, 0x14, 0x00, 0x81, 0x00, 0x80, 0x00, 0x04, 0x00, 0x00, 0x00, 0x14, 0x00, 0x21, 0x00, 0x00
             00 00 00 62 08 90 00
             00 00 00 00 12 14 00
             00 00 43 A1
      009BCC 16 00 00 00 00 00 00   173 	.byte 0x00, 0x00, 0x00, 0x40, 0x08, 0x10, 0x00, 0x92, 0xA3, 0x54, 0x5C, 0x00, 0x14, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0A, 0x24, 0x08, 0x00, 0x00
             00 00 00 38 20 02 00
             00 00 00 00 80 41 04
             00 22 85 52
      009BE5 AC 00 00 00 00 00 00   174 	.byte 0x00, 0x00, 0x00, 0x04, 0x82, 0x00, 0x02, 0x25, 0x46, 0xC5, 0x50, 0x00, 0xA9, 0x20, 0x00, 0x00, 0x92, 0x80, 0x00, 0x00, 0x30, 0x80, 0x80, 0x00, 0x00
             00 00 00 14 02 10 00
             00 00 00 00 09 08 00
             00 00 23 48
      009BFE 5A 00 00 00 00 00 00   175 	.byte 0x00, 0x00, 0x00, 0x00, 0x20, 0x42, 0x00, 0x4A, 0xD1, 0x28, 0xB8, 0x00, 0xA2, 0x40, 0x82, 0x24, 0x04, 0x00, 0x00, 0x00, 0x0A, 0x02, 0x22, 0x00, 0x00
             00 00 00 29 48 80 00
             00 00 00 04 00 42 40
             00 04 85 A0
      009C17 14 00 81 00 80 00 04   176 	.byte 0x00, 0x00, 0x00, 0x20, 0x04, 0x00, 0x10, 0x55, 0x61, 0xD5, 0x50, 0x04, 0x94, 0xA8, 0x00, 0x40, 0x21, 0x40, 0x00, 0x00, 0x04, 0x90, 0x00, 0x00, 0x00
             00 00 00 14 00 21 00
             00 00 00 00 40 08 10
             00 92 A3 54
      009C30 5C 00 14 00 00 00 00   177 	.byte 0x00, 0x80, 0x00, 0x04, 0x91, 0x08, 0x85, 0x15, 0xB0, 0x08, 0xB0, 0x01, 0x52, 0x02, 0x40, 0x0A, 0x8A, 0x80, 0x00, 0x00, 0x0A, 0x08, 0x90, 0x00, 0x00
             00 00 00 0A 24 08 00
             00 00 00 00 04 82 00
             02 25 46 C5
      009C49 50 00 A9 20 00 00 92   178 	.byte 0x00, 0x08, 0x00, 0x00, 0x00, 0x40, 0x20, 0xAB, 0x68, 0x6B, 0x60, 0x04, 0xA9, 0x50, 0x0A, 0x40, 0x20, 0x50, 0x00, 0x00, 0x09, 0x40, 0x00, 0x00, 0x00
             80 00 00 30 80 80 00
             00 00 00 00 00 20 42
             00 4A D1 28
      009C62 B8 00 A2 40 82 24 04   179 	.byte 0x00, 0x00, 0x00, 0x80, 0x24, 0x04, 0x8A, 0x56, 0xBC, 0x0A, 0xA0, 0x01, 0x02, 0x01, 0x20, 0x04, 0x8A, 0x84, 0x00, 0x20, 0x04, 0x05, 0x04, 0x80, 0x00
             00 00 00 0A 02 22 00
             00 00 00 00 20 04 00
             10 55 61 D5
      009C7B 50 04 94 A8 00 40 21   180 	.byte 0x00, 0x00, 0x00, 0x08, 0x01, 0x00, 0x21, 0x55, 0xE8, 0x12, 0xC0, 0x04, 0xA8, 0x84, 0x09, 0x00, 0x20, 0x20, 0x00, 0x00, 0x01, 0x20, 0x10, 0x00, 0x00
             40 00 00 04 90 00 00
             00 00 80 00 04 91 08
             85 15 B0 08
      009C94 B0 01 52 02 40 0A 8A   181 	.byte 0x00, 0x00, 0x40, 0x01, 0x00, 0x52, 0x8A, 0x2B, 0x5C, 0x0B, 0x60, 0x05, 0x02, 0x50, 0x00, 0x21, 0x02, 0x84, 0x00, 0x00, 0x04, 0x82, 0x40, 0x00, 0x00
             80 00 00 0A 08 90 00
             00 00 08 00 00 00 40
             20 AB 68 6B
      009CAD 60 04 A9 50 0A 40 20   182 	.byte 0x02, 0x00, 0x00, 0x20, 0x24, 0x00, 0x21, 0x56, 0xF6, 0x05, 0x80, 0x15, 0x50, 0x01, 0x20, 0x04, 0x50, 0x20, 0x80, 0x00, 0x04, 0x10, 0x00, 0x00, 0x00
             50 00 00 09 40 00 00
             00 00 00 00 80 24 04
             8A 56 BC 0A
      009CC6 A0 01 02 01 20 04 8A   183 	.byte 0x00, 0x10, 0x02, 0x00, 0x00, 0x04, 0x8A, 0xAA, 0xAE, 0x02, 0xC0, 0x05, 0x01, 0x08, 0x00, 0x00, 0x04, 0x90, 0x00, 0x00, 0x00, 0x80, 0x10, 0x00, 0x00
             84 00 20 04 05 04 80
             00 00 00 00 08 01 00
             21 55 E8 12
      009CDF C0 04 A8 84 09 00 20   184 	.byte 0x00, 0x00, 0x00, 0x01, 0x01, 0x20, 0x20, 0x2B, 0x7B, 0x01, 0x00, 0x12, 0x94, 0x40, 0x04, 0x90, 0x80, 0x05, 0x00, 0x00, 0x04, 0x24, 0x82, 0x00, 0x00
             20 00 00 01 20 10 00
             00 00 00 40 01 00 52
             8A 2B 5C 0B
      009CF8 60 05 02 50 00 21 02   185 	.byte 0x00, 0x01, 0x00, 0x48, 0x10, 0x02, 0x02, 0xA5, 0x4D, 0x81, 0x00, 0x04, 0x40, 0x04, 0x40, 0x00, 0x01, 0x20, 0x00, 0x00, 0x00, 0x00, 0x20, 0x00, 0x00
             84 00 00 04 82 40 00
             00 02 00 00 20 24 00
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 100.
Hexadecimal  21-Bits]



             00 20 00 00
      009D0E 56 F6 05 80 15 50 01   186 	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x48, 0x16, 0xFB, 0x00, 0x00, 0x12, 0x10, 0x80, 0x00, 0x04, 0x10, 0x0A, 0x48, 0x00, 0x02, 0x80, 0x00, 0x00, 0x00
             20 04 50 20 80 00 04
             10 00 00 00 00 10 02
             00 00 04 8A
      009D27 AA AE 02 C0 05 01 08   187 	.byte 0x00, 0x00, 0x12, 0x00, 0x40, 0x08, 0x00, 0x21, 0x56, 0xE0, 0x00, 0x00, 0x4A, 0x20, 0x08, 0x00, 0x80, 0x00, 0x00, 0x00, 0x00, 0x24, 0x84, 0x00, 0x00
             00 00 04 90 00 00 00
             80 10 00 00 00 00 00
             01 01 20 20
      009D40 2B 7B 01 00 12 94 40   188 	.byte 0x00, 0x00, 0x00, 0x04, 0x00, 0x01, 0x01, 0x0A, 0xAB, 0x40, 0x00, 0x45, 0x00, 0x04, 0x81, 0x20, 0x05, 0x20, 0x00, 0x00, 0x02, 0x00, 0x10, 0x00, 0x00
             04 90 80 05 00 00 04
             24 82 00 00 00 01 00
             48 10 02 02
      009D59 A5 4D 81 00 04 40 04   189 	.byte 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x10, 0x00, 0xAA, 0xA0, 0x00, 0x10, 0x22, 0x80, 0x00, 0x00, 0x00, 0x04, 0xA4, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
             40 00 01 20 00 00 00
             00 20 00 00 00 00 00
             00 00 00 48
      009D72 16 FB 00 00 12 10 80   190 	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x2A, 0x15, 0x50, 0x00, 0x04, 0x88, 0x20, 0x00, 0x09, 0x20, 0x00, 0x00, 0x00, 0x00, 0x24, 0x40, 0x00, 0x00
             00 04 10 0A 48 00 02
             80 00 00 00 00 00 12
             00 40 08 00
      009D8B 21 56 E0 00 00 4A 20   191 	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xAA, 0xA2, 0x00, 0x90, 0x40, 0x88, 0x09, 0x00, 0x02, 0x20, 0x00, 0x80, 0x02, 0x00, 0x09, 0x00, 0x00
             08 00 80 00 00 00 00
             24 84 00 00 00 00 00
             04 00 01 01
      009DA4 0A AB 40 00 45 00 04   192 	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x08, 0x00, 0x02, 0x08, 0x01, 0x00, 0x20, 0x00, 0x04, 0x92, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00
             81 20 05 20 00 00 02
             00 10 00 00 00 00 00
             40 00 00 10
      009DBD 00 AA A0 00 10 22 80   193 	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x4A, 0x15, 0x20, 0x00, 0x88, 0x22, 0x40, 0x20, 0x02, 0x20, 0x00, 0x00, 0x00, 0x08, 0x40, 0x00, 0x00, 0x00
             00 00 00 04 A4 00 00
             00 00 00 00 00 00 00
             00 00 00 00
      009DD6 2A 15 50 00 04 88 20   194 	.byte 0x00, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xA0, 0x49, 0x42, 0x00, 0x00, 0x08, 0x04, 0x90, 0x02, 0x20, 0x00, 0x10, 0x00, 0x09, 0x22, 0x00, 0x00
             00 09 20 00 00 00 00
             24 40 00 00 00 00 00
             00 00 00 00
      009DEF 00 AA A2 00 90 40 88   195 	.byte 0x00, 0x00, 0x80, 0x00, 0x00, 0x00, 0x00, 0x02, 0x05, 0x00, 0x08, 0x24, 0x90, 0x82, 0x00, 0x00, 0x00, 0x04, 0x92, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
             09 00 02 20 00 80 02
             00 09 00 00 00 00 00
             00 00 00 02
      009E08 00 00 08 00 02 08 01   196 	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x04, 0x88, 0xA0, 0x00, 0x00, 0x00, 0x04, 0x20, 0x40, 0x00, 0x88, 0x00, 0x00, 0x42, 0x04, 0x80, 0x00, 0x00, 0x00
             00 20 00 04 92 00 00
             01 00 00 00 00 00 00
             00 00 00 00
      009E21 4A 15 20 00 88 22 40   197 	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x08, 0x91, 0x21, 0x00, 0x00, 0x00, 0x12, 0x48, 0x00, 0x90, 0x00, 0x00, 0x20, 0x08, 0x48, 0x00, 0x00
             20 02 20 00 00 00 08
             40 00 00 00 00 20 00
             00 00 00 00
      009E3A 00 A0 49 42 00 00 08   198 	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20, 0x82, 0x00, 0x04, 0x24, 0xA9, 0x49, 0x00, 0x00, 0x00, 0x02, 0x49, 0x10, 0x00, 0x01, 0x00, 0x00, 0x00
             04 90 02 20 00 10 00
             09 22 00 00 00 00 80
             00 00 00 00
      009E53 02 05 00 08 24 90 82   199 	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x48, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
             00 00 00 04 92 00 00
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 101.
Hexadecimal  00-Bits]



             00 00 00 00 00 00 00
             00 00 00 00
      009E62 00 00 00 00 00 00 00   200 	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
             00 00 04 88 A0 00 00
             00 04 20 40 00 88 00
             00 42 04 80
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 102.
Hexadecimal [24-Bits]



                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2023,2024  
                                      3 ; This file is part of stm8-gamepad
                                      4 ;
                                      5 ;     stm8-gamepad is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     stm8-gamepad is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with ntsc_tuto.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                                     19 ;------------------------
                                     20 ; snake game 
                                     21 ; snake grow by eating mouse 
                                     22 ; 2 buttons used LEFT|RIGHT 
                                     23 ; to change snake direction 
                                     24 ; collision with walls,itself 
                                     25 ; and boulder end game
                                     26 ;------------------------
                                     27 
                                     28     .area G_DATA (ABS)
      000004                         29     .org 4 
      000004                         30 app_variables:
      000004                         31 score: .blkw 1 ; game score 
      000006                         32 speed: .blkb 1 ; snake speed delay
      000007                         33 chrono: .blkb 1 ; chronometer delay 
      000008                         34 max_score: .blkw 1 ; maximum score 
      00000A                         35 game_flags: .blkb 1 ; game boolean flags 
      00000B                         36 snake_len: .blkb 1 ; snake length 
      00000C                         37 snake_dir: .blkb 1 ; head direction 
      00000D                         38 food_coord: .blkw 1 ; food coordinates
      00000F                         39 snake_body: .blkw 32 ;  snake rings coords 
                                     40 
                                     41     .area CODE 
                                     42 ; chronometer delay 
                           00007F    43 CHRONO_DELAY=127
                                     44 
                                     45 ; snake speed value 
                           000001    46 MIN_SPEED=1 
                           000009    47 MAX_SPEED=9 
                                     48 
                                     49 ; borders position and area dimensions 
                           000000    50 LEFT_BORDER=0 ; left fence position 
                           000001    51 MIN_XCOOR=LEFT_BORDER+1; minimum snake x coordinate 
                           0000C4    52 RIGHT_BORDER=(HRES-4)&0xFC ; right fence position , 4 pixels reserved for calories bargraph.
                           0000C0    53 MAX_XCOOR=(RIGHT_BORDER-SNAKE_SPRITE_WIDTH) ; maximum snake x coordinate  
                           0000C3    54 PG_WIDTH=(RIGHT_BORDER-MIN_XCOOR) ; play ground width 
                           000008    55 TOP_BORDER=FONT_HEIGHT ; top fence y position , 1 character height reserved for status display  
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 103.
Hexadecimal [24-Bits]



                           000009    56 MIN_YCOOR=(TOP_BORDER+1) ; minimum snake y coordinate   
                           0000BF    57 BOTTOM_BORDER=(VRES-1) ; bottom fence position 
                           0000BB    58 MAX_YCOOR=(BOTTOM_BORDER-SNAKE_SPRITE_HEIGHT)
                           0000B6    59 PG_HEIGHT=(BOTTOM_BORDER-MIN_YCOOR); play ground height 
                                     60 
                                     61 ; game boolean flags 
                           000000    62 F_FOOD_COLL=0  ; collision with food, earn point
                           000001    63 F_NO_FOOD=1    ; no food available 
                           000002    64 F_GAME_OVER=2  ; game ended
                           000003    65 F_POO=3        ; snake poo 
                                     66 
                                     67 ; snake heading 
                           000000    68 NORTH=0 
                           000001    69 EAST=1
                           000002    70 SOUTH=2 
                           000004    71 WEST=4 
                                     72 
                                     73 ; game sprites 
                                     74 ; first 2 numbers: width,height 
                           000004    75 SNAKE_SPRITE_WIDTH=4 
                           000004    76 SNAKE_SPRITE_HEIGHT=4
      009E7B 00 00 00 00 00 00       77 HEAD_UP:    .byte SNAKE_SPRITE_WIDTH,SNAKE_SPRITE_HEIGHT,0X60,0X60,0X90,0X60
      009E81 00 00 00 00 02 08       78 HEAD_RIGHT: .byte SNAKE_SPRITE_WIDTH,SNAKE_SPRITE_HEIGHT,0X40,0XB0,0XB0,0X40 
      009E87 91 21 00 00 00 12       79 HEAD_DOWN:  .byte SNAKE_SPRITE_WIDTH,SNAKE_SPRITE_HEIGHT,0X60,0X90,0X60,0X60 
      009E8D 48 00 90 00 00 20       80 HEAD_LEFT:  .byte SNAKE_SPRITE_WIDTH,SNAKE_SPRITE_HEIGHT,0X20,0XD0,0XD0,0X20 
      009E93 08 48 00 00 00 00       81 RING:       .byte SNAKE_SPRITE_WIDTH,SNAKE_SPRITE_HEIGHT,0x60,0x90,0X90,0X60 
                           000005    82 MOUSE_WIDTH=5 
                           000004    83 MOUSE_HEIGHT=4
      009E99 00 00 00 00 00 20       84 MOUSE:      .byte MOUSE_WIDTH,MOUSE_HEIGHT,0X00,0X70,0XF8,0XA0 
                           000004    85 POO_WIDTH=4
                           000004    86 POO_HEIGHT=4
      009E9F 82 00 04 24 A9 49       87 POO:    .byte POO_WIDTH,POO_HEIGHT,0x40,0x60,0x70,0xf0
                           000003    88 CB_WIDTH=3
                           000001    89 CB_HEIGHT=1
      009EA5 00 00 00                90 CHRONO_BAR:    .byte CB_WIDTH,CB_HEIGHT,0x70 
                                     91 
                                     92 
                                     93 ;----------------------
                                     94 ; draw walls around 
                                     95 ; game area 
                                     96 ;---------------------
      001E8F                         97 draw_walls:
                                     98 ; top fence  
      009EA8 02 49 10         [ 2]   99     ldw x,#RIGHT_BORDER+1 
      009EAB 00 01 00 00      [ 2]  100     ldw y,#(TOP_BORDER<<8)+TOP_BORDER  
      009EAF 00 00 00         [ 4]  101     call line
                                    102 ; bottom fence  
      009EB2 00 00 00         [ 2]  103     ldw x,#RIGHT_BORDER+1 
      009EB5 00 00 02 48      [ 2]  104     ldw y,#(BOTTOM_BORDER<<8)+BOTTOM_BORDER
      009EB9 00 00 00         [ 4]  105     call line 
                                    106 ; left fence     
      009EBC 00               [ 1]  107     clrw x 
      009EBD 00 00 00 00      [ 2]  108     ldw y,#((TOP_BORDER+1)<<8)+BOTTOM_BORDER
      009EC1 00 00 00         [ 4]  109     call line 
                                    110 ; right fence
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 104.
Hexadecimal [24-Bits]



      009EC4 00 00 00         [ 2]  111     ldw x,#(RIGHT_BORDER<<8)+RIGHT_BORDER
      009EC7 00 00 00 00      [ 2]  112     ldw y,#((TOP_BORDER+1)<<8)+BOTTOM_BORDER
      009ECB 00 00 00         [ 4]  113     call line 
      009ECE 00               [ 4]  114     ret 
                                    115 
                                    116 ;---------------------------
                                    117 ; draw sprite 
                                    118 ; input:
                                    119 ;   XH   y coord 
                                    120 ;   XL   x coord 
                                    121 ;   Y    sprite data 
                                    122 ;----------------------------
      001EB6                        123 draw_sprite:
      009ECF 00 00 00         [ 1]  124     ld a,(1,y)
      009ED2 00 00 00 00      [ 2]  125     addw y,#2
      009ED6 00 00 00         [ 2]  126     jp put_sprite
                                    127 
                                    128 ;---------------------------
                                    129 ; select head sprite from 
                                    130 ; value of snake_dir 
                                    131 ; and draw it 
                                    132 ; input:
                                    133 ;    X    position 
                                    134 ;---------------------------
      001EC0                        135 draw_head:
      009ED9 00 00 00 00      [ 2]  136     ldw y,#6 
      001EC4                        137     _ldaz snake_dir 
      009EDD 00 00                    1     .byte 0xb6,snake_dir 
      009EDF 00 00            [ 4]  138     mul y,a 
      009EE1 00 A9 1E 62      [ 2]  139     addw y,#HEAD_UP 
      000004 20 E8            [ 2]  140     jra draw_sprite  
                                    141 
                                    142 
                                    143 ;--------------------------
                                    144 ; snake initial draw 
                                    145 ;--------------------------
                           000001   146     LEN=1
                           000002   147     IDX=LEN+1 
                           000003   148     VAR_SIZE=IDX+1
      000004                        149 draw_snake:
      000004                        150     _vars VAR_SIZE
      000006 52 03            [ 2]    1     sub sp,#VAR_SIZE 
      000007 CE 00 0F         [ 2]  151     ldw x,snake_body  
      000008 CD 1E C0         [ 4]  152     call draw_head 
      00000A                        153     _ldaz snake_len
      00000B B6 0B                    1     .byte 0xb6,snake_len 
      00000C 4A               [ 1]  154     dec a  
      00000D 6B 01            [ 1]  155     ld (LEN,sp),a  
      00000F AE 00 11         [ 2]  156     ldw x,#snake_body+2 
      001EDE                        157 1$:
      009EE2 04 04            [ 2]  158     ldw (IDX,sp),x ; array index  
      009EE4 60 60 90 60      [ 2]  159     ldw y,#RING 
      009EE8 04               [ 2]  160     ldw x,(x)
      009EE9 04 40 B0         [ 4]  161     call draw_sprite
      009EEC B0 40            [ 1]  162     dec (LEN,sp) 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 105.
Hexadecimal [24-Bits]



      009EEE 04 04            [ 1]  163     jreq 9$
      009EF0 60 90            [ 2]  164     ldw x,(IDX,sp)
      009EF2 60 60 04         [ 2]  165     addw x,#2 ; next element  
      009EF5 04 20            [ 2]  166     jra 1$
      001EF3                        167 9$:
      001EF3                        168     _drop VAR_SIZE 
      009EF7 D0 D0            [ 2]    1     addw sp,#VAR_SIZE 
      009EF9 20               [ 4]  169     ret 
                                    170 
                                    171 ;---------------------
                                    172 ; shit happen 
                                    173 ;---------------------
      001EF6                        174 snake_poo:
      009EFA 04               [ 1]  175     push a 
      009EFB 04               [ 2]  176     pushw x 
      001EF8                        177     _ldaz snake_len 
      009EFC 60 90                    1     .byte 0xb6,snake_len 
      009EFE 90               [ 1]  178     dec a 
      009EFF 60               [ 1]  179     clrw x 
      009F00 05               [ 1]  180     ld xl,a 
      009F01 04 00 70         [ 2]  181     addw x,#snake_body
      009F04 F8               [ 2]  182     ldw x,(x)
      009F05 A0 04 04 40      [ 2]  183     ldw y,#POO 
      009F09 60 70 F0         [ 4]  184     call draw_sprite 
      009F0C 03               [ 2]  185     popw x 
      009F0D 01               [ 1]  186     pop a
      009F0E 70 17 00 0A      [ 1]  187     bres game_flags,#F_POO 
      009F0F 81               [ 4]  188     ret 
                                    189 
                                    190 ;-----------------------------
                                    191 ; check for collision object
                                    192 ; if not mouse then game over.
                                    193 ; if MOUSE increase score and 
                                    194 ; delete mouse. 
                                    195 ; input:  
                                    196 ;    X   position 
                                    197 ; output:
                                    198 ;    game_flags:F_FOOD_COLL
                                    199 ;    X   unchanged 
                                    200 ;-------------------------------
                           000001   201     POS=1
                           000002   202     GAIN=2
                           000002   203     VAR_SIZE=2 
      001F0F                        204 food_collision:
      009F0F AE               [ 2]  205     pushw x
      001F10                        206     _vars VAR_SIZE 
      009F10 00 C5            [ 2]    1     sub sp,#VAR_SIZE 
      009F12 90 AE            [ 1]  207     clr (GAIN,sp)  
      001F14                        208     _clrz game_flags 
      009F14 08 08                    1     .byte 0x3f, game_flags 
      009F16 CD 88            [ 1]  209     ld a,#MOUSE_WIDTH
      009F18 82 AE            [ 1]  210     add a,#SNAKE_SPRITE_WIDTH
      009F1A 00 C5            [ 1]  211     ld (POS,sp),a 
      009F1C 90               [ 1]  212     ld a,xl ; snake head x coord 
      009F1D AE BF BF         [ 1]  213     sub a,food_coord+1 ; food x coord 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 106.
Hexadecimal [24-Bits]



      009F20 CD 88            [ 1]  214     jrpl 1$ 
      009F22 82               [ 1]  215     neg a  ; abs(delta)
      001F23                        216 1$: ; delta X 
      009F23 5F 90            [ 1]  217     cp a,(POS,sp) 
      009F25 AE 09            [ 1]  218     jrpl 3$ ; if delta X >= 0 collision object not mouse 
      009F27 BF CD            [ 1]  219     ld a,#MOUSE_HEIGHT
      009F29 88 82            [ 1]  220     add a,#SNAKE_SPRITE_HEIGHT
      009F2B AE C4            [ 1]  221     ld (POS,sp),a 
      009F2D C4               [ 1]  222     ld a,xh   ; head y coord 
      009F2E 90 AE 09         [ 1]  223     sub a,food_coord ; food y coord 
      009F31 BF CD            [ 1]  224     jrpl 2$
      009F33 88               [ 1]  225     neg a 
      001F34                        226 2$: ; delta Y 
      009F34 82 81            [ 1]  227     cp a,(POS,sp)
      009F36 2B 06            [ 1]  228     jrmi 4$ 
      001F38                        229 3$: ; if delta Y >= 0 collision object not mouse 
      009F36 90 E6 01 72      [ 1]  230     bset game_flags,#F_GAME_OVER
      009F3A A9 00            [ 1]  231     jrpl 9$ 
      001F3E                        232 4$:  ; collision with mouse
                                    233 ; erase food 
      009F3C 02 CC 88         [ 2]  234     ldw x,food_coord
      009F3F F5 AE 1E 80      [ 2]  235     ldw y,#MOUSE 
      009F40 CD 1E B6         [ 4]  236     call draw_sprite
      009F40 90 AE 00 06      [ 1]  237     bset game_flags,#F_NO_FOOD 
      009F44 B6 0C 90 42      [ 1]  238     bset game_flags,#F_FOOD_COLL
      001F50                        239     _incz snake_len 
      009F48 72 A9                    1     .byte 0x3c, snake_len 
      009F4A 9E E2            [ 1]  240     inc (GAIN,sp)
      009F4C 20 E8 0D         [ 1]  241     ld a,food_coord ; mouse y coord 
      009F4E A1 09            [ 1]  242     cp a,#MIN_YCOOR 
      009F4E 52 03            [ 1]  243     jrne 5$
      009F50 CE 00            [ 1]  244     inc (GAIN,sp) ; food at top border     
      009F52 0F CD            [ 1]  245 5$: cp a,#MAX_YCOOR 
      009F54 9F 40            [ 1]  246     jrne 6$ 
      009F56 B6 0B            [ 1]  247     inc (GAIN,sp) ; food at bottom border 
      009F58 4A 6B 01         [ 1]  248 6$: ld a,food_coord+1 ; mouse x coord
      009F5B AE 00            [ 1]  249     cp a,#MIN_XCOOR 
      009F5D 11 02            [ 1]  250     jrne 7$ 
      009F5E 0C 02            [ 1]  251     inc (GAIN,sp) ; food at left border 
      009F5E 1F 02            [ 1]  252 7$: cp a,#MAX_XCOOR
      009F60 90 AE            [ 1]  253     jrne 8$
      009F62 9E FA            [ 1]  254     inc (GAIN,sp) ; food at right border 
      001F72                        255 8$: ; score+=(MAX_SPEED+1-speed)*(GAIN,sp)
      009F64 FE CD            [ 1]  256     ld a,#MAX_SPEED+1
      009F66 9F 36 0A         [ 1]  257     sub a,speed 
      009F69 01               [ 1]  258     clrw x 
      009F6A 27               [ 1]  259     ld xl,a 
      009F6B 07 1E            [ 1]  260     ld a,(GAIN,sp)
      009F6D 02               [ 4]  261     mul x,a ; gain 
      009F6E 1C               [ 1]  262     ld a,xl 
      009F6F 00 02 20 EB      [ 2]  263     addw x,score
      009F73                        264     _strxz score
      009F73 5B 03                    1     .byte 0xbf,score 
      009F75 81 06            [ 1]  265     cp a,#6
      009F76 2B 04            [ 1]  266     jrmi 81$ 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 107.
Hexadecimal [24-Bits]



      009F76 88 89 B6 0B      [ 1]  267     bset game_flags,#F_POO 
      001F8B                        268 81$:
      001F8B                        269     _clrz food_coord 
      009F7A 4A 5F                    1     .byte 0x3f, food_coord 
      001F8D                        270     _clrz food_coord+1     
      009F7C 97 1C                    1     .byte 0x3f, food_coord+1 
      009F7E 00 0F FE         [ 4]  271     call beep 
      001F92                        272 9$:
      001F92                        273     _drop VAR_SIZE
      009F81 90 AE            [ 2]    1     addw sp,#VAR_SIZE 
      009F83 9F               [ 2]  274     popw x 
      009F84 06               [ 4]  275     ret 
                                    276 
                                    277 
                                    278 ;---------------------
                                    279 ; according to 
                                    280 ; actual head position 
                                    281 ; and direction compute 
                                    282 ; next snake head 
                                    283 ; coordinates
                                    284 ; input:
                                    285 ;   X     actual position
                                    286 ; output:
                                    287 ;   X     next position 
                                    288 ;---------------------
      001F96                        289 next_head_pos:
      001F96                        290     _ldaz snake_dir 
      009F85 CD 9F                    1     .byte 0xb6,snake_dir 
      009F87 36 85            [ 1]  291     cp a,#NORTH 
      009F89 84 72            [ 1]  292     jrne 2$ 
                                    293 ; going north 
      009F8B 17 00 0A         [ 2]  294     subw x,#SNAKE_SPRITE_HEIGHT<<8
      009F8E 81 15            [ 2]  295     jra 9$        
      009F8F A1 01            [ 1]  296 2$: cp a,#EAST 
      009F8F 89 52            [ 1]  297     jrne 4$ 
                                    298 ;going east 
      009F91 02 0F 02         [ 2]  299     addw x,#SNAKE_SPRITE_WIDTH 
      009F94 3F 0A            [ 2]  300     jra 9$ 
      009F96 A6 05            [ 1]  301 4$: cp a,#SOUTH 
      009F98 AB 04            [ 1]  302     jrne 6$
                                    303 ;going south 
      009F9A 6B 01 9F         [ 2]  304     addw x,#SNAKE_SPRITE_HEIGHT<<8
      009F9D C0 00            [ 2]  305     jra 9$ 
      001FB3                        306 6$: ; going west 
      009F9F 0E 2A 01         [ 2]  307     subw x,#SNAKE_SPRITE_WIDTH 
      001FB6                        308 9$:
      009FA2 40               [ 4]  309     ret 
                                    310 
                                    311 ;------------------------------
                                    312 ; move memory block from 
                                    313 ; low address to higher address    
                                    314 ; input:
                                    315 ;    A   count 
                                    316 ;    X   destination 
                                    317 ;    Y   source 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 108.
Hexadecimal [24-Bits]



                                    318 ;-------------------------------
      009FA3                        319 move_array_up:
      009FA3 11               [ 1]  320     push a 
      009FA4 01 2A            [ 1]  321 1$: ld a,(y)
      009FA6 11 A6            [ 2]  322     decw y 
      009FA8 04               [ 1]  323     ld (x),a 
      009FA9 AB               [ 2]  324     decw x 
      009FAA 04 6B            [ 1]  325     dec (1,sp)
      009FAC 01 9E            [ 1]  326     jrne 1$ 
      001FC2                        327     _drop 1 
      009FAE C0 00            [ 2]    1     addw sp,#1 
      009FB0 0D               [ 4]  328     ret 
                                    329 
                                    330 ;-----------------------
                                    331 ; move snake 
                                    332 ;-----------------------
                           000001   333     POS=1 ; new head coordinates 
                           000003   334     HEAD=POS+2 ; actual head position 
                           000003   335     TAIL=HEAD 
                           000004   336     VAR_SIZE=HEAD+1
      001FC5                        337 move_snake:
      009FB1 2A               [ 2]  338     pushw x 
      009FB2 01 40            [ 2]  339     pushw y 
      009FB4                        340     _vars VAR_SIZE 
      009FB4 11 01            [ 2]    1     sub sp,#VAR_SIZE 
                                    341 ; erase head by drawing over it 
      009FB6 2B 06 0F         [ 2]  342     ldw x,snake_body 
      009FB8 1F 03            [ 2]  343     ldw (HEAD,sp),x 
      009FB8 72 14 00         [ 4]  344     call draw_head 
                                    345 ; draw ring at head position     
      009FBB 0A 2A            [ 2]  346     ldw x,(HEAD,sp)  ; head position 
      009FBD 54 AE 1E 7A      [ 2]  347     ldw y,#RING 
      009FBE CD 1E B6         [ 4]  348     call draw_sprite 
                                    349 ;draw head at new position 
      009FBE CE 00            [ 2]  350     ldw x,(HEAD,sp)
      009FC0 0D 90 AE         [ 4]  351     call next_head_pos
      009FC3 9F 00            [ 2]  352     ldw (POS,sp),x
      009FC5 CD 9F 36         [ 4]  353     call draw_head
      009FC8 72 12            [ 1]  354     jreq 1$
                                    355 ;collision deteted  
      009FCA 00 0A            [ 2]  356     ldw x,(POS,sp)
      009FCC 72 10 00         [ 4]  357     call food_collision 
      009FCF 0A 3C 0B 0C 02   [ 2]  358     btjt game_flags,#F_GAME_OVER,9$
      001FF1                        359 1$: 
                                    360 ; move array elements 1 cell toward tail 
      001FF1                        361     _ldaz snake_len
      009FD4 C6 00                    1     .byte 0xb6,snake_len 
      009FD6 0D               [ 1]  362     dec a
      009FD7 A1               [ 1]  363     sll a 
      009FD8 09               [ 1]  364     clrw x 
      009FD9 26               [ 1]  365     ld xl,a 
      009FDA 02 0C 02         [ 2]  366     addw x,#snake_body ; last array element 
      009FDD A1 BB            [ 1]  367     ldw y,x 
      009FDF 26               [ 2]  368     ldw x,(x)
      009FE0 02 0C            [ 2]  369     ldw (TAIL,sp),x ; last ring position  
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 109.
Hexadecimal [24-Bits]



      009FE2 02               [ 1]  370     ldw x,y 
      009FE3 C6 00            [ 2]  371     decw y 
      009FE5 0E               [ 1]  372     incw x 
      002003                        373     _ldaz snake_len 
      009FE6 A1 01                    1     .byte 0xb6,snake_len 
      009FE8 26               [ 1]  374     dec a 
      009FE9 02               [ 1]  375     sll a     
      009FEA 0C 02 A1         [ 4]  376     call move_array_up 
                                    377 ; set 1 element as new head position 
      009FED C0 26            [ 2]  378     ldw x,(POS,sp)
      009FEF 02 0C 02         [ 2]  379     ldw snake_body,x    
      009FF2 72 00 00 0A 0B   [ 2]  380     btjt game_flags,#F_FOOD_COLL,8$
                                    381 ; erase last ring 
      009FF2 A6 0A            [ 2]  382     ldw x,(TAIL,sp)
      009FF4 C0 00 06 5F      [ 2]  383     ldw y,#RING
      009FF8 97 7B 02         [ 4]  384     call draw_sprite
      009FFB 42 9F            [ 2]  385     jra 9$ 
      00201F                        386 8$:
      009FFD 72 BB 00 04 BF   [ 2]  387     btjf game_flags,#F_POO,9$ 
      00A002 04 A1 06         [ 4]  388     call snake_poo 
      002027                        389 9$:
      002027                        390     _drop VAR_SIZE 
      00A005 2B 04            [ 2]    1     addw sp,#VAR_SIZE 
      00A007 72 16            [ 2]  391     popw y 
      00A009 00               [ 2]  392     popw x  
      00A00A 0A               [ 4]  393     ret 
                                    394 
                                    395 
                                    396 ;--------------------------
                                    397 ; rotate snake head 
                                    398 ; input
                                    399 ;     A   {LEFT,RIGHT}
                                    400 ;--------------------------
      00A00B                        401 rotate_head:
      00A00B 3F               [ 1]  402     push a 
      00202E                        403     _ldaz snake_dir 
      00A00C 0D 3F                    1     .byte 0xb6,snake_dir 
      00A00E 0E CD 80 FC      [ 2]  404     ldw y,#6 
      00A012 90 42            [ 4]  405     mul y,a 
      00A012 5B 02 85 81      [ 2]  406     addw y,#HEAD_UP
      00A016 CE 00 0F         [ 2]  407     ldw x,snake_body 
      00A016 B6 0C A1         [ 4]  408     call draw_sprite 
      00A019 00               [ 1]  409     pop a 
      00A01A 26 05            [ 1]  410     cp a,#BTN_LEFT 
      00A01C 1D 04            [ 1]  411     jrne 2$ 
      002045                        412     _ldaz snake_dir 
      00A01E 00 20                    1     .byte 0xb6,snake_dir 
      00A020 15               [ 1]  413     dec a 
      00A021 A1 01            [ 2]  414     jra 4$ 
      00204A                        415 2$: _ldaz snake_dir 
      00A023 26 05                    1     .byte 0xb6,snake_dir 
      00A025 1C               [ 1]  416     inc a 
      00A026 00 04            [ 1]  417 4$: and a,#3 
      00204F                        418     _straz snake_dir 
      00A028 20 0C                    1     .byte 0xb7,snake_dir 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 110.
Hexadecimal [24-Bits]



      00A02A A1 02 26 05      [ 2]  419     ldw y,#6
      00A02E 1C 04            [ 4]  420     mul y,a 
      00A030 00 20 03 62      [ 2]  421     addw y,#HEAD_UP 
      00A033 CE 00 0F         [ 2]  422     ldw x,snake_body 
      00A033 1D 00 04         [ 4]  423     call draw_sprite 
      00A036 81               [ 4]  424     ret 
                                    425 
                                    426 ;--------------------------
                                    427 ; read keypad 
                                    428 ; LEFT turn left 
                                    429 ; RIGHT turn right 
                                    430 ; UP increase speed 
                                    431 ; DOWN decreas speed 
                                    432 ;--------------------------
                           000001   433     KPAD=1
      002062                        434 user_input:
      00A036 81 00            [ 1]  435     push #0 
      00A037 CD 00 D5         [ 4]  436     call read_keypad
      00A037 88 90            [ 1]  437     jreq 8$ 
      00A039 F6 90            [ 1]  438     ld (KPAD,sp),a  
      00A03B 5A F7            [ 1]  439     ld a,#BTN_LEFT 
      00A03D 5A 0A            [ 1]  440     and a,(KPAD,sp)
      00A03F 01 26            [ 1]  441     jreq 2$ 
      00A041 F6 5B 01         [ 4]  442     call rotate_head
      00A044 81 31            [ 2]  443     jra 6$
      00A045 A6 04            [ 1]  444 2$: ld a,#BTN_RIGHT 
      00A045 89 90            [ 1]  445     and a,(KPAD,sp)
      00A047 89 52            [ 1]  446     jreq 3$ 
      00A049 04 CE 00         [ 4]  447     call rotate_head
      00A04C 0F 1F            [ 2]  448     jra 6$ 
      002081                        449 3$:
      00A04E 03 CD            [ 1]  450     ld a,#BTN_UP 
      00A050 9F 40            [ 1]  451     and a,(KPAD,sp)
      00A052 1E 03            [ 1]  452     jreq 4$
      00A054 90 AE            [ 1]  453     ld a,#MIN_SPEED 
      00A056 9E FA CD         [ 1]  454     cp a,speed 
      00A059 9F 36            [ 1]  455     jreq 6$  
      00208E                        456     _decz speed
      00A05B 1E 03                    1     .byte 0x3a,speed 
      00A05D CD A0 16         [ 4]  457     call prt_info 
      00A060 1F 01            [ 2]  458     jra 6$ 
      00A062 CD 9F            [ 1]  459 4$: ld a,#BTN_DOWN 
      00A064 40 27            [ 1]  460     and a,(KPAD,sp)
      00A066 0A 1E            [ 1]  461     jreq 6$
      00A068 01 CD            [ 1]  462     ld a,#MAX_SPEED 
      00A06A 9F 8F 72         [ 1]  463     cp a,speed 
      00A06D 04 00            [ 1]  464     jreq 6$
      0020A2                        465     _incz speed
      00A06F 0A 36                    1     .byte 0x3c, speed 
      00A071 CD 21 19         [ 4]  466     call prt_info  
      0020A7                        467 6$:
      00A071 B6 0B 4A         [ 2]  468     ldw x,#10
      00A074 48 5F 97         [ 4]  469     call wait_key_release
      0020AD                        470 8$:
      0020AD                        471     _drop 1 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 111.
Hexadecimal [24-Bits]



      00A077 1C 00            [ 2]    1     addw sp,#1 
      00A079 0F               [ 4]  472     ret 
                                    473 
                                    474 ;-----------------------
                                    475 ; when snake eat mouse 
                                    476 ; reset chronometer 
                                    477 ;-----------------------
      0020B0                        478 chrono_reset:
      00A07A 90 93            [ 1]  479     push #CHRONO_DELAY
      0020B2                        480 1$:
      0020B2                        481     _ldaz chrono 
      00A07C FE 1F                    1     .byte 0xb6,chrono 
      00A07E 03 93            [ 1]  482     cp a,(1,sp)
      00A080 90 5A            [ 1]  483     jrpl 9$ 
      00A082 5C B6            [ 1]  484     ld a,#VRES-1 
      00A084 0B 4A 48         [ 1]  485     sub a,chrono
      00A087 CD               [ 1]  486     ld xh,a  
      00A088 A0 37            [ 1]  487     ld a,#RIGHT_BORDER+1
      00A08A 1E               [ 1]  488     ld xl,a 
      00A08B 01 CF 00 0F      [ 2]  489     ldw y,#CHRONO_BAR
      00A08F 72 00 00         [ 4]  490     call draw_sprite
      0020C8                        491     _incz chrono 
      00A092 0A 0B                    1     .byte 0x3c, chrono 
      00A094 1E 03            [ 2]  492     jra 1$  
      0020CC                        493 9$: _drop 1 
      00A096 90 AE            [ 2]    1     addw sp,#1 
      00A098 9E               [ 4]  494     ret 
                                    495 
                                    496 ;-------------------------
                                    497 ; decrement chrono 
                                    498 ; remove a chrono tick 
                                    499 ;-------------------------
      0020CF                        500 chrono_decr:
      0020CF                        501     _decz chrono 
      00A099 FA CD                    1     .byte 0x3a,chrono 
      00A09B 9F 36            [ 1]  502     ld a,#VRES-1 
      00A09D 20 08 07         [ 1]  503     sub a,chrono 
      00A09F 95               [ 1]  504     ld xh,a 
      00A09F 72 07            [ 1]  505     ld a,#(RIGHT_BORDER+1)
      00A0A1 00               [ 1]  506     ld xl,a 
      00A0A2 0A 03 CD 9F      [ 2]  507     ldw y,#CHRONO_BAR 
      00A0A6 76 1E B6         [ 4]  508     call draw_sprite 
      00A0A7 72 5D 00 07      [ 1]  509     tnz chrono 
      00A0A7 5B               [ 4]  510     ret 
                                    511 
                                    512 ;-------------------------
                                    513 ; create a new mouse 
                                    514 ; at random position 
                                    515 ;-------------------------
      0020E6                        516 new_food:
      00A0A8 04 90 85         [ 4]  517     call prng
      00A0AB 85 81            [ 1]  518     ld a,#PG_HEIGHT 
      00A0AD 62               [ 2]  519     div x,a 
      00A0AD 88 B6            [ 1]  520     add a,#MIN_YCOOR
      0020EE                        521     _straz food_coord 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 112.
Hexadecimal [24-Bits]



      00A0AF 0C 90                    1     .byte 0xb7,food_coord 
      00A0B1 AE 00 06         [ 4]  522     call prng 
      00A0B4 90 42            [ 1]  523     ld a,#PG_WIDTH 
      00A0B6 72               [ 2]  524     div x,a 
      00A0B7 A9 9E            [ 1]  525     add a,#MIN_XCOOR
      0020F8                        526     _straz food_coord+1
      00A0B9 E2 CE                    1     .byte 0xb7,food_coord+1 
      00A0BB 00 0F CD         [ 2]  527     ldw x,food_coord 
      00A0BE 9F 36 84 A1      [ 2]  528     ldw y,#MOUSE 
      00A0C2 01 26 05         [ 4]  529     call draw_sprite 
      00A0C5 B6               [ 1]  530     tnz a 
      00A0C6 0C 4A            [ 1]  531     jreq 9$ 
      00A0C8 20 03 B6         [ 2]  532     ldw x,food_coord 
      00A0CB 0C 4C A4 03      [ 2]  533     ldw y,#MOUSE 
      00A0CF B7 0C 90         [ 4]  534     call draw_sprite 
      00A0D2 AE 00            [ 2]  535     jra new_food 
      002113                        536 9$: _clrz game_flags
      00A0D4 06 90                    1     .byte 0x3f, game_flags 
      00A0D6 42 72 A9         [ 4]  537     call chrono_reset 
      00A0D9 9E               [ 4]  538     ret 
                                    539 
                                    540 ;----------------------
                                    541 ; print score top left 
                                    542 ; corner 
                                    543 ;----------------------
      002119                        544 prt_info:
      00A0DA E2               [ 2]  545     pushw x 
      00211A                        546     _clrz cx 
      00A0DB CE 00                    1     .byte 0x3f, cx 
      00211C                        547     _clrz cy 
      00A0DD 0F CD                    1     .byte 0x3f, cy 
      00A0DF 9F 36 81 52      [ 2]  548     ldw y,#score_str
      00A0E2 CD 07 D2         [ 4]  549     call tv_puts 
      002125                        550     _ldxz score 
      00A0E2 4B 00                    1     .byte 0xbe,score 
      00A0E4 CD 81 55         [ 4]  551     call put_uint16
      00A0E7 27 44            [ 1]  552     ld a,#12
      00212C                        553     _straz cx 
      00A0E9 6B 01                    1     .byte 0xb7,cx 
      00A0EB A6 01 14 01      [ 2]  554     ldw y,#speed_str 
      00A0EF 27 05 CD         [ 4]  555     call tv_puts
      00A0F2 A0 AD            [ 1]  556     ld a,#MAX_SPEED+1 
      00A0F4 20 31 A6         [ 1]  557     sub a,speed 
      00A0F7 04               [ 1]  558     clrw x 
      00A0F8 14               [ 1]  559     ld xl,a 
      00A0F9 01 27 05         [ 4]  560     call put_uint16
      00A0FC CD A0            [ 1]  561     ld a,#24
      002141                        562     _straz cx 
      00A0FE AD 20                    1     .byte 0xb7,cx 
      00A100 26 AE 21 60      [ 2]  563     ldw y,#max_str 
      00A101 CD 07 D2         [ 4]  564     call tv_puts 
      00A101 A6 08 14         [ 2]  565     ldw x,max_score
      00A104 01 27 0E         [ 4]  566     call put_uint16
      00A107 A6               [ 2]  567     popw x
      00A108 01               [ 4]  568     ret 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 113.
Hexadecimal [24-Bits]



      00A109 C1 00 06 27 19 3A 06   569 score_str: .asciz "SCORE:"
      00A110 CD A1 99 20 12 A6 02   570 speed_str: .asciz "SPEED:"  
      00A117 14 01 27 0C A6         571 max_str: .asciz "max:"
                                    572 
                                    573 ;-------------------------
                                    574 ; game initialization
                                    575 ;-------------------------
      002165                        576 snake_init:
      00A11C 09 C1            [ 1]  577     ld a,#(1<<F_NO_FOOD)
      002167                        578     _straz game_flags 
      00A11E 00 06                    1     .byte 0xb7,game_flags 
      002169                        579     _clrz chrono 
      00A120 27 05                    1     .byte 0x3f, chrono 
      00A122 3C 06            [ 1]  580     ld a,#5 
      00216D                        581     _straz speed
      00A124 CD A1                    1     .byte 0xb7,speed 
      00A126 99               [ 1]  582     clrw x 
      00A127                        583     _strxz score 
      00A127 AE 00                    1     .byte 0xbf,score 
      002172                        584     _strxz food_coord
      00A129 0A CD                    1     .byte 0xbf,food_coord 
      00A12B 81 7E A3         [ 4]  585     call set_seed  ; using ticks 
      00A12D A6 03            [ 1]  586     ld a,#3
      002179                        587     _straz snake_len 
      00A12D 5B 01                    1     .byte 0xb7,snake_len 
      00A12F 81 01            [ 1]  588     ld a,#EAST
      00A130                        589     _straz snake_dir
      00A130 4B 7F                    1     .byte 0xb7,snake_dir 
      00A132 AE 00 0F         [ 2]  590     ldw x,#snake_body 
      00A132 B6 07 11 01      [ 2]  591     ldw y,#(31<<8)+48 
      00A136 2A               [ 2]  592     ldw (x),y
      00A137 14 A6 BF C0      [ 2]  593     subw y,#SNAKE_SPRITE_WIDTH
      00A13B 00 07            [ 2]  594     ldw (2,x),y 
      00A13D 95 A6 C5 97      [ 2]  595     subw y,#SNAKE_SPRITE_WIDTH
      00A141 90 AE            [ 2]  596     ldw (4,x),y 
      00A143 9F 0C CD         [ 4]  597     call tv_cls
      00A146 9F 36 3C         [ 4]  598     call draw_walls
      00A149 07 20 E6         [ 4]  599     call draw_snake 
      00A14C 5B               [ 4]  600     ret 
                                    601 
                                    602 ;-------------------------
                                    603 ; game main routine
                                    604 ;-------------------------
      00219D                        605 snake:
      00A14D 01 81 65         [ 4]  606     call snake_init
      00A14F A6 1E            [ 1]  607     ld a,#30
      00A14F 3A 07 A6         [ 4]  608     call pause
      0021A5                        609 1$: 
      00A152 BF C0 00 07 95   [ 2]  610     btjf game_flags,#F_NO_FOOD,2$
      00A157 A6 C5 97         [ 4]  611     call prt_info 
      00A15A 90 AE 9F         [ 4]  612     call new_food 
      0021B0                        613 2$:
      00A15D 0C CD 9F         [ 4]  614     call move_snake 
      00A160 36 72 5D 00 07   [ 2]  615     btjt game_flags,#F_GAME_OVER,game_over  
      00A165 81 20 62         [ 4]  616     call user_input
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 114.
Hexadecimal [24-Bits]



      00A166 CD 20 CF         [ 4]  617     call chrono_decr  
      00A166 CD 82            [ 1]  618     jreq timeout
      0021C0                        619     _ldaz speed 
      00A168 01 A6                    1     .byte 0xb6,speed 
      00A16A B6 62 AB         [ 4]  620     call noise 
      00A16D 09 B7            [ 2]  621     jra 1$
      0021C7                        622 timeout:
      00A16F 0D CD 82         [ 2]  623     ldw x,#(12<<8)+10 
      0021CA                        624     _strxz cy 
      00A172 01 A6                    1     .byte 0xbf,cy 
      00A174 C3 62 AB 01      [ 2]  625     ldw y,#timeout_str
      00A178 B7 0E CE         [ 4]  626     call tv_puts 
      00A17B 00 0D            [ 1]  627     ld a,#60 
      00A17D 90 AE 9F         [ 4]  628     call pause
      0021D8                        629 game_over:
      0021D8                        630     _ldxz score 
      00A180 00 CD                    1     .byte 0xbe,score 
      00A182 9F 36 4D         [ 2]  631     cpw x,max_score 
      00A185 27 0C            [ 1]  632     jrmi 4$ 
      0021DF                        633     _strxz max_score
      00A187 CE 00                    1     .byte 0xbf,max_score 
      0021E1                        634 4$:
      00A189 0D 90 AE         [ 2]  635     ldw x,#0xffff 
      00A18C 9F 00 CD         [ 4]  636     call wait_key_release
      00A18F 9F 36 20         [ 4]  637     call tv_cls 
      00A192 D3 3F 0A CD      [ 2]  638     ldw y,#gover 
      00A196 A1 30 81         [ 4]  639     call tv_puts 
      00A199 90 AE 21 52      [ 2]  640     ldw y,#score_str
      00A199 89 3F F4         [ 4]  641     call tv_puts 
      0021F8                        642     _ldxz score 
      00A19C 3F F3                    1     .byte 0xbe,score 
      00A19E 90 AE A1         [ 4]  643     call put_uint16
      00A1A1 D2 CD 88         [ 4]  644     call crlf 
      00A1A4 52 BE 04 CD      [ 2]  645     ldw y,#prompt 
      00A1A8 88 5E A6         [ 4]  646     call tv_puts 
      002207                        647 6$:
      00A1AB 0C B7 F4         [ 4]  648     call wait_key 
      00A1AE 90 AE            [ 1]  649     cp a,#BTN_A 
      00A1B0 A1 D9            [ 1]  650     jreq snake 
      00A1B2 CD 88            [ 1]  651     cp a,#BTN_B 
      00A1B4 52 A6            [ 1]  652     jreq 9$
      00A1B6 0A C0            [ 2]  653     jra 6$
      002214                        654 9$:     
      00A1B8 00               [ 4]  655     ret 
                                    656 
      00A1B9 06 5F 97 CD 88 5E A6   657 gover: .asciz "game over\r"
             18 B7 F4 90
      00A1C4 AE A1 E0 CD 88 52 CE   658 timeout_str: .asciz "TIME OUT" 
             00 08
      00A1CD CD 88 5E 85 81 53 43   659 prompt: .asciz "A new game\rB exit"
             4F 52 45 3A 00 53 50
             45 45 44 3A
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 115.
Hexadecimal [24-Bits]



                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2023,2024  
                                      3 ; This file is part of stm8-gamepad
                                      4 ;
                                      5 ;     stm8-gamepadis free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     stm8-gamepadis distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with ntsc_tuto.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                                     19 ;-------------------
                                     20 ; FALL 
                                     21 ; TRETIS  inspired  
                                     22 ;-------------------
                                     23 
                           000008    24 TETRA_WIDTH=8 ; 8x8 pixels tetrahedrons blocks 
                           000050    25 WELL_WIDTH=TETRA_WIDTH*10
                           0000B0    26 WELL_DEPTH=TETRA_WIDTH*22
                                     27  
                                     28     .area G_DATA 
                                     29 
                                     30     .area CODE 
                                     31 ; sprites 
      00A1DF 00 6D 61 78 3A 00       32 I0: .byte 4,1,0xff,0xff,0xff,0xff; horizontal I 
      00A1E5 01 04 FF FF FF FF       33 I1: .byte 1,4,0xff,0xff,0xff,0xff ; vertical I 
      00A1E5 A6 02 B7 0A 3F 07       34 SQUARE: .byte 2,2,0xff,0xff,0xff,0xff 
      00A1EB A6 05 B7 06 5F BF       35 T0: .byte 6,4,0xfc,0xfc,0x30,0x30 ; normal T 
      00A1F1 04 BF 0D CD 82 23 A6    36 T1: .byte 4,6,0x30,0x30,0xf0,0xf0,0x30,0x30 ; T rotated right  
             03
      00A1F9 B7 0B A6 01 B7 0C AE    37 T2: .byte 4,6,0xc0,0xc0,0xf0,0xf0,0xc0,0xc0 ; T rotated left 
             00
      00A201 0F 90 AE 1F 30 FF       38 T3: .byte 6,4,0x30,0x30,0xf0,0xf0 ; T upside down 
      00A207 72 A2 00 04 EF 02       39 L0: .byte 6,4,0xfc,0xfc,0xc0,0xc0 ; L rotated right 
      00A20D 72 A2 00 04 EF 04 CD    40 L1: .byte 4,6,0xf0,0xf0,0x30,0x30,0x30,0x30 ; L upside down 
             87
      00A215 35 CD 9F 0F CD 9F       41 L2: .byte 6,4,0xc,0xc,0xfc,0xfc ; L rotated left 
      00A21B 4E 81 C0 C0 C0 FC FC    42 L3: .byte 4,6,0xc0,0xc0,0xc0,0xfc,0xfc ; L upside 
      00A21D 06 04 FC FC 0C 0C       43 J0: .byte 6,4,0xfc,0xfc,0xc,0xc ; J rotated left 
      00A21D CD A1 E5 A6 1E CD 80    44 J1:  .byte 4,6,0xc0,0xc0,0xc0,0xc0,0xfc,0xfc ; J upside 
             B3
      00A225 06 04 C0 C0 FC FC       45 J2: .byte 6,4,0xc0,0xc0,0xfc,0xfc ; j rotated right 
      00A225 72 03 00 0A 06 CD A1    46 J3: .byte 4,6,0xfc,0xfc,0xc,0xc,0xc,0xc  ; j upside down 
             99
      00A22D CD A1 66 F0 3C 3C       47 Z0: .byte 6,4,0xf0,0xf0,0x3c,0x3c ; 
      00A230 04 06 30 30 3C 30 C0    48 Z1: .byte 4,6,0x30,0x30,0x3c,0x30,0xc0,0xc0 
             C0
      00A230 CD A0 45 72 04 00       49 S0: .byte 6,4,0x3c,0x3c,0xf0,0xf0 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 116.
Hexadecimal [24-Bits]



      00A236 0A 20 CD A0 E2 CD A1    50 S1: .byte 4,6,0xc0,0xc0,0xf0,0xf0,0xc,0xc 
             4F
                                     51 
                                     52 ;--------------------
                                     53 ; draw the well in 
                                     54 ; wich tetrahedrons 
                                     55 ; falls.
                                     56 ;--------------------
      0022BC                         57 draw_well:
                                     58 ; left side 
      00A23E 27 07 B6         [ 2]   59     ldw x,#(0<<8)+0
      00A241 06 CD 81 26      [ 2]   60     ldw y,#((VRES-WELL_DEPTH)<<8)+VRES
      00A245 20 DE 02         [ 4]   61     call line
                                     62 ;bottom  
      00A247 AE 01 51         [ 2]   63     ldw x,#(1<<8)+WELL_WIDTH+1 
      00A247 AE 0C 0A BF      [ 2]   64     ldw y,#((VRES-1)<<8)+VRES-1
      00A24B F3 90 AE         [ 4]   65     call line 
                                     66 ;right side
      00A24E A2 A0 CD         [ 2]   67     ldw x,#((WELL_WIDTH+1)<<8)+WELL_WIDTH+1
      00A251 88 52 A6 3C      [ 2]   68     ldw y,#((VRES-WELL_DEPTH)<<8)+VRES
      00A255 CD 80 B3         [ 4]   69     call line 
      00A258 81               [ 4]   70     ret 
                                     71 
                                     72 ;-------------------------
                                     73 ; initialize game 
                                     74 ;-------------------------
      0022DB                         75 fall_init:
      00A258 BE 04 C3         [ 4]   76     call tv_cls  
      00A25B 00 08 2B         [ 4]   77     call draw_well 
      00A25E 02               [ 4]   78     ret 
                                     79 
      0022E2                         80 fall:
      00A25F BF 08 DB         [ 4]   81     call fall_init
      00A261 CD 00 F8         [ 4]   82     call wait_key 
      00A261 AE               [ 4]   83     ret 
                                     84 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 117.
Hexadecimal [24-Bits]



                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2023,2024  
                                      3 ; This file is part of stm8-gamepad
                                      4 ;
                                      5 ;     stm8-gamepad is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     stm8-gamepad is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with ntsc_tuto.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                                     19 ;--------------------------------
                                     20 ; game of life 
                                     21 ; John H. Conway 
                                     22 ; cellular automaton simulation 
                                     23 ;--------------------------------
                                     24 
                           000020    25 GRID_WIDTH=32
                           000004    26 GRID_ROW_BYTES=4
                           000016    27 GRID_HEIGHT=22
                           000058    28 GRID_SIZE=(GRID_ROW_BYTES*GRID_HEIGHT)
                           000000    29 GRID_LEFT=0
                           000001    30 GRID_TOP=1
                           00000F    31 GRID_CNTR_X=(GRID_WIDTH)/2-1
                           00000A    32 GRID_CNTR_Y=(GRID_HEIGHT)/2-1
                           00007F    33 BLOCK=127
                           000084    34 CELL=132 
                           000020    35 EMPTY=SPACE 
                                     36 
                                     37     .area G_DATA (ABS)
      000004                         38     .org 4 
      000004                         39 gen: .blkw 1 ; generation
      000006                         40 src: .blkw 1 ; source grid address 
      000008                         41 dest: .blkw 1 ; dest grid address 
      00000A                         42 grid1: .blkb GRID_SIZE 
      000062                         43 grid2: .blkb GRID_SIZE
                                     44 
                                     45     .area CODE 
                                     46 
      0022E9                         47 print_gen:
      00A262 FF               [ 2]   48     pushw x
      00A263 FF CD 81         [ 2]   49     ldw x,#12
      0022ED                         50     _strxz cy 
      00A266 7E CD                    1     .byte 0xbf,cy 
      0022EF                         51     _ldxz gen 
      00A268 87 35                    1     .byte 0xbe,gen 
      00A26A 90 AE A2         [ 4]   52     call put_uint16
      00A26D 95               [ 2]   53     popw x 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 118.
Hexadecimal [24-Bits]



      00A26E CD               [ 4]   54     ret 
                                     55 
                                     56 ;------------------------
                                     57 ; program initialization
                                     58 ;------------------------
      0022F6                         59 life_init:
      00A26F 88               [ 1]   60     clrw x
      0022F7                         61     _strxz gen 
      00A270 52 90                    1     .byte 0xbf,gen 
      00A272 AE A1 D2         [ 2]   62     ldw x,#2*GRID_SIZE
      00A275 CD 88 52 BE      [ 2]   63     ldw y,#grid1
      002300                         64     _stryz src 
      00A279 04 CD 88                 1     .byte 0x90,0xbf,src 
      00A27C 5E               [ 1]   65     clr a 
      00A27D CD 87 BD         [ 4]   66     call fill
      00A280 90 AE A2         [ 2]   67     ldw x,#grid2 
      00230A                         68     _strxz dest
      00A283 A9 CD                    1     .byte 0xbf,dest 
      00A285 88               [ 4]   69     ret 
                                     70 
                                     71 ;------------------------
                                     72 ; compute cell byte index
                                     73 ; in array  
                                     74 ; input:
                                     75 ;    XL   x coord 
                                     76 ;    XH   y coord 
                                     77 ; output:
                                     78 ;    A     bit mask
                                     79 ;    X     unchanged
                                     80 ;    Y     array byte index  
                                     81 ;-----------------------     
                           000001    82     YCOOR=1
                           000002    83     XCOOR=2 
      00230D                         84 cell_index:
      00A286 52               [ 2]   85     pushw x 
      00A287 90 AE 00 04      [ 2]   86     ldw y,#GRID_ROW_BYTES 
      00A287 CD 81            [ 1]   87     ld a,(YCOOR,sp)
      00A289 78 A1            [ 4]   88     mul y,a 
      00A28B 20               [ 1]   89     clr a 
      00A28C 27               [ 1]   90     ld xh,a  
      00A28D 8F A1            [ 1]   91     ld a,#8 
      00A28F 10               [ 2]   92     div x,a 
      00231B                         93    _strxz acc16 
      00A290 27 02                    1     .byte 0xbf,acc16 
      00A292 20 F3 00 E4      [ 2]   94     addw y,acc16 
      00A294 CD 06 CC         [ 4]   95     call bit_mask
      00A294 81               [ 2]   96     popw x 
      00A295 67               [ 4]   97     ret 
                                     98 
                                     99 ;-------------------
                                    100 ; get cell state 
                                    101 ; from array   
                                    102 ; input:
                                    103 ;    XL   x coord 
                                    104 ;    XH   y coord
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 119.
Hexadecimal [24-Bits]



                                    105 ;     Y   array addr   
                                    106 ; output:
                                    107 ;    A   cell state
                                    108 ;    X   unchanged   
                                    109 ;    Y   unchanged   
                                    110 ;------------------
      002326                        111 get_cell_state:
      00A296 61               [ 2]  112     pushw x 
      00A297 6D 65            [ 2]  113     pushw y 
      00A299 20 6F 76         [ 4]  114     call cell_index 
      00A29C 65 72 0D         [ 2]  115     addw y,(1,sp) 
      00A29F 00 54            [ 1]  116     and a,(y)
      00A2A1 49 4D            [ 2]  117     popw y 
      00A2A3 45               [ 2]  118     popw x
      00A2A4 20               [ 4]  119     ret 
                                    120 
                                    121 ;-------------------------
                                    122 ; put cell state to display
                                    123 ; input:
                                    124 ;    XL   x coord 
                                    125 ;    XH   y coord  
                                    126 ;    Y    array addr
                                    127 ; output:
                                    128 ;    X   display {x,y} coordinates
                                    129 ;    Y   unchanged   
                                    130 ;---------------------------
      002335                        131 display_cell:
      00A2A5 4F 55 54         [ 4]  132     call get_cell_state
      00A2A8 00 41            [ 1]  133     push #SPACE 
      00A2AA 20               [ 1]  134     tnz a 
      00A2AB 6E 65            [ 1]  135     jreq 1$ 
      00A2AD 77 20            [ 1]  136     ld a,#CELL 
      00A2AF 67 61            [ 1]  137     ld (1,sp),a 
      002341                        138 1$:
      00A2B1 6D               [ 1]  139     pop a 
      002342                        140 display_char:    
      00A2B2 65 0D 42         [ 2]  141     addw x,#(GRID_TOP<<8)+GRID_LEFT
      002345                        142     _strxz cy 
      00A2B5 20 65                    1     .byte 0xbf,cy 
      00A2B7 78 69 74         [ 4]  143     call tv_putc 
      00A2BA 00               [ 4]  144     ret 
                                    145 
                                    146 ;-------------------------
                                    147 ; toggle cell state at 
                                    148 ; input:
                                    149 ;    XL   gx 
                                    150 ;    XH   gy
                                    151 ;    Y    array addr 
                                    152 ; output:
                                    153 ;     A    inverted cell state 
                                    154 ;     X    unchanged  
                                    155 ;     Y    unchanged 
                                    156 ;-------------------------- 
      00234B                        157 toggle_cell:
      00A2BB 04 01            [ 2]  158     pushw y 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 120.
Hexadecimal [24-Bits]



      00A2BD FF FF FF         [ 4]  159     call cell_index  
      00A2C0 FF 01 04         [ 2]  160     addw y,(1,sp)
      00A2C3 FF FF            [ 1]  161     xor a,(y)
      00A2C5 FF FF            [ 1]  162     ld (y),a 
      00A2C7 02 02            [ 2]  163     popw y 
      00A2C9 FF               [ 4]  164     ret 
                                    165 
                                    166 ;---------------------
                                    167 ; set cell bit in array 
                                    168 ; input:
                                    169 ;   XL   xcoord 
                                    170 ;   XH   ycoord 
                                    171 ;   Y    array addr 
                                    172 ; output:
                                    173 ;   X    unchanged 
                                    174 ;   y    unchanged 
                                    175 ;------------------------ 
      00235A                        176 set_cell:
      00A2CA FF FF            [ 2]  177     pushw y
      00A2CC FF 06 04         [ 4]  178     call cell_index 
      00A2CF FC FC 30         [ 2]  179     addw y,(1,sp)
      00A2D2 30 04            [ 1]  180     or a,(y)
      00A2D4 06 30            [ 1]  181     ld (y),a 
      00A2D6 30 F0            [ 2]  182     popw y 
      00A2D8 F0               [ 4]  183     ret 
                                    184 
                                    185 ;--------------------------
                                    186 ; get top row neighbors
                                    187 ; count
                                    188 ; input:
                                    189 ;    XL   x coord 
                                    190 ;    XH   y coord 
                                    191 ;    Y    grid addr 
                                    192 ; output:
                                    193 ;    A    count
                                    194 ;    X    not changed 
                                    195 ;    Y    not changed 
                                    196 ;--------------------------
                           000001   197     YCOOR=1
                           000002   198     XCOOR=YCOOR+1 
                           000003   199     ADDR=XCOOR+1 
                           000005   200     COUNT=ADDR+2  
                           000005   201     VAR_SIZE=COUNT 
      002369                        202 top_count:
      002369                        203     _vars VAR_SIZE 
      00A2D9 30 30            [ 2]    1     sub sp,#VAR_SIZE 
      00A2DB 04 06            [ 1]  204     clr (COUNT,sp)
      00A2DD C0 C0            [ 2]  205     ldw (YCOOR,sp),x 
      00A2DF F0 F0            [ 2]  206     ldw (ADDR,sp),y 
      00A2E1 C0               [ 1]  207     ld a,xh 
      00A2E2 C0               [ 1]  208     tnz a 
      00A2E3 06 04            [ 1]  209     jreq 9$ ; not top neighbors
      00A2E5 30               [ 1]  210     dec a 
      00A2E6 30               [ 1]  211     ld xh,a 
      00A2E7 F0 F0 06         [ 4]  212     call get_cell_state
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 121.
Hexadecimal [24-Bits]



      00A2EA 04 FC            [ 1]  213     jreq 1$ 
      00A2EC FC C0            [ 1]  214     inc (COUNT,sp)
      00A2EE C0               [ 1]  215 1$: ld a,xl 
      00A2EF 04               [ 1]  216     dec a 
      00A2F0 06 F0            [ 1]  217     jrmi 2$ ; no left neighbor
      00A2F2 F0               [ 1]  218     ld xl,a 
      00A2F3 30 30 30         [ 4]  219     call get_cell_state
      00A2F6 30 06            [ 1]  220     jreq 2$ 
      00A2F8 04 0C            [ 1]  221     inc (COUNT,sp)
      00A2FA 0C FC            [ 1]  222 2$: ld a,(XCOOR,sp) 
      00A2FC FC               [ 1]  223     inc a 
      00A2FD 04 06            [ 1]  224     cp a,#GRID_WIDTH 
      00A2FF C0 C0            [ 1]  225     jreq 9$
      00A301 C0               [ 1]  226     ld xl,a  
      00A302 FC FC 06         [ 4]  227     call get_cell_state
      00A305 04 FC            [ 1]  228     jreq 9$ 
      00A307 FC 0C            [ 1]  229     inc (COUNT,sp)
      002399                        230 9$: 
      00A309 0C 04            [ 1]  231     ld a,(COUNT,sp)
      00A30B 06 C0            [ 2]  232     ldw x,(YCOOR,sp)
      00A30D C0 C0            [ 2]  233     ldw y,(ADDR,sp)
      00239F                        234     _drop VAR_SIZE 
      00A30F C0 FC            [ 2]    1     addw sp,#VAR_SIZE 
      00A311 FC               [ 4]  235     ret 
                                    236 
                                    237 ;--------------------------
                                    238 ; get same row neighbors 
                                    239 ; count 
                                    240 ; input:
                                    241 ;    XL   x coord 
                                    242 ;    XH   y coord 
                                    243 ;    Y    grid addr 
                                    244 ; output:
                                    245 ;    A    count  
                                    246 ;    X    not changed 
                                    247 ;    Y    not changed 
                                    248 ;--------------------------
                           000001   249     YCOOR=1
                           000002   250     XCOOR=YCOOR+1 
                           000003   251     ADDR=XCOOR+1 
                           000005   252     COUNT=ADDR+2  
                           000005   253     VAR_SIZE=COUNT 
      0023A2                        254 row_count:
      0023A2                        255     _vars VAR_SIZE 
      00A312 06 04            [ 2]    1     sub sp,#VAR_SIZE 
      00A314 C0 C0            [ 1]  256     clr (COUNT,sp)
      00A316 FC FC            [ 2]  257     ldw (YCOOR,sp),x 
      00A318 04 06            [ 2]  258     ldw (ADDR,sp),y 
      00A31A FC               [ 1]  259     ld a,xl 
      00A31B FC               [ 1]  260     dec a 
      00A31C 0C 0C            [ 1]  261     jrmi 1$ 
      00A31E 0C               [ 1]  262     ld xl,a 
      00A31F 0C 06 04         [ 4]  263     call get_cell_state 
      00A322 F0 F0            [ 1]  264     jreq 1$ 
      00A324 3C 3C            [ 1]  265     inc (COUNT,sp)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 122.
Hexadecimal [24-Bits]



      00A326 04 06            [ 1]  266 1$: ld a,(XCOOR,sp)
      00A328 30               [ 1]  267     inc a 
      00A329 30 3C            [ 1]  268     cp a,#GRID_WIDTH
      00A32B 30 C0            [ 1]  269     jreq 2$ 
      00A32D C0               [ 1]  270     ld xl,a 
      00A32E 06 04 3C         [ 4]  271     call get_cell_state
      00A331 3C F0            [ 1]  272     jreq 2$ 
      00A333 F0 04            [ 1]  273     inc (COUNT,sp)
      0023C5                        274 2$: 
      00A335 06 C0            [ 1]  275     ld a,(COUNT,sp)
      00A337 C0 F0            [ 2]  276     ldw x,(YCOOR,sp)
      00A339 F0 0C            [ 2]  277     ldw y,(ADDR,sp)
      0023CB                        278     _drop VAR_SIZE 
      00A33B 0C 05            [ 2]    1     addw sp,#VAR_SIZE 
      00A33C 81               [ 4]  279     ret 
                                    280 
                                    281 ;--------------------------
                                    282 ; get bottom row neighbors 
                                    283 ; count
                                    284 ; input:
                                    285 ;    XL   x coord 
                                    286 ;    XH   y coord 
                                    287 ;    Y    grid addr 
                                    288 ; output:
                                    289 ;    A    count  
                                    290 ;    X    not changed 
                                    291 ;    Y    not changed 
                                    292 ;--------------------------
                           000001   293     YCOOR=1
                           000002   294     XCOOR=YCOOR+1 
                           000003   295     ADDR=XCOOR+1 
                           000005   296     COUNT=ADDR+2  
                           000005   297     VAR_SIZE=COUNT 
      0023CE                        298 bottom_count:
      0023CE                        299     _vars VAR_SIZE 
      00A33C AE 00            [ 2]    1     sub sp,#VAR_SIZE 
      00A33E 00 90            [ 1]  300     clr (COUNT,sp)
      00A340 AE 10            [ 2]  301     ldw (YCOOR,sp),x 
      00A342 C0 CD            [ 2]  302     ldw (ADDR,sp),y 
      00A344 88               [ 1]  303     ld a,xh 
      00A345 82               [ 1]  304     inc a 
      00A346 AE 01            [ 1]  305     cp a,#GRID_HEIGHT
      00A348 51 90            [ 1]  306     jreq 9$ ; no bottom row
      00A34A AE               [ 1]  307     ld xh,a 
      00A34B BF BF CD         [ 4]  308     call get_cell_state
      00A34E 88 82            [ 1]  309     jreq 1$ 
      00A350 AE 51            [ 1]  310     inc (COUNT,sp)
      0023E4                        311 1$: 
      00A352 51 90            [ 1]  312     ld a,(XCOOR,sp)
      00A354 AE               [ 1]  313     dec a 
      00A355 10 C0            [ 1]  314     jrmi 2$ ; no left column 
      00A357 CD               [ 1]  315     ld xl,a 
      00A358 88 82 81         [ 4]  316     call get_cell_state
      00A35B 27 02            [ 1]  317     jreq 2$ 
      00A35B CD 87            [ 1]  318     inc (COUNT,sp)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 123.
Hexadecimal [24-Bits]



      0023F1                        319 2$: 
      00A35D 35 CD            [ 1]  320     ld a,(XCOOR,sp)
      00A35F A3               [ 1]  321     inc a 
      00A360 3C 81            [ 1]  322     cp a,#GRID_WIDTH
      00A362 27 08            [ 1]  323     jreq 9$ ; no right column 
      00A362 CD               [ 1]  324     ld xl,a 
      00A363 A3 5B CD         [ 4]  325     call get_cell_state
      00A366 81 78            [ 1]  326     jreq 9$ 
      00A368 81 05            [ 1]  327     inc (COUNT,sp)
      000004                        328 9$: 
      000004 7B 05            [ 1]  329     ld a,(COUNT,sp)
      000006 7B 05            [ 1]  330     ld a,(COUNT,sp)     
      000008 1E 01            [ 2]  331     ldw x,(YCOOR,sp)
      00000A 16 03            [ 2]  332     ldw y,(ADDR,sp)
      000062                        333     _drop VAR_SIZE 
      00A369 5B 05            [ 2]    1     addw sp,#VAR_SIZE 
      00A369 89               [ 4]  334     ret 
                                    335 
                                    336 ;----------------------
                                    337 ; input:
                                    338 ;    XL    x coord 
                                    339 ;    XH    Y coord 
                                    340 ;    y     array addr 
                                    341 ; output:
                                    342 ;    A     count 
                                    343 ;    X     not changed 
                                    344 ;    Y     not changed 
                                    345 ;----------------------
      00240B                        346 neighbor_count: 
      00A36A AE 00 0C         [ 4]  347     call top_count 
      00A36D BF               [ 1]  348     push a 
      00A36E F3 BE 04         [ 4]  349     call bottom_count 
      00A371 CD 88            [ 1]  350     add a,(1,sp)
      00A373 5E 85            [ 1]  351     cp a,#4 
      00A375 81 07            [ 1]  352     jrpl 9$
      00A376 6B 01            [ 1]  353     ld (1,sp),a 
      00A376 5F BF 04         [ 4]  354     call row_count 
      00A379 AE 00            [ 1]  355     add a,(1,sp)
      00241F                        356 9$:
      00241F                        357     _drop 1
      00A37B B0 90            [ 2]    1     addw sp,#1 
      00A37D AE               [ 4]  358     ret 
                                    359 
                                    360 ;--------------------------
                                    361 ; compute next generation
                                    362 ; from src array to  
                                    363 ; dest array. 
                                    364 ; update display as each 
                                    365 ; cell is evaluated.
                                    366 ;--------------------------
                           000001   367     YCOOR=1
                           000002   368     XCOOR=YCOOR+1
                           000003   369     COL_COUNT=XCOOR+1
                           000004   370     ROW_COUNT=COL_COUNT+1
                           000005   371     INDEX=ROW_COUNT+1
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 124.
Hexadecimal [24-Bits]



                           000007   372     MASK=INDEX+2
                           000008   373     STATE=MASK+1 
                           000008   374     VAR_SIZE=STATE 
      002422                        375 next_gen:
      002422                        376     _vars VAR_SIZE
      00A37E 00 0A            [ 2]    1     sub sp,#VAR_SIZE 
      00A380 90 BF            [ 1]  377     clr (YCOOR,sp)
      00A382 06 4F            [ 1]  378     ld a,#GRID_HEIGHT
      00A384 CD 8A            [ 1]  379     ld (ROW_COUNT,sp),a 
      00242A                        380 1$: ;row loop 
      00A386 79 AE            [ 1]  381     clr (XCOOR,sp)
      00A388 00 62            [ 1]  382     ld a,#GRID_WIDTH
      00A38A BF 08            [ 1]  383     ld (COL_COUNT,sp),a 
      002430                        384 2$: ;column loop 
      00A38C 81 01            [ 2]  385     ldw x,(YCOOR,sp)
      00A38D CD 23 0D         [ 4]  386     call cell_index 
      00A38D 89 90            [ 1]  387     ld (MASK,sp),a 
      00A38F AE 00            [ 2]  388     ldw (INDEX,sp),y
                                    389 ; reset dest cell 
      00A391 04 7B 01 90      [ 2]  390     addw y,dest 
      00A395 42               [ 1]  391     cpl a 
      00A396 4F 95            [ 1]  392     and a,(y)
      00A398 A6 08            [ 1]  393     ld (y),a
                                    394 ; get source cell state        
      00A39A 62 BF E4 72      [ 2]  395     ldw y,src
      00A39E B9 00 E4         [ 2]  396     addw y,(INDEX,sp) 
      00A3A1 CD 87            [ 1]  397     ld a,(y)
      00A3A3 4C 85            [ 1]  398     and a,(MASK,sp)
      00A3A5 81 08            [ 1]  399     ld (STATE,sp),a 
      00A3A6 90 CE 00 06      [ 2]  400     ldw y,src 
      00A3A6 89 90 89         [ 4]  401     call neighbor_count
      00A3A9 CD A3 8D 72      [ 2]  402     ldw y,dest
      00A3AD F9 01 90         [ 2]  403     addw y,(INDEX,sp) 
      00A3B0 F4 90            [ 1]  404     cp a,#2
      00A3B2 85 85            [ 1]  405     jreq 3$ ; ==2 no cell change  
      00A3B4 81 0C            [ 1]  406     jrmi 4$ ; <2 reset cell 
      00A3B5 A1 04            [ 1]  407     cp a,#4 
      00A3B5 CD A3            [ 1]  408     jrpl 4$ ; >=4 reset cell  
                                    409 ; ==3 set cell     
      00A3B7 A6 4B            [ 1]  410     ld a,(MASK,sp)
      00A3B9 20 4D            [ 2]  411     jra 5$ 
      00246B                        412 3$: ; no cell change 
      00A3BB 27 04            [ 1]  413     ld a,(STATE,sp)
      00A3BD A6 84            [ 2]  414     jra 5$      
      00246F                        415 4$: ; reset cell 
      00A3BF 6B               [ 1]  416     clr a 
      00A3C0 01 FA            [ 1]  417 5$: or a,(y)
      00A3C1 90 F7            [ 1]  418     ld (y),a ; new state in dest array 
      00A3C1 84 01            [ 2]  419     ldw x,(YCOOR,sp)
      00A3C2                        420     _ldyz dest
      00A3C2 1C 01 00                 1     .byte 0x90,0xbe,dest 
      00A3C5 BF F3 CD         [ 4]  421     call display_cell
      00A3C8 87 D6            [ 1]  422     inc (XCOOR,sp)
      00A3CA 81 03            [ 1]  423     dec (COL_COUNT,sp)
      00A3CB 26 AE            [ 1]  424     jrne 2$ 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 125.
Hexadecimal [24-Bits]



      00A3CB 90 89            [ 1]  425     inc (YCOOR,sp)
      00A3CD CD A3            [ 1]  426     dec (ROW_COUNT,sp)
      00A3CF 8D 72            [ 1]  427     jrne 1$     
      002488                        428     _ldxz gen 
      00A3D1 F9 01                    1     .byte 0xbe,gen 
      00A3D3 90               [ 1]  429     incw x
      00248B                        430     _strxz gen 
      00A3D4 F8 90                    1     .byte 0xbf,gen 
      00248D                        431     _ldyz src 
      00A3D6 F7 90 85                 1     .byte 0x90,0xbe,src 
      002490                        432     _ldxz dest 
      00A3D9 81 08                    1     .byte 0xbe,dest 
      00A3DA                        433     _strxz src 
      00A3DA 90 89                    1     .byte 0xbf,src 
      002494                        434     _stryz dest 
      00A3DC CD A3 8D                 1     .byte 0x90,0xbf,dest 
      002497                        435     _drop VAR_SIZE 
      00A3DF 72 F9            [ 2]    1     addw sp,#VAR_SIZE 
      00A3E1 01               [ 4]  436     ret 
                                    437 
      00A3E2 90 FA 90 F7 90 85 81   438 gen_str: .asciz "GENERATION: "
             49 4F 4E 3A 20 00
      00A3E9 63 72 65 61 74 65 20   439 init_str: .asciz "create pattern";
             70 61 74 74 65 72 6E
             00
      00A3E9 52 05 0F 05 1F 01 17   440 erase_str: .asciz "              ";
             03 9E 4D 27 24 4A 95
             CD
                                    441 
                                    442 
                                    443 ;---------------------
                                    444 ; user initialize grid 
                                    445 ; moving cursor around
                                    446 ;---------------------
                           000001   447     YCOOR=1
                           000002   448     XCOOR=YCOOR+1
                           000003   449     KEY=XCOOR+1 
                           000003   450     VAR_SIZE=KEY 
      0024C5                        451 grid_init:
      0024C5                        452     _vars VAR_SIZE 
      00A3F8 A3 A6            [ 2]    1     sub sp,#VAR_SIZE 
      00A3FA 27 02            [ 1]  453     clr (KEY,sp)
      00A3FC 0C 05 9F         [ 2]  454     ldw x,#(GRID_CNTR_Y<<8)+GRID_CNTR_X
      00A3FF 4A 2B            [ 2]  455     ldw (YCOOR,sp),x
      00A401 08 97 CD         [ 4]  456     call tv_cls 
      00A404 A3 A6 27 02      [ 2]  457     ldw y,#init_str 
      00A408 0C 05 7B         [ 4]  458     call tv_puts 
      00A40B 02 4C A1         [ 2]  459 1$: ldw x,#10
      00A40E 20 27 08         [ 4]  460     call wait_key_release
      00A411 97 CD            [ 1]  461     ld a,#BLOCK
      00A413 A3 A6            [ 2]  462     ldw x,(YCOOR,sp) 
      00A415 27 02 0C         [ 4]  463     call display_char  
      00A418 05 00 F8         [ 4]  464     call wait_key 
      00A419 6B 03            [ 1]  465     ld (KEY,sp),a 
      00A419 7B 05            [ 2]  466     ldw x,(YCOOR,sp)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 126.
Hexadecimal [24-Bits]



      0024EC                        467     _ldyz src 
      00A41B 1E 01 16                 1     .byte 0x90,0xbe,src 
      00A41E 03 5B 05         [ 4]  468     call display_cell 
      00A421 81 08            [ 1]  469     ld a,#BTN_UP 
      00A422 11 03            [ 1]  470     cp a,(KEY,sp)
      00A422 52 05            [ 1]  471     jrne 2$ 
      00A424 0F 05            [ 1]  472     tnz (YCOOR,sp)
      00A426 1F 01            [ 1]  473     jreq 1$ 
      00A428 17 03            [ 1]  474     dec (YCOOR,sp)
      00A42A 9F 4A            [ 2]  475     jra 1$ 
      00A42C 2B 08            [ 1]  476 2$:  ld a,#BTN_DOWN 
      00A42E 97 CD            [ 1]  477     cp a,(KEY,sp)
      00A430 A3 A6            [ 1]  478     jrne 4$
      00A432 27 02            [ 1]  479     ld a,#GRID_HEIGHT-1 
      00A434 0C 05            [ 1]  480     cp a,(YCOOR,sp)
      00A436 7B 02            [ 1]  481     jreq 1$ 
      00A438 4C A1            [ 1]  482     inc (YCOOR,sp)
      00A43A 20 27            [ 2]  483     jra 1$ 
      00A43C 08 97            [ 1]  484 4$: ld a,#BTN_LEFT
      00A43E CD A3            [ 1]  485     cp a,(KEY,sp)
      00A440 A6 27            [ 1]  486     jrne 6$
      00A442 02 0C            [ 1]  487     tnz (XCOOR,sp)
      00A444 05 BE            [ 1]  488     jreq 1$ 
      00A445 0A 02            [ 1]  489     dec (XCOOR,sp)
      00A445 7B 05            [ 2]  490     jra 1$ 
      00A447 1E 01            [ 1]  491 6$: ld a,#BTN_RIGHT 
      00A449 16 03            [ 1]  492     cp a,(KEY,sp)
      00A44B 5B 05            [ 1]  493     jrne 8$ 
      00A44D 81 1F            [ 1]  494     ld a,#GRID_WIDTH-1 
      00A44E 11 02            [ 1]  495     cp a,(XCOOR,sp) 
      00A44E 52 05            [ 1]  496     jreq 1$ 
      00A450 0F 05            [ 1]  497     inc (XCOOR,sp)
      00A452 1F 01            [ 2]  498     jra 1$ 
      00A454 17 03            [ 1]  499 8$: ld a,#BTN_A
      00A456 9E 4C            [ 1]  500     cp a,(KEY,sp)
      00A458 A1 16            [ 1]  501     jrne 12$ 
      00A45A 27 24 95 CD      [ 2]  502     ldw y,src 
      00A45E A3 A6            [ 2]  503     ldw x,(YCOOR,sp)
      00A460 27 02 0C         [ 4]  504     call toggle_cell
      00A463 05 23 35         [ 4]  505     call display_cell
      00A464 20 96            [ 2]  506     jra 1$
      00A464 7B 02            [ 1]  507 12$: ld a,#BTN_B 
      00A466 4A 2B            [ 1]  508      cp a,(KEY,sp)
      00A468 08 97            [ 1]  509      jrne 1$    
      00A46A CD A3 A6 27      [ 2]  510     ldw y,#erase_str
      00A46E 02               [ 1]  511     clrw x 
      00254D                        512     _strxz cy 
      00A46F 0C 05                    1     .byte 0xbf,cy 
      00A471 CD 07 D2         [ 4]  513     call tv_puts 
      00A471 7B 02 4C         [ 4]  514     call wait_key_release
      002555                        515     _drop VAR_SIZE
      00A474 A1 20            [ 2]    1     addw sp,#VAR_SIZE 
      00A476 27               [ 4]  516     ret 
                                    517 
                                    518 ;---------------------------
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 127.
Hexadecimal [24-Bits]



                                    519 ; game of life 
                                    520 ; simulation entry function
                                    521 ;---------------------------
      002558                        522 game_of_life:
      00A477 08 97 CD         [ 4]  523     call life_init
      00A47A A3 A6 27 02      [ 2]  524     ldw y,#patterns 
      00A47E 0C 05 F6         [ 4]  525     call menu 
      00A480 5D               [ 2]  526     tnzw x 
      00A480 7B 05            [ 1]  527     jrne 1$
      00A482 7B               [ 4]  528     ret 
      00A483 05 1E 01         [ 2]  529 1$: cpw x,#free_hand 
      00A486 16 03            [ 1]  530     jrne set_pattern 
      00256B                        531 free_hand:
      00A488 5B 05 81         [ 4]  532     call grid_init
      00A48B                        533 sim_init:
      00A48B CD               [ 1]  534     clrw x 
      00256F                        535     _strxz cy 
      00A48C A3 E9                    1     .byte 0xbf,cy 
      00A48E 88 CD A4 4E      [ 2]  536     ldw y,#erase_str
      00A492 1B 01 A1         [ 4]  537     call tv_putc 
      00A495 04               [ 1]  538     clrw x 
      002579                        539     _strxz cy 
      00A496 2A 07                    1     .byte 0xbf,cy 
      00A498 6B 01 CD A4      [ 2]  540     ldw y,#gen_str
      00A49C 22 1B 01         [ 4]  541     call tv_puts 
      00A49F                        542 sim:
      00A49F 5B 01 81         [ 4]  543     call print_gen
      00A4A2 CD 24 22         [ 4]  544     call next_gen
      00A4A2 52 08            [ 1]  545 ld a,#15 
      00A4A4 0F 01 A6         [ 4]  546 call pause     
      00A4A7 16 6B 04         [ 4]  547     call kpad_input 
      00A4AA 27 F0            [ 1]  548     jreq sim  
      00A4AA 0F 02            [ 2]  549     jra game_of_life
                                    550 
                                    551 ;-------------------------
                                    552 ; set predefined pattern 
                                    553 ; input:
                                    554 ;   x     pattern address 
                                    555 ;-------------------------
                           000001   556     PATTERN=1
                           000002   557     VAR_SIZE=2 
      002594                        558 set_pattern:
      002594                        559     _vars VAR_SIZE 
      00A4AC A6 20            [ 2]    1     sub sp,#VAR_SIZE 
      00A4AE 6B 03 00 06      [ 2]  560     ldw y,src 
      00A4B0 1F 01            [ 2]  561 1$: ldw (PATTERN,sp),x 
      00A4B0 1E               [ 2]  562     ldw x,(x)
      00A4B1 01 CD A3         [ 2]  563     cpw x,#-1 
      00A4B4 8D 6B            [ 1]  564     jreq 9$
      00A4B6 07 17 05         [ 4]  565     call set_cell
      00A4B9 72 B9            [ 2]  566     ldw x,(PATTERN,sp)
      00A4BB 00 08 43         [ 2]  567     addw x,#2
      00A4BE 90 F4            [ 2]  568     jra 1$  
      0025AC                        569 9$: 
      0025AC                        570     _drop VAR_SIZE 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 128.
Hexadecimal [24-Bits]



      00A4C0 90 F7            [ 2]    1     addw sp,#VAR_SIZE 
      00A4C2 90 CE 00         [ 2]  571     jp sim_init
                                    572 
                                    573 
                                    574 ; liste de configuration prédéfinie 
      0025B1                        575 patterns:
      00A4C5 06 72 F9 05 90 F6 14   576 .asciz "FREE HAND"
             07 6B 08
      00A4CF 90 CE                  577 .word free_hand 
      00A4D1 00 06 CD A4 8B 90 CE   578 .asciz "GLIDER"
      00A4D8 00 08                  579 .word glider 
      00A4DA 72 F9 05 A1 02 27      580 .asciz "CLOCK"
      00A4E0 0A 2B                  581 .word clock
      00A4E2 0C A1 04 2A 08 7B 07   582 .asciz "PENTADECATHLON"
             20 05 54 48 4C 4F 4E
             00
      00A4EB 26 4A                  583 .word pentadecathon
      00A4EB 7B 08 20 01 4F 4D 49   584 .asciz "PENTOMINO R"
             4E 4F 20 52 00
      00A4EF 26 64                  585 .word pento_r 
      00A4EF 4F 90 FA 90 F7         586 .asciz "EXIT" 
      00A4F4 1E 01                  587 .word  0  
      00A4F6 90 BE                  588 .word 0 
                                    589 
                                    590   .macro _coord x,y 
                                    591   .word ((y+GRID_CNTR_Y)<<8)+x+GRID_CNTR_X   
                                    592   .endm 
                                    593 
                           00FFFF   594 PATTERN_END=0XFFFF   
      0025F6                        595 glider: 
      0025F6                        596     _coord 1,0 
      00A4F8 08 CD                    1   .word ((0+GRID_CNTR_Y)<<8)+1+GRID_CNTR_X   
      0025F8                        597     _coord 2,1
      00A4FA A3 B5                    1   .word ((1+GRID_CNTR_Y)<<8)+2+GRID_CNTR_X   
      0025FA                        598     _coord 2,2 
      00A4FC 0C 02                    1   .word ((2+GRID_CNTR_Y)<<8)+2+GRID_CNTR_X   
      0025FC                        599     _coord 1,2
      00A4FE 0A 03                    1   .word ((2+GRID_CNTR_Y)<<8)+1+GRID_CNTR_X   
      0025FE                        600     _coord 0,2 
      00A500 26 AE                    1   .word ((2+GRID_CNTR_Y)<<8)+0+GRID_CNTR_X   
      00A502 0C 01                  601     .word PATTERN_END 
                                    602 
      002602                        603 clock:
      002602                        604     _coord 6,0
      00A504 0A 04                    1   .word ((0+GRID_CNTR_Y)<<8)+6+GRID_CNTR_X   
      002604                        605     _coord 7,0
      00A506 26 A2                    1   .word ((0+GRID_CNTR_Y)<<8)+7+GRID_CNTR_X   
      002606                        606     _coord 6,1
      00A508 BE 04                    1   .word ((1+GRID_CNTR_Y)<<8)+6+GRID_CNTR_X   
      002608                        607     _coord 7,1
      00A50A 5C BF                    1   .word ((1+GRID_CNTR_Y)<<8)+7+GRID_CNTR_X   
      00260A                        608     _coord 4,3
      00A50C 04 90                    1   .word ((3+GRID_CNTR_Y)<<8)+4+GRID_CNTR_X   
      00260C                        609     _coord 5,3
      00A50E BE 06                    1   .word ((3+GRID_CNTR_Y)<<8)+5+GRID_CNTR_X   
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 129.
Hexadecimal [24-Bits]



      00260E                        610     _coord 6,3
      00A510 BE 08                    1   .word ((3+GRID_CNTR_Y)<<8)+6+GRID_CNTR_X   
      002610                        611     _coord 7,3
      00A512 BF 06                    1   .word ((3+GRID_CNTR_Y)<<8)+7+GRID_CNTR_X   
      002612                        612     _coord 0,4
      00A514 90 BF                    1   .word ((4+GRID_CNTR_Y)<<8)+0+GRID_CNTR_X   
      002614                        613     _coord 1,4
      00A516 08 5B                    1   .word ((4+GRID_CNTR_Y)<<8)+1+GRID_CNTR_X   
      002616                        614     _coord 3,4
      00A518 08 81                    1   .word ((4+GRID_CNTR_Y)<<8)+3+GRID_CNTR_X   
      002618                        615     _coord 6,4
      00A51A 47 45                    1   .word ((4+GRID_CNTR_Y)<<8)+6+GRID_CNTR_X   
      00261A                        616     _coord 8,4
      00A51C 4E 45                    1   .word ((4+GRID_CNTR_Y)<<8)+8+GRID_CNTR_X   
      00261C                        617     _coord 0,5 
      00A51E 52 41                    1   .word ((5+GRID_CNTR_Y)<<8)+0+GRID_CNTR_X   
      00261E                        618     _coord 1,5
      00A520 54 49                    1   .word ((5+GRID_CNTR_Y)<<8)+1+GRID_CNTR_X   
      002620                        619     _coord 3,5
      00A522 4F 4E                    1   .word ((5+GRID_CNTR_Y)<<8)+3+GRID_CNTR_X   
      002622                        620     _coord 5,5 
      00A524 3A 20                    1   .word ((5+GRID_CNTR_Y)<<8)+5+GRID_CNTR_X   
      002624                        621     _coord 8,5
      00A526 00 63                    1   .word ((5+GRID_CNTR_Y)<<8)+8+GRID_CNTR_X   
      002626                        622     _coord 3,6
      00A528 72 65                    1   .word ((6+GRID_CNTR_Y)<<8)+3+GRID_CNTR_X   
      002628                        623     _coord 5,6
      00A52A 61 74                    1   .word ((6+GRID_CNTR_Y)<<8)+5+GRID_CNTR_X   
      00262A                        624     _coord 8,6
      00A52C 65 20                    1   .word ((6+GRID_CNTR_Y)<<8)+8+GRID_CNTR_X   
      00262C                        625     _coord 10,6
      00A52E 70 61                    1   .word ((6+GRID_CNTR_Y)<<8)+10+GRID_CNTR_X   
      00262E                        626     _coord 11,6
      00A530 74 74                    1   .word ((6+GRID_CNTR_Y)<<8)+11+GRID_CNTR_X   
      002630                        627     _coord 3,7
      00A532 65 72                    1   .word ((7+GRID_CNTR_Y)<<8)+3+GRID_CNTR_X   
      002632                        628     _coord 8,7
      00A534 6E 00                    1   .word ((7+GRID_CNTR_Y)<<8)+8+GRID_CNTR_X   
      002634                        629     _coord 10,7
      00A536 20 20                    1   .word ((7+GRID_CNTR_Y)<<8)+10+GRID_CNTR_X   
      002636                        630     _coord 11,7
      00A538 20 20                    1   .word ((7+GRID_CNTR_Y)<<8)+11+GRID_CNTR_X   
      002638                        631     _coord 4,8
      00A53A 20 20                    1   .word ((8+GRID_CNTR_Y)<<8)+4+GRID_CNTR_X   
      00263A                        632     _coord 5,8
      00A53C 20 20                    1   .word ((8+GRID_CNTR_Y)<<8)+5+GRID_CNTR_X   
      00263C                        633     _coord 6,8
      00A53E 20 20                    1   .word ((8+GRID_CNTR_Y)<<8)+6+GRID_CNTR_X   
      00263E                        634     _coord 7,8 
      00A540 20 20                    1   .word ((8+GRID_CNTR_Y)<<8)+7+GRID_CNTR_X   
      002640                        635     _coord 4,10
      00A542 20 20                    1   .word ((10+GRID_CNTR_Y)<<8)+4+GRID_CNTR_X   
      002642                        636     _coord 5,10
      00A544 00 14                    1   .word ((10+GRID_CNTR_Y)<<8)+5+GRID_CNTR_X   
      00A545                        637     _coord 4,11 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 130.
Hexadecimal [24-Bits]



      00A545 52 03                    1   .word ((11+GRID_CNTR_Y)<<8)+4+GRID_CNTR_X   
      002646                        638     _coord 5,11
      00A547 0F 03                    1   .word ((11+GRID_CNTR_Y)<<8)+5+GRID_CNTR_X   
      00A549 AE 0A                  639     .word PATTERN_END 
                                    640 
      00264A                        641 pentadecathon:
      00264A                        642     _coord 2,0
      00A54B 0F 1F                    1   .word ((0+GRID_CNTR_Y)<<8)+2+GRID_CNTR_X   
      00264C                        643     _coord 7,0
      00A54D 01 CD                    1   .word ((0+GRID_CNTR_Y)<<8)+7+GRID_CNTR_X   
      00264E                        644     _coord 0,1
      00A54F 87 35                    1   .word ((1+GRID_CNTR_Y)<<8)+0+GRID_CNTR_X   
      002650                        645     _coord 1,1
      00A551 90 AE                    1   .word ((1+GRID_CNTR_Y)<<8)+1+GRID_CNTR_X   
      002652                        646     _coord 3,1
      00A553 A5 27                    1   .word ((1+GRID_CNTR_Y)<<8)+3+GRID_CNTR_X   
      002654                        647     _coord 4,1
      00A555 CD 88                    1   .word ((1+GRID_CNTR_Y)<<8)+4+GRID_CNTR_X   
      002656                        648     _coord 5,1
      00A557 52 AE                    1   .word ((1+GRID_CNTR_Y)<<8)+5+GRID_CNTR_X   
      002658                        649     _coord 6,1
      00A559 00 0A                    1   .word ((1+GRID_CNTR_Y)<<8)+6+GRID_CNTR_X   
      00265A                        650     _coord 8,1
      00A55B CD 81                    1   .word ((1+GRID_CNTR_Y)<<8)+8+GRID_CNTR_X   
      00265C                        651     _coord 9,1
      00A55D 7E A6                    1   .word ((1+GRID_CNTR_Y)<<8)+9+GRID_CNTR_X   
      00265E                        652     _coord 2,2 
      00A55F 7F 1E                    1   .word ((2+GRID_CNTR_Y)<<8)+2+GRID_CNTR_X   
      002660                        653     _coord 7,2
      00A561 01 CD                    1   .word ((2+GRID_CNTR_Y)<<8)+7+GRID_CNTR_X   
      00A563 A3 C2                  654     .word PATTERN_END 
                                    655 
      002664                        656 pento_r:
      002664                        657     _coord 1,0
      00A565 CD 81                    1   .word ((0+GRID_CNTR_Y)<<8)+1+GRID_CNTR_X   
      002666                        658     _coord 1,1 
      00A567 78 6B                    1   .word ((1+GRID_CNTR_Y)<<8)+1+GRID_CNTR_X   
      002668                        659     _coord 2,1
      00A569 03 1E                    1   .word ((1+GRID_CNTR_Y)<<8)+2+GRID_CNTR_X   
      00266A                        660     _coord 0,2
      00A56B 01 90                    1   .word ((2+GRID_CNTR_Y)<<8)+0+GRID_CNTR_X   
      00266C                        661     _coord 1,2
      00A56D BE 06                    1   .word ((2+GRID_CNTR_Y)<<8)+1+GRID_CNTR_X   
      00A56F CD A3                  662     .word PATTERN_END 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 131.
Hexadecimal [24-Bits]

Symbol Table

    .__.$$$.=  002710 L   |     .__.ABS.=  000000 G   |     .__.CPU.=  000000 L
    .__.H$L.=  000001 L   |     ACK     =  000006     |     ADC2_CR1=  005401 
    ADC2_CR1=  000000     |     ADC2_CR1=  000001     |     ADC2_CR1=  000004 
    ADC2_CR2=  005402     |     ADC2_CR2=  000003     |     ADC2_CR2=  000004 
    ADC2_CR2=  000006     |     ADC2_CR2=  000001     |     ADC2_CR3=  005403 
    ADC2_CR3=  000007     |     ADC2_CR3=  000006     |     ADC2_CSR=  005400 
    ADC2_CSR=  000006     |     ADC2_CSR=  000004     |     ADC2_CSR=  000000 
    ADC2_CSR=  000007     |     ADC2_CSR=  000005     |     ADC2_DRH=  005404 
    ADC2_DRL=  005405     |     ADC2_TDR=  005406     |     ADC2_TDR=  005407 
    ADDR    =  000003     |     AFR     =  004803     |     AFR0_ADC=  000000 
    AFR1_TIM=  000001     |     AFR2_CCO=  000002     |     AFR3_TIM=  000003 
    AFR4_TIM=  000004     |     AFR5_TIM=  000005     |     AFR6_I2C=  000006 
    AFR7_BEE=  000007     |     AWU_APR =  0050F1     |     AWU_CSR =  0050F0 
    AWU_CSR_=  000004     |     AWU_TBR =  0050F2     |     B0_MASK =  000001 
    B115200 =  000006     |     B19200  =  000003     |     B1_MASK =  000002 
    B230400 =  000007     |     B2400   =  000000     |     B2_MASK =  000004 
    B38400  =  000004     |     B3_MASK =  000008     |     B460800 =  000008 
    B4800   =  000001     |     B4_MASK =  000010     |     B57600  =  000005 
    B5_MASK =  000020     |     B6_MASK =  000040     |     B7_MASK =  000080 
    B921600 =  000009     |     B9600   =  000002     |     BEEP_BIT=  000004 
    BEEP_CSR=  0050F3     |     BEEP_MAS=  000010     |     BEEP_POR=  00000F 
    BELL    =  000007     |     BIT0    =  000000     |     BIT1    =  000001 
    BIT2    =  000002     |     BIT3    =  000003     |     BIT4    =  000004 
    BIT5    =  000005     |     BIT6    =  000006     |     BIT7    =  000007 
    BIT_A   =  000005     |     BIT_B   =  000004     |     BIT_DOWN=  000001 
    BIT_LEFT=  000000     |     BIT_RIGH=  000002     |     BIT_UP  =  000003 
    BLOCK   =  00007F     |     BLOCK_SI=  000080     |     BOFS    =  000003 
    BOFSL   =  000004     |     BOOT_ROM=  006000     |     BOOT_ROM=  007FFF 
    BOTTOM_B=  0000BF     |     BPL     =  000001     |     BPOS    =  000005 
    BS      =  000008     |     BTN_A   =  000020     |     BTN_B   =  000010 
    BTN_DOWN=  000002     |     BTN_LEFT=  000001     |     BTN_MASK=  00003F 
    BTN_RIGH=  000004     |     BTN_UP  =  000008     |     BUTTONS =  000003 
    BYTECNT =  000003     |     BYTES_PE=  000019     |     BYTES_PE=  000019 
    CAN     =  000018     |     CAN_DGR =  005426     |     CAN_FPSR=  005427 
    CAN_IER =  005425     |     CAN_MCR =  005420     |     CAN_MSR =  005421 
    CAN_P0  =  005428     |     CAN_P1  =  005429     |     CAN_P2  =  00542A 
    CAN_P3  =  00542B     |     CAN_P4  =  00542C     |     CAN_P5  =  00542D 
    CAN_P6  =  00542E     |     CAN_P7  =  00542F     |     CAN_P8  =  005430 
    CAN_P9  =  005431     |     CAN_PA  =  005432     |     CAN_PB  =  005433 
    CAN_PC  =  005434     |     CAN_PD  =  005435     |     CAN_PE  =  005436 
    CAN_PF  =  005437     |     CAN_RFR =  005424     |     CAN_TPR =  005423 
    CAN_TSR =  005422     |     CB_HEIGH=  000001     |     CB_WIDTH=  000003 
    CC_C    =  000000     |     CC_H    =  000004     |     CC_I0   =  000003 
    CC_I1   =  000005     |     CC_N    =  000002     |     CC_V    =  000007 
    CC_Z    =  000001     |     CELL    =  000084     |     CFG_GCR =  007F60 
    CFG_GCR_=  000001     |     CFG_GCR_=  000000     |     CHAR_PER=  000021 
  6 CHRONO_B   001E8C R   |     CHRONO_D=  00007F     |     CLKOPT  =  004807 
    CLKOPT_C=  000002     |     CLKOPT_E=  000003     |     CLKOPT_P=  000000 
    CLKOPT_P=  000001     |     CLK_CCOR=  0050C9     |     CLK_CKDI=  0050C6 
    CLK_CKDI=  000000     |     CLK_CKDI=  000001     |     CLK_CKDI=  000002 
    CLK_CKDI=  000003     |     CLK_CKDI=  000004     |     CLK_CMSR=  0050C3 
    CLK_CSSR=  0050C8     |     CLK_ECKR=  0050C1     |     CLK_ECKR=  000000 
    CLK_ECKR=  000001     |     CLK_HSIT=  0050CC     |     CLK_ICKR=  0050C0 
    CLK_ICKR=  000002     |     CLK_ICKR=  000000     |     CLK_ICKR=  000001 
    CLK_ICKR=  000003     |     CLK_ICKR=  000004     |     CLK_ICKR=  000005 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 132.
Hexadecimal [24-Bits]

Symbol Table

    CLK_PCKE=  0050C7     |     CLK_PCKE=  000000     |     CLK_PCKE=  000001 
    CLK_PCKE=  000007     |     CLK_PCKE=  000005     |     CLK_PCKE=  000006 
    CLK_PCKE=  000004     |     CLK_PCKE=  000002     |     CLK_PCKE=  000003 
    CLK_PCKE=  0050CA     |     CLK_PCKE=  000003     |     CLK_PCKE=  000002 
    CLK_PCKE=  000007     |     CLK_SWCR=  0050C5     |     CLK_SWCR=  000000 
    CLK_SWCR=  000001     |     CLK_SWCR=  000002     |     CLK_SWCR=  000003 
    CLK_SWIM=  0050CD     |     CLK_SWR =  0050C4     |     CLK_SWR_=  0000B4 
    CLK_SWR_=  0000E1     |     CLK_SWR_=  0000D2     |     COLL    =  000005 
    COLON   =  00003A     |     COL_COUN=  000003     |     COMMA   =  00002C 
    COUNT   =  000005     |     CPU_A   =  007F00     |     CPU_CCR =  007F0A 
    CPU_PCE =  007F01     |     CPU_PCH =  007F02     |     CPU_PCL =  007F03 
    CPU_SPH =  007F08     |     CPU_SPL =  007F09     |     CPU_XH  =  007F04 
    CPU_XL  =  007F05     |     CPU_YH  =  007F06     |     CPU_YL  =  007F07 
    CR      =  00000D     |     CTRL_A  =  000001     |     CTRL_B  =  000002 
    CTRL_C  =  000003     |     CTRL_D  =  000004     |     CTRL_E  =  000005 
    CTRL_F  =  000006     |     CTRL_G  =  000007     |     CTRL_H  =  000008 
    CTRL_I  =  000009     |     CTRL_J  =  00000A     |     CTRL_K  =  00000B 
    CTRL_L  =  00000C     |     CTRL_M  =  00000D     |     CTRL_N  =  00000E 
    CTRL_O  =  00000F     |     CTRL_P  =  000010     |     CTRL_Q  =  000011 
    CTRL_R  =  000012     |     CTRL_S  =  000013     |     CTRL_T  =  000014 
    CTRL_U  =  000015     |     CTRL_V  =  000016     |     CTRL_W  =  000017 
    CTRL_X  =  000018     |     CTRL_Y  =  000019     |     CTRL_Z  =  00001A 
    DC1     =  000011     |     DC2     =  000012     |     DC3     =  000013 
    DC4     =  000014     |     DEBOUNCE=  000001     |     DEBUG   =  000000 
    DEBUG_BA=  007F00     |     DEBUG_EN=  007FFF     |     DELTA   =  000009 
    DEVID_BA=  0048CD     |     DEVID_EN=  0048D8     |     DEVID_LO=  0048D2 
    DEVID_LO=  0048D3     |     DEVID_LO=  0048D4     |     DEVID_LO=  0048D5 
    DEVID_LO=  0048D6     |     DEVID_LO=  0048D7     |     DEVID_LO=  0048D8 
    DEVID_WA=  0048D1     |     DEVID_XH=  0048CE     |     DEVID_XL=  0048CD 
    DEVID_YH=  0048D0     |     DEVID_YL=  0048CF     |     DLE     =  000010 
    DLY     =  000001     |     DM_BK1RE=  007F90     |     DM_BK1RH=  007F91 
    DM_BK1RL=  007F92     |     DM_BK2RE=  007F93     |     DM_BK2RH=  007F94 
    DM_BK2RL=  007F95     |     DM_CR1  =  007F96     |     DM_CR2  =  007F97 
    DM_CSR1 =  007F98     |     DM_CSR2 =  007F99     |     DM_ENFCT=  007F9A 
    DX      =  000005     |     DY      =  000007     |     EAST    =  000001 
    EDGE    =  000006     |     EEPROM_B=  004000     |     EEPROM_E=  0043FF 
    EEPROM_S=  000400     |     EM      =  000019     |     EMPTY   =  000020 
    ENQ     =  000005     |     EOF     =  00001A     |     EOT     =  000004 
    EPULSE  =  000025     |     ESC     =  00001B     |     ETB     =  000017 
    ETX     =  000003     |     EXTI_CR1=  0050A0     |     EXTI_CR2=  0050A1 
    FF      =  00000C     |     FHSE    =  7A1200     |     FHSI    =  F42400 
    FIRST_VI=  000037     |     FLASH_BA=  008000     |     FLASH_CR=  00505A 
    FLASH_CR=  000002     |     FLASH_CR=  000000     |     FLASH_CR=  000003 
    FLASH_CR=  000001     |     FLASH_CR=  00505B     |     FLASH_CR=  000005 
    FLASH_CR=  000004     |     FLASH_CR=  000007     |     FLASH_CR=  000000 
    FLASH_CR=  000006     |     FLASH_DU=  005064     |     FLASH_DU=  0000AE 
    FLASH_DU=  000056     |     FLASH_EN=  017FFF     |     FLASH_FP=  00505D 
    FLASH_FP=  000000     |     FLASH_FP=  000001     |     FLASH_FP=  000002 
    FLASH_FP=  000003     |     FLASH_FP=  000004     |     FLASH_FP=  000005 
    FLASH_IA=  00505F     |     FLASH_IA=  000003     |     FLASH_IA=  000002 
    FLASH_IA=  000006     |     FLASH_IA=  000001     |     FLASH_IA=  000000 
    FLASH_NC=  00505C     |     FLASH_NF=  00505E     |     FLASH_NF=  000000 
    FLASH_NF=  000001     |     FLASH_NF=  000002     |     FLASH_NF=  000003 
    FLASH_NF=  000004     |     FLASH_NF=  000005     |     FLASH_PU=  005062 
    FLASH_PU=  000056     |     FLASH_PU=  0000AE     |     FLASH_SI=  010000 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 133.
Hexadecimal [24-Bits]

Symbol Table

    FLASH_WS=  00480D     |     FLSI    =  01F400     |     FMSTR   =  F42400 
    FONT_HEI=  000008     |     FONT_WID=  000006     |     FR_HORZ =  003D76 
    FR_T3_CL=  00F424     |     FS      =  00001C     |     F_CURSOR=  000001 
    F_CUR_VI=  000002     |     F_DISP_M=  000005     |     F_EVEN  =  000000 
    F_FOOD_C=  000000     |     F_GAME_O=  000002     |     F_GAME_T=  000007 
    F_NO_FOO=  000001     |     F_POO   =  000003     |     F_SOUND_=  000006 
    F_VIDEO =  000004     |     GAIN    =  000002     |     GAM_ADR =  000001 
    GPIO_BAS=  005000     |     GPIO_CR1=  000003     |     GPIO_CR2=  000004 
    GPIO_DDR=  000002     |     GPIO_IDR=  000001     |     GPIO_ODR=  000000 
    GPIO_SIZ=  000005     |     GRID_CNT=  00000F     |     GRID_CNT=  00000A 
    GRID_HEI=  000016     |     GRID_LEF=  000000     |     GRID_ROW=  000004 
    GRID_SIZ=  000058     |     GRID_TOP=  000001     |     GRID_WID=  000020 
    GS      =  00001D     |     HALF_LIN=  0001FC     |     HEAD    =  000003 
  6 HEAD_DOW   001E6E R   |   6 HEAD_LEF   001E74 R   |   6 HEAD_RIG   001E68 R
  6 HEAD_UP    001E62 R   |     HLINE   =  0003F8     |     HPULSE  =  00004B 
    HRES    =  0000C8     |     HSECNT  =  004809     |   6 I0         00223B R
  6 I1         002241 R   |     I2C_BASE=  005210     |     I2C_CCRH=  00521C 
    I2C_CCRH=  000080     |     I2C_CCRH=  0000C0     |     I2C_CCRH=  000080 
    I2C_CCRH=  000000     |     I2C_CCRH=  000001     |     I2C_CCRH=  000000 
    I2C_CCRH=  000006     |     I2C_CCRH=  000007     |     I2C_CCRL=  00521B 
    I2C_CCRL=  00001A     |     I2C_CCRL=  000002     |     I2C_CCRL=  00000D 
    I2C_CCRL=  000050     |     I2C_CCRL=  000090     |     I2C_CCRL=  0000A0 
    I2C_CR1 =  005210     |     I2C_CR1_=  000006     |     I2C_CR1_=  000007 
    I2C_CR1_=  000000     |     I2C_CR2 =  005211     |     I2C_CR2_=  000002 
    I2C_CR2_=  000003     |     I2C_CR2_=  000000     |     I2C_CR2_=  000001 
    I2C_CR2_=  000007     |     I2C_DR  =  005216     |     I2C_FAST=  000001 
    I2C_FREQ=  005212     |     I2C_ITR =  00521A     |     I2C_ITR_=  000002 
    I2C_ITR_=  000000     |     I2C_ITR_=  000001     |     I2C_OARH=  005214 
    I2C_OARH=  000001     |     I2C_OARH=  000002     |     I2C_OARH=  000006 
    I2C_OARH=  000007     |     I2C_OARL=  005213     |     I2C_OARL=  000000 
    I2C_OAR_=  000813     |     I2C_OAR_=  000009     |     I2C_PECR=  00521E 
    I2C_READ=  000001     |     I2C_SR1 =  005217     |     I2C_SR1_=  000003 
    I2C_SR1_=  000001     |     I2C_SR1_=  000002     |     I2C_SR1_=  000006 
    I2C_SR1_=  000000     |     I2C_SR1_=  000004     |     I2C_SR1_=  000007 
    I2C_SR2 =  005218     |     I2C_SR2_=  000002     |     I2C_SR2_=  000001 
    I2C_SR2_=  000000     |     I2C_SR2_=  000003     |     I2C_SR2_=  000005 
    I2C_SR3 =  005219     |     I2C_SR3_=  000001     |     I2C_SR3_=  000007 
    I2C_SR3_=  000004     |     I2C_SR3_=  000000     |     I2C_SR3_=  000002 
    I2C_STD =  000000     |     I2C_TRIS=  00521D     |     I2C_TRIS=  000005 
    I2C_TRIS=  000005     |     I2C_TRIS=  000005     |     I2C_TRIS=  000011 
    I2C_TRIS=  000011     |     I2C_TRIS=  000011     |     I2C_WRIT=  000000 
    IDX     =  000002     |     IMG_DATA=  0012C0     |     INCR    =  000001 
    INDEX   =  000005     |     INPUT_DI=  000000     |     INPUT_EI=  000001 
    INPUT_FL=  000000     |     INPUT_PU=  000001     |     INT_ADC2=  000016 
    INT_AUAR=  000012     |     INT_AWU =  000001     |     INT_CAN_=  000008 
    INT_CAN_=  000009     |     INT_CLK =  000002     |     INT_EXTI=  000003 
    INT_EXTI=  000004     |     INT_EXTI=  000005     |     INT_EXTI=  000006 
    INT_EXTI=  000007     |     INT_FLAS=  000018     |     INT_I2C =  000013 
    INT_SPI =  00000A     |     INT_TIM1=  00000C     |     INT_TIM1=  00000B 
    INT_TIM2=  00000E     |     INT_TIM2=  00000D     |     INT_TIM3=  000010 
    INT_TIM3=  00000F     |     INT_TIM4=  000017     |     INT_TLI =  000000 
    INT_UART=  000011     |     INT_UART=  000015     |     INT_UART=  000014 
    INT_VECT=  008060     |     INT_VECT=  00800C     |     INT_VECT=  008028 
    INT_VECT=  00802C     |     INT_VECT=  008010     |     INT_VECT=  008014 
    INT_VECT=  008018     |     INT_VECT=  00801C     |     INT_VECT=  008020 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 134.
Hexadecimal [24-Bits]

Symbol Table

    INT_VECT=  008024     |     INT_VECT=  008068     |     INT_VECT=  008054 
    INT_VECT=  008000     |     INT_VECT=  008030     |     INT_VECT=  008038 
    INT_VECT=  008034     |     INT_VECT=  008040     |     INT_VECT=  00803C 
    INT_VECT=  008048     |     INT_VECT=  008044     |     INT_VECT=  008064 
    INT_VECT=  008008     |     INT_VECT=  008004     |     INT_VECT=  008050 
    INT_VECT=  00804C     |     INT_VECT=  00805C     |     INT_VECT=  008058 
    ISTR    =  000003     |     ITC_SPR1=  007F70     |     ITC_SPR2=  007F71 
    ITC_SPR3=  007F72     |     ITC_SPR4=  007F73     |     ITC_SPR5=  007F74 
    ITC_SPR6=  007F75     |     ITC_SPR7=  007F76     |     ITC_SPR8=  007F77 
    ITC_SPR_=  000001     |     ITC_SPR_=  000000     |     ITC_SPR_=  000003 
    IWDG_KEY=  000055     |     IWDG_KEY=  0000CC     |     IWDG_KEY=  0000AA 
    IWDG_KR =  0050E0     |     IWDG_PR =  0050E1     |     IWDG_RLR=  0050E2 
  6 J0         002284 R   |   6 J1         00228A R   |   6 J2         002292 R
  6 J3         002298 R   |     KERNEL_V=  0000E0     |     KEY     =  000003 
    KPAD    =  000001     |     KPAD_IDR=  005006     |     KPAD_POR=  005005 
  6 L0         002269 R   |   6 L1         00226F R   |   6 L2         002277 R
  6 L3         00227D R   |     LB      =  000002     |     LED_BIT =  000005 
    LED_MASK=  000020     |     LED_PORT=  00500A     |     LEFT_BOR=  000000 
    LEN     =  000001     |     LF      =  00000A     |     LINE_DEL=  000082 
    LINE_PER=  000018     |     MAJOR   =  000001     |     MASK    =  000007 
    MAX_SPEE=  000009     |     MAX_XCOO=  0000C0     |     MAX_YCOO=  0000BB 
    MINOR   =  000001     |     MIN_SPEE=  000001     |     MIN_XCOO=  000001 
    MIN_YCOO=  000009     |   6 MOUSE      001E80 R   |     MOUSE_HE=  000004 
    MOUSE_WI=  000005     |     NAFR    =  004804     |     NAK     =  000015 
    NCLKOPT =  004808     |     NFLASH_W=  00480E     |     NHSECNT =  00480A 
    NOPT1   =  004802     |     NOPT2   =  004804     |     NOPT3   =  004806 
    NOPT4   =  004808     |     NOPT5   =  00480A     |     NOPT6   =  00480C 
    NOPT7   =  00480E     |     NOPTBL  =  00487F     |     NORTH   =  000000 
    NUBC    =  004802     |     NUCLEO  =  000001     |     NWDGOPT =  004806 
    NWDGOPT_=  FFFFFFFD     |     NWDGOPT_=  FFFFFFFC     |     NWDGOPT_=  FFFFFFFF 
    NWDGOPT_=  FFFFFFFE     |   6 NonHandl   000000 R   |     OFS_UART=  000002 
    OFS_UART=  000003     |     OFS_UART=  000004     |     OFS_UART=  000005 
    OFS_UART=  000006     |     OFS_UART=  000007     |     OFS_UART=  000008 
    OFS_UART=  000009     |     OFS_UART=  000001     |     OFS_UART=  000009 
    OFS_UART=  00000A     |     OFS_UART=  000000     |     OPT0    =  004800 
    OPT1    =  004801     |     OPT2    =  004803     |     OPT3    =  004805 
    OPT4    =  004807     |     OPT5    =  004809     |     OPT6    =  00480B 
    OPT7    =  00480D     |     OPTBL   =  00487E     |     OPTION_B=  004800 
    OPTION_E=  00487F     |     OPTION_S=  000080     |     OPT_BR0_=  000002 
    OPT_BR0_=  005010     |     OPT_BR1_=  000002     |     OPT_BR1_=  00500B 
    OPT_ECHO=  000000     |     OPT_ECHO=  005010     |     OUTPUT_F=  000001 
    OUTPUT_O=  000000     |     OUTPUT_P=  000001     |     OUTPUT_S=  000000 
    PA      =  000000     |     PATTERN =  000001     |     PATTERN_=  00FFFF 
    PA_BASE =  005000     |     PA_CR1  =  005003     |     PA_CR2  =  005004 
    PA_DDR  =  005002     |     PA_IDR  =  005001     |     PA_ODR  =  005000 
    PB      =  000005     |     PB_BASE =  005005     |     PB_CR1  =  005008 
    PB_CR2  =  005009     |     PB_DDR  =  005007     |     PB_IDR  =  005006 
    PB_ODR  =  005005     |     PC      =  00000A     |     PC_BASE =  00500A 
    PC_CR1  =  00500D     |     PC_CR2  =  00500E     |     PC_DDR  =  00500C 
    PC_IDR  =  00500B     |     PC_ODR  =  00500A     |     PD      =  00000F 
    PD_BASE =  00500F     |     PD_CR1  =  005012     |     PD_CR2  =  005013 
    PD_DDR  =  005011     |     PD_IDR  =  005010     |     PD_ODR  =  00500F 
    PE      =  000014     |     PE_BASE =  005014     |     PE_CR1  =  005017 
    PE_CR2  =  005018     |     PE_DDR  =  005016     |     PE_IDR  =  005015 
    PE_ODR  =  005014     |     PF      =  000019     |     PF_BASE =  005019 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 135.
Hexadecimal [24-Bits]

Symbol Table

    PF_CR1  =  00501C     |     PF_CR2  =  00501D     |     PF_DDR  =  00501B 
    PF_IDR  =  00501A     |     PF_ODR  =  005019     |     PG      =  00001E 
    PG_BASE =  00501E     |     PG_CR1  =  005021     |     PG_CR2  =  005022 
    PG_DDR  =  005020     |     PG_HEIGH=  0000B6     |     PG_IDR  =  00501F 
    PG_ODR  =  00501E     |     PG_WIDTH=  0000C3     |     PH      =  000023 
    PH_BASE =  005023     |     PH_CR1  =  005026     |     PH_CR2  =  005027 
    PH_DDR  =  005025     |     PH_IDR  =  005024     |     PH_ODR  =  005023 
    PH_POST_=  000003     |     PH_PRE_V=  000001     |     PH_VIDEO=  000002 
    PH_VSYNC=  000000     |     PI      =  000028     |     PI_BASE =  005028 
    PI_CR1  =  00502B     |     PI_CR2  =  00502C     |     PI_DDR  =  00502A 
    PI_IDR  =  005029     |     PI_ODR  =  005028     |   6 POO        001E86 R
    POO_HEIG=  000004     |     POO_WIDT=  000004     |     POS     =  000001 
    RAM_BASE=  000000     |     RAM_END =  0017FF     |     RAM_SIZE=  001800 
    REV     =  000000     |     RIGHT_BO=  0000C4     |   6 RING       001E7A R
    ROP     =  004800     |     ROW     =  000007     |     ROWS    =  000001 
    ROW_CNTR=  000005     |     ROW_COUN=  000004     |     RS      =  00001E 
    RST_SR  =  0050B3     |   6 S0         0022AE R   |   6 S1         0022B4 R
    SCROLL_D=  000001     |     SEL     =  000012     |     SEMIC   =  00003B 
    SFR_BASE=  005000     |     SFR_END =  0057FF     |     SHARP   =  000023 
    SHIFT   =  000004     |     SI      =  00000F     |     SNAKE_SP=  000004 
    SNAKE_SP=  000004     |     SO      =  00000E     |     SOH     =  000001 
    SOUND_BI=  000000     |     SOUND_PO=  00500F     |     SOUTH   =  000002 
    SPACE   =  000020     |     SPI_CR1 =  005200     |     SPI_CR1_=  000003 
    SPI_CR1_=  000000     |     SPI_CR1_=  000001     |     SPI_CR1_=  000007 
    SPI_CR1_=  000002     |     SPI_CR1_=  000006     |     SPI_CR2 =  005201 
    SPI_CR2_=  000007     |     SPI_CR2_=  000006     |     SPI_CR2_=  000005 
    SPI_CR2_=  000004     |     SPI_CR2_=  000002     |     SPI_CR2_=  000000 
    SPI_CR2_=  000001     |     SPI_CRCP=  005205     |     SPI_DR  =  005204 
    SPI_ICR =  005202     |     SPI_RXCR=  005206     |     SPI_SR  =  005203 
    SPI_SR_B=  000007     |     SPI_SR_C=  000004     |     SPI_SR_M=  000005 
    SPI_SR_O=  000006     |     SPI_SR_R=  000000     |     SPI_SR_T=  000001 
    SPI_SR_W=  000003     |     SPI_TXCR=  005207     |     SPRITE  =  000002 
  6 SQUARE     002247 R   |     STACK_EM=  0017FF     |     STACK_SI=  000080 
    STATE   =  000008     |     STX     =  000002     |     SUB     =  00001A 
    SWIM_CSR=  007F80     |     SYN     =  000016     |     SYS_VAR_=  000020 
  6 T0         00224D R   |   6 T1         002253 R   |   6 T2         00225B R
  6 T3         002263 R   |     TAB     =  000009     |     TAIL    =  000003 
    TETRA_WI=  000008     |     TICK    =  000027     |     TIM1_ARR=  005262 
    TIM1_ARR=  005263     |     TIM1_BKR=  00526D     |     TIM1_BKR=  000006 
    TIM1_BKR=  000004     |     TIM1_BKR=  000005     |     TIM1_BKR=  000000 
    TIM1_BKR=  000007     |     TIM1_BKR=  000002     |     TIM1_BKR=  000003 
    TIM1_CCE=  00525C     |     TIM1_CCE=  00525D     |     TIM1_CCM=  005258 
    TIM1_CCM=  000000     |     TIM1_CCM=  000001     |     TIM1_CCM=  000004 
    TIM1_CCM=  000005     |     TIM1_CCM=  000006     |     TIM1_CCM=  000007 
    TIM1_CCM=  000002     |     TIM1_CCM=  000003     |     TIM1_CCM=  000007 
    TIM1_CCM=  000002     |     TIM1_CCM=  000004     |     TIM1_CCM=  000005 
    TIM1_CCM=  000006     |     TIM1_CCM=  000004     |     TIM1_CCM=  000003 
    TIM1_CCM=  005259     |     TIM1_CCM=  000000     |     TIM1_CCM=  000001 
    TIM1_CCM=  000004     |     TIM1_CCM=  000005     |     TIM1_CCM=  000006 
    TIM1_CCM=  000007     |     TIM1_CCM=  000002     |     TIM1_CCM=  000003 
    TIM1_CCM=  000007     |     TIM1_CCM=  000002     |     TIM1_CCM=  000004 
    TIM1_CCM=  000005     |     TIM1_CCM=  000006     |     TIM1_CCM=  000004 
    TIM1_CCM=  000003     |     TIM1_CCM=  00525A     |     TIM1_CCM=  000000 
    TIM1_CCM=  000001     |     TIM1_CCM=  000004     |     TIM1_CCM=  000005 
    TIM1_CCM=  000006     |     TIM1_CCM=  000007     |     TIM1_CCM=  000002 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 136.
Hexadecimal [24-Bits]

Symbol Table

    TIM1_CCM=  000003     |     TIM1_CCM=  000007     |     TIM1_CCM=  000002 
    TIM1_CCM=  000004     |     TIM1_CCM=  000005     |     TIM1_CCM=  000006 
    TIM1_CCM=  000004     |     TIM1_CCM=  000003     |     TIM1_CCM=  00525B 
    TIM1_CCM=  000000     |     TIM1_CCM=  000001     |     TIM1_CCM=  000004 
    TIM1_CCM=  000005     |     TIM1_CCM=  000006     |     TIM1_CCM=  000007 
    TIM1_CCM=  000002     |     TIM1_CCM=  000003     |     TIM1_CCM=  000007 
    TIM1_CCM=  000002     |     TIM1_CCM=  000004     |     TIM1_CCM=  000005 
    TIM1_CCM=  000006     |     TIM1_CCM=  000004     |     TIM1_CCM=  000003 
    TIM1_CCR=  005265     |     TIM1_CCR=  005266     |     TIM1_CCR=  005267 
    TIM1_CCR=  005268     |     TIM1_CCR=  005269     |     TIM1_CCR=  00526A 
    TIM1_CCR=  00526B     |     TIM1_CCR=  00526C     |     TIM1_CNT=  00525E 
    TIM1_CNT=  00525F     |     TIM1_CR1=  005250     |     TIM1_CR1=  000007 
    TIM1_CR1=  000000     |     TIM1_CR1=  000006     |     TIM1_CR1=  000005 
    TIM1_CR1=  000004     |     TIM1_CR1=  000003     |     TIM1_CR1=  000001 
    TIM1_CR1=  000002     |     TIM1_CR2=  005251     |     TIM1_CR2=  000000 
    TIM1_CR2=  000002     |     TIM1_CR2=  000004     |     TIM1_CR2=  000005 
    TIM1_CR2=  000006     |     TIM1_DTR=  00526E     |     TIM1_EGR=  005257 
    TIM1_EGR=  000007     |     TIM1_EGR=  000001     |     TIM1_EGR=  000002 
    TIM1_EGR=  000003     |     TIM1_EGR=  000004     |     TIM1_EGR=  000005 
    TIM1_EGR=  000006     |     TIM1_EGR=  000000     |     TIM1_ETR=  005253 
    TIM1_ETR=  000006     |     TIM1_ETR=  000000     |     TIM1_ETR=  000001 
    TIM1_ETR=  000002     |     TIM1_ETR=  000003     |     TIM1_ETR=  000007 
    TIM1_ETR=  000004     |     TIM1_ETR=  000005     |     TIM1_IER=  005254 
    TIM1_IER=  000007     |     TIM1_IER=  000001     |     TIM1_IER=  000002 
    TIM1_IER=  000003     |     TIM1_IER=  000004     |     TIM1_IER=  000005 
    TIM1_IER=  000006     |     TIM1_IER=  000000     |     TIM1_OIS=  00526F 
    TIM1_PSC=  005260     |     TIM1_PSC=  005261     |     TIM1_RCR=  005264 
    TIM1_SMC=  005252     |     TIM1_SMC=  000007     |     TIM1_SMC=  000000 
    TIM1_SMC=  000001     |     TIM1_SMC=  000002     |     TIM1_SMC=  000004 
    TIM1_SMC=  000005     |     TIM1_SMC=  000006     |     TIM1_SR1=  005255 
    TIM1_SR1=  000007     |     TIM1_SR1=  000001     |     TIM1_SR1=  000002 
    TIM1_SR1=  000003     |     TIM1_SR1=  000004     |     TIM1_SR1=  000005 
    TIM1_SR1=  000006     |     TIM1_SR1=  000000     |     TIM1_SR2=  005256 
    TIM1_SR2=  000001     |     TIM1_SR2=  000002     |     TIM1_SR2=  000003 
    TIM1_SR2=  000004     |     TIM2_ARR=  00530D     |     TIM2_ARR=  00530E 
    TIM2_CCE=  005308     |     TIM2_CCE=  000000     |     TIM2_CCE=  000001 
    TIM2_CCE=  000004     |     TIM2_CCE=  000005     |     TIM2_CCE=  005309 
    TIM2_CCM=  005305     |     TIM2_CCM=  005306     |     TIM2_CCM=  005307 
    TIM2_CCM=  000000     |     TIM2_CCM=  000004     |     TIM2_CCM=  000003 
    TIM2_CCR=  00530F     |     TIM2_CCR=  005310     |     TIM2_CCR=  005311 
    TIM2_CCR=  005312     |     TIM2_CCR=  005313     |     TIM2_CCR=  005314 
    TIM2_CNT=  00530A     |     TIM2_CNT=  00530B     |     TIM2_CR1=  005300 
    TIM2_CR1=  000007     |     TIM2_CR1=  000000     |     TIM2_CR1=  000003 
    TIM2_CR1=  000001     |     TIM2_CR1=  000002     |     TIM2_EGR=  005304 
    TIM2_EGR=  000001     |     TIM2_EGR=  000002     |     TIM2_EGR=  000003 
    TIM2_EGR=  000006     |     TIM2_EGR=  000000     |     TIM2_IER=  005301 
    TIM2_PSC=  00530C     |     TIM2_SR1=  005302     |     TIM2_SR2=  005303 
    TIM3_ARR=  00532B     |     TIM3_ARR=  00532C     |     TIM3_CCE=  005327 
    TIM3_CCE=  000000     |     TIM3_CCE=  000001     |     TIM3_CCE=  000004 
    TIM3_CCE=  000005     |     TIM3_CCE=  000000     |     TIM3_CCE=  000001 
    TIM3_CCM=  005325     |     TIM3_CCM=  000000     |     TIM3_CCM=  000004 
    TIM3_CCM=  000003     |     TIM3_CCM=  005326     |     TIM3_CCM=  000000 
    TIM3_CCM=  000004     |     TIM3_CCM=  000003     |     TIM3_CCM=  000000 
    TIM3_CCM=  000004     |     TIM3_CCM=  000003     |     TIM3_CCR=  00532D 
    TIM3_CCR=  00532E     |     TIM3_CCR=  00532F     |     TIM3_CCR=  005330 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 137.
Hexadecimal [24-Bits]

Symbol Table

    TIM3_CNT=  005328     |     TIM3_CNT=  005329     |     TIM3_CR1=  005320 
    TIM3_CR1=  000007     |     TIM3_CR1=  000000     |     TIM3_CR1=  000003 
    TIM3_CR1=  000001     |     TIM3_CR1=  000002     |     TIM3_EGR=  005324 
    TIM3_EGR=  000001     |     TIM3_EGR=  000002     |     TIM3_EGR=  000003 
    TIM3_EGR=  000006     |     TIM3_EGR=  000000     |     TIM3_IER=  005321 
    TIM3_IER=  000001     |     TIM3_IER=  000002     |     TIM3_IER=  000003 
    TIM3_IER=  000006     |     TIM3_IER=  000000     |     TIM3_PSC=  00532A 
    TIM3_SR1=  005322     |     TIM3_SR1=  000001     |     TIM3_SR1=  000002 
    TIM3_SR1=  000003     |     TIM3_SR1=  000006     |     TIM3_SR1=  000000 
    TIM3_SR2=  005323     |     TIM3_SR2=  000001     |     TIM3_SR2=  000002 
    TIM3_SR2=  000003     |     TIM4_ARR=  005346     |     TIM4_CNT=  005344 
    TIM4_CR1=  005340     |     TIM4_CR1=  000007     |     TIM4_CR1=  000000 
    TIM4_CR1=  000003     |     TIM4_CR1=  000001     |     TIM4_CR1=  000002 
    TIM4_EGR=  005343     |     TIM4_EGR=  000000     |     TIM4_IER=  005341 
    TIM4_IER=  000000     |     TIM4_PSC=  005345     |     TIM4_PSC=  000000 
    TIM4_PSC=  000007     |     TIM4_PSC=  000004     |     TIM4_PSC=  000001 
    TIM4_PSC=  000005     |     TIM4_PSC=  000002     |     TIM4_PSC=  000006 
    TIM4_PSC=  000003     |     TIM4_PSC=  000000     |     TIM4_PSC=  000001 
    TIM4_PSC=  000002     |     TIM4_SR =  005342     |     TIM4_SR_=  000000 
    TOP_BORD=  000008     |     UART    =  000002     |     UART1   =  000000 
    UART1_BA=  005230     |     UART1_BR=  005232     |     UART1_BR=  005233 
    UART1_CR=  005234     |     UART1_CR=  005235     |     UART1_CR=  005236 
    UART1_CR=  005237     |     UART1_CR=  005238     |     UART1_DR=  005231 
    UART1_GT=  005239     |     UART1_PO=  000000     |     UART1_PS=  00523A 
    UART1_RX=  000004     |     UART1_SR=  005230     |     UART1_TX=  000005 
    UART2   =  000001     |     UART3   =  000002     |     UART3_BA=  005240 
    UART3_BR=  005242     |     UART3_BR=  005243     |     UART3_CR=  005244 
    UART3_CR=  005245     |     UART3_CR=  005246     |     UART3_CR=  005247 
    UART3_CR=  004249     |     UART3_DR=  005241     |     UART3_PO=  00000F 
    UART3_RX=  000006     |     UART3_SR=  005240     |     UART3_TX=  000005 
    UART_BRR=  005242     |     UART_BRR=  005243     |     UART_CR1=  005244 
    UART_CR1=  000004     |     UART_CR1=  000002     |     UART_CR1=  000000 
    UART_CR1=  000001     |     UART_CR1=  000007     |     UART_CR1=  000006 
    UART_CR1=  000005     |     UART_CR1=  000003     |     UART_CR2=  005245 
    UART_CR2=  000004     |     UART_CR2=  000002     |     UART_CR2=  000005 
    UART_CR2=  000001     |     UART_CR2=  000000     |     UART_CR2=  000006 
    UART_CR2=  000003     |     UART_CR2=  000007     |     UART_CR3=  000003 
    UART_CR3=  000001     |     UART_CR3=  000002     |     UART_CR3=  000000 
    UART_CR3=  000006     |     UART_CR3=  000004     |     UART_CR3=  000005 
    UART_CR4=  000000     |     UART_CR4=  000001     |     UART_CR4=  000002 
    UART_CR4=  000003     |     UART_CR4=  000004     |     UART_CR4=  000006 
    UART_CR4=  000005     |     UART_CR5=  000003     |     UART_CR5=  000001 
    UART_CR5=  000002     |     UART_CR5=  000004     |     UART_CR5=  000005 
    UART_CR6=  000004     |     UART_CR6=  000007     |     UART_CR6=  000001 
    UART_CR6=  000002     |     UART_CR6=  000000     |     UART_CR6=  000005 
    UART_DR =  005241     |     UART_PCK=  000003     |     UART_POR=  00500D 
    UART_POR=  00500E     |     UART_POR=  00500C     |     UART_POR=  00500B 
    UART_POR=  00500A     |     UART_RX_=  000006     |     UART_SR =  005240 
    UART_SR_=  000001     |     UART_SR_=  000004     |     UART_SR_=  000002 
    UART_SR_=  000003     |     UART_SR_=  000000     |     UART_SR_=  000005 
    UART_SR_=  000006     |     UART_SR_=  000007     |     UART_TX_=  000005 
    UBC     =  004801     |     UINT    =  000001     |     US      =  00001F 
    VAR_SIZE=  000002     |     VBUFF_SI=  0012C0     |     VIDEO_LI=  0000C0 
    VPULSE  =  0001B4     |     VRES    =  0000C0     |     VSIZE   =  000002 
    VT      =  00000B     |     WDGOPT  =  004805     |     WDGOPT_I=  000002 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 138.
Hexadecimal [24-Bits]

Symbol Table

    WDGOPT_L=  000003     |     WDGOPT_W=  000000     |     WDGOPT_W=  000001 
    WELL_DEP=  0000B0     |     WELL_WID=  000050     |     WEST    =  000004 
    WWDG_CR =  0050D1     |     WWDG_WR =  0050D2     |     X0      =  000001 
    X1      =  000002     |     XCOOR   =  000002     |     XCOORH  =  000001 
    XOFF    =  000013     |     XON     =  000011     |     Y0      =  000003 
    Y1      =  000004     |     YCOOR   =  000001     |   6 Z0         0022A0 R
  6 Z1         0022A6 R   |   5 acc16      0000E4 GR  |   5 acc8       0000E5 GR
  8 app_vari   000004 R   |   6 beep       00007C R   |   6 bit_mask   0006CC R
  6 bottom_c   0023CE R   |   6 cell_ind   00230D R   |   8 chrono     000007 R
  6 chrono_d   0020CF R   |   6 chrono_r   0020B0 R   |   6 clock      002602 R
  6 clock_in   000004 R   |   6 cold_sta   000115 R   |   6 cright     000A7C R
  6 crlf       00073D R   |   6 cursor_r   00074D R   |   5 cx         0000F4 R
  5 cy         0000F3 R   |   6 dbg_nl     000156 R   |   6 dbg_prin   000154 R
  6 dbg_prin   000155 R   |   5 delay_ti   0000E2 R   |   9 dest       000008 R
  6 display_   002335 R   |   6 display_   002342 R   |   6 draw_hea   001EC0 R
  6 draw_sna   001ECE R   |   6 draw_spr   001EB6 R   |   6 draw_wal   001E8F R
  6 draw_wel   0022BC R   |   6 erase_st   0024B6 R   |   6 fall       0022E2 R
  6 fall_ini   0022DB R   |   6 fill       0009F9 R   |   5 flags      0000EA GR
  5 fmstr      0000E6 GR  |   6 font_6x8   0001BD R   |   6 font_end   0004F5 R
  6 food_col   001F0F R   |   8 food_coo   00000D R   |   6 free_han   00256B R
  8 game_fla   00000A R   |   6 game_of_   002558 R   |   6 game_ove   0021D8 R
  9 gen        000004 R   |   6 gen_str    00249A R   |   6 get_cell   002326 R
  6 glider     0025F6 R   |   6 gover      002215 R   |   9 grid1      00000A R
  9 grid2      000062 R   |   6 grid_ini   0024C5 R   |   6 img_data   000BA2 R
  6 init_str   0024A7 R   |   6 invert_p   00070E R   |   6 jitter_c   000669 R
  6 kpad_inp   0000CD R   |   6 left_4pi   00093B R   |   6 life_ini   0022F6 R
  6 line       000802 R   |   6 load_bmp   000A01 R   |   6 main       000A9B R
  8 max_scor   000008 R   |   6 max_str    002160 R   |   6 menu       000AF6 R
  6 move       0009B5 GR  |   6 move_arr   001FB7 R   |   6 move_dow   0009D5 R
  6 move_exi   0009F4 R   |   6 move_loo   0009DA R   |   6 move_sna   001FC5 R
  6 move_up    0009C7 R   |   6 neighbor   00240B R   |   6 new_food   0020E6 R
  6 next_gen   002422 R   |   6 next_hea   001F96 R   |   6 noise      0000A6 R
  5 ntsc_fla   0000EF R   |   6 ntsc_ini   0004F5 R   |   5 ntsc_pha   0000F0 R
  6 ntsc_syn   000575 R   |   6 ntsc_vid   000652 R   |   6 patterns   0025B1 R
  6 pause      000033 R   |   6 pentadec   00264A R   |   6 pento_r    002664 R
  6 pixel_ad   0006DB R   |   6 post_vid   00062E R   |   6 print_ge   0022E9 R
  6 prng       000181 GR  |   6 prog_lis   000B88 R   |   6 prompt     002229 R
  6 prt_info   002119 R   |   5 ptr16      0000E8 GR  |   5 ptr8       0000E9 R
  6 put_spri   000875 R   |   6 put_uint   0007DE R   |   6 put_vers   000A46 R
  6 read_key   0000D5 R   |   6 reset_pi   000707 R   |   6 right_4p   000974 R
  6 rotate_h   00202D R   |   6 row_coun   0023A2 R   |   5 scan_lin   0000F1 R
  8 score      000004 R   |   6 score_st   002152 R   |   6 scroll_8   000A32 R
  6 scroll_d   000902 R   |   6 scroll_l   000964 R   |   6 scroll_r   0009A5 R
  6 scroll_t   000714 R   |   6 scroll_u   0008C9 R   |   5 seedx      0000EB R
  5 seedy      0000ED R   |   6 select_m   000B7E R   |   6 set_cell   00235A R
  6 set_patt   002594 R   |   6 set_pixe   000701 R   |   6 set_seed   0001A3 R
  6 sim        002582 R   |   6 sim_init   00256E R   |   6 sll_xy_3   000173 R
  6 snake      00219D R   |   8 snake_bo   00000F R   |   8 snake_di   00000C R
  6 snake_in   002165 R   |   8 snake_le   00000B R   |   6 snake_po   001EF6 R
  5 sound_ti   0000E3 R   |   8 speed      000006 R   |   6 speed_st   002159 R
  9 src        000006 R   |   6 srl_xy_3   00017A R   |   2 stack_fu   001780 GR
  2 stack_un   001800 R   |   6 sync_exi   00064F R   |   6 test_pre   0005E1 R
  5 ticks      0000E0 R   |   6 timeout    0021C7 R   |   6 timeout_   002220 R
  6 timer3_i   00001A R   |   6 toggle_c   00234B R   |   6 tone       00003F R
  6 top_coun   002369 R   |   6 tune       000089 R   |   2 tv_buffe   0004C0 R
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 139.
Hexadecimal [24-Bits]

Symbol Table

  6 tv_cls     0006B5 R   |   6 tv_putc    000756 R   |   6 tv_puts    0007D2 R
  6 user_inp   002062 R   |   6 user_sel   000B2E R   |   6 version_   000A68 R
  6 video_on   00055C R   |   6 wait_key   0000F8 R   |   6 wait_key   0000FE R
  6 xor_seed   000157 R

ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 140.
Hexadecimal [24-Bits]

Area Table

   0 _CODE      size      0   flags    0
   1 SSEG       size      0   flags    8
   2 SSEG0      size   1340   flags    8
   3 HOME       size     80   flags    0
   4 DATA       size      0   flags    8
   5 DATA1      size     15   flags    8
   6 CODE       size   2670   flags    0
   7 G_DATA     size      0   flags    8
   8 G_DATA2    size     4B   flags    8
   9 G_DATA3    size     B6   flags    8

