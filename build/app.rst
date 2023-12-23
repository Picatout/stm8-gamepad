ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 1.
Hexadecimal [24-Bits]



                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2023  
                                      3 ; This file is part of ntsc_tuto 
                                      4 ;
                                      5 ;     ntsc_tuto is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     ntsc_tuto is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with ntsc_tuto.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                                     19 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                     20 ;;; hardware initialization
                                     21 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
                                     22 
                                     23 ;------------------------
                                     24 ; if unified compilation 
                                     25 ; must be first in list 
                                     26 ;-----------------------
                                     27 
                                     28     .module HW_INIT 
                                     29 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 2.
Hexadecimal [24-Bits]



                                     30     .include "config.inc"
                                      1 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                      2 ;;  configuration parameters 
                                      3 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                      4 
                                      5 ;-----------------------
                                      6 ;  version  
                                      7 ;  information 
                                      8 ;-----------------------
                           000001     9 	MAJOR=1
                           000001    10 	MINOR=1
                           000000    11 	REV=0
                                     12 
                                     13 ; master clock frequency in hz 
                           F42400    14 	FMSTR=16000000 
                                     15 
                           00500F    16 SOUND_PORT=PD_BASE 
                           000000    17 SOUND_BIT=(0)
                                     18 
                                     19 
                                     20 ; navigation buttons 
                           00500F    21 KPAD_PORT=PD_BASE 
                           005010    22 KPAD_IDR=PD_IDR
                           000002    23 BIT_A=(2)
                           000003    24 BIT_B=(3)
                           000004    25 BIT_LEFT=(4)
                           000005    26 BIT_RIGHT=(5)
                           000006    27 BIT_DOWN=(6)
                           000007    28 BIT_UP=(7) 
                                     29 
                           000004    30 BTN_A=(1<<BIT_A) 
                           000008    31 BTN_B=(1<<BIT_B)
                           000010    32 BTN_LEFT=(1<<BIT_LEFT) 
                           000020    33 BTN_RIGHT=(1<<BIT_RIGHT)
                           000040    34 BTN_DOWN=(1<<BIT_DOWN) 
                           000080    35 BTN_UP=(1<<BIT_UP)
                           0000FC    36 BTN_MASK=0xFC
                                     37 
                                     38 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 3.
Hexadecimal [24-Bits]



                                     39 	.include "inc/ascii.inc"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 4.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 5.
Hexadecimal [24-Bits]



                                     40 	.include "inc/stm8s207.inc"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 6.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 7.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 8.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 9.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 10.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 11.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 12.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 13.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 14.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 15.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 16.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 17.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 18.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 19.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 20.
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
                                    855 ; Timer 2 - 16-bit timer
                           005300   856  TIM2_CR1  = (0x5300)
                           005301   857  TIM2_IER  = (0x5301)
                           005302   858  TIM2_SR1  = (0x5302)
                           005303   859  TIM2_SR2  = (0x5303)
                           005304   860  TIM2_EGR  = (0x5304)
                           005305   861  TIM2_CCMR1  = (0x5305)
                           005306   862  TIM2_CCMR2  = (0x5306)
                           005307   863  TIM2_CCMR3  = (0x5307)
                           005308   864  TIM2_CCER1  = (0x5308)
                           005309   865  TIM2_CCER2  = (0x5309)
                           00530A   866  TIM2_CNTRH  = (0x530A)
                           00530B   867  TIM2_CNTRL  = (0x530B)
                           00530C   868  TIM2_PSCR  = (0x530C)
                           00530D   869  TIM2_ARRH  = (0x530D)
                           00530E   870  TIM2_ARRL  = (0x530E)
                           00530F   871  TIM2_CCR1H  = (0x530F)
                           005310   872  TIM2_CCR1L  = (0x5310)
                           005311   873  TIM2_CCR2H  = (0x5311)
                           005312   874  TIM2_CCR2L  = (0x5312)
                           005313   875  TIM2_CCR3H  = (0x5313)
                           005314   876  TIM2_CCR3L  = (0x5314)
                                    877 
                                    878 ; TIM2_CR1 bitfields
                           000000   879  TIM2_CR1_CEN=(0) ; Counter enable
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 21.
Hexadecimal [24-Bits]



                           000001   880  TIM2_CR1_UDIS=(1) ; Update disable
                           000002   881  TIM2_CR1_URS=(2) ; Update request source
                           000003   882  TIM2_CR1_OPM=(3) ; One-pulse mode
                           000007   883  TIM2_CR1_ARPE=(7) ; Auto-reload preload enable
                                    884 
                                    885 ; TIMER2_CCMR bitfields 
                           000000   886  TIM2_CCMR_CCS=(0) ; input/output select
                           000003   887  TIM2_CCMR_OCPE=(3) ; preload enable
                           000004   888  TIM2_CCMR_OCM=(4)  ; output compare mode 
                                    889 
                                    890 ; TIMER2_CCER1 bitfields
                           000000   891  TIM2_CCER1_CC1E=(0)
                           000001   892  TIM2_CCER1_CC1P=(1)
                           000004   893  TIM2_CCER1_CC2E=(4)
                           000005   894  TIM2_CCER1_CC2P=(5)
                                    895 
                                    896 ; TIMER2_EGR bitfields
                           000000   897  TIM2_EGR_UG=(0) ; update generation
                           000001   898  TIM2_EGR_CC1G=(1) ; Capture/compare 1 generation
                           000002   899  TIM2_EGR_CC2G=(2) ; Capture/compare 2 generation
                           000003   900  TIM2_EGR_CC3G=(3) ; Capture/compare 3 generation
                           000006   901  TIM2_EGR_TG=(6); Trigger generation
                                    902 
                                    903 ; Timer 3
                           005320   904  TIM3_CR1  = (0x5320)
                           005321   905  TIM3_IER  = (0x5321)
                           005322   906  TIM3_SR1  = (0x5322)
                           005323   907  TIM3_SR2  = (0x5323)
                           005324   908  TIM3_EGR  = (0x5324)
                           005325   909  TIM3_CCMR1  = (0x5325)
                           005326   910  TIM3_CCMR2  = (0x5326)
                           005327   911  TIM3_CCER1  = (0x5327)
                           005328   912  TIM3_CNTRH  = (0x5328)
                           005329   913  TIM3_CNTRL  = (0x5329)
                           00532A   914  TIM3_PSCR  = (0x532A)
                           00532B   915  TIM3_ARRH  = (0x532B)
                           00532C   916  TIM3_ARRL  = (0x532C)
                           00532D   917  TIM3_CCR1H  = (0x532D)
                           00532E   918  TIM3_CCR1L  = (0x532E)
                           00532F   919  TIM3_CCR2H  = (0x532F)
                           005330   920  TIM3_CCR2L  = (0x5330)
                                    921 
                                    922 ; TIM3_CR1  fields
                           000000   923  TIM3_CR1_CEN = (0)
                           000001   924  TIM3_CR1_UDIS = (1)
                           000002   925  TIM3_CR1_URS = (2)
                           000003   926  TIM3_CR1_OPM = (3)
                           000007   927  TIM3_CR1_ARPE = (7)
                                    928  ; TIM3_IER fields
                           000000   929  TIM3_IER_UIE=(0)
                           000001   930  TIM3_IER_CC1IE=(1)
                           000002   931  TIM3_IER_CC2IE=(2)
                           000003   932  TIM3_IER_CC3IE=(3)
                           000006   933  TIM3_IER_TIE=(6)
                                    934 ;TIM3_SR1 fields 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 22.
Hexadecimal [24-Bits]



                           000000   935  TIM3_SR1_UIF=(0)
                           000001   936  TIM3_SR1_CC1IF=(1)
                           000002   937  TIM3_SR1_CC2IF=(2)
                           000003   938  TIM3_SR1_CC3IF=(3)
                           000006   939  TIM3_SR1_TIF=(6)    
                                    940 ;TIM3_SR2 fields
                           000001   941  TIM3_SR2_CC1OF=(1)
                           000002   942  TIM3_SR2_CC2OF=(2)
                           000003   943 TIM3_SR2_CC3OF=(3)
                                    944 ;TIM3_EGR fields 
                           000000   945  TIM3_EGR_UG=(0)
                           000001   946  TIM3_EGR_CC1G=(1)
                           000002   947  TIM3_EGR_CC2G=(2)
                           000003   948  TIM3_EGR_CC3G=(3)
                           000006   949  TIM3_EGR_TG=(6)
                                    950 ; TIM3_CCMR1  fields
                           000000   951  TIM3_CCMR1_CC1S = (0)
                           000003   952  TIM3_CCMR1_OC1PE = (3)
                           000004   953  TIM3_CCMR1_OC1M = (4)  
                                    954 ; TIM3_CCMR2  fields
                           000000   955  TIM3_CCMR2_CC2S = (0)
                           000003   956  TIM3_CCMR2_OC2PE = (3)
                           000004   957  TIM3_CCMR2_OC2M = (4)  
                                    958 ; TIM3_CCMR3  fields
                           000000   959  TIM3_CCMR3_CC3S = (0)
                           000003   960  TIM3_CCMR3_OC3PE = (3)
                           000004   961  TIM3_CCMR3_OC3M = (4)  
                                    962 ; TIM3_CCER3 fields
                           000000   963  TIM3_CCER1_CC1E = (0)
                           000001   964  TIM3_CCER1_CC1P = (1)
                           000004   965  TIM3_CCER1_CC2E = (4)
                           000005   966  TIM3_CCER1_CC2P = (5)
                                    967 ; TIM3_CCER2 fields
                           000000   968  TIM3_CCER2_CC3E = (0)
                           000001   969  TIM3_CCER2_CC3P = (1)
                                    970 
                                    971 ; Timer 4
                           005340   972  TIM4_CR1  = (0x5340)
                           005341   973  TIM4_IER  = (0x5341)
                           005342   974  TIM4_SR  = (0x5342)
                           005343   975  TIM4_EGR  = (0x5343)
                           005344   976  TIM4_CNTR  = (0x5344)
                           005345   977  TIM4_PSCR  = (0x5345)
                           005346   978  TIM4_ARR  = (0x5346)
                                    979 
                                    980 ; Timer 4 bitmasks
                                    981 
                           000007   982  TIM4_CR1_ARPE = (7)
                           000003   983  TIM4_CR1_OPM = (3)
                           000002   984  TIM4_CR1_URS = (2)
                           000001   985  TIM4_CR1_UDIS = (1)
                           000000   986  TIM4_CR1_CEN = (0)
                                    987 
                           000000   988  TIM4_IER_UIE = (0)
                                    989 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 23.
Hexadecimal [24-Bits]



                           000000   990  TIM4_SR_UIF = (0)
                                    991 
                           000000   992  TIM4_EGR_UG = (0)
                                    993 
                           000002   994  TIM4_PSCR_PSC2 = (2)
                           000001   995  TIM4_PSCR_PSC1 = (1)
                           000000   996  TIM4_PSCR_PSC0 = (0)
                                    997 
                           000000   998  TIM4_PSCR_1 = 0
                           000001   999  TIM4_PSCR_2 = 1
                           000002  1000  TIM4_PSCR_4 = 2
                           000003  1001  TIM4_PSCR_8 = 3
                           000004  1002  TIM4_PSCR_16 = 4
                           000005  1003  TIM4_PSCR_32 = 5
                           000006  1004  TIM4_PSCR_64 = 6
                           000007  1005  TIM4_PSCR_128 = 7
                                   1006 
                                   1007 ; ADC2
                           005400  1008  ADC2_CSR  = (0x5400) ; ADC control/status register
                           005401  1009  ADC2_CR1  = (0x5401) ; ADC configuration register 1
                           005402  1010  ADC2_CR2  = (0x5402) ; ADC configuration register 2
                           005403  1011  ADC2_CR3  = (0x5403) ; ADC configuration register 3
                           005404  1012  ADC2_DRH  = (0x5404) ; ADC data register high
                           005405  1013  ADC2_DRL  = (0x5405) ; ADC data register low 
                           005406  1014  ADC2_TDRH  = (0x5406) ; ADC Schmitt trigger disable register high
                           005407  1015  ADC2_TDRL  = (0x5407) ; ADC Schmitt trigger disable register low 
                                   1016  
                                   1017 ; ADC2 bitmasks
                                   1018 
                           000007  1019  ADC2_CSR_EOC = (7) ; end of conversion flag 
                           000006  1020  ADC2_CSR_AWD = (6) ; analog watchdog flag 
                           000005  1021  ADC2_CSR_EOCIE = (5) ; Interrupt enable for EOC 
                           000004  1022  ADC2_CSR_AWDIE = (4) ; Interrupt enable for AWD 
                           000000  1023  ADC2_CSR_CH = (0) ; bits 3:0 channel select field 
                                   1024  
                           000004  1025  ADC2_CR1_SPSEL2 = (4) ; bits 6:4 pre-scaler selection 
                           000001  1026  ADC2_CR1_CONT = (1) ; continuous converstion 
                           000000  1027  ADC2_CR1_ADON = (0) ; converter on/off 
                                   1028 
                           000006  1029  ADC2_CR2_EXTTRIG = (6) ; external trigger enable 
                           000004  1030  ADC2_CR2_EXTSEL1 = (4) ; bits 5:4 external event selection  
                           000003  1031  ADC2_CR2_ALIGN = (3) ; data alignment  
                           000001  1032  ADC2_CR2_SCAN = (1) ; scan mode eanble 
                                   1033 
                           000007  1034  ADC2_CR3_DBUF = (7) ; data buffer enable 
                           000006  1035  ADC2_CR3_DRH = (6)  ; overrun flag 
                                   1036 
                                   1037 ; beCAN
                           005420  1038  CAN_MCR = (0x5420)
                           005421  1039  CAN_MSR = (0x5421)
                           005422  1040  CAN_TSR = (0x5422)
                           005423  1041  CAN_TPR = (0x5423)
                           005424  1042  CAN_RFR = (0x5424)
                           005425  1043  CAN_IER = (0x5425)
                           005426  1044  CAN_DGR = (0x5426)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 24.
Hexadecimal [24-Bits]



                           005427  1045  CAN_FPSR = (0x5427)
                           005428  1046  CAN_P0 = (0x5428)
                           005429  1047  CAN_P1 = (0x5429)
                           00542A  1048  CAN_P2 = (0x542A)
                           00542B  1049  CAN_P3 = (0x542B)
                           00542C  1050  CAN_P4 = (0x542C)
                           00542D  1051  CAN_P5 = (0x542D)
                           00542E  1052  CAN_P6 = (0x542E)
                           00542F  1053  CAN_P7 = (0x542F)
                           005430  1054  CAN_P8 = (0x5430)
                           005431  1055  CAN_P9 = (0x5431)
                           005432  1056  CAN_PA = (0x5432)
                           005433  1057  CAN_PB = (0x5433)
                           005434  1058  CAN_PC = (0x5434)
                           005435  1059  CAN_PD = (0x5435)
                           005436  1060  CAN_PE = (0x5436)
                           005437  1061  CAN_PF = (0x5437)
                                   1062 
                                   1063 
                                   1064 ; CPU
                           007F00  1065  CPU_A  = (0x7F00)
                           007F01  1066  CPU_PCE  = (0x7F01)
                           007F02  1067  CPU_PCH  = (0x7F02)
                           007F03  1068  CPU_PCL  = (0x7F03)
                           007F04  1069  CPU_XH  = (0x7F04)
                           007F05  1070  CPU_XL  = (0x7F05)
                           007F06  1071  CPU_YH  = (0x7F06)
                           007F07  1072  CPU_YL  = (0x7F07)
                           007F08  1073  CPU_SPH  = (0x7F08)
                           007F09  1074  CPU_SPL   = (0x7F09)
                           007F0A  1075  CPU_CCR   = (0x7F0A)
                                   1076 
                                   1077 ; global configuration register
                           007F60  1078  CFG_GCR   = (0x7F60)
                           000001  1079  CFG_GCR_AL = 1
                           000000  1080  CFG_GCR_SWIM = 0
                                   1081 
                                   1082 ; interrupt software priority 
                           007F70  1083  ITC_SPR1   = (0x7F70) ; (0..3) 0->resreved,AWU..EXT0 
                           007F71  1084  ITC_SPR2   = (0x7F71) ; (4..7) EXT1..EXT4 RX 
                           007F72  1085  ITC_SPR3   = (0x7F72) ; (8..11) beCAN RX..TIM1 UPDT/OVR  
                           007F73  1086  ITC_SPR4   = (0x7F73) ; (12..15) TIM1 CAP/CMP .. TIM3 UPDT/OVR 
                           007F74  1087  ITC_SPR5   = (0x7F74) ; (16..19) TIM3 CAP/CMP..I2C  
                           007F75  1088  ITC_SPR6   = (0x7F75) ; (20..23) UART3 TX..TIM4 CAP/OVR 
                           007F76  1089  ITC_SPR7   = (0x7F76) ; (24..29) FLASH WR..
                           007F77  1090  ITC_SPR8   = (0x7F77) ; (30..32) ..
                                   1091 
                           000001  1092 ITC_SPR_LEVEL1=1 
                           000000  1093 ITC_SPR_LEVEL2=0
                           000003  1094 ITC_SPR_LEVEL3=3 
                                   1095 
                                   1096 ; SWIM, control and status register
                           007F80  1097  SWIM_CSR   = (0x7F80)
                                   1098 ; debug registers
                           007F90  1099  DM_BK1RE   = (0x7F90)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 25.
Hexadecimal [24-Bits]



                           007F91  1100  DM_BK1RH   = (0x7F91)
                           007F92  1101  DM_BK1RL   = (0x7F92)
                           007F93  1102  DM_BK2RE   = (0x7F93)
                           007F94  1103  DM_BK2RH   = (0x7F94)
                           007F95  1104  DM_BK2RL   = (0x7F95)
                           007F96  1105  DM_CR1   = (0x7F96)
                           007F97  1106  DM_CR2   = (0x7F97)
                           007F98  1107  DM_CSR1   = (0x7F98)
                           007F99  1108  DM_CSR2   = (0x7F99)
                           007F9A  1109  DM_ENFCTR   = (0x7F9A)
                                   1110 
                                   1111 ; Interrupt Numbers
                           000000  1112  INT_TLI = 0
                           000001  1113  INT_AWU = 1
                           000002  1114  INT_CLK = 2
                           000003  1115  INT_EXTI0 = 3
                           000004  1116  INT_EXTI1 = 4
                           000005  1117  INT_EXTI2 = 5
                           000006  1118  INT_EXTI3 = 6
                           000007  1119  INT_EXTI4 = 7
                           000008  1120  INT_CAN_RX = 8
                           000009  1121  INT_CAN_TX = 9
                           00000A  1122  INT_SPI = 10
                           00000B  1123  INT_TIM1_OVF = 11
                           00000C  1124  INT_TIM1_CCM = 12
                           00000D  1125  INT_TIM2_OVF = 13
                           00000E  1126  INT_TIM2_CCM = 14
                           00000F  1127  INT_TIM3_OVF = 15
                           000010  1128  INT_TIM3_CCM = 16
                           000011  1129  INT_UART1_TX_COMPLETED = 17
                           000012  1130  INT_AUART1_RX_FULL = 18
                           000013  1131  INT_I2C = 19
                           000014  1132  INT_UART3_TX_COMPLETED = 20
                           000015  1133  INT_UART3_RX_FULL = 21
                           000016  1134  INT_ADC2 = 22
                           000017  1135  INT_TIM4_OVF = 23
                           000018  1136  INT_FLASH = 24
                                   1137 
                                   1138 ; Interrupt Vectors
                           008000  1139  INT_VECTOR_RESET = 0x8000
                           008004  1140  INT_VECTOR_TRAP = 0x8004
                           008008  1141  INT_VECTOR_TLI = 0x8008
                           00800C  1142  INT_VECTOR_AWU = 0x800C
                           008010  1143  INT_VECTOR_CLK = 0x8010
                           008014  1144  INT_VECTOR_EXTI0 = 0x8014
                           008018  1145  INT_VECTOR_EXTI1 = 0x8018
                           00801C  1146  INT_VECTOR_EXTI2 = 0x801C
                           008020  1147  INT_VECTOR_EXTI3 = 0x8020
                           008024  1148  INT_VECTOR_EXTI4 = 0x8024
                           008028  1149  INT_VECTOR_CAN_RX = 0x8028
                           00802C  1150  INT_VECTOR_CAN_TX = 0x802c
                           008030  1151  INT_VECTOR_SPI = 0x8030
                           008034  1152  INT_VECTOR_TIM1_OVF = 0x8034
                           008038  1153  INT_VECTOR_TIM1_CCM = 0x8038
                           00803C  1154  INT_VECTOR_TIM2_OVF = 0x803C
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 26.
Hexadecimal [24-Bits]



                           008040  1155  INT_VECTOR_TIM2_CCM = 0x8040
                           008044  1156  INT_VECTOR_TIM3_OVF = 0x8044
                           008048  1157  INT_VECTOR_TIM3_CCM = 0x8048
                           00804C  1158  INT_VECTOR_UART1_TX_COMPLETED = 0x804c
                           008050  1159  INT_VECTOR_UART1_RX_FULL = 0x8050
                           008054  1160  INT_VECTOR_I2C = 0x8054
                           008058  1161  INT_VECTOR_UART3_TX_COMPLETED = 0x8058
                           00805C  1162  INT_VECTOR_UART3_RX_FULL = 0x805C
                           008060  1163  INT_VECTOR_ADC2 = 0x8060
                           008064  1164  INT_VECTOR_TIM4_OVF = 0x8064
                           008068  1165  INT_VECTOR_FLASH = 0x8068
                                   1166 
                                   1167 ; Condition code register bits
                           000007  1168 CC_V = 7  ; overflow flag 
                           000005  1169 CC_I1= 5  ; interrupt bit 1
                           000004  1170 CC_H = 4  ; half carry 
                           000003  1171 CC_I0 = 3 ; interrupt bit 0
                           000002  1172 CC_N = 2 ;  negative flag 
                           000001  1173 CC_Z = 1 ;  zero flag  
                           000000  1174 CC_C = 0 ; carry bit 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 27.
Hexadecimal [24-Bits]



                                     41 	.include "inc/gen_macros.inc" 
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 28.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 29.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 30.
Hexadecimal [24-Bits]



                                     42 	.include "app_macros.inc" 
                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2023  
                                      3 ; This file is part of ntsc_tuto 
                                      4 ;
                                      5 ;     ntsc_tuto is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     ntsc_tuto is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with ntsc_tuto.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                                     19  
                                     20 ; boolean flags 
                           000007    21     F_GAME_TMR=7 ; game timer expired reset 
                           000006    22     F_SOUND_TMR=6 ; sound timer expired reset  
                           000005    23     F_DISP_MODE=5 ; display mode 0->text,1->graphic 
                                     24     
                                     25 ;--------------------------------------
                                     26 ;   assembler flags 
                                     27 ;-------------------------------------
                                     28 
                                     29     ; assume 16 Mhz Fcpu 
                                     30      .macro _usec_dly n 
                                     31     ldw x,#(16*n-2)/4 ; 2 cy 
                                     32     decw x  ; 1 cy 
                                     33     nop     ; 1 cy 
                                     34     jrne .-2 ; 2 cy 
                                     35     .endm 
                                     36 
                                     37 ;----------------------------------
                                     38 ; functions arguments access 
                                     39 ; from stack 
                                     40 ; caller push arguments before call
                                     41 ; and drop them after call  
                                     42 ;----------------------------------    
                                     43     ; get argument in X 
                                     44     .macro _get_arg n 
                                     45     ldw x,(2*(n+1),sp)
                                     46     .endm 
                                     47 
                                     48     ; store X in argument n 
                                     49     .macro _store_arg n 
                                     50     ldw (2*(n+1),sp),x 
                                     51     .endm 
                                     52 
                                     53     ; drop function arguments 
                                     54     .macro _drop_args n 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 31.
Hexadecimal [24-Bits]



                                     55     addw sp,#2*n
                                     56     .endm 
                                     57 
                                     58 
                                     59     ; read buttons 
                                     60     .macro _read_buttons
                                     61     ld a,#BTN_PORT+GPIO_IDR 
                                     62     and a,#ALL_KEY_UP
                                     63     .endm 
                                     64 
                                     65 
                                     66 ;-----------------------------
                                     67 ;   keypad macros 
                                     68 ;-----------------------------
                                     69 
                                     70     .macro _btn_down btn 
                                     71     ld a,BTN_IDR 
                                     72     and a,#(1<<btn)
                                     73     or a,#(1<<btn)
                                     74     .endm 
                                     75 
                                     76     .macro _btn_up 
                                     77     ld a,#BTN_IDR 
                                     78     and a,#(1<<btn)
                                     79     .endm 
                                     80 
                                     81     .macro _btn_state 
                                     82     ld a,#BTN_IDR 
                                     83     and a,#ALL_KEY_UP
                                     84     .endm 
                                     85 
                                     86     .macro _wait_key_release  ?loop 
                                     87     loop:
                                     88     ld a,BTN_IDR 
                                     89     and a,#ALL_KEY_UP 
                                     90     cp a,#ALL_KEY_UP 
                                     91     jrne loop 
                                     92     .endm 
                                     93 
                                     94 ;------------------------
                                     95 ; LED control 
                                     96 ;-----------------------
                                     97 
                                     98     .macro _led_on 
                                     99     bset LED_PORT+GPIO_ODR,#LED_BIT 
                                    100     .endm 
                                    101 
                                    102     .macro _led_off 
                                    103     bres LED_PORT+GPIO_ODR,#LED_BIT
                                    104     .endm 
                                    105 
                                    106     .macro _led_toggle 
                                    107     bcpl LED_PORT+GPIO_ODR,#LED_BIT
                                    108     .endm 
                                    109 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 32.
Hexadecimal [24-Bits]



                                    110     
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 33.
Hexadecimal [24-Bits]



                                     43 
                                     44 
                                     45 
                                     46 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 34.
Hexadecimal [24-Bits]



                                     31 
                           0017FF    32 STACK_EMPTY=RAM_SIZE-1 
                           000080    33 STACK_SIZE=128   
                                     34 ;;-----------------------------------
                                     35     .area SSEG (ABS)
                                     36 ;; working buffers and stack at end of RAM. 	
                                     37 ;;-----------------------------------
      001780                         38     .org RAM_SIZE-STACK_SIZE
      001780                         39 stack_full:: .ds STACK_SIZE   ; control stack full 
      001800                         40 stack_unf: ; stack underflow ; RAM end +1 -> 0x1800
                                     41 
                                     42 
                                     43 ;;--------------------------------------
                                     44     .area HOME 
                                     45 ;; interrupt vector table at 0x8000
                                     46 ;;--------------------------------------
                                     47 
      008000 82 00 81 BF             48     int cold_start			; RESET vector 
      008004 82 00 80 80             49 	int NonHandledInterrupt ; trap instruction 
      008008 82 00 80 80             50 	int NonHandledInterrupt ;int0 TLI   external top level interrupt
      00800C 82 00 80 80             51 	int NonHandledInterrupt ;int1 AWU   auto wake up from halt
      008010 82 00 80 80             52 	int NonHandledInterrupt ;int2 CLK   clock controller
      008014 82 00 80 80             53 	int NonHandledInterrupt ;int3 EXTI0 gpio A external interrupts
      008018 82 00 80 80             54 	int NonHandledInterrupt ;int4 EXTI1 gpio B external interrupts
      00801C 82 00 80 80             55 	int NonHandledInterrupt ;int5 EXTI2 gpio C external interrupts
      008020 82 00 80 80             56 	int NonHandledInterrupt ;int6 EXTI3 gpio D external interrupts
      008024 82 00 80 80             57 	int NonHandledInterrupt ;int7 EXTI4 gpio E external interrupts
      008028 82 00 80 80             58 	int NonHandledInterrupt ;int8 beCAN RX interrupt
      00802C 82 00 80 80             59 	int NonHandledInterrupt ;int9 beCAN TX/ER/SC interrupt
      008030 82 00 80 80             60 	int NonHandledInterrupt ;int10 SPI End of transfer
      008034 82 00 86 22             61 	int ntsc_sync_interrupt ;int11 TIM1 update/overflow/underflow/trigger/break
      008038 82 00 86 CB             62 	int ntsc_video_interrupt ; int12 TIM1 capture/compare
      00803C 82 00 80 80             63 	int NonHandledInterrupt ;int13 TIM2 update /overflow
      008040 82 00 80 80             64 	int NonHandledInterrupt ;int14 TIM2 capture/compare
      008044 82 00 80 80             65 	int NonHandledInterrupt ;int15 TIM3 Update/overflow
      008048 82 00 80 80             66 	int NonHandledInterrupt ;int16 TIM3 Capture/compare
      00804C 82 00 80 80             67 	int NonHandledInterrupt ;int17 UART1 TX completed
      008050 82 00 80 80             68 	int NonHandledInterrupt ;int18 UART1 RX full  
      008054 82 00 80 80             69 	int NonHandledInterrupt ;int19 I2C 
      008058 82 00 80 80             70 	int NonHandledInterrupt ;int20 UART3 TX completed
      00805C 82 00 80 80             71 	int NonHandledInterrupt ;int21 UART3 RX full
      008060 82 00 80 80             72 	int NonHandledInterrupt ;int22 ADC2 end of conversion
      008064 82 00 80 84             73 	int Timer4UpdateHandler ;int23 TIM4 update/overflow ; use to blink tv cursor 
      008068 82 00 80 80             74 	int NonHandledInterrupt ;int24 flash writing EOP/WR_PG_DIS
      00806C 82 00 80 80             75 	int NonHandledInterrupt ;int25  not used
      008070 82 00 80 80             76 	int NonHandledInterrupt ;int26  not used
      008074 82 00 80 80             77 	int NonHandledInterrupt ;int27  not used
      008078 82 00 80 80             78 	int NonHandledInterrupt ;int28  not used
      00807C 82 00 80 80             79 	int NonHandledInterrupt ;int29  not used
                                     80 
                                     81 
                           000060    82 KERNEL_VAR_ORG=0x60
                                     83 ;--------------------------------------
                                     84     .area DATA (ABS)
      000060                         85 	.org KERNEL_VAR_ORG 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 35.
Hexadecimal [24-Bits]



                                     86 ;--------------------------------------	
                                     87 
      000060                         88 ticks: .blkw 1 ; millisecond counter
      000062                         89 delay_timer: .blkb 1 
      000063                         90 sound_timer: .blkb 1 
                                     91 ; keep the following 3 variables in this order 
      000064                         92 acc16:: .blkb 1 ; 16 bits accumulator, acc24 high-byte
      000065                         93 acc8::  .blkb 1 ;  8 bits accumulator, acc24 low-byte  
      000066                         94 fmstr:: .blkw 1 ; frequency in Mhz of Fmaster
      000068                         95 ptr16::  .blkb 1 ; 16 bits pointer , farptr high-byte 
      000069                         96 ptr8:   .blkb 1 ; 8 bits pointer, farptr low-byte  
      00006A                         97 flags:: .blkb 1 ; various boolean flags
      00006B                         98 seedx: .blkw 1  ; prng seed bits 0..15
      00006D                         99 seedy: .blkw 1  ; prng seed bits 16..31
                                    100 
                                    101 ; tvout variables 
      00006F                        102 ntsc_flags: .blkb 1 
      000070                        103 ntsc_phase: .blkb 1 ; 
      000071                        104 scan_line: .blkw 1 ; video lines {0..262} 
                                    105 
                                    106 ; display variables 
      000073                        107 cy: .blkb 1 ; text cursor y coord {0..7} 
      000074                        108 cx: .blkb 1 ; text cursor y coord {0..15}
                                    109 
                                    110 
                                    111 ; video buffer size=768 bytes 
      000080                        112 	.org 0x80 
                           0012C0   113 VBUFF_SIZE=HRES/8*VRES
      000080                        114 tv_buffer: .blkb  VBUFF_SIZE
                                    115 
                                    116 
                                    117 	.area CODE 
                                    118 
                                    119 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    120 ; non handled interrupt 
                                    121 ; reset MCU
                                    122 ;;;;;;;;;;;;;;;;;;;;;;;;;;;
      008080                        123 NonHandledInterrupt:
      000000                        124 	_swreset ; see "inc/gen_macros.inc"
      008080 35 80 50 D1      [ 1]    1     mov WWDG_CR,#0X80
                                    125 
                                    126 ;------------------------------
                                    127 ; TIMER 4 is used to maintain 
                                    128 ; timers and ticks 
                                    129 ; interrupt interval is 1.664 msec 
                                    130 ;--------------------------------
      008084                        131 Timer4UpdateHandler:
      008084 72 5F 53 42      [ 1]  132 	clr TIM4_SR 
      000008                        133 	_ldxz ticks
      008088 BE 60                    1     .byte 0xbe,ticks 
      00808A 5C               [ 1]  134 	incw x 
      00000B                        135 	_strxz ticks
      00808B BF 60                    1     .byte 0xbf,ticks 
                                    136 ; decrement delay_timer and sound_timer on ticks mod 10==0
      00808D A6 0A            [ 1]  137 	ld a,#10
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 36.
Hexadecimal [24-Bits]



      00808F 62               [ 2]  138 	div x,a 
      008090 4D               [ 1]  139 	tnz a
      008091 26 1E            [ 1]  140 	jrne 9$
      008093                        141 1$:	 
      008093 72 0F 00 6A 0A   [ 2]  142 	btjf flags,#F_GAME_TMR,2$  
      008098 72 5A 00 62      [ 1]  143 	dec delay_timer 
      00809C 26 04            [ 1]  144 	jrne 2$ 
      00809E 72 1F 00 6A      [ 1]  145 	bres flags,#F_GAME_TMR  
      0080A2                        146 2$:
      0080A2 72 0D 00 6A 0A   [ 2]  147 	btjf flags,#F_SOUND_TMR,9$
      0080A7 72 5A 00 63      [ 1]  148 	dec sound_timer 
      0080AB 26 04            [ 1]  149 	jrne 9$ 
      0080AD 72 1D 00 6A      [ 1]  150 	bres flags,#F_SOUND_TMR
      0080B1                        151 9$:
      0080B1 80               [11]  152 	iret 
                                    153 
                                    154 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    155 ;    peripherals initialization
                                    156 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    157 
                                    158 ;----------------------------------------
                                    159 ; inialize MCU clock 
                                    160 ; select HSE 
                                    161 ; no CPU divisor 
                                    162 ;----------------------------------------
      0080B2                        163 clock_init:	
      0080B2 72 17 50 C5      [ 1]  164 	bres CLK_SWCR,#CLK_SWCR_SWIF 
      0080B6 35 B4 50 C4      [ 1]  165 	mov CLK_SWR,#CLK_SWR_HSE  
      0080BA 72 07 50 C5 FB   [ 2]  166 	btjf CLK_SWCR,#CLK_SWCR_SWIF,. 
      0080BF 72 12 50 C5      [ 1]  167 	bset CLK_SWCR,#CLK_SWCR_SWEN
      0080C3                        168 2$: 
      0080C3 72 5F 50 C6      [ 1]  169 	clr CLK_CKDIVR   	
      0080C7 81               [ 4]  170 	ret
                                    171 
                                    172 ;---------------------------------
                                    173 ; TIM4 is configured to generate an 
                                    174 ; interrupt every 1.66 millisecond 
                                    175 ;----------------------------------
      0080C8                        176 timer4_init:
      0080C8 72 18 50 C7      [ 1]  177 	bset CLK_PCKENR1,#CLK_PCKENR1_TIM4
      0080CC 72 11 53 40      [ 1]  178 	bres TIM4_CR1,#TIM4_CR1_CEN 
      0080D0 35 07 53 45      [ 1]  179 	mov TIM4_PSCR,#7 ; Fmstr/128=125000 hertz  
      0080D4 35 83 53 46      [ 1]  180 	mov TIM4_ARR,#(256-125) ; 125000/125=1 msec 
      0080D8 35 05 53 40      [ 1]  181 	mov TIM4_CR1,#((1<<TIM4_CR1_CEN)|(1<<TIM4_CR1_URS))
      0080DC 72 10 53 41      [ 1]  182 	bset TIM4_IER,#TIM4_IER_UIE
      0080E0 81               [ 4]  183 	ret
                                    184 
                                    185 ;----------------------------------
                                    186 ; TIMER3 used as audio tone output 
                                    187 ; on port D:2. pin 27
                                    188 ; channel 3 configured as PWM mode 1 
                                    189 ;-----------------------------------  
      0080E1                        190 timer3_init:
      0080E1 72 1C 50 C7      [ 1]  191 	bset CLK_PCKENR1,#CLK_PCKENR1_TIM3 ; enable TIMER3 clock 
      0080E5 72 10 50 11      [ 1]  192  	bset SOUND_PORT+GPIO_DDR,#SOUND_BIT
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 37.
Hexadecimal [24-Bits]



      0080E9 35 60 53 26      [ 1]  193 	mov TIM3_CCMR2,#(6<<TIM3_CCMR2_OC2M) ; PWM mode 1 
      0080ED 35 08 53 2A      [ 1]  194 	mov TIM3_PSCR,#8 ; Ft2clk=fmstr/256=62500 hertz 
      0080F1 72 11 53 20      [ 1]  195 	bres TIM3_CR1,#TIM3_CR1_CEN
      0080F5 72 19 53 27      [ 1]  196 	bres TIM3_CCER1,#TIM3_CCER1_CC2E
      0080F9 81               [ 4]  197 	ret 
                                    198  
                           000000   199 .if 0
                                    200 ;--------------------------
                                    201 ; set software interrupt 
                                    202 ; priority 
                                    203 ; input:
                                    204 ;   A    priority 1,2,3 
                                    205 ;   X    vector 
                                    206 ;---------------------------
                                    207 	SPR_ADDR=1 
                                    208 	PRIORITY=3
                                    209 	SLOT=4
                                    210 	MASKED=5  
                                    211 	VSIZE=5
                                    212 set_int_priority::
                                    213 	_vars VSIZE
                                    214 	and a,#3  
                                    215 	ld (PRIORITY,sp),a 
                                    216 	ld a,#4 
                                    217 	div x,a 
                                    218 	sll a  ; slot*2 
                                    219 	ld (SLOT,sp),a
                                    220 	addw x,#ITC_SPR1 
                                    221 	ldw (SPR_ADDR,sp),x 
                                    222 ; build mask
                                    223 	ldw x,#0xfffc 	
                                    224 	ld a,(SLOT,sp)
                                    225 	jreq 2$ 
                                    226 	scf 
                                    227 1$:	rlcw x 
                                    228 	dec a 
                                    229 	jrne 1$
                                    230 2$:	ld a,xl 
                                    231 ; apply mask to slot 
                                    232 	ldw x,(SPR_ADDR,sp)
                                    233 	and a,(x)
                                    234 	ld (MASKED,sp),a 
                                    235 ; shift priority to slot 
                                    236 	ld a,(PRIORITY,sp)
                                    237 	ld xl,a 
                                    238 	ld a,(SLOT,sp)
                                    239 	jreq 4$
                                    240 3$:	sllw x 
                                    241 	dec a 
                                    242 	jrne 3$
                                    243 4$:	ld a,xl 
                                    244 	or a,(MASKED,sp)
                                    245 	ldw x,(SPR_ADDR,sp)
                                    246 	ld (x),a 
                                    247 	_drop VSIZE 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 38.
Hexadecimal [24-Bits]



                                    248 	ret 
                                    249 .endif 
                                    250 
                                    251 ;------------------------
                                    252 ; suspend execution 
                                    253 ; input:
                                    254 ;   A     n/60 seconds  
                                    255 ;-------------------------
      0080FA                        256 pause:
      00007A                        257 	_straz delay_timer 
      0080FA B7 62                    1     .byte 0xb7,delay_timer 
      0080FC 72 1E 00 6A      [ 1]  258 	bset flags,#F_GAME_TMR 
      008100                        259 1$: 	
      008100 72 0E 00 6A FB   [ 2]  260 	btjt flags,#F_GAME_TMR,1$ 
      008105 81               [ 4]  261 	ret 
                                    262 
                                    263 ;-----------------------
                                    264 ; tone generator 
                                    265 ; Ft2clk=62500 hertz 
                                    266 ; input:
                                    267 ;   A   duration n*10 msec    
                                    268 ;   X   frequency 
                                    269 ;------------------------
                           00F424   270 FR_T3_CLK=62500
      008106                        271 tone:
      008106 90 89            [ 2]  272 	pushw y 
      008108 88               [ 1]  273 	push a 
      008109 90 93            [ 1]  274 	ldw y,x 
      00810B AE F4 24         [ 2]  275 	ldw x,#FR_T3_CLK 
      00810E 65               [ 2]  276 	divw x,y 
      00810F 9E               [ 1]  277 	ld a,xh 
      008110 C7 53 2B         [ 1]  278 	ld TIM3_ARRH,a 
      008113 9F               [ 1]  279 	ld a,xl 
      008114 C7 53 2C         [ 1]  280 	ld TIM3_ARRL,a 
      008117 54               [ 2]  281 	srlw x 
      008118 9E               [ 1]  282 	ld a,xh 
      008119 C7 53 2F         [ 1]  283 	ld TIM3_CCR2H,a 
      00811C 9F               [ 1]  284 	ld a,xl 
      00811D C7 53 30         [ 1]  285 	ld TIM3_CCR2L,a 
      008120 72 18 53 27      [ 1]  286 	bset TIM3_CCER1,#TIM3_CCER1_CC2E
      008124 72 10 53 20      [ 1]  287 	bset TIM3_CR1,#TIM3_CR1_CEN 
      008128 72 10 53 24      [ 1]  288 	bset TIM3_EGR,#TIM3_EGR_UG
      00812C 84               [ 1]  289 	pop a 
      0000AD                        290 	_straz sound_timer  
      00812D B7 63                    1     .byte 0xb7,sound_timer 
      00812F 72 1C 00 6A      [ 1]  291 	bset flags,#F_SOUND_TMR 
      008133                        292 1$:  
      008133 72 0C 00 6A FB   [ 2]  293 	btjt flags,#F_SOUND_TMR,1$
      008138 72 11 53 20      [ 1]  294 	bres TIM3_CR1,#TIM3_CR1_CEN 
      00813C 72 19 53 27      [ 1]  295 	bres TIM3_CCER1,#TIM3_CCER1_CC2E
      008140 90 85            [ 2]  296 	popw y 
      008142 81               [ 4]  297 	ret 
                                    298 
                                    299 ;-----------------
                                    300 ; 1Khz beep 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 39.
Hexadecimal [24-Bits]



                                    301 ;-----------------
      008143                        302 beep:
      008143 88               [ 1]  303 	push a 
      008144 89               [ 2]  304 	pushw x 
      008145 AE 03 E8         [ 2]  305 	ldw x,#1000 ; hertz 
      008148 A6 14            [ 1]  306 	ld a,#20
      00814A CD 81 06         [ 4]  307 	call tone
      00814D 85               [ 2]  308 	popw x 
      00814E 84               [ 1]  309 	pop a   
      00814F 81               [ 4]  310 	ret 
                                    311 
                                    312 ;------------------------
                                    313 ; generate white noise 
                                    314 ; input:
                                    315 ;    A  duration 10*A msec.
                                    316 ;-------------------------- 
      008150                        317 noise:
      008150 89               [ 2]  318 	pushw x
      0000D1                        319 	_straz sound_timer 
      008151 B7 63                    1     .byte 0xb7,sound_timer 
      008153 4B 00            [ 1]  320 	push #0  
      008155 72 1C 00 6A      [ 1]  321 	bset flags,#F_SOUND_TMR
      008159 CD 82 2E         [ 4]  322 1$: call prng
      00815C A6 10            [ 1]  323 	ld a,#16 
      00815E 6B 01            [ 1]  324 	ld (1,sp),a  
      008160 58               [ 2]  325 2$:	sllw x 
      008161 90 11 50 0F      [ 1]  326 	bccm SOUND_PORT,#SOUND_BIT
      008165 A6 0A            [ 1]  327 	ld a,#10 
      008167 4A               [ 1]  328 4$:	dec a 
      008168 26 FD            [ 1]  329 	jrne 4$
      00816A 0A 01            [ 1]  330 	dec (1,sp)
      00816C 26 F2            [ 1]  331 	jrne 2$  
      00816E 72 0C 00 6A E6   [ 2]  332 	btjt flags,#F_SOUND_TMR,1$
      0000F3                        333 	_drop 1 
      008173 5B 01            [ 2]    1     addw sp,#1 
      008175 85               [ 2]  334 	popw x 
      008176 81               [ 4]  335 	ret 
                                    336 
                                    337 ;------------------------
                                    338 ; reading keypad 
                                    339 ; without debouncing 
                                    340 ; output:
                                    341 ;     A   reading 
                                    342 ;-----------------------
      008177                        343 kpad_input:
      008177 C6 50 10         [ 1]  344 	ld a,KPAD_IDR 
      00817A A4 FC            [ 1]  345 	and a,#BTN_MASK 
      00817C A8 FC            [ 1]  346 	xor a,#BTN_MASK  
      00817E 81               [ 4]  347 	ret 
                                    348 
                                    349 
                                    350 ;-------------------------
                                    351 ; read keypad
                                    352 ; ouput:
                                    353 ;    A 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 40.
Hexadecimal [24-Bits]



                                    354 ;       BTN_A -> bit 0 (1)
                                    355 ;       BTN_B -> bit 3 (8)
                                    356 ;       BTN_LEFT -> bit 4 (16)
                                    357 ;       BTN_RIGHT -> bit 5 (32)
                                    358 ;       BTN_DOWN -> bit 6 (64)
                                    359 ;       BNT_UP -> bit 7  (128)
                                    360 ;    Z   set no key 
                                    361 ;-------------------------
                           000001   362 	DEBOUNCE=1
                           000003   363 	BUTTONS=DEBOUNCE+2
                           000003   364 	VAR_SIZE=BUTTONS 
      00817F                        365 read_keypad:
      00817F 89               [ 2]  366 	pushw x 
      000100                        367 	_vars VAR_SIZE
      008180 52 03            [ 2]    1     sub sp,#VAR_SIZE 
      008182 CD 81 77         [ 4]  368 	call kpad_input 
      008185 6B 03            [ 1]  369 1$:	ld (BUTTONS,sp),a  
      008187 CE 00 60         [ 2]  370     ldw x,ticks 
      00818A 1C 00 08         [ 2]  371 	addw x,#8
      00818D 1F 01            [ 2]  372 	ldw (DEBOUNCE,sp),x 	
      00818F CD 81 77         [ 4]  373 2$: call kpad_input 
      008192 11 03            [ 1]  374 	cp a,(BUTTONS,sp)
      008194 26 EF            [ 1]  375 	jrne 1$
      008196 CE 00 60         [ 2]  376 	ldw x,ticks 
      008199 13 01            [ 2]  377 	cpw x,(DEBOUNCE,sp)
      00819B 26 F2            [ 1]  378 	jrne 2$
      00011D                        379 	_drop VAR_SIZE  
      00819D 5B 03            [ 2]    1     addw sp,#VAR_SIZE 
      00819F 85               [ 2]  380 	popw x
      0081A0 4D               [ 1]  381 	tnz a 
      0081A1 81               [ 4]  382 	ret 
                                    383 
                                    384 ;----------------------------
                                    385 ; wait until key pressed 
                                    386 ; output:
                                    387 ;    A    key
                                    388 ;----------------------------
      0081A2                        389 wait_key:
      0081A2 CD 81 7F         [ 4]  390 	call read_keypad 
      0081A5 27 FB            [ 1]  391 	jreq wait_key
      0081A7 81               [ 4]  392 	ret 
                                    393 
                                    394 ;--------------------------
                                    395 ; wait for buttons released 
                                    396 ; but no more than 100msec
                                    397 ; input:
                                    398 ;    X   maximum delay msec
                                    399 ;--------------------------
                           000001   400     DLY=1
                           000002   401     VAR_SIZE=2
      0081A8                        402 wait_key_release:
      000128                        403     _vars VAR_SIZE
      0081A8 52 02            [ 2]    1     sub sp,#VAR_SIZE 
      0081AA 72 BB 00 60      [ 2]  404     addw x,ticks
      0081AE 1F 01            [ 2]  405     ldw (DLY,sp),x 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 41.
Hexadecimal [24-Bits]



      0081B0                        406 1$: 
      0081B0 CE 00 60         [ 2]  407     ldw x,ticks 
      0081B3 13 01            [ 2]  408     cpw x,(DLY,sp)
      0081B5 2A 05            [ 1]  409     jrpl 9$     
      0081B7 CD 81 77         [ 4]  410     call kpad_input
      0081BA 26 F4            [ 1]  411     jrne 1$ 
      0081BC                        412 9$:
      00013C                        413     _drop VAR_SIZE 
      0081BC 5B 02            [ 2]    1     addw sp,#VAR_SIZE 
      0081BE 81               [ 4]  414     ret 
                                    415 
                                    416 ;-------------------------------------
                                    417 ;  initialization entry point 
                                    418 ;-------------------------------------
      0081BF                        419 cold_start:
                                    420 ;set stack 
      0081BF 9B               [ 1]  421 	sim
      0081C0 AE 17 FF         [ 2]  422 	ldw x,#STACK_EMPTY
      0081C3 94               [ 1]  423 	ldw sp,x
                                    424 ; clear all ram 
      0081C4 7F               [ 1]  425 0$: clr (x)
      0081C5 5A               [ 2]  426 	decw x 
      0081C6 26 FC            [ 1]  427 	jrne 0$
                                    428 ; disable all peripherals clock 
      0081C8 72 5F 50 C7      [ 1]  429 	clr CLK_PCKENR1 
      0081CC 72 5F 50 CA      [ 1]  430 	clr CLK_PCKENR2 
                                    431 ; activate pull up on all inputs 
                                    432 ; or push pull on output 
      0081D0 A6 FF            [ 1]  433 	ld a,#255 
      0081D2 C7 50 03         [ 1]  434 	ld PA_CR1,a 
      0081D5 C7 50 08         [ 1]  435 	ld PB_CR1,a 
      0081D8 C7 50 0D         [ 1]  436 	ld PC_CR1,a 
      0081DB C7 50 12         [ 1]  437 	ld PD_CR1,a
      0081DE C7 50 17         [ 1]  438 	ld PE_CR1,a 
      0081E1 C7 50 1C         [ 1]  439 	ld PF_CR1,a 
      0081E4 C7 50 21         [ 1]  440 	ld PG_CR1,a 
      0081E7 C7 50 26         [ 1]  441 	ld PH_CR1,a 
      0081EA C7 50 2B         [ 1]  442 	ld PI_CR1,a 
      0081ED CD 80 B2         [ 4]  443 	call clock_init	
      0081F0 CD 80 C8         [ 4]  444 	call timer4_init
      0081F3 CD 80 E1         [ 4]  445 	call timer3_init
      0081F6 CD 85 A2         [ 4]  446 	call ntsc_init ;
      0081F9 9A               [ 1]  447 	rim ; enable interrupts 
      0081FA 5F               [ 1]  448 	clrw x 
      0081FB CD 82 50         [ 4]  449 	call set_seed
      0081FE                        450 4$:
      0081FE CD 81 43         [ 4]  451 	call beep
      008201 CC 89 54         [ 2]  452 	jp main ; in tv_term.asm 
                                    453 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 42.
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
                                     20 
                                     21 ;---------------------------------
                                     22 ; Pseudo Random Number Generator 
                                     23 ; XORShift algorithm.
                                     24 ; 32 bits seed.
                                     25 ;---------------------------------
                                     26 
                                     27 ;---------------------------------
                                     28 ;  seedx:seedy= x:y ^ seedx:seedy
                                     29 ; output:
                                     30 ;  X:Y   seedx:seedy new value   
                                     31 ;---------------------------------
      008204                         32 xor_seed32:
      008204 9E               [ 1]   33     ld a,xh 
      000185                         34     _xorz seedx 
      008205 B8 6B                    1     .byte 0xb8,seedx 
      000187                         35     _straz seedx
      008207 B7 6B                    1     .byte 0xb7,seedx 
      008209 9F               [ 1]   36     ld a,xl 
      00018A                         37     _xorz seedx+1 
      00820A B8 6C                    1     .byte 0xb8,seedx+1 
      00018C                         38     _straz seedx+1 
      00820C B7 6C                    1     .byte 0xb7,seedx+1 
      00820E 90 9E            [ 1]   39     ld a,yh 
      000190                         40     _xorz seedy
      008210 B8 6D                    1     .byte 0xb8,seedy 
      000192                         41     _straz seedy 
      008212 B7 6D                    1     .byte 0xb7,seedy 
      008214 90 9F            [ 1]   42     ld a,yl 
      000196                         43     _xorz seedy+1 
      008216 B8 6E                    1     .byte 0xb8,seedy+1 
      000198                         44     _straz seedy+1 
      008218 B7 6E                    1     .byte 0xb7,seedy+1 
      00019A                         45     _ldxz seedx  
      00821A BE 6B                    1     .byte 0xbe,seedx 
      00019C                         46     _ldyz seedy 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 43.
Hexadecimal [24-Bits]



      00821C 90 BE 6D                 1     .byte 0x90,0xbe,seedy 
      00821F 81               [ 4]   47     ret 
                                     48 
                                     49 ;-----------------------------------
                                     50 ;   x:y= x:y << a 
                                     51 ;  input:
                                     52 ;    A     shift count 
                                     53 ;    X:Y   uint32 value 
                                     54 ;  output:
                                     55 ;    X:Y   uint32 shifted value   
                                     56 ;-----------------------------------
      008220                         57 sll_xy_32: 
      008220 90 58            [ 2]   58     sllw y 
      008222 59               [ 2]   59     rlcw x
      008223 4A               [ 1]   60     dec a 
      008224 26 FA            [ 1]   61     jrne sll_xy_32 
      008226 81               [ 4]   62     ret 
                                     63 
                                     64 ;-----------------------------------
                                     65 ;   x:y= x:y >> a 
                                     66 ;  input:
                                     67 ;    A     shift count 
                                     68 ;    X:Y   uint32 value 
                                     69 ;  output:
                                     70 ;    X:Y   uint32 shifted value   
                                     71 ;-----------------------------------
      008227                         72 srl_xy_32: 
      008227 54               [ 2]   73     srlw x 
      008228 90 56            [ 2]   74     rrcw y 
      00822A 4A               [ 1]   75     dec a 
      00822B 26 FA            [ 1]   76     jrne srl_xy_32 
      00822D 81               [ 4]   77     ret 
                                     78 
                                     79 ;-------------------------------------
                                     80 ;  PRNG generator proper 
                                     81 ; input:
                                     82 ;   none 
                                     83 ; ouput:
                                     84 ;   X     bits 31...16  PRNG seed  
                                     85 ;  use: 
                                     86 ;   seedx:seedy   system variables   
                                     87 ;--------------------------------------
      00822E                         88 prng::
      00822E 90 89            [ 2]   89 	pushw y   
      0001B0                         90     _ldxz seedx
      008230 BE 6B                    1     .byte 0xbe,seedx 
      0001B2                         91 	_ldyz seedy  
      008232 90 BE 6D                 1     .byte 0x90,0xbe,seedy 
      008235 A6 0D            [ 1]   92 	ld a,#13
      008237 CD 82 20         [ 4]   93     call sll_xy_32 
      00823A CD 82 04         [ 4]   94     call xor_seed32
      00823D A6 11            [ 1]   95     ld a,#17 
      00823F CD 82 27         [ 4]   96     call srl_xy_32
      008242 CD 82 04         [ 4]   97     call xor_seed32 
      008245 A6 05            [ 1]   98     ld a,#5 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 44.
Hexadecimal [24-Bits]



      008247 CD 82 20         [ 4]   99     call sll_xy_32
      00824A CD 82 04         [ 4]  100     call xor_seed32
      00824D 90 85            [ 2]  101     popw y 
      00824F 81               [ 4]  102     ret 
                                    103 
                                    104 
                                    105 ;---------------------------------
                                    106 ; initialize seedx:seedy 
                                    107 ; input:
                                    108 ;    X    0 -> seedx=ticks, seedy=[0x6000] 
                                    109 ;    X    !0 -> seedx=X, y=[0x6000], seedy=swapw(y)
                                    110 ;-------------------------------------------
      008250                        111 set_seed:
      008250 5D               [ 2]  112     tnzw x 
      008251 26 0B            [ 1]  113     jrne 1$ 
      008253 CE 00 60         [ 2]  114     ldw x,ticks 
      0001D6                        115     _strxz seedx
      008256 BF 6B                    1     .byte 0xbf,seedx 
      008258 AE 60 00         [ 2]  116     ldw x,#0x6000  
      0001DB                        117     _strxz seedy  
      00825B BF 6D                    1     .byte 0xbf,seedy 
      00825D 81               [ 4]  118     ret 
      00825E                        119 1$:  
      0001DE                        120     _strxz seedx
      00825E BF 6B                    1     .byte 0xbf,seedx 
      008260 90 CE 60 00      [ 2]  121     ldw y,0x6000
      008264 90 5E            [ 1]  122     swapw y 
      0001E6                        123     _stryz seedy 
      008266 90 BF 6D                 1     .byte 0x90,0xbf,seedy 
      008269 81               [ 4]  124     ret 
                                    125 
                                    126 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 45.
Hexadecimal [24-Bits]



                                      1  
                                      2  ;
                                      3 ; Copyright Jacques Deschênes 2023 
                                      4 ; This file is part of stm8_terminal 
                                      5 ;
                                      6 ;     stm8_terminal is free software: you can redistribute it and/or modify
                                      7 ;     it under the terms of the GNU General Public License as published by
                                      8 ;     the Free Software Foundation, either version 3 of the License, or
                                      9 ;     (at your option) any later version.
                                     10 ;
                                     11 ;     stm8_terminal is distributed in the hope that it will be useful,
                                     12 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     13 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     14 ;     GNU General Public License for more details.
                                     15 ;
                                     16 ;     You should have received a copy of the GNU General Public License
                                     17 ;     along with stm8_terminal.  If not, see <http://www.gnu.org/licenses/>.
                                     18 ;;
                                     19 
                                     20     .area CODE
                                     21 
                           000008    22 FONT_HEIGHT=8
                           000006    23 FONT_WIDTH=6
      00826A                         24 font_6x8: 
      00826A 00 00 00 00 00 00 00    25 .byte 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00  ; space ASCII 32
             00
      008272 20 20 20 20 20 00 20    26 .byte 0x20,0x20,0x20,0x20,0x20,0x00,0x20,0x00  ; !
             00
      00827A 50 50 50 00 00 00 00    27 .byte 0x50,0x50,0x50,0x00,0x00,0x00,0x00,0x00  ; "
             00
      008282 50 50 F8 50 F8 50 50    28 .byte 0x50,0x50,0xF8,0x50,0xF8,0x50,0x50,0x00  ; #
             00
      00828A 20 78 A0 70 28 F0 20    29 .byte 0x20,0x78,0xA0,0x70,0x28,0xF0,0x20,0x00  ; $
             00
      008292 C0 C8 10 20 40 98 18    30 .byte 0xC0,0xC8,0x10,0x20,0x40,0x98,0x18,0x00  ; %
             00
      00829A 60 90 A0 40 A8 90 68    31 .byte 0x60,0X90,0xA0,0x40,0xA8,0x90,0x68,0x00  ; &
             00
      0082A2 60 20 40 00 00 00 00    32 .byte 0x60,0x20,0x40,0x00,0x00,0x00,0x00,0x00  ; '
             00
      0082AA 10 20 40 40 40 20 10    33 .byte 0x10,0x20,0x40,0x40,0x40,0x20,0x10,0x00  ; (
             00
      0082B2 40 20 10 10 10 20 40    34 .byte 0x40,0x20,0x10,0x10,0x10,0x20,0x40,0x00  ; )
             00
      0082BA 00 20 A8 70 A8 20 00    35 .byte 0x00,0x20,0xA8,0x70,0xA8,0x20,0x00,0x00  ; *
             00
      0082C2 00 20 20 F8 20 20 00    36 .byte 0x00,0x20,0x20,0xF8,0x20,0x20,0x00,0x00  ; +
             00
      0082CA 00 00 00 70 70 30 60    37 .byte 0x00,0x00,0x00,0x70,0x70,0x30,0x60,0x40  ; ,
             40
      0082D2 00 00 00 F0 00 00 00    38 .byte 0x00,0x00,0x00,0xF0,0x00,0x00,0x00,0x00  ; -
             00
      0082DA 00 00 00 00 00 60 60    39 .byte 0x00,0x00,0x00,0x00,0x00,0x60,0x60,0x00  ; .
             00
      0082E2 00 06 0C 18 30 60 00    40 .byte 0x00,0x06,0x0c,0x18,0x30,0x60,0x00,0x00  ; /
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 46.
Hexadecimal  00-Bits]



             00
      0082EA 70 88 98 A8 C8 88 70    41 .byte 0x70,0x88,0x98,0xA8,0xC8,0x88,0x70,0x00  ; 0
             00
      0082F2 20 60 20 20 20 20 F8    42 .byte 0x20,0x60,0x20,0x20,0x20,0x20,0xF8,0x00  ; 1
             00
      0082FA 70 88 10 20 40 80 F8    43 .byte 0x70,0x88,0x10,0x20,0x40,0x80,0xF8,0x00  ; 2
             00
      008302 F0 08 08 F0 08 08 F0    44 .byte 0xF0,0x08,0x08,0xF0,0x08,0x08,0xF0,0x00  ; 3
             00
      00830A 10 30 50 90 F8 10 10    45 .byte 0x10,0x30,0x50,0x90,0xF8,0x10,0x10,0x00  ; 4
             00
      008312 F8 80 80 F0 08 08 F0    46 .byte 0xF8,0x80,0x80,0xF0,0x08,0x08,0xF0,0x00  ; 5
             00
      00831A 30 40 80 F0 88 88 70    47 .byte 0x30,0x40,0x80,0xF0,0x88,0x88,0x70,0x00  ; 6
             00
      008322 F8 08 10 20 40 40 40    48 .byte 0xF8,0x08,0x10,0x20,0x40,0x40,0x40,0x00  ; 7
             00
      00832A 70 88 88 70 88 88 70    49 .byte 0x70,0x88,0x88,0x70,0x88,0x88,0x70,0x00  ; 8
             00
      008332 70 88 88 70 08 08 70    50 .byte 0x70,0x88,0x88,0x70,0x08,0x08,0x70,0x00  ; 9
             00
      00833A 00 70 70 00 70 70 00    51 .byte 0x00,0x70,0x70,0x00,0x70,0x70,0x00,0x00  ; :
             00
      008342 00 70 70 00 70 70 60    52 .byte 0x00,0x70,0x70,0x00,0x70,0x70,0x60,0x40  ; ;
             40
      00834A 10 20 40 80 40 20 10    53 .byte 0x10,0x20,0x40,0x80,0x40,0x20,0x10,0x00  ; <
             00
      008352 00 00 F8 00 F8 00 00    54 .byte 0x00,0x00,0xF8,0x00,0xF8,0x00,0x00,0x00  ; =
             00
      00835A 40 20 10 08 10 20 40    55 .byte 0x40,0x20,0x10,0x08,0x10,0x20,0x40,0x00  ; >
             00
      008362 70 88 08 10 20 00 20    56 .byte 0x70,0x88,0x08,0x10,0x20,0x00,0x20,0x00  ; ?
             00
      00836A 70 88 08 68 A8 A8 70    57 .byte 0x70,0x88,0x08,0x68,0xA8,0xA8,0x70,0x00  ; @
             00
      008372 70 88 88 F8 88 88 88    58 .byte 0x70,0x88,0x88,0xF8,0x88,0x88,0x88,0x00  ; A
             00
      00837A F0 88 88 F0 88 88 F0    59 .byte 0xF0,0x88,0x88,0xF0,0x88,0x88,0xF0,0x00  ; B
             00
      008382 78 80 80 80 80 80 78    60 .byte 0x78,0x80,0x80,0x80,0x80,0x80,0x78,0x00  ; C
             00
      00838A F0 88 88 88 88 88 F0    61 .byte 0xF0,0x88,0x88,0x88,0x88,0x88,0xF0,0x00  ; D
             00
      008392 F8 80 80 F8 80 80 F8    62 .byte 0xF8,0x80,0x80,0xF8,0x80,0x80,0xF8,0x00  ; E
             00
      00839A F8 80 80 F8 80 80 80    63 .byte 0xF8,0x80,0x80,0xF8,0x80,0x80,0x80,0x00  ; F
             00
      0083A2 78 80 80 B0 88 88 70    64 .byte 0x78,0x80,0x80,0xB0,0x88,0x88,0x70,0x00  ; G
             00
      0083AA 88 88 88 F8 88 88 88    65 .byte 0x88,0x88,0x88,0xF8,0x88,0x88,0x88,0x00  ; H
             00
      0083B2 70 20 20 20 20 20 70    66 .byte 0x70,0x20,0x20,0x20,0x20,0x20,0x70,0x00  ; I
             00
      0083BA 78 08 08 08 08 90 60    67 .byte 0x78,0x08,0x08,0x08,0x08,0x90,0x60,0x00  ; J
             00
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 47.
Hexadecimal [24-Bits]



      0083C2 88 90 A0 C0 A0 90 88    68 .byte 0x88,0x90,0xA0,0xC0,0xA0,0x90,0x88,0x00  ; K
             00
      0083CA 80 80 80 80 80 80 F8    69 .byte 0x80,0x80,0x80,0x80,0x80,0x80,0xF8,0x00  ; L
             00
      0083D2 88 D8 A8 88 88 88 88    70 .byte 0x88,0xD8,0xA8,0x88,0x88,0x88,0x88,0x00  ; M
             00
      0083DA 88 88 C8 A8 98 88 88    71 .byte 0x88,0x88,0xC8,0xA8,0x98,0x88,0x88,0x00  ; N
             00
      0083E2 70 88 88 88 88 88 70    72 .byte 0x70,0x88,0x88,0x88,0x88,0x88,0x70,0x00  ; O
             00
      0083EA F0 88 88 F0 80 80 80    73 .byte 0xF0,0x88,0x88,0xF0,0x80,0x80,0x80,0x00  ; P
             00
      0083F2 70 88 88 88 A8 90 68    74 .byte 0x70,0x88,0x88,0x88,0xA8,0x90,0x68,0x00  ; Q
             00
      0083FA F0 88 88 F0 A0 90 88    75 .byte 0xF0,0x88,0x88,0xF0,0xA0,0x90,0x88,0x00  ; R
             00
      008402 78 80 80 70 08 08 F0    76 .byte 0x78,0x80,0x80,0x70,0x08,0x08,0xF0,0x00  ; S
             00
      00840A F8 20 20 20 20 20 20    77 .byte 0xF8,0x20,0x20,0x20,0x20,0x20,0x20,0x00  ; T
             00
      008412 88 88 88 88 88 88 70    78 .byte 0x88,0x88,0x88,0x88,0x88,0x88,0x70,0x00  ; U
             00
      00841A 88 88 88 88 88 50 20    79 .byte 0x88,0x88,0x88,0x88,0x88,0x50,0x20,0x00  ; V
             00
      008422 88 88 88 A8 A8 D8 88    80 .byte 0x88,0x88,0x88,0xA8,0xA8,0xD8,0x88,0x00  ; W
             00
      00842A 88 88 50 20 50 88 88    81 .byte 0x88,0x88,0x50,0x20,0x50,0x88,0x88,0x00  ; X
             00
      008432 88 88 88 50 20 20 20    82 .byte 0x88,0x88,0x88,0x50,0x20,0x20,0x20,0x00  ; Y
             00
      00843A F8 10 20 40 80 80 F8    83 .byte 0xF8,0x10,0x20,0x40,0x80,0x80,0xF8,0x00  ; Z
             00
      008442 60 40 40 40 40 40 60    84 .byte 0x60,0x40,0x40,0x40,0x40,0x40,0x60,0x00  ; [
             00
      00844A 00 80 40 20 10 08 00    85 .byte 0x00,0x80,0x40,0x20,0x10,0x08,0x00,0x00  ; '\'
             00
      008452 18 08 08 08 08 08 18    86 .byte 0x18,0x08,0x08,0x08,0x08,0x08,0x18,0x00  ; ]
             00
      00845A 20 50 88 00 00 00 00    87 .byte 0x20,0x50,0x88,0x00,0x00,0x00,0x00,0x00  ; ^
             00
      008462 00 00 00 00 00 00 00    88 .byte 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFE  ; _
             FE
      00846A 40 20 10 00 00 00 00    89 .byte 0x40,0x20,0x10,0x00,0x00,0x00,0x00,0x00  ; `
             00
      008472 00 00 70 08 78 88 78    90 .byte 0x00,0x00,0x70,0x08,0x78,0x88,0x78,0x00  ; a
             00
      00847A 80 80 80 B0 C8 88 F0    91 .byte 0x80,0x80,0x80,0xB0,0xC8,0x88,0xF0,0x00  ; b
             00
      008482 00 00 70 80 80 88 70    92 .byte 0x00,0x00,0x70,0x80,0x80,0x88,0x70,0x00  ; c
             00
      00848A 08 08 08 68 98 88 78    93 .byte 0x08,0x08,0x08,0x68,0x98,0x88,0x78,0x00  ; d
             00
      008492 00 00 70 88 F8 80 70    94 .byte 0x00,0x00,0x70,0x88,0xF8,0x80,0x70,0x00  ; e
             00
      00849A 30 48 40 E0 40 40 40    95 .byte 0x30,0x48,0x40,0xE0,0x40,0x40,0x40,0x00  ; f
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 48.
Hexadecimal  00-Bits]



             00
      0084A2 00 00 78 88 88 78 08    96 .byte 0x00,0x00,0x78,0x88,0x88,0x78,0x08,0x70  ; g
             70
      0084AA 80 80 B0 C8 88 88 88    97 .byte 0x80,0x80,0xB0,0xC8,0x88,0x88,0x88,0x00  ; h
             00
      0084B2 00 20 00 20 20 20 20    98 .byte 0x00,0x20,0x00,0x20,0x20,0x20,0x20,0x00  ; i
             00
      0084BA 10 00 30 10 10 90 60    99 .byte 0x10,0x00,0x30,0x10,0x10,0x90,0x60,0x00  ; j
             00
      0084C2 80 80 90 A0 C0 A0 90   100 .byte 0x80,0x80,0x90,0xA0,0xC0,0xA0,0x90,0x00  ; k
             00
      0084CA 60 20 20 20 20 20 70   101 .byte 0x60,0x20,0x20,0x20,0x20,0x20,0x70,0x00  ; l
             00
      0084D2 00 00 D0 A8 A8 88 88   102 .byte 0x00,0x00,0xD0,0xA8,0xA8,0x88,0x88,0x00  ; m
             00
      0084DA 00 00 B0 C8 88 88 88   103 .byte 0x00,0x00,0xB0,0xC8,0x88,0x88,0x88,0x00  ; n
             00
      0084E2 00 00 70 88 88 88 70   104 .byte 0x00,0x00,0x70,0x88,0x88,0x88,0x70,0x00  ; o
             00
      0084EA 00 00 F0 88 88 F0 80   105 .byte 0x00,0x00,0xF0,0x88,0x88,0xF0,0x80,0x80  ; p
             80
      0084F2 00 00 68 90 90 B0 50   106 .byte 0x00,0x00,0x68,0x90,0x90,0xB0,0x50,0x18  ; q
             18
      0084FA 00 00 B0 C8 80 80 80   107 .byte 0x00,0x00,0xB0,0xC8,0x80,0x80,0x80,0x00  ; r
             00
      008502 00 00 70 80 70 08 F0   108 .byte 0x00,0x00,0x70,0x80,0x70,0x08,0xF0,0x00  ; s
             00
      00850A 40 40 E0 40 40 48 30   109 .byte 0x40,0x40,0xE0,0x40,0x40,0x48,0x30,0x00  ; t
             00
      008512 00 00 88 88 88 98 68   110 .byte 0x00,0x00,0x88,0x88,0x88,0x98,0x68,0x00  ; u
             00
      00851A 00 00 88 88 88 50 20   111 .byte 0x00,0x00,0x88,0x88,0x88,0x50,0x20,0x00  ; v
             00
      008522 00 00 88 88 A8 A8 50   112 .byte 0x00,0x00,0x88,0x88,0xA8,0xA8,0x50,0x00  ; w
             00
      00852A 00 00 88 50 20 50 88   113 .byte 0x00,0x00,0x88,0x50,0x20,0x50,0x88,0x00  ; x
             00
      008532 00 00 88 88 88 78 08   114 .byte 0x00,0x00,0x88,0x88,0x88,0x78,0x08,0x70  ; y
             70
      00853A 00 00 F8 10 20 40 F8   115 .byte 0x00,0x00,0xF8,0x10,0x20,0x40,0xF8,0x00  ; z
             00
      008542 20 40 40 80 40 40 20   116 .byte 0x20,0x40,0x40,0x80,0x40,0x40,0x20,0x00  ; {
             00
      00854A 20 20 20 20 20 20 20   117 .byte 0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x00  ; |
             00
      008552 40 20 20 10 20 20 40   118 .byte 0x40,0x20,0x20,0x10,0x20,0x20,0x40,0x00  ; }
             00
      00855A 00 00 40 A8 10 00 00   119 .byte 0x00,0x00,0x40,0xA8,0x10,0x00,0x00,0x00  ; ~  ASCII 127 
             00
      008562 FC FC FC FC FC FC FC   120 .byte 0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC  ; 95 block cursor  128 
             FC
      00856A 40 20 10 F8 10 20 40   121 .byte 0x40,0x20,0x10,0xF8,0x10,0x20,0x40,0x00  ; 96 flèche droite 129 
             00
      008572 10 20 40 F8 40 20 10   122 .byte 0x10,0x20,0x40,0xF8,0x40,0x20,0x10,0x00  ; 97 flèche gauche 130
             00
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 49.
Hexadecimal [24-Bits]



      00857A 20 70 A8 20 20 20 00   123 .byte 0x20,0x70,0xA8,0x20,0x20,0x20,0x00,0x00  ; 98 flèche haut   131
             00
      008582 00 20 20 20 A8 70 20   124 .byte 0x00,0x20,0x20,0x20,0xA8,0x70,0x20,0x00  ; 99 flèche bas    132
             00
      00858A 00 70 F8 F8 F8 70 00   125 .byte 0x00,0x70,0xF8,0xF8,0xF8,0x70,0x00,0x00  ; 100 rond		  133 
             00
      008592 00 00 00 00 00 00 00   126 .byte 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xff  ; 101 underline cursor 134
             FF
      00859A 80 80 80 80 80 80 80   127 .byte 0x80,0x80,0x80,0x80,0x80,0x80,0x80,0x80  ; 102 insert cursor 135 
             80
      0085A2                        128 font_end:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 50.
Hexadecimal [24-Bits]



                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2023  
                                      3 ; This file is part of ntsc_tuto 
                                      4 ;
                                      5 ;     ntsc_tuto is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     ntsc_tuto is distributed in the hope that it will be useful,
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
                           00008C    34 LINE_DELAY=(140) 
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 51.
Hexadecimal [24-Bits]



                                     56 ; initialize TIMER1 for 
                                     57 ; NTSC synchronisation 
                                     58 ; signal 
                                     59 ;------------------------------
      0085A2                         60 ntsc_init:
      000522                         61     _clrz ntsc_flags 
      0085A2 3F 6F                    1     .byte 0x3f, ntsc_flags 
      000524                         62     _clrz ntsc_phase 
      0085A4 3F 70                    1     .byte 0x3f, ntsc_phase 
                                     63 ; enable TIMER1 and SPI clock 
      0085A6 72 1E 50 C7      [ 1]   64     bset CLK_PCKENR1,#CLK_PCKENR1_TIM1
      0085AA 72 12 50 C7      [ 1]   65     bset CLK_PCKENR1,#CLK_PCKENR1_SPI
                                     66 ; set MOSI pin as output high-speed push-pull 
      0085AE 72 1C 50 0C      [ 1]   67     bset PC_DDR,#6 
      0085B2 72 1D 50 0A      [ 1]   68     bres PC_ODR,#6
      0085B6 72 1C 50 0D      [ 1]   69     bset PC_CR1,#6
      0085BA 72 1C 50 0E      [ 1]   70     bset PC_CR2,#6
      0085BE 72 5F 52 03      [ 1]   71     clr SPI_SR 
      0085C2 72 5F 52 04      [ 1]   72     clr SPI_DR 
      0085C6 35 4C 52 00      [ 1]   73     mov SPI_CR1,#(1<<SPI_CR1_SPE)|(1<<SPI_CR1_MSTR)|(1<<SPI_CR1_BR)
                                     74 ; initialize timer1 for pwm
                                     75 ; generate NTSC sync signal  on CH3 
      0085CA 35 01 52 54      [ 1]   76     mov TIM1_IER,#1 ; UIE set 
      0085CE 72 1E 52 50      [ 1]   77     bset TIM1_CR1,#TIM1_CR1_ARPE ; auto preload enabled 
      0085D2 35 78 52 5A      [ 1]   78     mov TIM1_CCMR3,#(7<<TIM1_CCMR3_OC3MODE)  |(1<<TIM1_CCMR3_OC3PE)
      0085D6 72 10 52 5D      [ 1]   79     bset TIM1_CCER2,#0
      0085DA 72 1E 52 6D      [ 1]   80     bset TIM1_BKR,#7
                                     81 ; use channel 2 for video stream trigger 
                                     82 ; set pixel out delay   
      0085DE 35 60 52 59      [ 1]   83     mov TIM1_CCMR2,#(6<<TIM1_CCMR2_OC2MODE) 
      0085E2 35 00 52 67      [ 1]   84     mov TIM1_CCR2H,#LINE_DELAY>>8 
      0085E6 35 8C 52 68      [ 1]   85     mov TIM1_CCR2L,#LINE_DELAY&0xFF
                                     86 ; begin with PH_PRE_EQU odd field 
      00056A                         87     _clrz ntsc_phase 
      0085EA 3F 70                    1     .byte 0x3f, ntsc_phase 
      0085EC 35 03 52 62      [ 1]   88     mov TIM1_ARRH,#HLINE>>8
      0085F0 35 F8 52 63      [ 1]   89     mov TIM1_ARRL,#HLINE&0XFF
      0085F4 35 00 52 69      [ 1]   90     mov TIM1_CCR3H,#HPULSE>>8 
      0085F8 35 4B 52 6A      [ 1]   91     mov TIM1_CCR3L,#HPULSE&0XFF
      0085FC CD 87 2A         [ 4]   92     call tv_cls 
      0085FF 72 10 52 50      [ 1]   93     bset TIM1_CR1,#TIM1_CR1_CEN 
      008603 A6 01            [ 1]   94     ld a,#1
      008605 CD 86 09         [ 4]   95     call video_on_off 
      008608 81               [ 4]   96     ret 
                                     97 
                                     98 ;--------------------
                                     99 ; enable|disable 
                                    100 ; video output 
                                    101 ; input:
                                    102 ;   A    0->off 
                                    103 ;        1->on
                                    104 ;--------------------
      008609                        105 video_on_off:
      008609 4D               [ 1]  106     tnz a 
      00860A 27 09            [ 1]  107     jreq 1$ 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 52.
Hexadecimal [24-Bits]



                                    108 ; enable video 
      00860C 72 18 00 6F      [ 1]  109     bset ntsc_flags,#F_VIDEO 
      008610 72 10 52 54      [ 1]  110     bset TIM1_IER,#TIM1_IER_UIE 
      008614 81               [ 4]  111     ret     
      008615                        112 1$: ; disable video 
      008615 72 19 00 6F      [ 1]  113     bres ntsc_flags,#F_VIDEO 
      008619 72 15 52 54      [ 1]  114     bres TIM1_IER,#TIM1_IER_CC2IE 
      00861D 72 10 52 54      [ 1]  115     bset TIM1_IER,#TIM1_IER_UIE 
      008621 81               [ 4]  116     ret 
                                    117 
                                    118 
                                    119 ;-------------------------------
                                    120 ; TIMER1 update interrupt handler 
                                    121 ; interrupt happend at end 
                                    122 ; of each phase and and pwm 
                                    123 ; is set for next phase 
                                    124 ;-------------------------------
      008622                        125 ntsc_sync_interrupt:
      008622 72 5F 52 55      [ 1]  126     clr TIM1_SR1 
      0005A6                        127     _ldxz scan_line 
      008626 BE 71                    1     .byte 0xbe,scan_line 
      008628 5C               [ 1]  128     incw x 
      0005A9                        129     _strxz scan_line 
      008629 BF 71                    1     .byte 0xbf,scan_line 
      0005AB                        130     _ldaz ntsc_phase 
      00862B B6 70                    1     .byte 0xb6,ntsc_phase 
      00862D A1 00            [ 1]  131     cp a,#PH_VSYNC  
      00862F 26 5D            [ 1]  132     jrne test_pre_video 
      008631 A3 00 01         [ 2]  133     cpw x,#1 
      008634 26 13            [ 1]  134     jrne  1$ 
      008636 35 01 52 62      [ 1]  135     mov TIM1_ARRH,#HALF_LINE>>8 
      00863A 35 FC 52 63      [ 1]  136     mov TIM1_ARRL,#HALF_LINE & 0xff 
      00863E 35 00 52 69      [ 1]  137     mov TIM1_CCR3H,#EPULSE>>8 
      008642 35 25 52 6A      [ 1]  138     mov TIM1_CCR3L,#EPULSE&0xff 
      008646 CC 86 C8         [ 2]  139     jp sync_exit 
      008649 A3 00 07         [ 2]  140 1$: cpw x,#7 
      00864C 26 0B            [ 1]  141     jrne 2$ 
      00864E 35 01 52 69      [ 1]  142     mov TIM1_CCR3H,#VPULSE>>8 
      008652 35 B4 52 6A      [ 1]  143     mov TIM1_CCR3L,#VPULSE&0xff 
      008656 CC 86 C8         [ 2]  144     jp sync_exit 
      008659                        145 2$:
      008659 A3 00 0D         [ 2]  146     cpw x,#13 
      00865C 26 0B            [ 1]  147     jrne 3$ 
      00865E 35 00 52 69      [ 1]  148     mov TIM1_CCR3H,#EPULSE>>8 
      008662 35 25 52 6A      [ 1]  149     mov TIM1_CCR3L,#EPULSE&0xff 
      008666 CC 86 C8         [ 2]  150     jp sync_exit 
      008669                        151 3$: 
      008669 A3 00 12         [ 2]  152     cpw x,#18 
      00866C 26 19            [ 1]  153     jrne 5$ 
      00866E 72 00 00 6F 55   [ 2]  154     btjt ntsc_flags,#F_EVEN,sync_exit 
      008673                        155 4$:
      008673 35 03 52 62      [ 1]  156     mov TIM1_ARRH,#HLINE>>8 
      008677 35 F8 52 63      [ 1]  157     mov TIM1_ARRL,#HLINE & 0xff 
      00867B 35 00 52 69      [ 1]  158     mov TIM1_CCR3H,#HPULSE>>8 
      00867F 35 4B 52 6A      [ 1]  159     mov TIM1_CCR3L,#HPULSE&0xff 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 53.
Hexadecimal [24-Bits]



      008683 4C               [ 1]  160     inc a 
      008684 CC 86 C8         [ 2]  161     jp sync_exit 
      008687                        162 5$: 
      008687 A3 00 13         [ 2]  163     cpw x,#19 
      00868A 27 E7            [ 1]  164     jreq 4$ 
      00868C 20 3A            [ 2]  165     jra sync_exit 
      00868E                        166 test_pre_video:
      00868E A1 01            [ 1]  167     cp a,#PH_PRE_VIDEO 
      008690 26 15            [ 1]  168     jrne post_video  
      008692 A3 00 37         [ 2]  169     cpw x,#FIRST_VIDEO_LINE
      008695 26 31            [ 1]  170     jrne sync_exit 
      008697 4C               [ 1]  171     inc a 
      008698 72 09 00 6F 2B   [ 2]  172     btjf ntsc_flags,#F_VIDEO,sync_exit
      00869D 72 11 52 54      [ 1]  173     bres TIM1_IER,#TIM1_IER_UIE 
      0086A1 72 14 52 54      [ 1]  174     bset TIM1_IER,#TIM1_IER_CC2IE
      0086A5 20 21            [ 2]  175     jra sync_exit
      0086A7                        176 post_video:
      0086A7 A3 01 0F         [ 2]  177     cpw x,#271
      0086AA 26 07            [ 1]  178     jrne 2$ 
      0086AC 72 01 00 6F 0F   [ 2]  179     btjf ntsc_flags,#F_EVEN,#3$  
      0086B1 20 15            [ 2]  180     jra sync_exit  
      0086B3                        181 2$: 
      0086B3 A3 01 10         [ 2]  182     cpw x,#272 
      0086B6 26 10            [ 1]  183     jrne sync_exit 
      0086B8 35 01 52 62      [ 1]  184     mov TIM1_ARRH,#HALF_LINE>>8
      0086BC 35 FC 52 63      [ 1]  185     mov TIM1_ARRL,#HALF_LINE & 0xff 
      0086C0                        186 3$: ;field end     
      0086C0 4F               [ 1]  187     clr a 
      0086C1 5F               [ 1]  188     clrw x 
      000642                        189     _strxz scan_line
      0086C2 BF 71                    1     .byte 0xbf,scan_line 
      0086C4 90 10 00 6F      [ 1]  190     bcpl ntsc_flags,#F_EVEN
      0086C8                        191 sync_exit:
      000648                        192     _straz ntsc_phase
      0086C8 B7 70                    1     .byte 0xb7,ntsc_phase 
      0086CA 80               [11]  193     iret 
                                    194 
                                    195 
                                    196 
                                    197 ;----------------------------------
                                    198 ; TIMER1 compare interrupt handler
                                    199 ;----------------------------------
                           000001   200     BPL=1 
                           000001   201     VAR_SIZE=1
      0086CB                        202 ntsc_video_interrupt:
      00064B                        203     _vars VAR_SIZE
      0086CB 52 01            [ 2]    1     sub sp,#VAR_SIZE 
      0086CD 72 5F 52 55      [ 1]  204     clr TIM1_SR1
      0086D1 C6 52 5F         [ 1]  205     ld a,TIM1_CNTRL 
      0086D4 A4 07            [ 1]  206     and a,#7 
      0086D6 88               [ 1]  207     push a 
      0086D7 4B 00            [ 1]  208     push #0 
      0086D9 AE 86 E2         [ 2]  209     ldw x,#jitter_cancel 
      0086DC 72 FB 01         [ 2]  210     addw x,(1,sp)
      00065F                        211     _drop 2 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 54.
Hexadecimal [24-Bits]



      0086DF 5B 02            [ 2]    1     addw sp,#2 
      0086E1 FC               [ 2]  212     jp (x)
      0086E2                        213 jitter_cancel:
      0086E2 9D               [ 1]  214     nop 
      0086E3 9D               [ 1]  215     nop 
      0086E4 9D               [ 1]  216     nop 
      0086E5 9D               [ 1]  217     nop 
      0086E6 9D               [ 1]  218     nop 
      0086E7 9D               [ 1]  219     nop 
      0086E8 9D               [ 1]  220     nop 
      0086E9 9D               [ 1]  221     nop 
                                    222 ; compute postion in buffer 
                                    223 ; 3 scan line/video buffer line 
                                    224 ; ofs=scan_line/3+tv_buffer       
      00066A                        225     _ldxz scan_line 
      0086EA BE 71                    1     .byte 0xbe,scan_line 
      0086EC 1D 00 37         [ 2]  226     subw x,#FIRST_VIDEO_LINE
      0086EF A6 19            [ 1]  227     ld a,#BYTES_PER_LINE  
      0086F1 42               [ 4]  228     mul x,a  ; tv_buffer line  
      0086F2 1C 00 80         [ 2]  229     addw x,#tv_buffer
      0086F5 A6 19            [ 1]  230     ld a,#BYTES_PER_LINE
      0086F7 6B 01            [ 1]  231     ld (BPL,sp),a 
                                    232 ;    bset SPI_CR1,#SPI_CR1_SPE  
                                    233 ;    _shift_out_scan_line
      0086F9 F6               [ 1]  234 1$: ld a,(x)
      0086FA 5C               [ 1]  235     incw x 
      0086FB C7 52 04         [ 1]  236     ld SPI_DR,a 
      0086FE 72 03 52 03 FB   [ 2]  237     btjf SPI_SR,#SPI_SR_TXE,. 
      008703 0A 01            [ 1]  238     dec (BPL,sp)
      008705 26 F2            [ 1]  239     jrne 1$ 
      008707 72 5F 52 04      [ 1]  240     clr SPI_DR
      00870B 72 03 52 03 FB   [ 2]  241     btjf SPI_SR,#SPI_SR_TXE,. 
      008710 72 0E 52 03 FB   [ 2]  242     btjt SPI_SR,#SPI_SR_BSY,.
                                    243 ;    bres SPI_CR1,#SPI_CR1_SPE  
      000695                        244     _ldxz scan_line 
      008715 BE 71                    1     .byte 0xbe,scan_line 
      008717 5C               [ 1]  245     incw x 
      000698                        246     _strxz scan_line 
      008718 BF 71                    1     .byte 0xbf,scan_line 
      00871A A3 00 F7         [ 2]  247     cpw x,#FIRST_VIDEO_LINE+VIDEO_LINES
      00871D 2B 08            [ 1]  248     jrmi 4$ 
      00871F 72 15 52 54      [ 1]  249     bres TIM1_IER,#TIM1_IER_CC2IE
      008723 72 10 52 54      [ 1]  250     bset TIM1_IER,#TIM1_IER_UIE
      0006A7                        251 4$: _drop VAR_SIZE
      008727 5B 01            [ 2]    1     addw sp,#VAR_SIZE 
      008729 80               [11]  252     iret 
                                    253 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 55.
Hexadecimal [24-Bits]



                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2023  
                                      3 ; This file is part of ntsc_tuto 
                                      4 ;
                                      5 ;     ntsc_tuto is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     ntsc_tuto is distributed in the hope that it will be useful,
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
      00872A                         31 tv_cls:
      00872A 90 89            [ 2]   32     pushw y 
      00872C AE 12 C0         [ 2]   33     ldw x,#VBUFF_SIZE 
      00872F 90 AE 00 80      [ 2]   34     ldw y,#tv_buffer
      008733 90 7F            [ 1]   35 1$: clr (y)
      008735 90 5C            [ 1]   36     incw y 
      008737 5A               [ 2]   37     decw x 
      008738 26 F9            [ 1]   38     jrne 1$
      0006BA                         39     _clrz cx 
      00873A 3F 74                    1     .byte 0x3f, cx 
      0006BC                         40     _clrz cy   
      00873C 3F 73                    1     .byte 0x3f, cy 
      00873E 90 85            [ 2]   41     popw y 
      008740 81               [ 4]   42     ret 
                                     43 
                                     44 ;------------------------
                                     45 ; build bitmask from 
                                     46 ; bit position 
                                     47 ; input:
                                     48 ;    A    position {0..7}
                                     49 ;------------------------
      008741                         50 bit_mask:
      008741 88               [ 1]   51     push a 
      008742 A6 80            [ 1]   52     ld a,#128 
      008744 0D 01            [ 1]   53 1$: tnz (1,sp)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 56.
Hexadecimal [24-Bits]



      008746 27 05            [ 1]   54     jreq 9$ 
      008748                         55 2$:
      008748 44               [ 1]   56     srl a 
      008749 0A 01            [ 1]   57     dec (1,sp)
      00874B 26 FB            [ 1]   58     jrne 2$
      0006CD                         59 9$: _drop 1 
      00874D 5B 01            [ 2]    1     addw sp,#1 
      00874F 81               [ 4]   60     ret 
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
      008750                         79 pixel_addr:
      0006D0                         80     _vars VAR_SIZE
      008750 52 05            [ 2]    1     sub sp,#VAR_SIZE 
      008752 1F 01            [ 2]   81     ldw (YCOOR,sp),x 
      008754 5F               [ 1]   82     clrw x 
      008755 1F 03            [ 2]   83     ldw (BOFS,sp),x 
      008757 7B 02            [ 1]   84     ld a,(XCOOR,sp)
      008759 97               [ 1]   85     ld xl,a 
      00875A A6 08            [ 1]   86     ld a,#8 
      00875C 62               [ 2]   87     div x,a 
                                     88 ;    sub a,#7 
                                     89 ;    neg a 
      00875D 6B 05            [ 1]   90     ld (BPOS,sp),a
      00875F 9F               [ 1]   91     ld a,xl 
      008760 6B 04            [ 1]   92     ld (BOFSL,sp),a 
      008762 7B 01            [ 1]   93     ld a,(YCOOR,sp)
      008764 AE 00 19         [ 2]   94     ldw x,#BYTES_PER_LINE 
      008767 42               [ 4]   95     mul x,a 
      008768 1C 00 80         [ 2]   96     addw x,#tv_buffer
      00876B 72 FB 03         [ 2]   97     addw x,(BOFS,sp)
      00876E 7B 05            [ 1]   98     ld a,(BPOS,sp)
      008770 CD 87 41         [ 4]   99     call bit_mask 
      0006F3                        100     _drop VAR_SIZE  
      008773 5B 05            [ 2]    1     addw sp,#VAR_SIZE 
      008775 81               [ 4]  101     ret 
                                    102 
                                    103 ;-------------------------
                                    104 ; set pixel 
                                    105 ; input:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 57.
Hexadecimal [24-Bits]



                                    106 ;     XH    y coord {0..63}
                                    107 ;     XL    x coord (0..95)
                                    108 ;---------------------------
      008776                        109 set_pixel:
      008776 CD 87 50         [ 4]  110     call pixel_addr
      008779 FA               [ 1]  111     or a,(x)
      00877A F7               [ 1]  112     ld (x),a 
      00877B 81               [ 4]  113     ret 
                                    114 
                                    115 ;-------------------------
                                    116 ; reset pixel 
                                    117 ; input:
                                    118 ;     XH    y coord {0..63}
                                    119 ;     XL    x coord (0..95)
                                    120 ;---------------------------
      00877C                        121 reset_pixel:
      00877C CD 87 50         [ 4]  122     call pixel_addr
      00877F 43               [ 1]  123     cpl a 
      008780 F4               [ 1]  124     and a,(x)
      008781 F7               [ 1]  125     ld (x),a 
      008782 81               [ 4]  126     ret 
                                    127 
                                    128 ;-------------------------
                                    129 ; invert pixel 
                                    130 ; input:
                                    131 ;     XH    y coord {0..63}
                                    132 ;     XL    x coord (0..95)
                                    133 ;---------------------------
      008783                        134 invert_pixel:
      008783 CD 87 50         [ 4]  135     call pixel_addr 
      008786 F8               [ 1]  136     xor a,(x)
      008787 F7               [ 1]  137     ld (x),a 
      008788 81               [ 4]  138     ret 
                                    139 
                                    140 ;-----------------------------
                                    141 ; move text 1 line up 
                                    142 ; clear bottom line 
                                    143 ;-----------------------------
      008789                        144 scroll_up:
      008789 88               [ 1]  145     push a 
      00878A 89               [ 2]  146     pushw x 
      00878B 90 89            [ 2]  147     pushw y 
                                    148 ; count bytes to copy     
      00878D AE 11 F8         [ 2]  149     ldw x,#(VRES-FONT_HEIGHT)*BYTES_PER_LINE
      008790 89               [ 2]  150     pushw x 
                                    151 ; destination address     
      008791 AE 00 80         [ 2]  152     ldw x,#tv_buffer 
      008794 90 93            [ 1]  153     ldw y,x 
                                    154 ; source address     
      008796 72 A9 00 C8      [ 2]  155     addw y,#BYTES_PER_LINE*FONT_HEIGHT 
      00879A 90 F6            [ 1]  156 1$: ld a,(y)
      00879C 90 5C            [ 1]  157     incw y 
      00879E F7               [ 1]  158     ld (x),a
      00879F 5C               [ 1]  159     incw x
      0087A0 89               [ 2]  160     pushw x 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 58.
Hexadecimal [24-Bits]



      0087A1 1E 03            [ 2]  161     ldw x,(3,sp)
      0087A3 5A               [ 2]  162     decw x
      0087A4 1F 03            [ 2]  163     ldw (3,sp),x 
      0087A6 85               [ 2]  164     popw x 
      0087A7 26 F1            [ 1]  165     jrne 1$     
                                    166 ; clear bottom text line 
      0087A9 AE 00 C8         [ 2]  167     ldw x,#(FONT_HEIGHT*BYTES_PER_LINE) 
      0087AC 1F 01            [ 2]  168     ldw (1,sp),x 
      0087AE 72 F2 01         [ 2]  169     subw y,(1,sp)
      0087B1 90 7F            [ 1]  170 2$: clr (y)
      0087B3 90 5C            [ 1]  171     incw y 
      0087B5 5A               [ 2]  172     decw x 
      0087B6 26 F9            [ 1]  173     jrne 2$    
      000738                        174     _drop 2     
      0087B8 5B 02            [ 2]    1     addw sp,#2 
      0087BA 90 85            [ 2]  175     popw y 
      0087BC 85               [ 2]  176     popw x 
      0087BD 84               [ 1]  177     pop a 
      0087BE 81               [ 4]  178     ret 
                                    179 
                                    180 
                                    181 
                                    182 ;----------------------------
                                    183 ; move text cursor to 
                                    184 ; next line 
                                    185 ;----------------------------
      0087BF                        186 crlf:
      00073F                        187     _clrz cx 
      0087BF 3F 74                    1     .byte 0x3f, cx 
      000741                        188     _ldaz cy 
      0087C1 B6 73                    1     .byte 0xb6,cy 
      0087C3 4C               [ 1]  189     inc a
      0087C4 A1 18            [ 1]  190     cp a,#LINE_PER_SCREEN
      0087C6 2B 04            [ 1]  191     jrmi 1$
      0087C8 CD 87 89         [ 4]  192     call scroll_up
      0087CB 81               [ 4]  193     ret  
      0087CC                        194 1$: 
      00074C                        195     _straz cy 
      0087CC B7 73                    1     .byte 0xb7,cy 
      0087CE 81               [ 4]  196     ret 
                                    197 
                                    198 ;------------------------------
                                    199 ; move text cursor right 
                                    200 ;------------------------------
      0087CF                        201 cursor_right:
      00074F                        202     _incz cx 
      0087CF 3C 74                    1     .byte 0x3c, cx 
      000751                        203     _ldaz cx 
      0087D1 B6 74                    1     .byte 0xb6,cx 
      0087D3 A1 21            [ 1]  204     cp a,#CHAR_PER_LINE  
      0087D5 2A E8            [ 1]  205     jrpl crlf 
      0087D7 81               [ 4]  206     ret 
                                    207 
                                    208 ;-------------------------
                                    209 ; put character on tv 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 59.
Hexadecimal [24-Bits]



                                    210 ; input:
                                    211 ;    A    character 
                                    212 ;------------------------
                           000001   213     XCOORH=1
                           000002   214     XCOOR=XCOORH+1
                           000003   215     BYTECNT=XCOOR+1
                           000004   216     SHIFT=BYTECNT+1
                           000005   217     MASK=SHIFT+1
                           000007   218     ROW=MASK+2
                           000008   219     VAR_SIZE=ROW+1  
      0087D8                        220 tv_putc:
      0087D8 90 89            [ 2]  221     pushw y 
      00075A                        222     _vars VAR_SIZE 
      0087DA 52 08            [ 2]    1     sub sp,#VAR_SIZE 
      0087DC A1 0D            [ 1]  223     cp a,#CR 
      0087DE 26 06            [ 1]  224     jrne 1$ 
      0087E0 CD 87 BF         [ 4]  225     call crlf 
      0087E3 CC 88 4D         [ 2]  226     jp 9$
      0087E6                        227  1$:
      0087E6 A0 20            [ 1]  228     sub a,#SPACE 
      0087E8 AE 00 08         [ 2]  229     ldw x,#FONT_HEIGHT
      0087EB 42               [ 4]  230     mul x,a 
      0087EC 1C 82 6A         [ 2]  231     addw x,#font_6x8
      0087EF 90 93            [ 1]  232     ldw y,x 
      0087F1 AE 03 FF         [ 2]  233     ldw x,#0x03ff
      0087F4 1F 05            [ 2]  234     ldw (MASK,sp),x 
      0087F6 A6 08            [ 1]  235     ld a,#FONT_HEIGHT
      0087F8 6B 03            [ 1]  236     ld (BYTECNT,sp),a 
      00077A                        237     _ldaz cx 
      0087FA B6 74                    1     .byte 0xb6,cx 
      0087FC AE 00 06         [ 2]  238     ldw x,#FONT_WIDTH  
      0087FF 42               [ 4]  239     mul x,a
      008800 A6 08            [ 1]  240     ld a,#8 
      008802 62               [ 2]  241     div x,a 
      008803 6B 04            [ 1]  242     ld (SHIFT,sp),a 
      008805 1F 01            [ 2]  243     ldw (XCOORH,sp),x     
      000787                        244     _ldaz cy 
      008807 B6 73                    1     .byte 0xb6,cy 
      008809 AE 00 08         [ 2]  245     ldw x,#FONT_HEIGHT
      00880C 42               [ 4]  246     mul x,a 
      00880D A6 19            [ 1]  247     ld a,#BYTES_PER_LINE
      00880F 42               [ 4]  248     mul x,a 
      008810 72 FB 01         [ 2]  249     addw x,(XCOORH,sp)
      008813 1C 00 80         [ 2]  250     addw x,#tv_buffer 
                                    251 ; shift MASK 
      008816 7B 04            [ 1]  252     ld a,(SHIFT,sp)
      008818 27 08            [ 1]  253     jreq 4$
      00881A 99               [ 1]  254     scf 
      00881B 06 05            [ 1]  255 3$: rrc (MASK,sp)
      00881D 06 06            [ 1]  256     rrc (MASK+1,sp)
      00881F 4A               [ 1]  257     dec a 
      008820 26 F9            [ 1]  258     jrne 3$
                                    259 ; get font row 
                                    260 ; and shift it 
      008822                        261 4$:     
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 60.
Hexadecimal [24-Bits]



      008822 90 F6            [ 1]  262     ld a,(y)
      008824 90 5C            [ 1]  263     incw y 
      008826 6B 07            [ 1]  264     ld (ROW,sp),a 
      008828 0F 08            [ 1]  265     clr (ROW+1,sp)
      00882A 7B 04            [ 1]  266     ld a,(SHIFT,sp)
      00882C 27 07            [ 1]  267     jreq 6$ 
      00882E                        268 5$:  
      00882E 04 07            [ 1]  269     srl (ROW,sp)
      008830 06 08            [ 1]  270     rrc (ROW+1,sp)
      008832 4A               [ 1]  271     dec a 
      008833 26 F9            [ 1]  272     jrne 5$ 
      008835                        273 6$: 
      008835 7B 05            [ 1]  274     ld a,(MASK,sp)
      008837 F4               [ 1]  275     and a,(x)
      008838 1A 07            [ 1]  276     or a,(ROW,sp)
      00883A F7               [ 1]  277     ld (x),a 
      00883B E6 01            [ 1]  278     ld a,(1,x)
      00883D 14 06            [ 1]  279     and a,(MASK+1,sp)
      00883F 1A 08            [ 1]  280     or a,(ROW+1,sp)
      008841 E7 01            [ 1]  281     ld (1,x),a 
      008843 1C 00 19         [ 2]  282     addw x,#BYTES_PER_LINE
      008846 0A 03            [ 1]  283     dec (BYTECNT,sp)
      008848 26 D8            [ 1]  284     jrne 4$ 
      00884A CD 87 CF         [ 4]  285     call cursor_right
      00884D                        286 9$:
      0007CD                        287     _drop VAR_SIZE 
      00884D 5B 08            [ 2]    1     addw sp,#VAR_SIZE 
      00884F 90 85            [ 2]  288     popw y 
      008851 81               [ 4]  289     ret 
                                    290 
                                    291 ;--------------------------
                                    292 ; put string on tv 
                                    293 ; input:
                                    294 ;   Y     *aciz 
                                    295 ;--------------------------
      008852                        296 tv_puts:
      008852 90 F6            [ 1]  297     ld a,(y)
      008854 27 07            [ 1]  298     jreq 9$
      008856 90 5C            [ 1]  299     incw y 
      008858 CD 87 D8         [ 4]  300     call tv_putc 
      00885B 20 F5            [ 2]  301     jra tv_puts 
      00885D                        302 9$:
      00885D 81               [ 4]  303     ret
                                    304 
                                    305 
                                    306 ;-------------------------------
                                    307 ; line drawing 
                                    308 ;  X0<=X1 
                                    309 ;  Y0<=Y1 
                                    310 ; input:
                                    311 ;     XH  x0 
                                    312 ;     XL  x1 
                                    313 ;     YH  y0 
                                    314 ;     YL  y1 
                                    315 ;--------------------------------
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 61.
Hexadecimal [24-Bits]



                           000001   316     X0=1  ; int8 
                           000002   317     X1=2  ; int8 
                           000003   318     Y0=3  ; int8 
                           000004   319     Y1=4  ; int8 
                           000005   320     DX=5   ; int16 
                           000007   321     DY=7   ; int16 
                           000009   322     DELTA=9 ; int16 
                           00000A   323     VAR_SIZE=10
      00885E                        324 line:
      0007DE                        325     _vars VAR_SIZE 
      00885E 52 0A            [ 2]    1     sub sp,#VAR_SIZE 
      008860 1F 01            [ 2]  326     ldw (X0,sp),x
      008862 17 03            [ 2]  327     ldw (Y0,sp),y
      008864 9E               [ 1]  328     ld a,xh 
      008865 11 02            [ 1]  329     cp a,(X1,sp)
      008867 27 41            [ 1]  330     jreq 3$ 
      008869 90 9E            [ 1]  331     ld a,yh 
      00886B 11 04            [ 1]  332     cp a,(Y1,sp)
      00886D 27 4E            [ 1]  333     jreq 4$ 
      00886F 7B 02            [ 1]  334     ld a,(X1,sp)
      008871 10 01            [ 1]  335     sub a,(X0,sp)
      008873 5F               [ 1]  336     clrw x 
      008874 97               [ 1]  337     ld xl,a 
      008875 1F 05            [ 2]  338     ldw (DX,sp),x 
      008877 7B 04            [ 1]  339     ld a,(Y1,sp)
      008879 10 03            [ 1]  340     sub a,(Y0,sp)
      00887B 97               [ 1]  341     ld xl,a 
      00887C 1F 07            [ 2]  342     ldw (DY,sp),x 
      00887E 58               [ 2]  343     sllw x 
      00887F 72 F0 05         [ 2]  344     subw x,(DX,sp)
      008882 1F 09            [ 2]  345     ldw (DELTA,sp),x 
      008884                        346 1$:  
      008884 7B 01            [ 1]  347     ld a,(X0,sp)
      008886 11 02            [ 1]  348     cp a,(X1,sp)
      008888 27 46            [ 1]  349     jreq 9$ 
      00888A 97               [ 1]  350     ld xl,a 
      00888B 7B 03            [ 1]  351     ld a,(Y0,sp)
      00888D 95               [ 1]  352     ld xh,a
      00888E CD 87 76         [ 4]  353     call set_pixel 
      008891 1E 09            [ 2]  354     ldw x,(DELTA,sp)
      008893 5D               [ 2]  355     tnzw x
      008894 2B 08            [ 1]  356     jrmi 2$
      008896 0C 03            [ 1]  357     inc (Y0,sp)
      008898 72 F0 05         [ 2]  358     subw x,(DX,sp)
      00889B 72 F0 05         [ 2]  359     subw x,(DX,sp)
      00889E                        360 2$: 
      00889E 72 FB 07         [ 2]  361     addw x,(DY,sp)
      0088A1 72 FB 07         [ 2]  362     addw x,(DY,sp)
      0088A4 1F 09            [ 2]  363     ldw (DELTA,sp),x  
      0088A6 0C 01            [ 1]  364     inc (X0,sp)
      0088A8 20 DA            [ 2]  365     jra 1$
      0088AA                        366 3$: ; vertical line 
      0088AA 7B 01            [ 1]  367     ld a,(X0,sp)
      0088AC 97               [ 1]  368     ld xl,a 
      0088AD 7B 03            [ 1]  369     ld a,(Y0,sp)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 62.
Hexadecimal [24-Bits]



      0088AF 95               [ 1]  370     ld xh,a 
      0088B0 CD 87 76         [ 4]  371     call set_pixel 
      0088B3 0C 03            [ 1]  372     inc (Y0,sp)
      0088B5 7B 03            [ 1]  373     ld a,(Y0,sp)
      0088B7 11 04            [ 1]  374     cp a,(Y1,sp)
      0088B9 2A 15            [ 1]  375     jrpl 9$ 
      0088BB 20 ED            [ 2]  376     jra 3$ 
      0088BD                        377 4$: ; horizontal line 
      0088BD 7B 01            [ 1]  378     ld a,(X0,sp)
      0088BF 97               [ 1]  379     ld xl, a 
      0088C0 7B 03            [ 1]  380     ld a,(Y0,sp)
      0088C2 95               [ 1]  381     ld xh,a 
      0088C3 CD 87 76         [ 4]  382     call set_pixel
      0088C6 0C 01            [ 1]  383     inc (X0,sp)
      0088C8 7B 01            [ 1]  384     ld a,(X0,sp)
      0088CA 11 02            [ 1]  385     cp a,(X1,sp)
      0088CC 2A 02            [ 1]  386     jrpl 9$ 
      0088CE 20 ED            [ 2]  387     jra 4$ 
      0088D0                        388 9$:
      000850                        389     _drop VAR_SIZE 
      0088D0 5B 0A            [ 2]    1     addw sp,#VAR_SIZE 
      0088D2 81               [ 4]  390     ret 
                                    391 
                                    392 
                                    393 ;----------------------------
                                    394 ; print unsigned integer 
                                    395 ; input:
                                    396 ;    X uint16_t 
                                    397 ;-----------------------------
                           000001   398     UINT=1
                           000003   399     ISTR=UINT+2 
                           000008   400     VAR_SIZE=ISTR+5
      0088D3                        401 put_uint16:
      0088D3 90 89            [ 2]  402     pushw y 
      000855                        403     _vars VAR_SIZE 
      0088D5 52 08            [ 2]    1     sub sp,#VAR_SIZE 
      0088D7 1F 01            [ 2]  404     ldw (UINT,sp),x 
      0088D9 96               [ 1]  405     ldw x,sp 
      0088DA 1C 00 08         [ 2]  406     addw x,#ISTR+5
      0088DD 90 93            [ 1]  407     ldw y,x 
      0088DF 90 7F            [ 1]  408     clr (y)
      0088E1 1E 01            [ 2]  409     ldw x,(UINT,sp) 
      0088E3 90 5A            [ 2]  410 1$: decw y 
      0088E5 A6 0A            [ 1]  411     ld a,#10 
      0088E7 62               [ 2]  412     div x,a 
      0088E8 AB 30            [ 1]  413     add a,#'0 
      0088EA 90 F7            [ 1]  414     ld (y),a
      0088EC 5D               [ 2]  415     tnzw x 
      0088ED 26 F4            [ 1]  416     jrne 1$ 
      0088EF CD 88 52         [ 4]  417     call tv_puts 
      000872                        418     _drop VAR_SIZE 
      0088F2 5B 08            [ 2]    1     addw sp,#VAR_SIZE 
      0088F4 90 85            [ 2]  419     popw y 
      0088F6 81               [ 4]  420     ret 
                                    421 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 63.
Hexadecimal [24-Bits]



                                    422 
                                    423 ;--------------------------------------
                                    424 ; use invert_pixel 
                                    425 ; to put sprite on screen 
                                    426 ; normal sprite are 8 bits wide 
                                    427 ; n rows 
                                    428 ; input:
                                    429 ;     A     row count 
                                    430 ;     XH    ycoord 
                                    431 ;     XL    xcoord
                                    432 ;     Y     sprite address  
                                    433 ; output:
                                    434 ;     A     collision if not null
                                    435 ;     Z     if not zero the collision  
                                    436 ;-------------------------------------
                           000001   437     ROWS=1
                           000002   438     SPRITE=ROWS+1 
                           000004   439     SHIFT=SPRITE+2
                           000005   440     COLL=SHIFT+1
                           000005   441     VAR_SIZE=COLL
      0088F7                        442 put_sprite:
      000877                        443     _vars VAR_SIZE 
      0088F7 52 05            [ 2]    1     sub sp,#VAR_SIZE 
      0088F9 0F 05            [ 1]  444     clr (COLL,sp) 
      0088FB 6B 01            [ 1]  445     ld (ROWS,sp),a 
      0088FD CD 87 50         [ 4]  446     call pixel_addr 
      008900 6B 04            [ 1]  447     ld (SHIFT,sp),a
      008902                        448 1$:    
      008902 0F 03            [ 1]  449     clr (SPRITE+1,sp)
      008904 90 F6            [ 1]  450     ld a,(y)
      008906 90 5C            [ 1]  451     incw y 
      008908 6B 02            [ 1]  452     ld (SPRITE,sp),a 
      00890A 7B 04            [ 1]  453     ld a,(SHIFT,sp)
      00890C 2B 07            [ 1]  454 2$: jrmi 4$
      00890E                        455 3$: ; shift sprite and mask
      00890E 04 02            [ 1]  456     srl (SPRITE,sp)
      008910 06 03            [ 1]  457     rrc (SPRITE+1,sp)
      008912 48               [ 1]  458     sll a
      008913 2A F9            [ 1]  459     jrpl 3$ 
      008915                        460 4$: 
      008915 7B 02            [ 1]  461     ld a,(SPRITE,sp)
      008917 F8               [ 1]  462     xor a,(x)
      008918 F7               [ 1]  463     ld (x),a
      008919 14 02            [ 1]  464     and a,(SPRITE,sp)
      00891B 11 02            [ 1]  465     cp a,(SPRITE,sp)
      00891D 27 02            [ 1]  466     jreq 5$
      00891F 0C 05            [ 1]  467     inc (COLL,sp)
      008921 7B 03            [ 1]  468 5$: ld a,(SPRITE+1,sp)
      008923 E8 01            [ 1]  469     xor a,(1,x)
      008925 E7 01            [ 1]  470     ld (1,x),a 
      008927 14 03            [ 1]  471     and a,(SPRITE+1,sp) 
      008929 11 03            [ 1]  472     cp a,(SPRITE+1,sp)
      00892B 27 02            [ 1]  473     jreq 6$
      00892D 0C 05            [ 1]  474     inc (COLL,sp)
      00892F 1C 00 19         [ 2]  475 6$: addw x,#BYTES_PER_LINE 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 64.
Hexadecimal [24-Bits]



      008932 0A 01            [ 1]  476     dec (ROWS,sp)
      008934 26 CC            [ 1]  477     jrne 1$
      008936 7B 05            [ 1]  478     ld a,(COLL,sp)
      0008B8                        479     _drop VAR_SIZE 
      008938 5B 05            [ 2]    1     addw sp,#VAR_SIZE 
      00893A 81               [ 4]  480     ret 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 65.
Hexadecimal [24-Bits]



                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2023  
                                      3 ; This file is part of ntsc_tuto 
                                      4 ;
                                      5 ;     ntsc_tuto is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     ntsc_tuto is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with ntsc_tuto.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                           000001    19     CURPOS=1 
                           000002    20     VAR_SIZE=2
      00893B                         21 dbg_print:
      00893B 89               [ 2]   22     pushw x 
      0008BC                         23     _vars VAR_SIZE 
      00893C 52 02            [ 2]    1     sub sp,#VAR_SIZE 
      0008BE                         24     _ldxz cy 
      00893E BE 73                    1     .byte 0xbe,cy 
      008940 1F 01            [ 2]   25     ldw (CURPOS,sp),x 
      008942 AE 07 08         [ 2]   26     ldw x,#(7<<8)+8
      0008C5                         27     _strxz cy 
      008945 BF 73                    1     .byte 0xbf,cy 
      0008C7                         28     _ldxz acc16 
      008947 BE 64                    1     .byte 0xbe,acc16 
      008949 CD 88 D3         [ 4]   29     call put_uint16
      00894C 1E 01            [ 2]   30     ldw x,(CURPOS,sp)
      0008CE                         31     _strxz cy 
      00894E BF 73                    1     .byte 0xbf,cy 
      0008D0                         32     _drop VAR_SIZE 
      008950 5B 02            [ 2]    1     addw sp,#VAR_SIZE 
      008952 85               [ 2]   33     popw x 
      008953 81               [ 4]   34     ret 
                                     35 
      008954                         36 main:
      008954 CD 89 5A         [ 4]   37     call menu 
      008957 FD               [ 4]   38     call (x)
      008958 20 FA            [ 2]   39     jra main 
                                     40 
                                     41 
                                     42 ;---------------------------
                                     43 ; display list of games
                                     44 ;--------------------------
                           000001    45 	GAM_ADR=1
                           000011    46 	KPAD=GAM_ADR+16
                           000012    47 	SEL=KPAD+1 
                           000013    48 	COUNT=SEL+1
                           000013    49 	VAR_SIZE=COUNT 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 66.
Hexadecimal [24-Bits]



      00895A                         50 menu:
      0008DA                         51 	_vars VAR_SIZE 
      00895A 52 13            [ 2]    1     sub sp,#VAR_SIZE 
      00895C 0F 12            [ 1]   52 	clr (SEL,sp)
      00895E 0F 13            [ 1]   53 	clr (COUNT,sp)
      008960 96               [ 1]   54 	ldw x,sp 
      008961 5C               [ 1]   55 	incw x 
      0008E2                         56 	_strxz ptr16 
      008962 BF 68                    1     .byte 0xbf,ptr16 
      008964 CD 87 2A         [ 4]   57 	call tv_cls  
      008967 90 AE 89 F0      [ 2]   58 	ldw y,#prog_list
                                     59 ; build games list on stack     
      00896B 90 F6            [ 1]   60 1$: ld a,(y)
      00896D 27 27            [ 1]   61     jreq user_select 
      00896F 7B 13            [ 1]   62 	ld a,(COUNT,sp)
      008971 95               [ 1]   63 	ld xh,a 
      008972 A6 20            [ 1]   64 	ld a,#SPACE  
      008974 CD 89 E6         [ 4]   65 	call select_mark 
      008977 CD 88 52         [ 4]   66 	call tv_puts  
      00897A 90 5C            [ 1]   67 	incw y 
      00897C 7B 13            [ 1]   68 	ld a,(COUNT,sp)
      00897E 48               [ 1]   69 	sll a 
      00897F 5F               [ 1]   70 	clrw x 
      008980 97               [ 1]   71 	ld xl,a 
      008981 90 F6            [ 1]   72 	ld a,(y)
      008983 90 5C            [ 1]   73 	incw y 
      008985 72 D7 00 68      [ 4]   74 	ld ([ptr16],X),a 
      008989 5C               [ 1]   75 	incw x 
      00898A 90 F6            [ 1]   76 	ld a,(y)
      00898C 90 5C            [ 1]   77 	incw y 
      00898E 72 D7 00 68      [ 4]   78 	ld ([ptr16],x),a
      008992 0C 13            [ 1]   79 	inc (COUNT,sp)
      008994 20 D5            [ 2]   80 	jra 1$ 
                                     81 ; display selection cursor and 
                                     82 ; wait for user input    
      008996                         83 user_select:
      008996 AE 02 00         [ 2]   84     ldw x,#0x200 
      008999 CD 81 A8         [ 4]   85 	call wait_key_release
      00899C 7B 12            [ 1]   86 	ld a,(SEL,sp)
      00899E 95               [ 1]   87 	ld xh,a 
      00899F A6 3E            [ 1]   88 	ld a,#'>
      0089A1 CD 89 E6         [ 4]   89 	call select_mark
      0089A4 CD 81 A2         [ 4]   90 	call wait_key 
      0089A7 6B 11            [ 1]   91 	ld (KPAD,sp),a
      0089A9 7B 12            [ 1]   92 	ld a,(SEL,sp)
      0089AB 95               [ 1]   93 	ld xh,a
      0089AC A6 20            [ 1]   94 	ld a,#SPACE 
      0089AE CD 89 E6         [ 4]   95 	call select_mark
      0089B1 7B 11            [ 1]   96 	ld a,(KPAD,sp)
      0089B3 A4 40            [ 1]   97 	and a,#BTN_DOWN ; down button? 
      0089B5 27 0B            [ 1]   98 	jreq 4$ 
                                     99 ; down button 
      0089B7 7B 12            [ 1]  100 	ld a,(SEL,sp)
      0089B9 4C               [ 1]  101 	inc a 
      0089BA 11 13            [ 1]  102 	cp a,(COUNT,sp)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 67.
Hexadecimal [24-Bits]



      0089BC 27 D8            [ 1]  103 	jreq user_select
      0089BE 6B 12            [ 1]  104 	ld (SEL,sp),a 
      0089C0 20 D4            [ 2]  105 	jra user_select 
                                    106 ; up button ?
      0089C2                        107 4$: 
      0089C2 7B 11            [ 1]  108 	ld a,(KPAD,sp)
      0089C4 A4 80            [ 1]  109 	and a,#BTN_UP
      0089C6 27 09            [ 1]  110 	jreq 6$ 
      0089C8 7B 12            [ 1]  111 	ld a,(SEL,sp)
      0089CA 4A               [ 1]  112 	dec a 
      0089CB 2B C9            [ 1]  113 	jrmi user_select 
      0089CD 6B 12            [ 1]  114 	ld (SEL,sp),a 
      0089CF 20 C5            [ 2]  115 	jra user_select 
      0089D1                        116 6$:
      0089D1 7B 11            [ 1]  117 	ld a,(KPAD,sp)
      0089D3 A4 04            [ 1]  118 	and a,#BTN_A
      0089D5 27 BF            [ 1]  119 	jreq user_select
      0089D7 CD 81 A8         [ 4]  120 	call wait_key_release 
      0089DA 7B 12            [ 1]  121 	ld a,(SEL,sp)
      0089DC 48               [ 1]  122 	sll a 
      0089DD 5F               [ 1]  123 	clrw x 
      0089DE 97               [ 1]  124 	ld xl,a 
      0089DF 72 DE 00 68      [ 5]  125 	ldw x,([ptr16],x)
      000963                        126 	_drop VAR_SIZE 
      0089E3 5B 13            [ 2]    1     addw sp,#VAR_SIZE 
      0089E5 81               [ 4]  127 	ret 
                                    128 
                                    129 ;-------------------------------
                                    130 ; display or erase 
                                    131 ; selection marker 
                                    132 ; input:
                                    133 ;    A    char to diplay 
                                    134 ;    XH   selected item {0..7}
                                    135 ;------------------------------
      0089E6                        136 select_mark:
      0089E6 88               [ 1]  137     push a 
      0089E7 4F               [ 1]  138     clr a 
      0089E8 97               [ 1]  139     ld xl,a 
      000969                        140 	_strxz cy 
      0089E9 BF 73                    1     .byte 0xbf,cy 
      0089EB 84               [ 1]  141     pop a 
      0089EC CD 87 D8         [ 4]  142 	call tv_putc 
      0089EF 81               [ 4]  143 	ret 
                                    144 
                                    145 
      0089F0                        146 prog_list:
      0089F0 53 4E 41 4B 45 00      147 .asciz "SNAKE"
      0089F6 8C 9E                  148 .word snake
      0089F8 46 41 4C 4C 00         149 .asciz "FALL"
      0089FD 8D E9                  150 .word fall
      0089FF 51 55 49 43 4B 20 42   151 .asciz "QUICK BROWN FOX"
             52 4F 57 4E 20 46 4F
             58 00
      008A0F 8A 13                  152 .word quick   
      008A11 00 00                  153 .word 0 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 68.
Hexadecimal [24-Bits]



                                    154 
      008A13                        155 quick:
      008A13 CD 87 2A         [ 4]  156     call tv_cls 
      008A16 90 AE 8A 24      [ 2]  157     ldw y,#qbf 
      008A1A CD 88 52         [ 4]  158     call tv_puts 
      008A1D CD 81 A2         [ 4]  159     call wait_key 
      008A20 CD 81 A8         [ 4]  160     call wait_key_release 
      008A23 81               [ 4]  161     ret 
                                    162 
      008A24 54 48 45 20 51 55 49   163 qbf: .asciz "THE QUICK BROWN FOX JUMP OVER THE LAZY DOG."
             43 4B 20 42 52 4F 57
             4E 20 46 4F 58 20 4A
             55 4D 50 20 4F 56 45
             52 20 54 48 45 20 4C
             41 5A 59 20 44 4F 47
             2E 00
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 69.
Hexadecimal [24-Bits]



                                      1 ;------------------------
                                      2 ; snake game 
                                      3 ; snake grow by eating mouse 
                                      4 ; 2 buttons used LEFT|RIGHT 
                                      5 ; to change snake direction 
                                      6 ; collision with walls,itself 
                                      7 ; and boulder end game
                                      8 ;------------------------
                                      9 
                                     10     .area G_DATA (ABS)
      000004                         11     .org 4 
      000004                         12 app_variables:
      000004                         13 score: .blkw 1 ; game score 
      000006                         14 max_score: .blkw 1 ; maximum score 
      000008                         15 game_flags: .blkb 1 ; game boolean flags 
      000009                         16 snake_len: .blkb 1 ; snake length 
      00000A                         17 snake_dir: .blkb 1 ; head direction 
      00000B                         18 food_coord: .blkw 1 ; food coordinates
      00000D                         19 snake_body: .blkw 32 ;  snake rings coords 
                                     20 
                                     21     .area CODE 
                                     22 
                                     23 ; game boolean flags 
                           000000    24 F_FOOD_COLL=0  ; collision with food, earn point
                           000001    25 F_NO_FOOD=1    ; no food available 
                           000002    26 F_GAME_OVER=2  ; game ended
                                     27 
                                     28 ; snake heading 
                           000000    29 NORTH=0 
                           000001    30 EAST=1
                           000002    31 SOUTH=2 
                           000004    32 WEST=4 
                                     33 
                                     34 ; game sprites 
                                     35 ; first 2 numbers: width,height 
                           000004    36 SNAKE_SPRITE_WIDTH=4 
                           000004    37 SNAKE_SPRITE_HEIGHT=4
      008A50 04 04 60 60 90 60       38 HEAD_UP:    .byte SNAKE_SPRITE_WIDTH,SNAKE_SPRITE_HEIGHT,0X60,0X60,0X90,0X60
      008A56 04 04 40 B0 B0 40       39 HEAD_RIGHT: .byte SNAKE_SPRITE_WIDTH,SNAKE_SPRITE_HEIGHT,0X40,0XB0,0XB0,0X40 
      008A5C 04 04 60 90 60 60       40 HEAD_DOWN:  .byte SNAKE_SPRITE_WIDTH,SNAKE_SPRITE_HEIGHT,0X60,0X90,0X60,0X60 
      008A62 04 04 20 D0 D0 20       41 HEAD_LEFT:  .byte SNAKE_SPRITE_WIDTH,SNAKE_SPRITE_HEIGHT,0X20,0XD0,0XD0,0X20 
      008A68 04 04 60 90 90 60       42 RING:       .byte SNAKE_SPRITE_WIDTH,SNAKE_SPRITE_HEIGHT,0x60,0x90,0X90,0X60 
                           000005    43 MOUSE_WIDTH=5 
                           000004    44 MOUSE_HEIGHT=4
      008A6E 05 04 00 70 F8 A0       45 MOUSE:      .byte MOUSE_WIDTH,MOUSE_HEIGHT,0X00,0X70,0XF8,0XA0 
                           000007    46 BOULDER_WIDTH=7
                           000005    47 BOULDER_HEIGHT=5
      008A74 07 05 28 54 AA 54 AA    48 BOULDER:    .byte BOULDER_WIDTH,BOULDER_HEIGHT,0x28,0x54,0xaa,0x54,0xaa
                                     49 
                                     50 
                                     51 ;----------------------
                                     52 ; draw walls around 
                                     53 ; game area 
                                     54 ;---------------------
      008A7B                         55 draw_walls:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 70.
Hexadecimal [24-Bits]



      008A7B AE 00 60         [ 2]   56     ldw x,#96
      008A7E 90 AE 08 08      [ 2]   57     ldw y,#8*256+8  
      008A82 CD 88 5E         [ 4]   58     call line
      008A85 AE 00 60         [ 2]   59     ldw x,#96 
      008A88 90 AE BF BF      [ 2]   60     ldw y,#(VRES-1)*256+(VRES-1)
      008A8C CD 88 5E         [ 4]   61     call line 
      008A8F AE 00 00         [ 2]   62     ldw x,#0 
      008A92 90 AE 08 BF      [ 2]   63     ldw y,#8*256+(VRES-1)
      008A96 CD 88 5E         [ 4]   64     call line 
      008A99 AE 5F 5F         [ 2]   65     ldw x,#(95*256)+95
      008A9C 90 AE 08 BF      [ 2]   66     ldw y,#8*256+(VRES-1)
      008AA0 CD 88 5E         [ 4]   67     call line 
      008AA3 81               [ 4]   68     ret 
                                     69 
                                     70 ;---------------------------
                                     71 ; draw sprite 
                                     72 ; input:
                                     73 ;   XH   y coord 
                                     74 ;   XL   x coord 
                                     75 ;   Y    sprite data 
                                     76 ;----------------------------
      008AA4                         77 draw_sprite:
      008AA4 90 E6 01         [ 1]   78     ld a,(1,y)
      008AA7 72 A9 00 02      [ 2]   79     addw y,#2
      008AAB CC 88 F7         [ 2]   80     jp put_sprite
                                     81 
                                     82 ;---------------------------
                                     83 ; select head sprite from 
                                     84 ; value of snake_dir 
                                     85 ; and draw it 
                                     86 ; input:
                                     87 ;    X    position 
                                     88 ;---------------------------
      008AAE                         89 draw_head:
      008AAE 90 AE 00 06      [ 2]   90     ldw y,#6 
      000A32                         91     _ldaz snake_dir 
      008AB2 B6 0A                    1     .byte 0xb6,snake_dir 
      008AB4 90 42            [ 4]   92     mul y,a 
      008AB6 72 A9 8A 50      [ 2]   93     addw y,#HEAD_UP 
      008ABA 20 E8            [ 2]   94     jra draw_sprite  
                                     95 
                                     96 
                                     97 ;--------------------------
                                     98 ; snake initial draw 
                                     99 ;--------------------------
                           000001   100     LEN=1
                           000002   101     IDX=LEN+1 
                           000003   102     VAR_SIZE=IDX+1
      008ABC                        103 draw_snake:
      000A3C                        104     _vars VAR_SIZE
      008ABC 52 03            [ 2]    1     sub sp,#VAR_SIZE 
      008ABE CE 00 0D         [ 2]  105     ldw x,snake_body  
      008AC1 CD 8A AE         [ 4]  106     call draw_head 
      000A44                        107     _ldaz snake_len
      008AC4 B6 09                    1     .byte 0xb6,snake_len 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 71.
Hexadecimal [24-Bits]



      008AC6 4A               [ 1]  108     dec a  
      008AC7 6B 01            [ 1]  109     ld (LEN,sp),a  
      008AC9 AE 00 0F         [ 2]  110     ldw x,#snake_body+2 
      008ACC                        111 1$:
      008ACC 1F 02            [ 2]  112     ldw (IDX,sp),x ; array index  
      008ACE 90 AE 8A 68      [ 2]  113     ldw y,#RING 
      008AD2 FE               [ 2]  114     ldw x,(x)
      008AD3 CD 8A A4         [ 4]  115     call draw_sprite
      008AD6 0A 01            [ 1]  116     dec (LEN,sp) 
      008AD8 27 07            [ 1]  117     jreq 9$
      008ADA 1E 02            [ 2]  118     ldw x,(IDX,sp)
      008ADC 1C 00 02         [ 2]  119     addw x,#2 ; next element  
      008ADF 20 EB            [ 2]  120     jra 1$
      008AE1                        121 9$:
      000A61                        122     _drop VAR_SIZE 
      008AE1 5B 03            [ 2]    1     addw sp,#VAR_SIZE 
      008AE3 81               [ 4]  123     ret 
                                    124 
                                    125 
                                    126 ;-----------------------------
                                    127 ; check for collision object
                                    128 ; if not mouse then game over.
                                    129 ; if MOUSE increase score and 
                                    130 ; delete mouse. 
                                    131 ; input:  
                                    132 ;    X   position 
                                    133 ; output:
                                    134 ;    game_flags:F_FOOD_COLL
                                    135 ;    X   unchanged 
                                    136 ;-------------------------------
      008AE4                        137 food_collision:
      008AE4 89               [ 2]  138     pushw x 
      000A65                        139     _clrz game_flags 
      008AE5 3F 08                    1     .byte 0x3f, game_flags 
      008AE7 A6 05            [ 1]  140     ld a,#MOUSE_WIDTH
      008AE9 AB 04            [ 1]  141     add a,#SNAKE_SPRITE_WIDTH
      008AEB 88               [ 1]  142     push a
      008AEC 9F               [ 1]  143     ld a,xl ; snake head x coord 
      008AED C0 00 0C         [ 1]  144     sub a,food_coord+1 ; food x coord 
      008AF0 2A 01            [ 1]  145     jrpl 1$ 
      008AF2 40               [ 1]  146     neg a  ; abs(delta)
      008AF3                        147 1$: 
      008AF3 11 01            [ 1]  148     cp a,(1,sp) 
      008AF5 2A 11            [ 1]  149     jrpl 3$ ; if >= 0 collision object not mouse 
      008AF7 A6 04            [ 1]  150     ld a,#MOUSE_HEIGHT
      008AF9 AB 04            [ 1]  151     add a,#SNAKE_SPRITE_HEIGHT
      008AFB 6B 01            [ 1]  152     ld (1,sp),a 
      008AFD 9E               [ 1]  153     ld a,xh   ; head y coord 
      008AFE C0 00 0B         [ 1]  154     sub a,food_coord ; food y coord 
      008B01 2A 01            [ 1]  155     jrpl 2$
      008B03 40               [ 1]  156     neg a 
      008B04                        157 2$:
      008B04 11 01            [ 1]  158     cp a,(1,sp)
      008B06 2B 06            [ 1]  159     jrmi 4$ 
      008B08                        160 3$: ; collision object not mose 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 72.
Hexadecimal [24-Bits]



      008B08 72 14 00 08      [ 1]  161     bset game_flags,#F_GAME_OVER
      008B0C 2A 37            [ 1]  162     jrpl 9$ 
      008B0E                        163 4$:  ; collision with mouse
                                    164 ; erase food 
      008B0E CE 00 0B         [ 2]  165     ldw x,food_coord
      008B11 90 AE 8A 6E      [ 2]  166     ldw y,#MOUSE 
      008B15 CD 8A A4         [ 4]  167     call draw_sprite
      008B18 72 12 00 08      [ 1]  168     bset game_flags,#F_NO_FOOD 
      008B1C 72 10 00 08      [ 1]  169     bset game_flags,#F_FOOD_COLL
      000AA0                        170     _incz snake_len 
      008B20 3C 09                    1     .byte 0x3c, snake_len 
      000AA2                        171     _ldxz score 
      008B22 BE 04                    1     .byte 0xbe,score 
      008B24 5C               [ 1]  172     incw x 
      008B25 C6 00 0B         [ 1]  173     ld a,food_coord ; mouse y coord 
      008B28 A1 09            [ 1]  174     cp a,#9 
      008B2A 26 01            [ 1]  175     jrne 5$
      008B2C 5C               [ 1]  176     incw x      
      008B2D A1 BB            [ 1]  177 5$: cp a,#VRES-MOUSE_HEIGHT-1
      008B2F 26 01            [ 1]  178     jrne 6$ 
      008B31 5C               [ 1]  179     incw  x 
      008B32 C6 00 0C         [ 1]  180 6$: ld a,food_coord+1 ; mouse x coord
      008B35 A1 01            [ 1]  181     cp a,#1 
      008B37 26 01            [ 1]  182     jrne 7$ 
      008B39 5C               [ 1]  183     incw x  
      008B3A A1 C2            [ 1]  184 7$: cp a,#HRES-MOUSE_WIDTH-1
      008B3C 26 01            [ 1]  185     jrne 8$
      008B3E 5C               [ 1]  186     incw x
      008B3F                        187 8$:
      000ABF                        188     _strxz score
      008B3F BF 04                    1     .byte 0xbf,score 
      000AC1                        189     _clrz food_coord 
      008B41 3F 0B                    1     .byte 0x3f, food_coord 
      000AC3                        190     _clrz food_coord+1     
      008B43 3F 0C                    1     .byte 0x3f, food_coord+1 
      008B45                        191 9$:
      000AC5                        192     _drop 1 
      008B45 5B 01            [ 2]    1     addw sp,#1 
      008B47 85               [ 2]  193     popw x 
      008B48 81               [ 4]  194     ret 
                                    195 
                                    196 
                                    197 ;---------------------
                                    198 ; according to 
                                    199 ; actual head position 
                                    200 ; and direction compute 
                                    201 ; next snake head 
                                    202 ; coordinates
                                    203 ; input:
                                    204 ;   X     actual position
                                    205 ; output:
                                    206 ;   X     next position 
                                    207 ;---------------------
      008B49                        208 next_head_pos:
      000AC9                        209     _ldaz snake_dir 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 73.
Hexadecimal [24-Bits]



      008B49 B6 0A                    1     .byte 0xb6,snake_dir 
      008B4B A1 00            [ 1]  210     cp a,#NORTH 
      008B4D 26 05            [ 1]  211     jrne 2$ 
                                    212 ; going north 
      008B4F 1D 04 00         [ 2]  213     subw x,#SNAKE_SPRITE_HEIGHT<<8
      008B52 20 15            [ 2]  214     jra 9$        
      008B54 A1 01            [ 1]  215 2$: cp a,#EAST 
      008B56 26 05            [ 1]  216     jrne 4$ 
                                    217 ;going east 
      008B58 1C 00 04         [ 2]  218     addw x,#SNAKE_SPRITE_WIDTH 
      008B5B 20 0C            [ 2]  219     jra 9$ 
      008B5D A1 02            [ 1]  220 4$: cp a,#SOUTH 
      008B5F 26 05            [ 1]  221     jrne 6$
                                    222 ;going south 
      008B61 1C 04 00         [ 2]  223     addw x,#SNAKE_SPRITE_HEIGHT<<8
      008B64 20 03            [ 2]  224     jra 9$ 
      008B66                        225 6$: ; going west 
      008B66 1D 00 04         [ 2]  226     subw x,#SNAKE_SPRITE_WIDTH 
      008B69                        227 9$:
      008B69 81               [ 4]  228     ret 
                                    229 
                                    230 ;------------------------------
                                    231 ; move memory block from 
                                    232 ; low address to higher address    
                                    233 ; input:
                                    234 ;    A   count 
                                    235 ;    X   destination 
                                    236 ;    Y   source 
                                    237 ;-------------------------------
      008B6A                        238 move_up:
      008B6A 88               [ 1]  239     push a 
      008B6B 90 F6            [ 1]  240 1$: ld a,(y)
      008B6D 90 5A            [ 2]  241     decw y 
      008B6F F7               [ 1]  242     ld (x),a 
      008B70 5A               [ 2]  243     decw x 
      008B71 0A 01            [ 1]  244     dec (1,sp)
      008B73 26 F6            [ 1]  245     jrne 1$ 
      000AF5                        246     _drop 1 
      008B75 5B 01            [ 2]    1     addw sp,#1 
      008B77 81               [ 4]  247     ret 
                                    248 
                                    249 ;-----------------------
                                    250 ; move snake 
                                    251 ;-----------------------
                           000001   252     POS=1 ; new head coordinates 
                           000003   253     HEAD=POS+2 ; actual head position 
                           000003   254     TAIL=HEAD 
                           000004   255     VAR_SIZE=HEAD+1
      008B78                        256 move_snake:
      008B78 89               [ 2]  257     pushw x 
      008B79 90 89            [ 2]  258     pushw y 
      000AFB                        259     _vars VAR_SIZE 
      008B7B 52 04            [ 2]    1     sub sp,#VAR_SIZE 
                                    260 ; erase head by drawing over it 
      008B7D CE 00 0D         [ 2]  261     ldw x,snake_body 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 74.
Hexadecimal [24-Bits]



      008B80 1F 03            [ 2]  262     ldw (HEAD,sp),x 
      008B82 CD 8A AE         [ 4]  263     call draw_head 
                                    264 ; draw ring at head position     
      008B85 1E 03            [ 2]  265     ldw x,(HEAD,sp)  ; head position 
      008B87 90 AE 8A 68      [ 2]  266     ldw y,#RING 
      008B8B CD 8A A4         [ 4]  267     call draw_sprite 
                                    268 ;draw head at new position 
      008B8E 1E 03            [ 2]  269     ldw x,(HEAD,sp)
      008B90 CD 8B 49         [ 4]  270     call next_head_pos
      008B93 1F 01            [ 2]  271     ldw (POS,sp),x
      008B95 CD 8A AE         [ 4]  272     call draw_head
      008B98 27 0A            [ 1]  273     jreq 1$
                                    274 ;collision deteted  
      008B9A 1E 01            [ 2]  275     ldw x,(POS,sp)
      008B9C CD 8A E4         [ 4]  276     call food_collision 
      008B9F 72 04 00 08 2C   [ 2]  277     btjt game_flags,#F_GAME_OVER,9$
      008BA4                        278 1$: 
                                    279 ; move array elements 1 cell toward tail 
      000B24                        280     _ldaz snake_len
      008BA4 B6 09                    1     .byte 0xb6,snake_len 
      008BA6 4A               [ 1]  281     dec a
      008BA7 48               [ 1]  282     sll a 
      008BA8 5F               [ 1]  283     clrw x 
      008BA9 97               [ 1]  284     ld xl,a 
      008BAA 1C 00 0D         [ 2]  285     addw x,#snake_body ; last array element 
      008BAD 90 93            [ 1]  286     ldw y,x 
      008BAF FE               [ 2]  287     ldw x,(x)
      008BB0 1F 03            [ 2]  288     ldw (TAIL,sp),x ; last ring position  
      008BB2 93               [ 1]  289     ldw x,y 
      008BB3 90 5A            [ 2]  290     decw y 
      008BB5 5C               [ 1]  291     incw x 
      000B36                        292     _ldaz snake_len 
      008BB6 B6 09                    1     .byte 0xb6,snake_len 
      008BB8 4A               [ 1]  293     dec a 
      008BB9 48               [ 1]  294     sll a     
      008BBA CD 8B 6A         [ 4]  295     call move_up 
                                    296 ; set 1 element as new head position 
      008BBD 1E 01            [ 2]  297     ldw x,(POS,sp)
      008BBF CF 00 0D         [ 2]  298     ldw snake_body,x    
      008BC2 72 00 00 08 09   [ 2]  299     btjt game_flags,#F_FOOD_COLL,9$
                                    300 ; erase last ring 
      008BC7 1E 03            [ 2]  301     ldw x,(TAIL,sp)
      008BC9 90 AE 8A 68      [ 2]  302     ldw y,#RING
      008BCD CD 8A A4         [ 4]  303     call draw_sprite
      008BD0                        304 9$:
      000B50                        305     _drop VAR_SIZE 
      008BD0 5B 04            [ 2]    1     addw sp,#VAR_SIZE 
      008BD2 90 85            [ 2]  306     popw y 
      008BD4 85               [ 2]  307     popw x  
      008BD5 81               [ 4]  308     ret 
                                    309 
                                    310 
                                    311 ;--------------------------
                                    312 ; rotate snake head 
                                    313 ; input
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 75.
Hexadecimal [24-Bits]



                                    314 ;     A   {LEFT,RIGHT}
                                    315 ;--------------------------
      008BD6                        316 rotate_head:
      008BD6 88               [ 1]  317     push a 
      000B57                        318     _ldaz snake_dir 
      008BD7 B6 0A                    1     .byte 0xb6,snake_dir 
      008BD9 90 AE 00 06      [ 2]  319     ldw y,#6 
      008BDD 90 42            [ 4]  320     mul y,a 
      008BDF 72 A9 8A 50      [ 2]  321     addw y,#HEAD_UP
      008BE3 CE 00 0D         [ 2]  322     ldw x,snake_body 
      008BE6 CD 8A A4         [ 4]  323     call draw_sprite 
      008BE9 84               [ 1]  324     pop a 
      008BEA A1 10            [ 1]  325     cp a,#BTN_LEFT 
      008BEC 26 05            [ 1]  326     jrne 2$ 
      000B6E                        327     _ldaz snake_dir 
      008BEE B6 0A                    1     .byte 0xb6,snake_dir 
      008BF0 4A               [ 1]  328     dec a 
      008BF1 20 03            [ 2]  329     jra 4$ 
      000B73                        330 2$: _ldaz snake_dir 
      008BF3 B6 0A                    1     .byte 0xb6,snake_dir 
      008BF5 4C               [ 1]  331     inc a 
      008BF6 A4 03            [ 1]  332 4$: and a,#3 
      000B78                        333     _straz snake_dir 
      008BF8 B7 0A                    1     .byte 0xb7,snake_dir 
      008BFA 90 AE 00 06      [ 2]  334     ldw y,#6
      008BFE 90 42            [ 4]  335     mul y,a 
      008C00 72 A9 8A 50      [ 2]  336     addw y,#HEAD_UP 
      008C04 CE 00 0D         [ 2]  337     ldw x,snake_body 
      008C07 CD 8A A4         [ 4]  338     call draw_sprite 
      008C0A 81               [ 4]  339     ret 
                                    340 
                                    341 ;--------------------------
                                    342 ; read keypad 
                                    343 ; LEFT turn left 
                                    344 ; RIGHT turn right 
                                    345 ;--------------------------
                           000001   346     KPAD=1
      008C0B                        347 user_input:
      008C0B 4B 00            [ 1]  348     push #0 
      008C0D CD 81 7F         [ 4]  349     call read_keypad
      008C10 27 1C            [ 1]  350     jreq 4$ 
      008C12 6B 01            [ 1]  351     ld (KPAD,sp),a  
      008C14 A6 10            [ 1]  352     ld a,#BTN_LEFT 
      008C16 14 01            [ 1]  353     and a,(KPAD,sp)
      008C18 27 05            [ 1]  354     jreq 2$ 
      008C1A CD 8B D6         [ 4]  355     call rotate_head
      008C1D 20 09            [ 2]  356     jra 3$
      008C1F A6 20            [ 1]  357 2$: ld a,#BTN_RIGHT 
      008C21 14 01            [ 1]  358     and a,(KPAD,sp)
      008C23 27 03            [ 1]  359     jreq 3$ 
      008C25 CD 8B D6         [ 4]  360     call rotate_head 
      008C28                        361 3$:
      008C28 AE 00 5A         [ 2]  362     ldw x,#90
      008C2B CD 81 A8         [ 4]  363     call wait_key_release
      008C2E                        364 4$:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 76.
Hexadecimal [24-Bits]



      000BAE                        365     _drop 1 
      008C2E 5B 01            [ 2]    1     addw sp,#1 
      008C30 81               [ 4]  366     ret 
                                    367 
                                    368 ;-------------------------
                                    369 ; create a new mouse 
                                    370 ; at random position 
                                    371 ;-------------------------
      008C31                        372 new_food:
      008C31 CD 82 2E         [ 4]  373     call prng
      008C34 A6 32            [ 1]  374     ld a,#54-MOUSE_HEIGHT 
      008C36 62               [ 2]  375     div x,a 
      008C37 AB 09            [ 1]  376     add a,#FONT_HEIGHT+1
      000BB9                        377     _straz food_coord 
      008C39 B7 0B                    1     .byte 0xb7,food_coord 
      008C3B CD 82 2E         [ 4]  378     call prng 
      008C3E A6 39            [ 1]  379     ld a,#62-MOUSE_WIDTH 
      008C40 62               [ 2]  380     div x,a 
      008C41 4C               [ 1]  381     inc a 
      000BC2                        382     _straz food_coord+1
      008C42 B7 0C                    1     .byte 0xb7,food_coord+1 
      008C44 CE 00 0B         [ 2]  383     ldw x,food_coord 
      008C47 90 AE 8A 6E      [ 2]  384     ldw y,#MOUSE 
      008C4B CD 8A A4         [ 4]  385     call draw_sprite 
      008C4E 4D               [ 1]  386     tnz a 
      008C4F 27 0C            [ 1]  387     jreq 9$ 
      008C51 CE 00 0B         [ 2]  388     ldw x,food_coord 
      008C54 90 AE 8A 6E      [ 2]  389     ldw y,#MOUSE 
      008C58 CD 8A A4         [ 4]  390     call draw_sprite 
      008C5B 20 D4            [ 2]  391     jra new_food 
      000BDD                        392 9$: _clrz game_flags
      008C5D 3F 08                    1     .byte 0x3f, game_flags 
      008C5F 81               [ 4]  393     ret 
                                    394 
                                    395 ;----------------------
                                    396 ; print score top left 
                                    397 ; corner 
                                    398 ;----------------------
      008C60                        399 prt_score:
      008C60 89               [ 2]  400     pushw x 
      000BE1                        401     _clrz cx 
      008C61 3F 74                    1     .byte 0x3f, cx 
      000BE3                        402     _clrz cy 
      008C63 3F 73                    1     .byte 0x3f, cy 
      000BE5                        403     _ldxz score 
      008C65 BE 04                    1     .byte 0xbe,score 
      008C67 CD 88 D3         [ 4]  404     call put_uint16
      008C6A 85               [ 2]  405     popw x
      008C6B 81               [ 4]  406     ret 
                                    407 
                                    408 ;-------------------------
                                    409 ; game initialization
                                    410 ;-------------------------
      008C6C                        411 snake_init:
      008C6C A6 02            [ 1]  412     ld a,#(1<<F_NO_FOOD)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 77.
Hexadecimal [24-Bits]



      000BEE                        413     _straz game_flags 
      008C6E B7 08                    1     .byte 0xb7,game_flags 
      008C70 5F               [ 1]  414     clrw x 
      000BF1                        415     _strxz score 
      008C71 BF 04                    1     .byte 0xbf,score 
      000BF3                        416     _strxz food_coord
      008C73 BF 0B                    1     .byte 0xbf,food_coord 
      008C75 CD 82 50         [ 4]  417     call set_seed  ; using ticks 
      008C78 A6 03            [ 1]  418     ld a,#3
      000BFA                        419     _straz snake_len 
      008C7A B7 09                    1     .byte 0xb7,snake_len 
      008C7C A6 01            [ 1]  420     ld a,#EAST
      000BFE                        421     _straz snake_dir
      008C7E B7 0A                    1     .byte 0xb7,snake_dir 
      008C80 AE 00 0D         [ 2]  422     ldw x,#snake_body 
      008C83 90 AE 1F 30      [ 2]  423     ldw y,#(31<<8)+48 
      008C87 FF               [ 2]  424     ldw (x),y
      008C88 72 A2 00 04      [ 2]  425     subw y,#SNAKE_SPRITE_WIDTH
      008C8C EF 02            [ 2]  426     ldw (2,x),y 
      008C8E 72 A2 00 04      [ 2]  427     subw y,#SNAKE_SPRITE_WIDTH
      008C92 EF 04            [ 2]  428     ldw (4,x),y 
      008C94 CD 87 2A         [ 4]  429     call tv_cls
      008C97 CD 8A 7B         [ 4]  430     call draw_walls 
      008C9A CD 8A BC         [ 4]  431     call draw_snake 
      008C9D 81               [ 4]  432     ret 
                                    433 
                                    434 ;-------------------------
                                    435 ; game main routine
                                    436 ;-------------------------
      008C9E                        437 snake:
      008C9E CD 8C 6C         [ 4]  438     call snake_init
      008CA1 A6 64            [ 1]  439     ld a,#100 
      008CA3 CD 80 FA         [ 4]  440     call pause
      008CA6                        441 1$: 
      008CA6 72 03 00 08 06   [ 2]  442     btjf game_flags,#F_NO_FOOD,2$
      008CAB CD 8C 60         [ 4]  443     call prt_score 
      008CAE CD 8C 31         [ 4]  444     call new_food 
      008CB1                        445 2$:
      008CB1 CD 8B 78         [ 4]  446     call move_snake 
      008CB4 72 04 00 08 0A   [ 2]  447     btjt game_flags,#F_GAME_OVER,game_over  
      008CB9 CD 8C 0B         [ 4]  448     call user_input
      008CBC A6 07            [ 1]  449     ld a,#7
      008CBE CD 80 FA         [ 4]  450     call pause 
      008CC1 20 E3            [ 2]  451     jra 1$
      008CC3                        452 game_over:
      000C43                        453     _ldxz score 
      008CC3 BE 04                    1     .byte 0xbe,score 
      008CC5 C3 00 06         [ 2]  454     cpw x,max_score 
      008CC8 2B 02            [ 1]  455     jrmi 4$ 
      000C4A                        456     _strxz max_score
      008CCA BF 06                    1     .byte 0xbf,max_score 
      008CCC                        457 4$:
      008CCC AE FF FF         [ 2]  458     ldw x,#0xffff 
      008CCF CD 81 A8         [ 4]  459     call wait_key_release
      008CD2 CD 87 2A         [ 4]  460     call tv_cls 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 78.
Hexadecimal [24-Bits]



      008CD5 90 AE 8D 0F      [ 2]  461     ldw y,#gover 
      008CD9 CD 88 52         [ 4]  462     call tv_puts 
      008CDC 90 AE 8D 1A      [ 2]  463     ldw y,#score_str
      008CE0 CD 88 52         [ 4]  464     call tv_puts 
      000C63                        465     _ldxz score 
      008CE3 BE 04                    1     .byte 0xbe,score 
      008CE5 CD 88 D3         [ 4]  466     call put_uint16
      008CE8 CD 87 BF         [ 4]  467     call crlf 
      008CEB 90 AE 8D 22      [ 2]  468     ldw y,#max_score_str
      008CEF CD 88 52         [ 4]  469     call tv_puts 
      000C72                        470     _ldxz max_score 
      008CF2 BE 06                    1     .byte 0xbe,max_score 
      008CF4 CD 88 D3         [ 4]  471     call put_uint16
      008CF7 CD 87 BF         [ 4]  472     call crlf
      008CFA 90 AE 8D 2E      [ 2]  473     ldw y,#prompt 
      008CFE CD 88 52         [ 4]  474     call tv_puts 
      008D01                        475 6$:
      008D01 CD 81 A2         [ 4]  476     call wait_key 
      008D04 A1 04            [ 1]  477     cp a,#BTN_A 
      008D06 27 96            [ 1]  478     jreq snake 
      008D08 A1 08            [ 1]  479     cp a,#BTN_B 
      008D0A 27 02            [ 1]  480     jreq 9$
      008D0C 20 F3            [ 2]  481     jra 6$
      008D0E                        482 9$:     
      008D0E 81               [ 4]  483     ret 
                                    484 
      008D0F 67 61 6D 65 20 6F 76   485 gover: .asciz "game over\r"
             65 72 0D 00
      008D1A 73 63 6F 72 65 3A 20   486 score_str: .asciz "score: "
             00
      008D22 6D 61 78 20 73 63 6F   487 max_score_str: .asciz "max score: "
             72 65 3A 20 00
      008D2E 41 20 6E 65 77 20 67   488 prompt: .asciz "A new game\rB exit"
             61 6D 65 0D 42 20 65
             78 69 74 00
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 79.
Hexadecimal [24-Bits]



                                      1 ;-------------------
                                      2 ; FALL 
                                      3 ; TRETIS  inspired  
                                      4 ;-------------------
                                      5 
                           000002     6 TETRA_WIDTH=2 ; 2x2 pixels tetrahedrons blocks 
                           000014     7 WELL_WIDTH=TETRA_WIDTH*10
                           00002C     8 WELL_DEPTH=TETRA_WIDTH*22
                                      9  
                                     10 
                                     11 ; sprites 
      008D40 08 02 FF FF             12 I0: .byte 8,2,0xff,0xff; horizontal I 
      008D44 02 08 60 60 60 60 60    13 I1: .byte 2,8,0x60,0x60,0x60,0x60,0x60,0x60,0x60,0x60 ; vertical I 
             60 60 60
      008D4E 04 04 F0 F0 F0 F0       14 SQUARE: .byte 4,4,0xf0,0xf0,0xf0,0xf0 
      008D54 06 04 FC FC 30 30       15 T0: .byte 6,4,0xfc,0xfc,0x30,0x30 ; normal T 
      008D5A 04 06 30 30 F0 F0 30    16 T1: .byte 4,6,0x30,0x30,0xf0,0xf0,0x30,0x30 ; T rotated right  
             30
      008D62 04 06 C0 C0 F0 F0 C0    17 T2: .byte 4,6,0xc0,0xc0,0xf0,0xf0,0xc0,0xc0 ; T rotated left 
             C0
      008D6A 06 04 30 30 F0 F0       18 T3: .byte 6,4,0x30,0x30,0xf0,0xf0 ; T upside down 
      008D70 06 04 FC FC C0 C0       19 L0: .byte 6,4,0xfc,0xfc,0xc0,0xc0 ; L rotated right 
      008D76 04 06 F0 F0 30 30 30    20 L1: .byte 4,6,0xf0,0xf0,0x30,0x30,0x30,0x30 ; L upside down 
             30
      008D7E 06 04 0C 0C FC FC       21 L2: .byte 6,4,0xc,0xc,0xfc,0xfc ; L rotated left 
      008D84 04 06 C0 C0 C0 FC FC    22 L3: .byte 4,6,0xc0,0xc0,0xc0,0xfc,0xfc ; L upside 
      008D8B 06 04 FC FC 0C 0C       23 J0: .byte 6,4,0xfc,0xfc,0xc,0xc ; J rotated left 
      008D91 04 06 C0 C0 C0 C0 FC    24 J1:  .byte 4,6,0xc0,0xc0,0xc0,0xc0,0xfc,0xfc ; J upside 
             FC
      008D99 06 04 C0 C0 FC FC       25 J2: .byte 6,4,0xc0,0xc0,0xfc,0xfc ; j rotated right 
      008D9F 04 06 FC FC 0C 0C 0C    26 J3: .byte 4,6,0xfc,0xfc,0xc,0xc,0xc,0xc  ; j upside down 
             0C
      008DA7 06 04 F0 F0 3C 3C       27 Z0: .byte 6,4,0xf0,0xf0,0x3c,0x3c ; 
      008DAD 04 06 30 30 3C 30 C0    28 Z1: .byte 4,6,0x30,0x30,0x3c,0x30,0xc0,0xc0 
             C0
      008DB5 06 04 3C 3C F0 F0       29 S0: .byte 6,4,0x3c,0x3c,0xf0,0xf0 
      008DBB 04 06 C0 C0 F0 F0 0C    30 S1: .byte 4,6,0xc0,0xc0,0xf0,0xf0,0xc,0xc 
             0C
                                     31 
                                     32 ;--------------------
                                     33 ; draw the well in 
                                     34 ; wich tetrahedrons 
                                     35 ; falls.
                                     36 ;--------------------
      008DC3                         37 draw_well:
                                     38 ; left side 
      008DC3 AE 00 00         [ 2]   39     ldw x,#(0<<8)+0
      008DC6 90 AE 94 C0      [ 2]   40     ldw y,#((VRES-WELL_DEPTH)<<8)+VRES
      008DCA CD 88 5E         [ 4]   41     call line
                                     42 ;bottom  
      008DCD AE 01 15         [ 2]   43     ldw x,#(1<<8)+WELL_WIDTH+1 
      008DD0 90 AE BF BF      [ 2]   44     ldw y,#((VRES-1)<<8)+VRES-1
      008DD4 CD 88 5E         [ 4]   45     call line 
                                     46 ;right side
      008DD7 AE 15 15         [ 2]   47     ldw x,#((WELL_WIDTH+1)<<8)+WELL_WIDTH+1
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 80.
Hexadecimal [24-Bits]



      008DDA 90 AE 94 C0      [ 2]   48     ldw y,#((VRES-WELL_DEPTH)<<8)+VRES
      008DDE CD 88 5E         [ 4]   49     call line 
      008DE1 81               [ 4]   50     ret 
                                     51 
                                     52 ;-------------------------
                                     53 ; initialize game 
                                     54 ;-------------------------
      008DE2                         55 fall_init:
      008DE2 CD 87 2A         [ 4]   56     call tv_cls  
      008DE5 CD 8D C3         [ 4]   57     call draw_well 
      008DE8 81               [ 4]   58     ret 
                                     59 
      008DE9                         60 fall:
      008DE9 CD 8D E2         [ 4]   61     call fall_init
      008DEC 20 FE            [ 2]   62 jra .
      008DEE 81               [ 4]   63     ret 
                                     64 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 81.
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
    AFR     =  004803     |     AFR0_ADC=  000000     |     AFR1_TIM=  000001 
    AFR2_CCO=  000002     |     AFR3_TIM=  000003     |     AFR4_TIM=  000004 
    AFR5_TIM=  000005     |     AFR6_I2C=  000006     |     AFR7_BEE=  000007 
    AWU_APR =  0050F1     |     AWU_CSR =  0050F0     |     AWU_CSR_=  000004 
    AWU_TBR =  0050F2     |     B0_MASK =  000001     |     B115200 =  000006 
    B19200  =  000003     |     B1_MASK =  000002     |     B230400 =  000007 
    B2400   =  000000     |     B2_MASK =  000004     |     B38400  =  000004 
    B3_MASK =  000008     |     B460800 =  000008     |     B4800   =  000001 
    B4_MASK =  000010     |     B57600  =  000005     |     B5_MASK =  000020 
    B6_MASK =  000040     |     B7_MASK =  000080     |     B921600 =  000009 
    B9600   =  000002     |     BEEP_BIT=  000004     |     BEEP_CSR=  0050F3 
    BEEP_MAS=  000010     |     BEEP_POR=  00000F     |     BELL    =  000007 
    BIT0    =  000000     |     BIT1    =  000001     |     BIT2    =  000002 
    BIT3    =  000003     |     BIT4    =  000004     |     BIT5    =  000005 
    BIT6    =  000006     |     BIT7    =  000007     |     BIT_A   =  000002 
    BIT_B   =  000003     |     BIT_DOWN=  000006     |     BIT_LEFT=  000004 
    BIT_RIGH=  000005     |     BIT_UP  =  000007     |     BLOCK_SI=  000080 
    BOFS    =  000003     |     BOFSL   =  000004     |     BOOT_ROM=  006000 
    BOOT_ROM=  007FFF     |   7 BOULDER    0009F4 R   |     BOULDER_=  000005 
    BOULDER_=  000007     |     BPL     =  000001     |     BPOS    =  000005 
    BS      =  000008     |     BTN_A   =  000004     |     BTN_B   =  000008 
    BTN_DOWN=  000040     |     BTN_LEFT=  000010     |     BTN_MASK=  0000FC 
    BTN_RIGH=  000020     |     BTN_UP  =  000080     |     BUTTONS =  000003 
    BYTECNT =  000003     |     BYTES_PE=  000019     |     CAN     =  000018 
    CAN_DGR =  005426     |     CAN_FPSR=  005427     |     CAN_IER =  005425 
    CAN_MCR =  005420     |     CAN_MSR =  005421     |     CAN_P0  =  005428 
    CAN_P1  =  005429     |     CAN_P2  =  00542A     |     CAN_P3  =  00542B 
    CAN_P4  =  00542C     |     CAN_P5  =  00542D     |     CAN_P6  =  00542E 
    CAN_P7  =  00542F     |     CAN_P8  =  005430     |     CAN_P9  =  005431 
    CAN_PA  =  005432     |     CAN_PB  =  005433     |     CAN_PC  =  005434 
    CAN_PD  =  005435     |     CAN_PE  =  005436     |     CAN_PF  =  005437 
    CAN_RFR =  005424     |     CAN_TPR =  005423     |     CAN_TSR =  005422 
    CC_C    =  000000     |     CC_H    =  000004     |     CC_I0   =  000003 
    CC_I1   =  000005     |     CC_N    =  000002     |     CC_V    =  000007 
    CC_Z    =  000001     |     CFG_GCR =  007F60     |     CFG_GCR_=  000001 
    CFG_GCR_=  000000     |     CHAR_PER=  000021     |     CLKOPT  =  004807 
    CLKOPT_C=  000002     |     CLKOPT_E=  000003     |     CLKOPT_P=  000000 
    CLKOPT_P=  000001     |     CLK_CCOR=  0050C9     |     CLK_CKDI=  0050C6 
    CLK_CKDI=  000000     |     CLK_CKDI=  000001     |     CLK_CKDI=  000002 
    CLK_CKDI=  000003     |     CLK_CKDI=  000004     |     CLK_CMSR=  0050C3 
    CLK_CSSR=  0050C8     |     CLK_ECKR=  0050C1     |     CLK_ECKR=  000000 
    CLK_ECKR=  000001     |     CLK_HSIT=  0050CC     |     CLK_ICKR=  0050C0 
    CLK_ICKR=  000002     |     CLK_ICKR=  000000     |     CLK_ICKR=  000001 
    CLK_ICKR=  000003     |     CLK_ICKR=  000004     |     CLK_ICKR=  000005 
    CLK_PCKE=  0050C7     |     CLK_PCKE=  000000     |     CLK_PCKE=  000001 
    CLK_PCKE=  000007     |     CLK_PCKE=  000005     |     CLK_PCKE=  000006 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 82.
Hexadecimal [24-Bits]

Symbol Table

    CLK_PCKE=  000004     |     CLK_PCKE=  000002     |     CLK_PCKE=  000003 
    CLK_PCKE=  0050CA     |     CLK_PCKE=  000003     |     CLK_PCKE=  000002 
    CLK_PCKE=  000007     |     CLK_SWCR=  0050C5     |     CLK_SWCR=  000000 
    CLK_SWCR=  000001     |     CLK_SWCR=  000002     |     CLK_SWCR=  000003 
    CLK_SWIM=  0050CD     |     CLK_SWR =  0050C4     |     CLK_SWR_=  0000B4 
    CLK_SWR_=  0000E1     |     CLK_SWR_=  0000D2     |     COLL    =  000005 
    COLON   =  00003A     |     COMMA   =  00002C     |     COUNT   =  000013 
    CPU_A   =  007F00     |     CPU_CCR =  007F0A     |     CPU_PCE =  007F01 
    CPU_PCH =  007F02     |     CPU_PCL =  007F03     |     CPU_SPH =  007F08 
    CPU_SPL =  007F09     |     CPU_XH  =  007F04     |     CPU_XL  =  007F05 
    CPU_YH  =  007F06     |     CPU_YL  =  007F07     |     CR      =  00000D 
    CTRL_A  =  000001     |     CTRL_B  =  000002     |     CTRL_C  =  000003 
    CTRL_D  =  000004     |     CTRL_E  =  000005     |     CTRL_F  =  000006 
    CTRL_G  =  000007     |     CTRL_H  =  000008     |     CTRL_I  =  000009 
    CTRL_J  =  00000A     |     CTRL_K  =  00000B     |     CTRL_L  =  00000C 
    CTRL_M  =  00000D     |     CTRL_N  =  00000E     |     CTRL_O  =  00000F 
    CTRL_P  =  000010     |     CTRL_Q  =  000011     |     CTRL_R  =  000012 
    CTRL_S  =  000013     |     CTRL_T  =  000014     |     CTRL_U  =  000015 
    CTRL_V  =  000016     |     CTRL_W  =  000017     |     CTRL_X  =  000018 
    CTRL_Y  =  000019     |     CTRL_Z  =  00001A     |     CURPOS  =  000001 
    DC1     =  000011     |     DC2     =  000012     |     DC3     =  000013 
    DC4     =  000014     |     DEBOUNCE=  000001     |     DEBUG_BA=  007F00 
    DEBUG_EN=  007FFF     |     DELTA   =  000009     |     DEVID_BA=  0048CD 
    DEVID_EN=  0048D8     |     DEVID_LO=  0048D2     |     DEVID_LO=  0048D3 
    DEVID_LO=  0048D4     |     DEVID_LO=  0048D5     |     DEVID_LO=  0048D6 
    DEVID_LO=  0048D7     |     DEVID_LO=  0048D8     |     DEVID_WA=  0048D1 
    DEVID_XH=  0048CE     |     DEVID_XL=  0048CD     |     DEVID_YH=  0048D0 
    DEVID_YL=  0048CF     |     DLE     =  000010     |     DLY     =  000001 
    DM_BK1RE=  007F90     |     DM_BK1RH=  007F91     |     DM_BK1RL=  007F92 
    DM_BK2RE=  007F93     |     DM_BK2RH=  007F94     |     DM_BK2RL=  007F95 
    DM_CR1  =  007F96     |     DM_CR2  =  007F97     |     DM_CSR1 =  007F98 
    DM_CSR2 =  007F99     |     DM_ENFCT=  007F9A     |     DX      =  000005 
    DY      =  000007     |     EAST    =  000001     |     EEPROM_B=  004000 
    EEPROM_E=  0043FF     |     EEPROM_S=  000400     |     EM      =  000019 
    ENQ     =  000005     |     EOF     =  00001A     |     EOT     =  000004 
    EPULSE  =  000025     |     ESC     =  00001B     |     ETB     =  000017 
    ETX     =  000003     |     EXTI_CR1=  0050A0     |     EXTI_CR2=  0050A1 
    FF      =  00000C     |     FHSI    =  F42400     |     FIRST_VI=  000037 
    FLASH_BA=  008000     |     FLASH_CR=  00505A     |     FLASH_CR=  000002 
    FLASH_CR=  000000     |     FLASH_CR=  000003     |     FLASH_CR=  000001 
    FLASH_CR=  00505B     |     FLASH_CR=  000005     |     FLASH_CR=  000004 
    FLASH_CR=  000007     |     FLASH_CR=  000000     |     FLASH_CR=  000006 
    FLASH_DU=  005064     |     FLASH_DU=  0000AE     |     FLASH_DU=  000056 
    FLASH_EN=  017FFF     |     FLASH_FP=  00505D     |     FLASH_FP=  000000 
    FLASH_FP=  000001     |     FLASH_FP=  000002     |     FLASH_FP=  000003 
    FLASH_FP=  000004     |     FLASH_FP=  000005     |     FLASH_IA=  00505F 
    FLASH_IA=  000003     |     FLASH_IA=  000002     |     FLASH_IA=  000006 
    FLASH_IA=  000001     |     FLASH_IA=  000000     |     FLASH_NC=  00505C 
    FLASH_NF=  00505E     |     FLASH_NF=  000000     |     FLASH_NF=  000001 
    FLASH_NF=  000002     |     FLASH_NF=  000003     |     FLASH_NF=  000004 
    FLASH_NF=  000005     |     FLASH_PU=  005062     |     FLASH_PU=  000056 
    FLASH_PU=  0000AE     |     FLASH_SI=  010000     |     FLASH_WS=  00480D 
    FLSI    =  01F400     |     FMSTR   =  F42400     |     FONT_HEI=  000008 
    FONT_WID=  000006     |     FR_HORZ =  003D76     |     FR_T3_CL=  00F424 
    FS      =  00001C     |     F_CURSOR=  000001     |     F_CUR_VI=  000002 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 83.
Hexadecimal [24-Bits]

Symbol Table

    F_DISP_M=  000005     |     F_EVEN  =  000000     |     F_FOOD_C=  000000 
    F_GAME_O=  000002     |     F_GAME_T=  000007     |     F_NO_FOO=  000001 
    F_SOUND_=  000006     |     F_VIDEO =  000004     |     GAM_ADR =  000001 
    GPIO_BAS=  005000     |     GPIO_CR1=  000003     |     GPIO_CR2=  000004 
    GPIO_DDR=  000002     |     GPIO_IDR=  000001     |     GPIO_ODR=  000000 
    GPIO_SIZ=  000005     |     GS      =  00001D     |     HALF_LIN=  0001FC 
    HEAD    =  000003     |   7 HEAD_DOW   0009DC R   |   7 HEAD_LEF   0009E2 R
  7 HEAD_RIG   0009D6 R   |   7 HEAD_UP    0009D0 R   |     HLINE   =  0003F8 
    HPULSE  =  00004B     |     HRES    =  0000C8     |     HSECNT  =  004809 
  7 I0         000CC0 R   |   7 I1         000CC4 R   |     I2C_BASE=  005210 
    I2C_CCRH=  00521C     |     I2C_CCRH=  000080     |     I2C_CCRH=  0000C0 
    I2C_CCRH=  000080     |     I2C_CCRH=  000000     |     I2C_CCRH=  000001 
    I2C_CCRH=  000000     |     I2C_CCRH=  000006     |     I2C_CCRH=  000007 
    I2C_CCRL=  00521B     |     I2C_CCRL=  00001A     |     I2C_CCRL=  000002 
    I2C_CCRL=  00000D     |     I2C_CCRL=  000050     |     I2C_CCRL=  000090 
    I2C_CCRL=  0000A0     |     I2C_CR1 =  005210     |     I2C_CR1_=  000006 
    I2C_CR1_=  000007     |     I2C_CR1_=  000000     |     I2C_CR2 =  005211 
    I2C_CR2_=  000002     |     I2C_CR2_=  000003     |     I2C_CR2_=  000000 
    I2C_CR2_=  000001     |     I2C_CR2_=  000007     |     I2C_DR  =  005216 
    I2C_FAST=  000001     |     I2C_FREQ=  005212     |     I2C_ITR =  00521A 
    I2C_ITR_=  000002     |     I2C_ITR_=  000000     |     I2C_ITR_=  000001 
    I2C_OARH=  005214     |     I2C_OARH=  000001     |     I2C_OARH=  000002 
    I2C_OARH=  000006     |     I2C_OARH=  000007     |     I2C_OARL=  005213 
    I2C_OARL=  000000     |     I2C_OAR_=  000813     |     I2C_OAR_=  000009 
    I2C_PECR=  00521E     |     I2C_READ=  000001     |     I2C_SR1 =  005217 
    I2C_SR1_=  000003     |     I2C_SR1_=  000001     |     I2C_SR1_=  000002 
    I2C_SR1_=  000006     |     I2C_SR1_=  000000     |     I2C_SR1_=  000004 
    I2C_SR1_=  000007     |     I2C_SR2 =  005218     |     I2C_SR2_=  000002 
    I2C_SR2_=  000001     |     I2C_SR2_=  000000     |     I2C_SR2_=  000003 
    I2C_SR2_=  000005     |     I2C_SR3 =  005219     |     I2C_SR3_=  000001 
    I2C_SR3_=  000007     |     I2C_SR3_=  000004     |     I2C_SR3_=  000000 
    I2C_SR3_=  000002     |     I2C_STD =  000000     |     I2C_TRIS=  00521D 
    I2C_TRIS=  000005     |     I2C_TRIS=  000005     |     I2C_TRIS=  000005 
    I2C_TRIS=  000011     |     I2C_TRIS=  000011     |     I2C_TRIS=  000011 
    I2C_WRIT=  000000     |     IDX     =  000002     |     INPUT_DI=  000000 
    INPUT_EI=  000001     |     INPUT_FL=  000000     |     INPUT_PU=  000001 
    INT_ADC2=  000016     |     INT_AUAR=  000012     |     INT_AWU =  000001 
    INT_CAN_=  000008     |     INT_CAN_=  000009     |     INT_CLK =  000002 
    INT_EXTI=  000003     |     INT_EXTI=  000004     |     INT_EXTI=  000005 
    INT_EXTI=  000006     |     INT_EXTI=  000007     |     INT_FLAS=  000018 
    INT_I2C =  000013     |     INT_SPI =  00000A     |     INT_TIM1=  00000C 
    INT_TIM1=  00000B     |     INT_TIM2=  00000E     |     INT_TIM2=  00000D 
    INT_TIM3=  000010     |     INT_TIM3=  00000F     |     INT_TIM4=  000017 
    INT_TLI =  000000     |     INT_UART=  000011     |     INT_UART=  000015 
    INT_UART=  000014     |     INT_VECT=  008060     |     INT_VECT=  00800C 
    INT_VECT=  008028     |     INT_VECT=  00802C     |     INT_VECT=  008010 
    INT_VECT=  008014     |     INT_VECT=  008018     |     INT_VECT=  00801C 
    INT_VECT=  008020     |     INT_VECT=  008024     |     INT_VECT=  008068 
    INT_VECT=  008054     |     INT_VECT=  008000     |     INT_VECT=  008030 
    INT_VECT=  008038     |     INT_VECT=  008034     |     INT_VECT=  008040 
    INT_VECT=  00803C     |     INT_VECT=  008048     |     INT_VECT=  008044 
    INT_VECT=  008064     |     INT_VECT=  008008     |     INT_VECT=  008004 
    INT_VECT=  008050     |     INT_VECT=  00804C     |     INT_VECT=  00805C 
    INT_VECT=  008058     |     ISTR    =  000003     |     ITC_SPR1=  007F70 
    ITC_SPR2=  007F71     |     ITC_SPR3=  007F72     |     ITC_SPR4=  007F73 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 84.
Hexadecimal [24-Bits]

Symbol Table

    ITC_SPR5=  007F74     |     ITC_SPR6=  007F75     |     ITC_SPR7=  007F76 
    ITC_SPR8=  007F77     |     ITC_SPR_=  000001     |     ITC_SPR_=  000000 
    ITC_SPR_=  000003     |     IWDG_KEY=  000055     |     IWDG_KEY=  0000CC 
    IWDG_KEY=  0000AA     |     IWDG_KR =  0050E0     |     IWDG_PR =  0050E1 
    IWDG_RLR=  0050E2     |   7 J0         000D0B R   |   7 J1         000D11 R
  7 J2         000D19 R   |   7 J3         000D1F R   |     KERNEL_V=  000060 
    KPAD    =  000001     |     KPAD_IDR=  005010     |     KPAD_POR=  00500F 
  7 L0         000CF0 R   |   7 L1         000CF6 R   |   7 L2         000CFE R
  7 L3         000D04 R   |     LEN     =  000001     |     LF      =  00000A 
    LINE_DEL=  00008C     |     LINE_PER=  000018     |     MAJOR   =  000001 
    MASK    =  000005     |     MINOR   =  000001     |   7 MOUSE      0009EE R
    MOUSE_HE=  000004     |     MOUSE_WI=  000005     |     NAFR    =  004804 
    NAK     =  000015     |     NCLKOPT =  004808     |     NFLASH_W=  00480E 
    NHSECNT =  00480A     |     NOPT1   =  004802     |     NOPT2   =  004804 
    NOPT3   =  004806     |     NOPT4   =  004808     |     NOPT5   =  00480A 
    NOPT6   =  00480C     |     NOPT7   =  00480E     |     NOPTBL  =  00487F 
    NORTH   =  000000     |     NUBC    =  004802     |     NWDGOPT =  004806 
    NWDGOPT_=  FFFFFFFD     |     NWDGOPT_=  FFFFFFFC     |     NWDGOPT_=  FFFFFFFF 
    NWDGOPT_=  FFFFFFFE     |   7 NonHandl   000000 R   |     OFS_UART=  000002 
    OFS_UART=  000003     |     OFS_UART=  000004     |     OFS_UART=  000005 
    OFS_UART=  000006     |     OFS_UART=  000007     |     OFS_UART=  000008 
    OFS_UART=  000009     |     OFS_UART=  000001     |     OFS_UART=  000009 
    OFS_UART=  00000A     |     OFS_UART=  000000     |     OPT0    =  004800 
    OPT1    =  004801     |     OPT2    =  004803     |     OPT3    =  004805 
    OPT4    =  004807     |     OPT5    =  004809     |     OPT6    =  00480B 
    OPT7    =  00480D     |     OPTBL   =  00487E     |     OPTION_B=  004800 
    OPTION_E=  00487F     |     OPTION_S=  000080     |     OUTPUT_F=  000001 
    OUTPUT_O=  000000     |     OUTPUT_P=  000001     |     OUTPUT_S=  000000 
    PA      =  000000     |     PA_BASE =  005000     |     PA_CR1  =  005003 
    PA_CR2  =  005004     |     PA_DDR  =  005002     |     PA_IDR  =  005001 
    PA_ODR  =  005000     |     PB      =  000005     |     PB_BASE =  005005 
    PB_CR1  =  005008     |     PB_CR2  =  005009     |     PB_DDR  =  005007 
    PB_IDR  =  005006     |     PB_ODR  =  005005     |     PC      =  00000A 
    PC_BASE =  00500A     |     PC_CR1  =  00500D     |     PC_CR2  =  00500E 
    PC_DDR  =  00500C     |     PC_IDR  =  00500B     |     PC_ODR  =  00500A 
    PD      =  00000F     |     PD_BASE =  00500F     |     PD_CR1  =  005012 
    PD_CR2  =  005013     |     PD_DDR  =  005011     |     PD_IDR  =  005010 
    PD_ODR  =  00500F     |     PE      =  000014     |     PE_BASE =  005014 
    PE_CR1  =  005017     |     PE_CR2  =  005018     |     PE_DDR  =  005016 
    PE_IDR  =  005015     |     PE_ODR  =  005014     |     PF      =  000019 
    PF_BASE =  005019     |     PF_CR1  =  00501C     |     PF_CR2  =  00501D 
    PF_DDR  =  00501B     |     PF_IDR  =  00501A     |     PF_ODR  =  005019 
    PG      =  00001E     |     PG_BASE =  00501E     |     PG_CR1  =  005021 
    PG_CR2  =  005022     |     PG_DDR  =  005020     |     PG_IDR  =  00501F 
    PG_ODR  =  00501E     |     PH      =  000023     |     PH_BASE =  005023 
    PH_CR1  =  005026     |     PH_CR2  =  005027     |     PH_DDR  =  005025 
    PH_IDR  =  005024     |     PH_ODR  =  005023     |     PH_POST_=  000003 
    PH_PRE_V=  000001     |     PH_VIDEO=  000002     |     PH_VSYNC=  000000 
    PI      =  000028     |     PI_BASE =  005028     |     PI_CR1  =  00502B 
    PI_CR2  =  00502C     |     PI_DDR  =  00502A     |     PI_IDR  =  005029 
    PI_ODR  =  005028     |     POS     =  000001     |     RAM_BASE=  000000 
    RAM_END =  0017FF     |     RAM_SIZE=  001800     |     REV     =  000000 
  7 RING       0009E8 R   |     ROP     =  004800     |     ROW     =  000007 
    ROWS    =  000001     |     RS      =  00001E     |     RST_SR  =  0050B3 
  7 S0         000D35 R   |   7 S1         000D3B R   |     SEL     =  000012 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 85.
Hexadecimal [24-Bits]

Symbol Table

    SEMIC   =  00003B     |     SFR_BASE=  005000     |     SFR_END =  0057FF 
    SHARP   =  000023     |     SHIFT   =  000004     |     SI      =  00000F 
    SNAKE_SP=  000004     |     SNAKE_SP=  000004     |     SO      =  00000E 
    SOH     =  000001     |     SOUND_BI=  000000     |     SOUND_PO=  00500F 
    SOUTH   =  000002     |     SPACE   =  000020     |     SPI_CR1 =  005200 
    SPI_CR1_=  000003     |     SPI_CR1_=  000000     |     SPI_CR1_=  000001 
    SPI_CR1_=  000007     |     SPI_CR1_=  000002     |     SPI_CR1_=  000006 
    SPI_CR2 =  005201     |     SPI_CR2_=  000007     |     SPI_CR2_=  000006 
    SPI_CR2_=  000005     |     SPI_CR2_=  000004     |     SPI_CR2_=  000002 
    SPI_CR2_=  000000     |     SPI_CR2_=  000001     |     SPI_CRCP=  005205 
    SPI_DR  =  005204     |     SPI_ICR =  005202     |     SPI_RXCR=  005206 
    SPI_SR  =  005203     |     SPI_SR_B=  000007     |     SPI_SR_C=  000004 
    SPI_SR_M=  000005     |     SPI_SR_O=  000006     |     SPI_SR_R=  000000 
    SPI_SR_T=  000001     |     SPI_SR_W=  000003     |     SPI_TXCR=  005207 
    SPRITE  =  000002     |   7 SQUARE     000CCE R   |     STACK_EM=  0017FF 
    STACK_SI=  000080     |     STX     =  000002     |     SUB     =  00001A 
    SWIM_CSR=  007F80     |     SYN     =  000016     |   7 T0         000CD4 R
  7 T1         000CDA R   |   7 T2         000CE2 R   |   7 T3         000CEA R
    TAB     =  000009     |     TAIL    =  000003     |     TETRA_WI=  000002 
    TICK    =  000027     |     TIM1_ARR=  005262     |     TIM1_ARR=  005263 
    TIM1_BKR=  00526D     |     TIM1_CCE=  00525C     |     TIM1_CCE=  00525D 
    TIM1_CCM=  005258     |     TIM1_CCM=  000000     |     TIM1_CCM=  000001 
    TIM1_CCM=  000004     |     TIM1_CCM=  000005     |     TIM1_CCM=  000006 
    TIM1_CCM=  000007     |     TIM1_CCM=  000002     |     TIM1_CCM=  000003 
    TIM1_CCM=  000007     |     TIM1_CCM=  000002     |     TIM1_CCM=  000004 
    TIM1_CCM=  000005     |     TIM1_CCM=  000006     |     TIM1_CCM=  000004 
    TIM1_CCM=  000003     |     TIM1_CCM=  005259     |     TIM1_CCM=  000000 
    TIM1_CCM=  000001     |     TIM1_CCM=  000004     |     TIM1_CCM=  000005 
    TIM1_CCM=  000006     |     TIM1_CCM=  000007     |     TIM1_CCM=  000002 
    TIM1_CCM=  000003     |     TIM1_CCM=  000007     |     TIM1_CCM=  000002 
    TIM1_CCM=  000004     |     TIM1_CCM=  000005     |     TIM1_CCM=  000006 
    TIM1_CCM=  000004     |     TIM1_CCM=  000003     |     TIM1_CCM=  00525A 
    TIM1_CCM=  000000     |     TIM1_CCM=  000001     |     TIM1_CCM=  000004 
    TIM1_CCM=  000005     |     TIM1_CCM=  000006     |     TIM1_CCM=  000007 
    TIM1_CCM=  000002     |     TIM1_CCM=  000003     |     TIM1_CCM=  000007 
    TIM1_CCM=  000002     |     TIM1_CCM=  000004     |     TIM1_CCM=  000005 
    TIM1_CCM=  000006     |     TIM1_CCM=  000004     |     TIM1_CCM=  000003 
    TIM1_CCM=  00525B     |     TIM1_CCM=  000000     |     TIM1_CCM=  000001 
    TIM1_CCM=  000004     |     TIM1_CCM=  000005     |     TIM1_CCM=  000006 
    TIM1_CCM=  000007     |     TIM1_CCM=  000002     |     TIM1_CCM=  000003 
    TIM1_CCM=  000007     |     TIM1_CCM=  000002     |     TIM1_CCM=  000004 
    TIM1_CCM=  000005     |     TIM1_CCM=  000006     |     TIM1_CCM=  000004 
    TIM1_CCM=  000003     |     TIM1_CCR=  005265     |     TIM1_CCR=  005266 
    TIM1_CCR=  005267     |     TIM1_CCR=  005268     |     TIM1_CCR=  005269 
    TIM1_CCR=  00526A     |     TIM1_CCR=  00526B     |     TIM1_CCR=  00526C 
    TIM1_CNT=  00525E     |     TIM1_CNT=  00525F     |     TIM1_CR1=  005250 
    TIM1_CR1=  000007     |     TIM1_CR1=  000000     |     TIM1_CR1=  000006 
    TIM1_CR1=  000005     |     TIM1_CR1=  000004     |     TIM1_CR1=  000003 
    TIM1_CR1=  000001     |     TIM1_CR1=  000002     |     TIM1_CR2=  005251 
    TIM1_CR2=  000000     |     TIM1_CR2=  000002     |     TIM1_CR2=  000004 
    TIM1_CR2=  000005     |     TIM1_CR2=  000006     |     TIM1_DTR=  00526E 
    TIM1_EGR=  005257     |     TIM1_EGR=  000007     |     TIM1_EGR=  000001 
    TIM1_EGR=  000002     |     TIM1_EGR=  000003     |     TIM1_EGR=  000004 
    TIM1_EGR=  000005     |     TIM1_EGR=  000006     |     TIM1_EGR=  000000 
    TIM1_ETR=  005253     |     TIM1_ETR=  000006     |     TIM1_ETR=  000000 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 86.
Hexadecimal [24-Bits]

Symbol Table

    TIM1_ETR=  000001     |     TIM1_ETR=  000002     |     TIM1_ETR=  000003 
    TIM1_ETR=  000007     |     TIM1_ETR=  000004     |     TIM1_ETR=  000005 
    TIM1_IER=  005254     |     TIM1_IER=  000007     |     TIM1_IER=  000001 
    TIM1_IER=  000002     |     TIM1_IER=  000003     |     TIM1_IER=  000004 
    TIM1_IER=  000005     |     TIM1_IER=  000006     |     TIM1_IER=  000000 
    TIM1_OIS=  00526F     |     TIM1_PSC=  005260     |     TIM1_PSC=  005261 
    TIM1_RCR=  005264     |     TIM1_SMC=  005252     |     TIM1_SMC=  000007 
    TIM1_SMC=  000000     |     TIM1_SMC=  000001     |     TIM1_SMC=  000002 
    TIM1_SMC=  000004     |     TIM1_SMC=  000005     |     TIM1_SMC=  000006 
    TIM1_SR1=  005255     |     TIM1_SR1=  000007     |     TIM1_SR1=  000001 
    TIM1_SR1=  000002     |     TIM1_SR1=  000003     |     TIM1_SR1=  000004 
    TIM1_SR1=  000005     |     TIM1_SR1=  000006     |     TIM1_SR1=  000000 
    TIM1_SR2=  005256     |     TIM1_SR2=  000001     |     TIM1_SR2=  000002 
    TIM1_SR2=  000003     |     TIM1_SR2=  000004     |     TIM2_ARR=  00530D 
    TIM2_ARR=  00530E     |     TIM2_CCE=  005308     |     TIM2_CCE=  000000 
    TIM2_CCE=  000001     |     TIM2_CCE=  000004     |     TIM2_CCE=  000005 
    TIM2_CCE=  005309     |     TIM2_CCM=  005305     |     TIM2_CCM=  005306 
    TIM2_CCM=  005307     |     TIM2_CCM=  000000     |     TIM2_CCM=  000004 
    TIM2_CCM=  000003     |     TIM2_CCR=  00530F     |     TIM2_CCR=  005310 
    TIM2_CCR=  005311     |     TIM2_CCR=  005312     |     TIM2_CCR=  005313 
    TIM2_CCR=  005314     |     TIM2_CNT=  00530A     |     TIM2_CNT=  00530B 
    TIM2_CR1=  005300     |     TIM2_CR1=  000007     |     TIM2_CR1=  000000 
    TIM2_CR1=  000003     |     TIM2_CR1=  000001     |     TIM2_CR1=  000002 
    TIM2_EGR=  005304     |     TIM2_EGR=  000001     |     TIM2_EGR=  000002 
    TIM2_EGR=  000003     |     TIM2_EGR=  000006     |     TIM2_EGR=  000000 
    TIM2_IER=  005301     |     TIM2_PSC=  00530C     |     TIM2_SR1=  005302 
    TIM2_SR2=  005303     |     TIM3_ARR=  00532B     |     TIM3_ARR=  00532C 
    TIM3_CCE=  005327     |     TIM3_CCE=  000000     |     TIM3_CCE=  000001 
    TIM3_CCE=  000004     |     TIM3_CCE=  000005     |     TIM3_CCE=  000000 
    TIM3_CCE=  000001     |     TIM3_CCM=  005325     |     TIM3_CCM=  000000 
    TIM3_CCM=  000004     |     TIM3_CCM=  000003     |     TIM3_CCM=  005326 
    TIM3_CCM=  000000     |     TIM3_CCM=  000004     |     TIM3_CCM=  000003 
    TIM3_CCM=  000000     |     TIM3_CCM=  000004     |     TIM3_CCM=  000003 
    TIM3_CCR=  00532D     |     TIM3_CCR=  00532E     |     TIM3_CCR=  00532F 
    TIM3_CCR=  005330     |     TIM3_CNT=  005328     |     TIM3_CNT=  005329 
    TIM3_CR1=  005320     |     TIM3_CR1=  000007     |     TIM3_CR1=  000000 
    TIM3_CR1=  000003     |     TIM3_CR1=  000001     |     TIM3_CR1=  000002 
    TIM3_EGR=  005324     |     TIM3_EGR=  000001     |     TIM3_EGR=  000002 
    TIM3_EGR=  000003     |     TIM3_EGR=  000006     |     TIM3_EGR=  000000 
    TIM3_IER=  005321     |     TIM3_IER=  000001     |     TIM3_IER=  000002 
    TIM3_IER=  000003     |     TIM3_IER=  000006     |     TIM3_IER=  000000 
    TIM3_PSC=  00532A     |     TIM3_SR1=  005322     |     TIM3_SR1=  000001 
    TIM3_SR1=  000002     |     TIM3_SR1=  000003     |     TIM3_SR1=  000006 
    TIM3_SR1=  000000     |     TIM3_SR2=  005323     |     TIM3_SR2=  000001 
    TIM3_SR2=  000002     |     TIM3_SR2=  000003     |     TIM4_ARR=  005346 
    TIM4_CNT=  005344     |     TIM4_CR1=  005340     |     TIM4_CR1=  000007 
    TIM4_CR1=  000000     |     TIM4_CR1=  000003     |     TIM4_CR1=  000001 
    TIM4_CR1=  000002     |     TIM4_EGR=  005343     |     TIM4_EGR=  000000 
    TIM4_IER=  005341     |     TIM4_IER=  000000     |     TIM4_PSC=  005345 
    TIM4_PSC=  000000     |     TIM4_PSC=  000007     |     TIM4_PSC=  000004 
    TIM4_PSC=  000001     |     TIM4_PSC=  000005     |     TIM4_PSC=  000002 
    TIM4_PSC=  000006     |     TIM4_PSC=  000003     |     TIM4_PSC=  000000 
    TIM4_PSC=  000001     |     TIM4_PSC=  000002     |     TIM4_SR =  005342 
    TIM4_SR_=  000000     |   7 Timer4Up   000004 R   |     UART1   =  000000 
    UART1_BA=  005230     |     UART1_BR=  005232     |     UART1_BR=  005233 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 87.
Hexadecimal [24-Bits]

Symbol Table

    UART1_CR=  005234     |     UART1_CR=  005235     |     UART1_CR=  005236 
    UART1_CR=  005237     |     UART1_CR=  005238     |     UART1_DR=  005231 
    UART1_GT=  005239     |     UART1_PO=  000000     |     UART1_PS=  00523A 
    UART1_RX=  000004     |     UART1_SR=  005230     |     UART1_TX=  000005 
    UART2   =  000001     |     UART3   =  000002     |     UART3_BA=  005240 
    UART3_BR=  005242     |     UART3_BR=  005243     |     UART3_CR=  005244 
    UART3_CR=  005245     |     UART3_CR=  005246     |     UART3_CR=  005247 
    UART3_CR=  004249     |     UART3_DR=  005241     |     UART3_PO=  00000F 
    UART3_RX=  000006     |     UART3_SR=  005240     |     UART3_TX=  000005 
    UART_CR1=  000004     |     UART_CR1=  000002     |     UART_CR1=  000000 
    UART_CR1=  000001     |     UART_CR1=  000007     |     UART_CR1=  000006 
    UART_CR1=  000005     |     UART_CR1=  000003     |     UART_CR2=  000004 
    UART_CR2=  000002     |     UART_CR2=  000005     |     UART_CR2=  000001 
    UART_CR2=  000000     |     UART_CR2=  000006     |     UART_CR2=  000003 
    UART_CR2=  000007     |     UART_CR3=  000003     |     UART_CR3=  000001 
    UART_CR3=  000002     |     UART_CR3=  000000     |     UART_CR3=  000006 
    UART_CR3=  000004     |     UART_CR3=  000005     |     UART_CR4=  000000 
    UART_CR4=  000001     |     UART_CR4=  000002     |     UART_CR4=  000003 
    UART_CR4=  000004     |     UART_CR4=  000006     |     UART_CR4=  000005 
    UART_CR5=  000003     |     UART_CR5=  000001     |     UART_CR5=  000002 
    UART_CR5=  000004     |     UART_CR5=  000005     |     UART_CR6=  000004 
    UART_CR6=  000007     |     UART_CR6=  000001     |     UART_CR6=  000002 
    UART_CR6=  000000     |     UART_CR6=  000005     |     UART_SR_=  000001 
    UART_SR_=  000004     |     UART_SR_=  000002     |     UART_SR_=  000003 
    UART_SR_=  000000     |     UART_SR_=  000005     |     UART_SR_=  000006 
    UART_SR_=  000007     |     UBC     =  004801     |     UINT    =  000001 
    US      =  00001F     |     VAR_SIZE=  000004     |     VBUFF_SI=  0012C0 
    VIDEO_LI=  0000C0     |     VPULSE  =  0001B4     |     VRES    =  0000C0 
    VT      =  00000B     |     WDGOPT  =  004805     |     WDGOPT_I=  000002 
    WDGOPT_L=  000003     |     WDGOPT_W=  000000     |     WDGOPT_W=  000001 
    WELL_DEP=  00002C     |     WELL_WID=  000014     |     WEST    =  000004 
    WWDG_CR =  0050D1     |     WWDG_WR =  0050D2     |     X0      =  000001 
    X1      =  000002     |     XCOOR   =  000002     |     XCOORH  =  000001 
    XOFF    =  000013     |     XON     =  000011     |     Y0      =  000003 
    Y1      =  000004     |     YCOOR   =  000001     |   7 Z0         000D27 R
  7 Z1         000D2D R   |   5 acc16      000064 GR  |   5 acc8       000065 GR
  9 app_vari   000004 R   |   7 beep       0000C3 R   |   7 bit_mask   0006C1 R
  7 clock_in   000032 R   |   7 cold_sta   00013F R   |   7 crlf       00073F R
  7 cursor_r   00074F R   |   5 cx         000074 R   |   5 cy         000073 R
  7 dbg_prin   0008BB R   |   5 delay_ti   000062 R   |   7 draw_hea   000A2E R
  7 draw_sna   000A3C R   |   7 draw_spr   000A24 R   |   7 draw_wal   0009FB R
  7 draw_wel   000D43 R   |   7 fall       000D69 R   |   7 fall_ini   000D62 R
  5 flags      00006A GR  |   5 fmstr      000066 GR  |   7 font_6x8   0001EA R
  7 font_end   000522 R   |   7 food_col   000A64 R   |   9 food_coo   00000B R
  9 game_fla   000008 R   |   7 game_ove   000C43 R   |   7 gover      000C8F R
  7 invert_p   000703 R   |   7 jitter_c   000662 R   |   7 kpad_inp   0000F7 R
  7 line       0007DE R   |   7 main       0008D4 R   |   9 max_scor   000006 R
  7 max_scor   000CA2 R   |   7 menu       0008DA R   |   7 move_sna   000AF8 R
  7 move_up    000AEA R   |   7 new_food   000BB1 R   |   7 next_hea   000AC9 R
  7 noise      0000D0 R   |   5 ntsc_fla   00006F R   |   7 ntsc_ini   000522 R
  5 ntsc_pha   000070 R   |   7 ntsc_syn   0005A2 R   |   7 ntsc_vid   00064B R
  7 pause      00007A R   |   7 pixel_ad   0006D0 R   |   7 post_vid   000627 R
  7 prng       0001AE GR  |   7 prog_lis   000970 R   |   7 prompt     000CAE R
  7 prt_scor   000BE0 R   |   5 ptr16      000068 GR  |   5 ptr8       000069 R
  7 put_spri   000877 R   |   7 put_uint   000853 R   |   7 qbf        0009A4 R
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 88.
Hexadecimal [24-Bits]

Symbol Table

  7 quick      000993 R   |   7 read_key   0000FF R   |   7 reset_pi   0006FC R
  7 rotate_h   000B56 R   |   5 scan_lin   000071 R   |   9 score      000004 R
  7 score_st   000C9A R   |   7 scroll_u   000709 R   |   5 seedx      00006B R
  5 seedy      00006D R   |   7 select_m   000966 R   |   7 set_pixe   0006F6 R
  7 set_seed   0001D0 R   |   7 sll_xy_3   0001A0 R   |   7 snake      000C1E R
  9 snake_bo   00000D R   |   9 snake_di   00000A R   |   7 snake_in   000BEC R
  9 snake_le   000009 R   |   5 sound_ti   000063 R   |   7 srl_xy_3   0001A7 R
  2 stack_fu   001780 GR  |   2 stack_un   001800 R   |   7 sync_exi   000648 R
  7 test_pre   00060E R   |   5 ticks      000060 R   |   7 timer3_i   000061 R
  7 timer4_i   000048 R   |   7 tone       000086 R   |   6 tv_buffe   000080 R
  7 tv_cls     0006AA R   |   7 tv_putc    000758 R   |   7 tv_puts    0007D2 R
  7 user_inp   000B8B R   |   7 user_sel   000916 R   |   7 video_on   000589 R
  7 wait_key   000122 R   |   7 wait_key   000128 R   |   7 xor_seed   000184 R

ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 89.
Hexadecimal [24-Bits]

Area Table

   0 _CODE      size      0   flags    0
   1 SSEG       size      0   flags    8
   2 SSEG0      size     80   flags    8
   3 HOME       size     80   flags    0
   4 DATA       size      0   flags    8
   5 DATA1      size     15   flags    8
   6 DATA2      size   12C0   flags    8
   7 CODE       size    D6F   flags    0
   8 G_DATA     size      0   flags    8
   9 G_DATA3    size     49   flags    8

