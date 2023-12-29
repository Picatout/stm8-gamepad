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
                                     13 ; set to 1 to add dbg_print code 
                           000001    14 DEBUG=1
                                     15 
                                     16 ; master clock frequency in hz 
                           F42400    17 	FMSTR=16000000 
                                     18 
                           00500F    19 SOUND_PORT=PD_BASE 
                           000000    20 SOUND_BIT=(0)
                                     21 
                                     22 
                                     23 ; navigation buttons 
                           005005    24 KPAD_PORT=PB_BASE 
                           005006    25 KPAD_IDR=PB_IDR
                           000005    26 BIT_A=(5)
                           000004    27 BIT_B=(4)
                           000000    28 BIT_LEFT=(0)
                           000002    29 BIT_RIGHT=(2)
                           000001    30 BIT_DOWN=(1)
                           000003    31 BIT_UP=(3)
                           00003F    32 BTN_MASK=0x3f
                                     33 
                           000020    34 BTN_A=(1<<BIT_A) 
                           000010    35 BTN_B=(1<<BIT_B)
                           000001    36 BTN_LEFT=(1<<BIT_LEFT) 
                           000004    37 BTN_RIGHT=(1<<BIT_RIGHT)
                           000002    38 BTN_DOWN=(1<<BIT_DOWN) 
                           000008    39 BTN_UP=(1<<BIT_UP)
                                     40 
                                     41 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 3.
Hexadecimal [24-Bits]



                                     42 	.include "inc/ascii.inc"
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



                                     43 	.include "inc/stm8s207.inc"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 21.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 22.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 23.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 24.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 25.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 26.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 27.
Hexadecimal [24-Bits]



                                     44 	.include "inc/gen_macros.inc" 
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



                                     45 	.include "app_macros.inc" 
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



                                     46 
                                     47 
                                     48 
                                     49 
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
      008000 82 00 81 78             48     int cold_start			; RESET vector 
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
      008034 82 00 85 D8             61 	int ntsc_sync_interrupt ;int11 TIM1 update/overflow/underflow/trigger/break
      008038 82 00 86 B5             62 	int ntsc_video_interrupt ; int12 TIM1 capture/compare
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
      008064 82 00 80 80             73 	int NonHandledInterrupt ;int23 TIM4 update$overflow 
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
      000060                         88 ticks: .blkw 1 ; 2 millisecond counter
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
                                    126 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    127 ;    peripherals initialization
                                    128 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    129 
                                    130 ;----------------------------------------
                                    131 ; inialize MCU clock 
                                    132 ; select HSE 
                                    133 ; no CPU divisor 
                                    134 ;----------------------------------------
      008084                        135 clock_init:	
      008084 72 17 50 C5      [ 1]  136 	bres CLK_SWCR,#CLK_SWCR_SWIF 
      008088 35 B4 50 C4      [ 1]  137 	mov CLK_SWR,#CLK_SWR_HSE  
      00808C 72 07 50 C5 FB   [ 2]  138 	btjf CLK_SWCR,#CLK_SWCR_SWIF,. 
      008091 72 12 50 C5      [ 1]  139 	bset CLK_SWCR,#CLK_SWCR_SWEN
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 36.
Hexadecimal [24-Bits]



      008095                        140 2$: 
      008095 72 5F 50 C6      [ 1]  141 	clr CLK_CKDIVR   	
      008099 81               [ 4]  142 	ret
                                    143 
                                    144 ;----------------------------------
                                    145 ; TIMER3 used as audio tone output 
                                    146 ; on port D:2. pin 27
                                    147 ; channel 3 configured as PWM mode 1 
                                    148 ;-----------------------------------  
      00809A                        149 timer3_init:
      00809A 72 1C 50 C7      [ 1]  150 	bset CLK_PCKENR1,#CLK_PCKENR1_TIM3 ; enable TIMER3 clock 
      00809E 72 10 50 11      [ 1]  151  	bset SOUND_PORT+GPIO_DDR,#SOUND_BIT
      0080A2 35 60 53 26      [ 1]  152 	mov TIM3_CCMR2,#(6<<TIM3_CCMR2_OC2M) ; PWM mode 1 
      0080A6 35 08 53 2A      [ 1]  153 	mov TIM3_PSCR,#8 ; Ft2clk=fmstr/256=62500 hertz 
      0080AA 72 11 53 20      [ 1]  154 	bres TIM3_CR1,#TIM3_CR1_CEN
      0080AE 72 19 53 27      [ 1]  155 	bres TIM3_CCER1,#TIM3_CCER1_CC2E
      0080B2 81               [ 4]  156 	ret 
                                    157  
                           000000   158 .if 0
                                    159 ;--------------------------
                                    160 ; set software interrupt 
                                    161 ; priority 
                                    162 ; input:
                                    163 ;   A    priority 1,2,3 
                                    164 ;   X    vector# 
                                    165 ;---------------------------
                                    166 	SPR_ADDR=1 
                                    167 	PRIORITY=3
                                    168 	SLOT=4
                                    169 	MASKED=5  
                                    170 	VSIZE=5
                                    171 set_int_priority::
                                    172 	_vars VSIZE
                                    173 	and a,#3  
                                    174 	ld (PRIORITY,sp),a 
                                    175 ; select ITC_SPRX register 
                                    176 	ld a,#4 
                                    177 	div x,a 
                                    178 	sll a  ; slot*2 
                                    179 	ld (SLOT,sp),a
                                    180 	addw x,#ITC_SPR1 
                                    181 	ldw (SPR_ADDR,sp),x 
                                    182 ; build mask
                                    183 	ldw x,#0xfffc ; slot 0 mask 	
                                    184 	ld a,(SLOT,sp)
                                    185 	jreq 2$ 
                                    186 	scf 
                                    187 1$:	rlcw x 
                                    188 	dec a 
                                    189 	jrne 1$
                                    190 2$:	ld a,xl 
                                    191 ; apply mask to slot 
                                    192 	ldw x,(SPR_ADDR,sp)
                                    193 	and a,(x)
                                    194 	ld (MASKED,sp),a 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 37.
Hexadecimal [24-Bits]



                                    195 ; shift priority to slot 
                                    196 	ld a,(PRIORITY,sp)
                                    197 	tnz (SLOT,sp)
                                    198 	jreq 4$
                                    199 3$:	sll a  
                                    200 	dec (SLOT,sp) 
                                    201 	jrne 3$
                                    202 4$:	 
                                    203 	or a,(MASKED,sp)
                                    204 	ldw x,(SPR_ADDR,sp)
                                    205 	ld (x),a 
                                    206 	_drop VSIZE 
                                    207 	ret 
                                    208 .endif 
                                    209 
                                    210 ;------------------------
                                    211 ; suspend execution 
                                    212 ; input:
                                    213 ;   A     16.7*n msec   
                                    214 ;-------------------------
      0080B3                        215 pause:
      000033                        216 	_straz delay_timer 
      0080B3 B7 62                    1     .byte 0xb7,delay_timer 
      0080B5 72 1E 00 6A      [ 1]  217 	bset flags,#F_GAME_TMR 
      0080B9                        218 1$: 	
      0080B9 72 0E 00 6A FB   [ 2]  219 	btjt flags,#F_GAME_TMR,1$ 
      0080BE 81               [ 4]  220 	ret 
                                    221 
                                    222 ;-----------------------
                                    223 ; tone generator 
                                    224 ; Ft2clk=62500 hertz 
                                    225 ; input:
                                    226 ;   A   duration 16.7*n msec    
                                    227 ;   X   frequency 
                                    228 ;------------------------
                           00F424   229 FR_T3_CLK=62500
      0080BF                        230 tone:
      0080BF 90 89            [ 2]  231 	pushw y 
      0080C1 88               [ 1]  232 	push a 
      0080C2 90 93            [ 1]  233 	ldw y,x 
      0080C4 AE F4 24         [ 2]  234 	ldw x,#FR_T3_CLK 
      0080C7 65               [ 2]  235 	divw x,y 
      0080C8 9E               [ 1]  236 	ld a,xh 
      0080C9 C7 53 2B         [ 1]  237 	ld TIM3_ARRH,a 
      0080CC 9F               [ 1]  238 	ld a,xl 
      0080CD C7 53 2C         [ 1]  239 	ld TIM3_ARRL,a 
      0080D0 54               [ 2]  240 	srlw x 
      0080D1 9E               [ 1]  241 	ld a,xh 
      0080D2 C7 53 2F         [ 1]  242 	ld TIM3_CCR2H,a 
      0080D5 9F               [ 1]  243 	ld a,xl 
      0080D6 C7 53 30         [ 1]  244 	ld TIM3_CCR2L,a 
      0080D9 72 18 53 27      [ 1]  245 	bset TIM3_CCER1,#TIM3_CCER1_CC2E
      0080DD 72 10 53 20      [ 1]  246 	bset TIM3_CR1,#TIM3_CR1_CEN 
      0080E1 72 10 53 24      [ 1]  247 	bset TIM3_EGR,#TIM3_EGR_UG
      0080E5 84               [ 1]  248 	pop a 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 38.
Hexadecimal [24-Bits]



      000066                        249 	_straz sound_timer  
      0080E6 B7 63                    1     .byte 0xb7,sound_timer 
      0080E8 72 1C 00 6A      [ 1]  250 	bset flags,#F_SOUND_TMR 
      0080EC                        251 1$:  
      0080EC 72 0C 00 6A FB   [ 2]  252 	btjt flags,#F_SOUND_TMR,1$
      0080F1 72 11 53 20      [ 1]  253 	bres TIM3_CR1,#TIM3_CR1_CEN 
      0080F5 72 19 53 27      [ 1]  254 	bres TIM3_CCER1,#TIM3_CCER1_CC2E
      0080F9 90 85            [ 2]  255 	popw y 
      0080FB 81               [ 4]  256 	ret 
                                    257 
                                    258 ;-----------------
                                    259 ; 1Khz beep 
                                    260 ;-----------------
      0080FC                        261 beep:
      0080FC 88               [ 1]  262 	push a 
      0080FD 89               [ 2]  263 	pushw x 
      0080FE AE 03 E8         [ 2]  264 	ldw x,#1000 ; hertz 
      008101 A6 08            [ 1]  265 	ld a,#8
      008103 CD 80 BF         [ 4]  266 	call tone
      008106 85               [ 2]  267 	popw x 
      008107 84               [ 1]  268 	pop a   
      008108 81               [ 4]  269 	ret 
                                    270 
                                    271 ;------------------------
                                    272 ; generate white noise 
                                    273 ; input:
                                    274 ;    A  duration 60*A msec.
                                    275 ;-------------------------- 
      008109                        276 noise:
      008109 89               [ 2]  277 	pushw x
      00008A                        278 	_straz sound_timer 
      00810A B7 63                    1     .byte 0xb7,sound_timer 
      00810C 4B 00            [ 1]  279 	push #0  
      00810E 72 1C 00 6A      [ 1]  280 	bset flags,#F_SOUND_TMR
      008112 CD 81 E4         [ 4]  281 1$: call prng
      008115 A6 10            [ 1]  282 	ld a,#16 
      008117 6B 01            [ 1]  283 	ld (1,sp),a  
      008119 58               [ 2]  284 2$:	sllw x 
      00811A 90 11 50 0F      [ 1]  285 	bccm SOUND_PORT,#SOUND_BIT
      00811E A6 0A            [ 1]  286 	ld a,#10 
      008120 4A               [ 1]  287 4$:	dec a 
      008121 26 FD            [ 1]  288 	jrne 4$
      008123 0A 01            [ 1]  289 	dec (1,sp)
      008125 26 F2            [ 1]  290 	jrne 2$  
      008127 72 0C 00 6A E6   [ 2]  291 	btjt flags,#F_SOUND_TMR,1$
      0000AC                        292 	_drop 1 
      00812C 5B 01            [ 2]    1     addw sp,#1 
      00812E 85               [ 2]  293 	popw x 
      00812F 81               [ 4]  294 	ret 
                                    295 
                                    296 ;------------------------
                                    297 ; reading keypad 
                                    298 ; without debouncing 
                                    299 ; output:
                                    300 ;     A   reading 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 39.
Hexadecimal [24-Bits]



                                    301 ;-----------------------
      008130                        302 kpad_input:
      008130 C6 50 06         [ 1]  303 	ld a,KPAD_IDR 
      008133 A4 3F            [ 1]  304 	and a,#BTN_MASK 
      008135 A8 3F            [ 1]  305 	xor a,#BTN_MASK  
      008137 81               [ 4]  306 	ret 
                                    307 
                                    308 
                                    309 ;-------------------------
                                    310 ; read keypad
                                    311 ; ouput:
                                    312 ;    A 
                                    313 ;       BTN_A -> bit 0 (1)
                                    314 ;       BTN_B -> bit 3 (8)
                                    315 ;       BTN_LEFT -> bit 4 (16)
                                    316 ;       BTN_RIGHT -> bit 5 (32)
                                    317 ;       BTN_DOWN -> bit 6 (64)
                                    318 ;       BNT_UP -> bit 7  (128)
                                    319 ;    Z   set no key 
                                    320 ;-------------------------
                           000001   321 	DEBOUNCE=1
                           000003   322 	BUTTONS=DEBOUNCE+2
                           000003   323 	VAR_SIZE=BUTTONS 
      008138                        324 read_keypad:
      008138 89               [ 2]  325 	pushw x 
      0000B9                        326 	_vars VAR_SIZE
      008139 52 03            [ 2]    1     sub sp,#VAR_SIZE 
      00813B CD 81 30         [ 4]  327 	call kpad_input 
      00813E 6B 03            [ 1]  328 1$:	ld (BUTTONS,sp),a  
      008140 CE 00 60         [ 2]  329     ldw x,ticks 
      008143 1C 00 01         [ 2]  330 	addw x,#1
      008146 1F 01            [ 2]  331 	ldw (DEBOUNCE,sp),x 	
      008148 CD 81 30         [ 4]  332 2$: call kpad_input 
      00814B 11 03            [ 1]  333 	cp a,(BUTTONS,sp)
      00814D 26 EF            [ 1]  334 	jrne 1$
      00814F CE 00 60         [ 2]  335 	ldw x,ticks 
      008152 13 01            [ 2]  336 	cpw x,(DEBOUNCE,sp)
      008154 26 F2            [ 1]  337 	jrne 2$
      0000D6                        338 	_drop VAR_SIZE  
      008156 5B 03            [ 2]    1     addw sp,#VAR_SIZE 
      008158 85               [ 2]  339 	popw x
      008159 4D               [ 1]  340 	tnz a 
      00815A 81               [ 4]  341 	ret 
                                    342 
                                    343 ;----------------------------
                                    344 ; wait until key pressed 
                                    345 ; output:
                                    346 ;    A    key
                                    347 ;----------------------------
      00815B                        348 wait_key:
      00815B CD 81 38         [ 4]  349 	call read_keypad 
      00815E 27 FB            [ 1]  350 	jreq wait_key
      008160 81               [ 4]  351 	ret 
                                    352 
                                    353 ;--------------------------
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 40.
Hexadecimal [24-Bits]



                                    354 ; wait for buttons released 
                                    355 ; but no more than 100msec
                                    356 ; input:
                                    357 ;    X   maximum delay msec
                                    358 ;--------------------------
                           000001   359     DLY=1
                           000002   360     VAR_SIZE=2
      008161                        361 wait_key_release:
      0000E1                        362     _vars VAR_SIZE
      008161 52 02            [ 2]    1     sub sp,#VAR_SIZE 
      008163 72 BB 00 60      [ 2]  363     addw x,ticks
      008167 1F 01            [ 2]  364     ldw (DLY,sp),x 
      008169                        365 1$: 
      008169 CE 00 60         [ 2]  366     ldw x,ticks 
      00816C 13 01            [ 2]  367     cpw x,(DLY,sp)
      00816E 2A 05            [ 1]  368     jrpl 9$     
      008170 CD 81 30         [ 4]  369     call kpad_input
      008173 26 F4            [ 1]  370     jrne 1$ 
      008175                        371 9$:
      0000F5                        372     _drop VAR_SIZE 
      008175 5B 02            [ 2]    1     addw sp,#VAR_SIZE 
      008177 81               [ 4]  373     ret 
                                    374 
                                    375 ;-------------------------------------
                                    376 ;  initialization entry point 
                                    377 ;-------------------------------------
      008178                        378 cold_start:
                                    379 ;set stack 
      008178 9B               [ 1]  380 	sim
      008179 AE 17 FF         [ 2]  381 	ldw x,#STACK_EMPTY
      00817C 94               [ 1]  382 	ldw sp,x
                                    383 ; clear all ram 
      00817D 7F               [ 1]  384 0$: clr (x)
      00817E 5A               [ 2]  385 	decw x 
      00817F 26 FC            [ 1]  386 	jrne 0$
                                    387 ; disable all peripherals clock 
      008181 72 5F 50 C7      [ 1]  388 	clr CLK_PCKENR1 
      008185 72 5F 50 CA      [ 1]  389 	clr CLK_PCKENR2 
                                    390 ; activate pull up on all inputs 
                                    391 ; or push pull on output 
      008189 A6 FF            [ 1]  392 	ld a,#255 
      00818B C7 50 03         [ 1]  393 	ld PA_CR1,a 
      00818E C7 50 08         [ 1]  394 	ld PB_CR1,a 
      008191 C7 50 0D         [ 1]  395 	ld PC_CR1,a 
      008194 C7 50 12         [ 1]  396 	ld PD_CR1,a
      008197 C7 50 17         [ 1]  397 	ld PE_CR1,a 
      00819A C7 50 1C         [ 1]  398 	ld PF_CR1,a 
      00819D C7 50 21         [ 1]  399 	ld PG_CR1,a 
      0081A0 C7 50 26         [ 1]  400 	ld PH_CR1,a 
      0081A3 C7 50 2B         [ 1]  401 	ld PI_CR1,a 
      0081A6 CD 80 84         [ 4]  402 	call clock_init	
      0081A9 CD 80 9A         [ 4]  403 	call timer3_init
      0081AC CD 85 58         [ 4]  404 	call ntsc_init ;
      0081AF 9A               [ 1]  405 	rim ; enable interrupts 
      0081B0 5F               [ 1]  406 	clrw x 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 41.
Hexadecimal [24-Bits]



      0081B1 CD 82 06         [ 4]  407 	call set_seed
      0081B4                        408 4$:
      0081B4 CD 80 FC         [ 4]  409 	call beep
      0081B7 CC 8A 7B         [ 2]  410 	jp main ; in tv_term.asm 
                                    411 
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
      0081BA                         32 xor_seed32:
      0081BA 9E               [ 1]   33     ld a,xh 
      00013B                         34     _xorz seedx 
      0081BB B8 6B                    1     .byte 0xb8,seedx 
      00013D                         35     _straz seedx
      0081BD B7 6B                    1     .byte 0xb7,seedx 
      0081BF 9F               [ 1]   36     ld a,xl 
      000140                         37     _xorz seedx+1 
      0081C0 B8 6C                    1     .byte 0xb8,seedx+1 
      000142                         38     _straz seedx+1 
      0081C2 B7 6C                    1     .byte 0xb7,seedx+1 
      0081C4 90 9E            [ 1]   39     ld a,yh 
      000146                         40     _xorz seedy
      0081C6 B8 6D                    1     .byte 0xb8,seedy 
      000148                         41     _straz seedy 
      0081C8 B7 6D                    1     .byte 0xb7,seedy 
      0081CA 90 9F            [ 1]   42     ld a,yl 
      00014C                         43     _xorz seedy+1 
      0081CC B8 6E                    1     .byte 0xb8,seedy+1 
      00014E                         44     _straz seedy+1 
      0081CE B7 6E                    1     .byte 0xb7,seedy+1 
      000150                         45     _ldxz seedx  
      0081D0 BE 6B                    1     .byte 0xbe,seedx 
      000152                         46     _ldyz seedy 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 43.
Hexadecimal [24-Bits]



      0081D2 90 BE 6D                 1     .byte 0x90,0xbe,seedy 
      0081D5 81               [ 4]   47     ret 
                                     48 
                                     49 ;-----------------------------------
                                     50 ;   x:y= x:y << a 
                                     51 ;  input:
                                     52 ;    A     shift count 
                                     53 ;    X:Y   uint32 value 
                                     54 ;  output:
                                     55 ;    X:Y   uint32 shifted value   
                                     56 ;-----------------------------------
      0081D6                         57 sll_xy_32: 
      0081D6 90 58            [ 2]   58     sllw y 
      0081D8 59               [ 2]   59     rlcw x
      0081D9 4A               [ 1]   60     dec a 
      0081DA 26 FA            [ 1]   61     jrne sll_xy_32 
      0081DC 81               [ 4]   62     ret 
                                     63 
                                     64 ;-----------------------------------
                                     65 ;   x:y= x:y >> a 
                                     66 ;  input:
                                     67 ;    A     shift count 
                                     68 ;    X:Y   uint32 value 
                                     69 ;  output:
                                     70 ;    X:Y   uint32 shifted value   
                                     71 ;-----------------------------------
      0081DD                         72 srl_xy_32: 
      0081DD 54               [ 2]   73     srlw x 
      0081DE 90 56            [ 2]   74     rrcw y 
      0081E0 4A               [ 1]   75     dec a 
      0081E1 26 FA            [ 1]   76     jrne srl_xy_32 
      0081E3 81               [ 4]   77     ret 
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
      0081E4                         88 prng::
      0081E4 90 89            [ 2]   89 	pushw y   
      000166                         90     _ldxz seedx
      0081E6 BE 6B                    1     .byte 0xbe,seedx 
      000168                         91 	_ldyz seedy  
      0081E8 90 BE 6D                 1     .byte 0x90,0xbe,seedy 
      0081EB A6 0D            [ 1]   92 	ld a,#13
      0081ED CD 81 D6         [ 4]   93     call sll_xy_32 
      0081F0 CD 81 BA         [ 4]   94     call xor_seed32
      0081F3 A6 11            [ 1]   95     ld a,#17 
      0081F5 CD 81 DD         [ 4]   96     call srl_xy_32
      0081F8 CD 81 BA         [ 4]   97     call xor_seed32 
      0081FB A6 05            [ 1]   98     ld a,#5 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 44.
Hexadecimal [24-Bits]



      0081FD CD 81 D6         [ 4]   99     call sll_xy_32
      008200 CD 81 BA         [ 4]  100     call xor_seed32
      008203 90 85            [ 2]  101     popw y 
      008205 81               [ 4]  102     ret 
                                    103 
                                    104 
                                    105 ;---------------------------------
                                    106 ; initialize seedx:seedy 
                                    107 ; input:
                                    108 ;    X    0 -> seedx=ticks, seedy=[0x6000] 
                                    109 ;    X    !0 -> seedx=X, y=[0x6000], seedy=swapw(y)
                                    110 ;-------------------------------------------
      008206                        111 set_seed:
      008206 5D               [ 2]  112     tnzw x 
      008207 26 0B            [ 1]  113     jrne 1$ 
      008209 CE 00 60         [ 2]  114     ldw x,ticks 
      00018C                        115     _strxz seedx
      00820C BF 6B                    1     .byte 0xbf,seedx 
      00820E AE 60 00         [ 2]  116     ldw x,#0x6000  
      000191                        117     _strxz seedy  
      008211 BF 6D                    1     .byte 0xbf,seedy 
      008213 81               [ 4]  118     ret 
      008214                        119 1$:  
      000194                        120     _strxz seedx
      008214 BF 6B                    1     .byte 0xbf,seedx 
      008216 90 CE 60 00      [ 2]  121     ldw y,0x6000
      00821A 90 5E            [ 1]  122     swapw y 
      00019C                        123     _stryz seedy 
      00821C 90 BF 6D                 1     .byte 0x90,0xbf,seedy 
      00821F 81               [ 4]  124     ret 
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
      008220                         24 font_6x8: 
      008220 00 00 00 00 00 00 00    25 .byte 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00  ; space ASCII 32
             00
      008228 20 20 20 20 20 00 20    26 .byte 0x20,0x20,0x20,0x20,0x20,0x00,0x20,0x00  ; !
             00
      008230 50 50 50 00 00 00 00    27 .byte 0x50,0x50,0x50,0x00,0x00,0x00,0x00,0x00  ; "
             00
      008238 50 50 F8 50 F8 50 50    28 .byte 0x50,0x50,0xF8,0x50,0xF8,0x50,0x50,0x00  ; #
             00
      008240 20 78 A0 70 28 F0 20    29 .byte 0x20,0x78,0xA0,0x70,0x28,0xF0,0x20,0x00  ; $
             00
      008248 C0 C8 10 20 40 98 18    30 .byte 0xC0,0xC8,0x10,0x20,0x40,0x98,0x18,0x00  ; %
             00
      008250 60 90 A0 40 A8 90 68    31 .byte 0x60,0X90,0xA0,0x40,0xA8,0x90,0x68,0x00  ; &
             00
      008258 60 20 40 00 00 00 00    32 .byte 0x60,0x20,0x40,0x00,0x00,0x00,0x00,0x00  ; '
             00
      008260 10 20 40 40 40 20 10    33 .byte 0x10,0x20,0x40,0x40,0x40,0x20,0x10,0x00  ; (
             00
      008268 40 20 10 10 10 20 40    34 .byte 0x40,0x20,0x10,0x10,0x10,0x20,0x40,0x00  ; )
             00
      008270 00 20 A8 70 A8 20 00    35 .byte 0x00,0x20,0xA8,0x70,0xA8,0x20,0x00,0x00  ; *
             00
      008278 00 20 20 F8 20 20 00    36 .byte 0x00,0x20,0x20,0xF8,0x20,0x20,0x00,0x00  ; +
             00
      008280 00 00 00 70 70 30 60    37 .byte 0x00,0x00,0x00,0x70,0x70,0x30,0x60,0x40  ; ,
             40
      008288 00 00 00 F0 00 00 00    38 .byte 0x00,0x00,0x00,0xF0,0x00,0x00,0x00,0x00  ; -
             00
      008290 00 00 00 00 00 60 60    39 .byte 0x00,0x00,0x00,0x00,0x00,0x60,0x60,0x00  ; .
             00
      008298 00 06 0C 18 30 60 00    40 .byte 0x00,0x06,0x0c,0x18,0x30,0x60,0x00,0x00  ; /
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 46.
Hexadecimal  00-Bits]



             00
      0082A0 70 88 98 A8 C8 88 70    41 .byte 0x70,0x88,0x98,0xA8,0xC8,0x88,0x70,0x00  ; 0
             00
      0082A8 20 60 20 20 20 20 F8    42 .byte 0x20,0x60,0x20,0x20,0x20,0x20,0xF8,0x00  ; 1
             00
      0082B0 70 88 10 20 40 80 F8    43 .byte 0x70,0x88,0x10,0x20,0x40,0x80,0xF8,0x00  ; 2
             00
      0082B8 F0 08 08 F0 08 08 F0    44 .byte 0xF0,0x08,0x08,0xF0,0x08,0x08,0xF0,0x00  ; 3
             00
      0082C0 10 30 50 90 F8 10 10    45 .byte 0x10,0x30,0x50,0x90,0xF8,0x10,0x10,0x00  ; 4
             00
      0082C8 F8 80 80 F0 08 08 F0    46 .byte 0xF8,0x80,0x80,0xF0,0x08,0x08,0xF0,0x00  ; 5
             00
      0082D0 30 40 80 F0 88 88 70    47 .byte 0x30,0x40,0x80,0xF0,0x88,0x88,0x70,0x00  ; 6
             00
      0082D8 F8 08 10 20 40 40 40    48 .byte 0xF8,0x08,0x10,0x20,0x40,0x40,0x40,0x00  ; 7
             00
      0082E0 70 88 88 70 88 88 70    49 .byte 0x70,0x88,0x88,0x70,0x88,0x88,0x70,0x00  ; 8
             00
      0082E8 70 88 88 70 08 08 70    50 .byte 0x70,0x88,0x88,0x70,0x08,0x08,0x70,0x00  ; 9
             00
      0082F0 00 70 70 00 70 70 00    51 .byte 0x00,0x70,0x70,0x00,0x70,0x70,0x00,0x00  ; :
             00
      0082F8 00 70 70 00 70 70 60    52 .byte 0x00,0x70,0x70,0x00,0x70,0x70,0x60,0x40  ; ;
             40
      008300 10 20 40 80 40 20 10    53 .byte 0x10,0x20,0x40,0x80,0x40,0x20,0x10,0x00  ; <
             00
      008308 00 00 F8 00 F8 00 00    54 .byte 0x00,0x00,0xF8,0x00,0xF8,0x00,0x00,0x00  ; =
             00
      008310 40 20 10 08 10 20 40    55 .byte 0x40,0x20,0x10,0x08,0x10,0x20,0x40,0x00  ; >
             00
      008318 70 88 08 10 20 00 20    56 .byte 0x70,0x88,0x08,0x10,0x20,0x00,0x20,0x00  ; ?
             00
      008320 70 88 08 68 A8 A8 70    57 .byte 0x70,0x88,0x08,0x68,0xA8,0xA8,0x70,0x00  ; @
             00
      008328 70 88 88 F8 88 88 88    58 .byte 0x70,0x88,0x88,0xF8,0x88,0x88,0x88,0x00  ; A
             00
      008330 F0 88 88 F0 88 88 F0    59 .byte 0xF0,0x88,0x88,0xF0,0x88,0x88,0xF0,0x00  ; B
             00
      008338 78 80 80 80 80 80 78    60 .byte 0x78,0x80,0x80,0x80,0x80,0x80,0x78,0x00  ; C
             00
      008340 F0 88 88 88 88 88 F0    61 .byte 0xF0,0x88,0x88,0x88,0x88,0x88,0xF0,0x00  ; D
             00
      008348 F8 80 80 F8 80 80 F8    62 .byte 0xF8,0x80,0x80,0xF8,0x80,0x80,0xF8,0x00  ; E
             00
      008350 F8 80 80 F8 80 80 80    63 .byte 0xF8,0x80,0x80,0xF8,0x80,0x80,0x80,0x00  ; F
             00
      008358 78 80 80 B0 88 88 70    64 .byte 0x78,0x80,0x80,0xB0,0x88,0x88,0x70,0x00  ; G
             00
      008360 88 88 88 F8 88 88 88    65 .byte 0x88,0x88,0x88,0xF8,0x88,0x88,0x88,0x00  ; H
             00
      008368 70 20 20 20 20 20 70    66 .byte 0x70,0x20,0x20,0x20,0x20,0x20,0x70,0x00  ; I
             00
      008370 78 08 08 08 08 90 60    67 .byte 0x78,0x08,0x08,0x08,0x08,0x90,0x60,0x00  ; J
             00
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 47.
Hexadecimal [24-Bits]



      008378 88 90 A0 C0 A0 90 88    68 .byte 0x88,0x90,0xA0,0xC0,0xA0,0x90,0x88,0x00  ; K
             00
      008380 80 80 80 80 80 80 F8    69 .byte 0x80,0x80,0x80,0x80,0x80,0x80,0xF8,0x00  ; L
             00
      008388 88 D8 A8 88 88 88 88    70 .byte 0x88,0xD8,0xA8,0x88,0x88,0x88,0x88,0x00  ; M
             00
      008390 88 88 C8 A8 98 88 88    71 .byte 0x88,0x88,0xC8,0xA8,0x98,0x88,0x88,0x00  ; N
             00
      008398 70 88 88 88 88 88 70    72 .byte 0x70,0x88,0x88,0x88,0x88,0x88,0x70,0x00  ; O
             00
      0083A0 F0 88 88 F0 80 80 80    73 .byte 0xF0,0x88,0x88,0xF0,0x80,0x80,0x80,0x00  ; P
             00
      0083A8 70 88 88 88 A8 90 68    74 .byte 0x70,0x88,0x88,0x88,0xA8,0x90,0x68,0x00  ; Q
             00
      0083B0 F0 88 88 F0 A0 90 88    75 .byte 0xF0,0x88,0x88,0xF0,0xA0,0x90,0x88,0x00  ; R
             00
      0083B8 78 80 80 70 08 08 F0    76 .byte 0x78,0x80,0x80,0x70,0x08,0x08,0xF0,0x00  ; S
             00
      0083C0 F8 20 20 20 20 20 20    77 .byte 0xF8,0x20,0x20,0x20,0x20,0x20,0x20,0x00  ; T
             00
      0083C8 88 88 88 88 88 88 70    78 .byte 0x88,0x88,0x88,0x88,0x88,0x88,0x70,0x00  ; U
             00
      0083D0 88 88 88 88 88 50 20    79 .byte 0x88,0x88,0x88,0x88,0x88,0x50,0x20,0x00  ; V
             00
      0083D8 88 88 88 A8 A8 D8 88    80 .byte 0x88,0x88,0x88,0xA8,0xA8,0xD8,0x88,0x00  ; W
             00
      0083E0 88 88 50 20 50 88 88    81 .byte 0x88,0x88,0x50,0x20,0x50,0x88,0x88,0x00  ; X
             00
      0083E8 88 88 88 50 20 20 20    82 .byte 0x88,0x88,0x88,0x50,0x20,0x20,0x20,0x00  ; Y
             00
      0083F0 F8 10 20 40 80 80 F8    83 .byte 0xF8,0x10,0x20,0x40,0x80,0x80,0xF8,0x00  ; Z
             00
      0083F8 60 40 40 40 40 40 60    84 .byte 0x60,0x40,0x40,0x40,0x40,0x40,0x60,0x00  ; [
             00
      008400 00 80 40 20 10 08 00    85 .byte 0x00,0x80,0x40,0x20,0x10,0x08,0x00,0x00  ; '\'
             00
      008408 18 08 08 08 08 08 18    86 .byte 0x18,0x08,0x08,0x08,0x08,0x08,0x18,0x00  ; ]
             00
      008410 20 50 88 00 00 00 00    87 .byte 0x20,0x50,0x88,0x00,0x00,0x00,0x00,0x00  ; ^
             00
      008418 00 00 00 00 00 00 00    88 .byte 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFE  ; _
             FE
      008420 40 20 10 00 00 00 00    89 .byte 0x40,0x20,0x10,0x00,0x00,0x00,0x00,0x00  ; `
             00
      008428 00 00 70 08 78 88 78    90 .byte 0x00,0x00,0x70,0x08,0x78,0x88,0x78,0x00  ; a
             00
      008430 80 80 80 B0 C8 88 F0    91 .byte 0x80,0x80,0x80,0xB0,0xC8,0x88,0xF0,0x00  ; b
             00
      008438 00 00 70 80 80 88 70    92 .byte 0x00,0x00,0x70,0x80,0x80,0x88,0x70,0x00  ; c
             00
      008440 08 08 08 68 98 88 78    93 .byte 0x08,0x08,0x08,0x68,0x98,0x88,0x78,0x00  ; d
             00
      008448 00 00 70 88 F8 80 70    94 .byte 0x00,0x00,0x70,0x88,0xF8,0x80,0x70,0x00  ; e
             00
      008450 30 48 40 E0 40 40 40    95 .byte 0x30,0x48,0x40,0xE0,0x40,0x40,0x40,0x00  ; f
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 48.
Hexadecimal  00-Bits]



             00
      008458 00 00 78 88 88 78 08    96 .byte 0x00,0x00,0x78,0x88,0x88,0x78,0x08,0x70  ; g
             70
      008460 80 80 B0 C8 88 88 88    97 .byte 0x80,0x80,0xB0,0xC8,0x88,0x88,0x88,0x00  ; h
             00
      008468 00 20 00 20 20 20 20    98 .byte 0x00,0x20,0x00,0x20,0x20,0x20,0x20,0x00  ; i
             00
      008470 10 00 30 10 10 90 60    99 .byte 0x10,0x00,0x30,0x10,0x10,0x90,0x60,0x00  ; j
             00
      008478 80 80 90 A0 C0 A0 90   100 .byte 0x80,0x80,0x90,0xA0,0xC0,0xA0,0x90,0x00  ; k
             00
      008480 60 20 20 20 20 20 70   101 .byte 0x60,0x20,0x20,0x20,0x20,0x20,0x70,0x00  ; l
             00
      008488 00 00 D0 A8 A8 88 88   102 .byte 0x00,0x00,0xD0,0xA8,0xA8,0x88,0x88,0x00  ; m
             00
      008490 00 00 B0 C8 88 88 88   103 .byte 0x00,0x00,0xB0,0xC8,0x88,0x88,0x88,0x00  ; n
             00
      008498 00 00 70 88 88 88 70   104 .byte 0x00,0x00,0x70,0x88,0x88,0x88,0x70,0x00  ; o
             00
      0084A0 00 00 F0 88 88 F0 80   105 .byte 0x00,0x00,0xF0,0x88,0x88,0xF0,0x80,0x80  ; p
             80
      0084A8 00 00 68 90 90 B0 50   106 .byte 0x00,0x00,0x68,0x90,0x90,0xB0,0x50,0x18  ; q
             18
      0084B0 00 00 B0 C8 80 80 80   107 .byte 0x00,0x00,0xB0,0xC8,0x80,0x80,0x80,0x00  ; r
             00
      0084B8 00 00 70 80 70 08 F0   108 .byte 0x00,0x00,0x70,0x80,0x70,0x08,0xF0,0x00  ; s
             00
      0084C0 40 40 E0 40 40 48 30   109 .byte 0x40,0x40,0xE0,0x40,0x40,0x48,0x30,0x00  ; t
             00
      0084C8 00 00 88 88 88 98 68   110 .byte 0x00,0x00,0x88,0x88,0x88,0x98,0x68,0x00  ; u
             00
      0084D0 00 00 88 88 88 50 20   111 .byte 0x00,0x00,0x88,0x88,0x88,0x50,0x20,0x00  ; v
             00
      0084D8 00 00 88 88 A8 A8 50   112 .byte 0x00,0x00,0x88,0x88,0xA8,0xA8,0x50,0x00  ; w
             00
      0084E0 00 00 88 50 20 50 88   113 .byte 0x00,0x00,0x88,0x50,0x20,0x50,0x88,0x00  ; x
             00
      0084E8 00 00 88 88 88 78 08   114 .byte 0x00,0x00,0x88,0x88,0x88,0x78,0x08,0x70  ; y
             70
      0084F0 00 00 F8 10 20 40 F8   115 .byte 0x00,0x00,0xF8,0x10,0x20,0x40,0xF8,0x00  ; z
             00
      0084F8 20 40 40 80 40 40 20   116 .byte 0x20,0x40,0x40,0x80,0x40,0x40,0x20,0x00  ; {
             00
      008500 20 20 20 20 20 20 20   117 .byte 0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x00  ; |
             00
      008508 40 20 20 10 20 20 40   118 .byte 0x40,0x20,0x20,0x10,0x20,0x20,0x40,0x00  ; }
             00
      008510 00 00 40 A8 10 00 00   119 .byte 0x00,0x00,0x40,0xA8,0x10,0x00,0x00,0x00  ; ~  ASCII 127 
             00
      008518 FC FC FC FC FC FC FC   120 .byte 0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC  ; 95 block cursor  128 
             FC
      008520 40 20 10 F8 10 20 40   121 .byte 0x40,0x20,0x10,0xF8,0x10,0x20,0x40,0x00  ; 96 flèche droite 129 
             00
      008528 10 20 40 F8 40 20 10   122 .byte 0x10,0x20,0x40,0xF8,0x40,0x20,0x10,0x00  ; 97 flèche gauche 130
             00
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 49.
Hexadecimal [24-Bits]



      008530 20 70 A8 20 20 20 00   123 .byte 0x20,0x70,0xA8,0x20,0x20,0x20,0x00,0x00  ; 98 flèche haut   131
             00
      008538 00 20 20 20 A8 70 20   124 .byte 0x00,0x20,0x20,0x20,0xA8,0x70,0x20,0x00  ; 99 flèche bas    132
             00
      008540 00 70 F8 F8 F8 70 00   125 .byte 0x00,0x70,0xF8,0xF8,0xF8,0x70,0x00,0x00  ; 100 rond		  133 
             00
      008548 00 00 00 00 00 00 00   126 .byte 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xff  ; 101 underline cursor 134
             FF
      008550 80 80 80 80 80 80 80   127 .byte 0x80,0x80,0x80,0x80,0x80,0x80,0x80,0x80  ; 102 insert cursor 135 
             80
      008558                        128 font_end:
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 51.
Hexadecimal [24-Bits]



                                     56 ; initialize TIMER1 for 
                                     57 ; NTSC synchronisation 
                                     58 ; signal 
                                     59 ;------------------------------
      008558                         60 ntsc_init:
      0004D8                         61     _clrz ntsc_flags 
      008558 3F 6F                    1     .byte 0x3f, ntsc_flags 
      0004DA                         62     _clrz ntsc_phase 
      00855A 3F 70                    1     .byte 0x3f, ntsc_phase 
                                     63 ; enable TIMER1 and SPI clock 
      00855C 72 1E 50 C7      [ 1]   64     bset CLK_PCKENR1,#CLK_PCKENR1_TIM1
      008560 72 12 50 C7      [ 1]   65     bset CLK_PCKENR1,#CLK_PCKENR1_SPI
                                     66 ; set MOSI pin as output high-speed push-pull 
      008564 72 1C 50 0C      [ 1]   67     bset PC_DDR,#6 
      008568 72 1D 50 0A      [ 1]   68     bres PC_ODR,#6
      00856C 72 1C 50 0D      [ 1]   69     bset PC_CR1,#6
      008570 72 1C 50 0E      [ 1]   70     bset PC_CR2,#6
      008574 72 5F 52 03      [ 1]   71     clr SPI_SR 
      008578 72 5F 52 04      [ 1]   72     clr SPI_DR 
      00857C 35 4C 52 00      [ 1]   73     mov SPI_CR1,#(1<<SPI_CR1_SPE)|(1<<SPI_CR1_MSTR)|(1<<SPI_CR1_BR)
                                     74 ; initialize timer1 for pwm
                                     75 ; generate NTSC sync signal  on CH3 
      008580 35 01 52 54      [ 1]   76     mov TIM1_IER,#1 ; UIE set 
      008584 72 1E 52 50      [ 1]   77     bset TIM1_CR1,#TIM1_CR1_ARPE ; auto preload enabled 
      008588 35 78 52 5A      [ 1]   78     mov TIM1_CCMR3,#(7<<TIM1_CCMR3_OC3MODE)  |(1<<TIM1_CCMR3_OC3PE)
      00858C 72 10 52 5D      [ 1]   79     bset TIM1_CCER2,#0
      008590 72 1E 52 6D      [ 1]   80     bset TIM1_BKR,#TIM1_BKR_MOE
                                     81 ; use channel 2 for video stream trigger 
                                     82 ; set pixel out delay   
      008594 35 60 52 59      [ 1]   83     mov TIM1_CCMR2,#(6<<TIM1_CCMR2_OC2MODE) 
      008598 35 00 52 67      [ 1]   84     mov TIM1_CCR2H,#LINE_DELAY>>8 
      00859C 35 82 52 68      [ 1]   85     mov TIM1_CCR2L,#LINE_DELAY&0xFF
                                     86 ; begin with PH_PRE_EQU odd field 
      000520                         87     _clrz ntsc_phase 
      0085A0 3F 70                    1     .byte 0x3f, ntsc_phase 
      0085A2 35 03 52 62      [ 1]   88     mov TIM1_ARRH,#HLINE>>8
      0085A6 35 F8 52 63      [ 1]   89     mov TIM1_ARRL,#HLINE&0XFF
      0085AA 35 00 52 69      [ 1]   90     mov TIM1_CCR3H,#HPULSE>>8 
      0085AE 35 4B 52 6A      [ 1]   91     mov TIM1_CCR3L,#HPULSE&0XFF
      0085B2 CD 87 18         [ 4]   92     call tv_cls 
      0085B5 72 10 52 50      [ 1]   93     bset TIM1_CR1,#TIM1_CR1_CEN 
      0085B9 A6 01            [ 1]   94     ld a,#1
      0085BB CD 85 BF         [ 4]   95     call video_on_off 
      0085BE 81               [ 4]   96     ret 
                                     97 
                                     98 ;--------------------
                                     99 ; enable|disable 
                                    100 ; video output 
                                    101 ; input:
                                    102 ;   A    0->off 
                                    103 ;        1->on
                                    104 ;--------------------
      0085BF                        105 video_on_off:
      0085BF 4D               [ 1]  106     tnz a 
      0085C0 27 09            [ 1]  107     jreq 1$ 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 52.
Hexadecimal [24-Bits]



                                    108 ; enable video 
      0085C2 72 18 00 6F      [ 1]  109     bset ntsc_flags,#F_VIDEO 
      0085C6 72 10 52 54      [ 1]  110     bset TIM1_IER,#TIM1_IER_UIE 
      0085CA 81               [ 4]  111     ret     
      0085CB                        112 1$: ; disable video 
      0085CB 72 19 00 6F      [ 1]  113     bres ntsc_flags,#F_VIDEO 
      0085CF 72 15 52 54      [ 1]  114     bres TIM1_IER,#TIM1_IER_CC2IE 
      0085D3 72 10 52 54      [ 1]  115     bset TIM1_IER,#TIM1_IER_UIE 
      0085D7 81               [ 4]  116     ret 
                                    117 
                                    118 
                                    119 ;-------------------------------
                                    120 ; TIMER1 update interrupt handler 
                                    121 ; interrupt happend at end 
                                    122 ; of each phase and and pwm 
                                    123 ; is set for next phase 
                                    124 ;-------------------------------
      0085D8                        125 ntsc_sync_interrupt:
      0085D8 72 5F 52 55      [ 1]  126     clr TIM1_SR1 
      00055C                        127     _ldxz scan_line 
      0085DC BE 71                    1     .byte 0xbe,scan_line 
      0085DE 5C               [ 1]  128     incw x 
      00055F                        129     _strxz scan_line 
      0085DF BF 71                    1     .byte 0xbf,scan_line 
      000561                        130     _ldaz ntsc_phase 
      0085E1 B6 70                    1     .byte 0xb6,ntsc_phase 
      0085E3 A1 00            [ 1]  131     cp a,#PH_VSYNC  
      0085E5 26 5D            [ 1]  132     jrne test_pre_video 
      0085E7 A3 00 01         [ 2]  133     cpw x,#1 
      0085EA 26 13            [ 1]  134     jrne  1$ 
      0085EC 35 01 52 62      [ 1]  135     mov TIM1_ARRH,#HALF_LINE>>8 
      0085F0 35 FC 52 63      [ 1]  136     mov TIM1_ARRL,#HALF_LINE & 0xff 
      0085F4 35 00 52 69      [ 1]  137     mov TIM1_CCR3H,#EPULSE>>8 
      0085F8 35 25 52 6A      [ 1]  138     mov TIM1_CCR3L,#EPULSE&0xff 
      0085FC CC 86 B2         [ 2]  139     jp sync_exit 
      0085FF A3 00 07         [ 2]  140 1$: cpw x,#7 
      008602 26 0B            [ 1]  141     jrne 2$ 
      008604 35 01 52 69      [ 1]  142     mov TIM1_CCR3H,#VPULSE>>8 
      008608 35 B4 52 6A      [ 1]  143     mov TIM1_CCR3L,#VPULSE&0xff 
      00860C CC 86 B2         [ 2]  144     jp sync_exit 
      00860F                        145 2$:
      00860F A3 00 0D         [ 2]  146     cpw x,#13 
      008612 26 0B            [ 1]  147     jrne 3$ 
      008614 35 00 52 69      [ 1]  148     mov TIM1_CCR3H,#EPULSE>>8 
      008618 35 25 52 6A      [ 1]  149     mov TIM1_CCR3L,#EPULSE&0xff 
      00861C CC 86 B2         [ 2]  150     jp sync_exit 
      00861F                        151 3$: 
      00861F A3 00 12         [ 2]  152     cpw x,#18 
      008622 26 19            [ 1]  153     jrne 5$ 
      008624 72 00 00 6F 11   [ 2]  154     btjt ntsc_flags,#F_EVEN,44$ 
      008629                        155 4$:
      008629 35 03 52 62      [ 1]  156     mov TIM1_ARRH,#HLINE>>8 
      00862D 35 F8 52 63      [ 1]  157     mov TIM1_ARRL,#HLINE & 0xff 
      008631 35 00 52 69      [ 1]  158     mov TIM1_CCR3H,#HPULSE>>8 
      008635 35 4B 52 6A      [ 1]  159     mov TIM1_CCR3L,#HPULSE&0xff 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 53.
Hexadecimal [24-Bits]



      008639 4C               [ 1]  160     inc a 
      00863A                        161 44$:
      00863A CC 86 B2         [ 2]  162     jp sync_exit 
      00863D                        163 5$: 
      00863D A3 00 13         [ 2]  164     cpw x,#19 
      008640 27 E7            [ 1]  165     jreq 4$ 
      008642 20 6E            [ 2]  166     jra sync_exit 
      008644                        167 test_pre_video:
      008644 A1 01            [ 1]  168     cp a,#PH_PRE_VIDEO 
      008646 26 49            [ 1]  169     jrne post_video  
      008648 A3 00 14         [ 2]  170     cpw x,#20 
      00864B 26 07            [ 1]  171     jrne 1$ 
      0005CD                        172     _ldxz ticks 
      00864D BE 60                    1     .byte 0xbe,ticks 
      00864F 5C               [ 1]  173     incw x 
      0005D0                        174     _strxz ticks 
      008650 BF 60                    1     .byte 0xbf,ticks 
      008652 20 5E            [ 2]  175     jra sync_exit 
      008654 A3 00 15         [ 2]  176 1$: cpw x,#21 
      008657 26 0F            [ 1]  177     jrne 2$ 
      008659 72 0F 00 6A 54   [ 2]  178     btjf flags,#F_GAME_TMR,sync_exit 
      0005DE                        179     _decz delay_timer 
      00865E 3A 62                    1     .byte 0x3a,delay_timer 
      008660 26 50            [ 1]  180     jrne sync_exit 
      008662 72 1F 00 6A      [ 1]  181     bres flags,#F_GAME_TMR
      008666 20 4A            [ 2]  182     jra sync_exit 
      008668 A3 00 16         [ 2]  183 2$: cpw x,#22 
      00866B 26 0F            [ 1]  184     jrne 3$ 
      00866D 72 0D 00 6A 40   [ 2]  185     btjf flags,#F_SOUND_TMR,sync_exit 
      0005F2                        186     _decz sound_timer
      008672 3A 63                    1     .byte 0x3a,sound_timer 
      008674 26 3C            [ 1]  187     jrne sync_exit 
      008676 72 1D 00 6A      [ 1]  188     bres flags,#F_SOUND_TMR
      00867A 20 36            [ 2]  189     jra sync_exit 
      00867C                        190 3$:
      00867C A3 00 37         [ 2]  191     cpw x,#FIRST_VIDEO_LINE
      00867F 26 31            [ 1]  192     jrne sync_exit 
      008681 4C               [ 1]  193     inc a 
      008682 72 09 00 6F 2B   [ 2]  194     btjf ntsc_flags,#F_VIDEO,sync_exit
      008687 72 11 52 54      [ 1]  195     bres TIM1_IER,#TIM1_IER_UIE 
      00868B 72 14 52 54      [ 1]  196     bset TIM1_IER,#TIM1_IER_CC2IE
      00868F 20 21            [ 2]  197     jra sync_exit
      008691                        198 post_video:
      008691 A3 01 0F         [ 2]  199     cpw x,#271
      008694 26 07            [ 1]  200     jrne 2$ 
      008696 72 01 00 6F 0F   [ 2]  201     btjf ntsc_flags,#F_EVEN,#3$  
      00869B 20 15            [ 2]  202     jra sync_exit  
      00869D                        203 2$: 
      00869D A3 01 10         [ 2]  204     cpw x,#272 
      0086A0 26 10            [ 1]  205     jrne sync_exit 
      0086A2 35 01 52 62      [ 1]  206     mov TIM1_ARRH,#HALF_LINE>>8
      0086A6 35 FC 52 63      [ 1]  207     mov TIM1_ARRL,#HALF_LINE & 0xff 
      0086AA                        208 3$: ;field end     
      0086AA 4F               [ 1]  209     clr a 
      0086AB 5F               [ 1]  210     clrw x 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 54.
Hexadecimal [24-Bits]



      00062C                        211     _strxz scan_line
      0086AC BF 71                    1     .byte 0xbf,scan_line 
      0086AE 90 10 00 6F      [ 1]  212     bcpl ntsc_flags,#F_EVEN
      0086B2                        213 sync_exit:
      000632                        214     _straz ntsc_phase
      0086B2 B7 70                    1     .byte 0xb7,ntsc_phase 
      0086B4 80               [11]  215     iret 
                                    216 
                                    217 
                                    218 
                                    219 ;----------------------------------
                                    220 ; TIMER1 compare interrupt handler
                                    221 ;----------------------------------
                           000001   222     BPL=1 ; bytes per scan line 
                           000001   223     VAR_SIZE=1
      0086B5                        224 ntsc_video_interrupt:
      000635                        225     _vars VAR_SIZE
      0086B5 52 01            [ 2]    1     sub sp,#VAR_SIZE 
      0086B7 72 5F 52 55      [ 1]  226     clr TIM1_SR1
      0086BB C6 52 5F         [ 1]  227     ld a,TIM1_CNTRL 
      0086BE A4 07            [ 1]  228     and a,#7 
      0086C0 88               [ 1]  229     push a 
      0086C1 4B 00            [ 1]  230     push #0 
      0086C3 AE 86 CC         [ 2]  231     ldw x,#jitter_cancel 
      0086C6 72 FB 01         [ 2]  232     addw x,(1,sp)
      000649                        233     _drop 2 
      0086C9 5B 02            [ 2]    1     addw sp,#2 
      0086CB FC               [ 2]  234     jp (x)
      0086CC                        235 jitter_cancel:
      0086CC 9D               [ 1]  236     nop 
      0086CD 9D               [ 1]  237     nop 
      0086CE 9D               [ 1]  238     nop 
      0086CF 9D               [ 1]  239     nop 
      0086D0 9D               [ 1]  240     nop 
      0086D1 9D               [ 1]  241     nop 
      0086D2 9D               [ 1]  242     nop 
      0086D3 9D               [ 1]  243     nop 
                                    244 ; compute postion in buffer 
                                    245 ; 1 scan line/video buffer line 
                                    246 ; ofs=scan_line-FIRST_VIDEO_LINE*BYTES_PER_LINE+tv_buffer       
      000654                        247     _ldxz scan_line 
      0086D4 BE 71                    1     .byte 0xbe,scan_line 
      0086D6 1D 00 37         [ 2]  248     subw x,#FIRST_VIDEO_LINE
      0086D9 A6 19            [ 1]  249     ld a,#BYTES_PER_LINE  
      0086DB 42               [ 4]  250     mul x,a  ; tv_buffer line  
      0086DC 1C 00 80         [ 2]  251     addw x,#tv_buffer
      0086DF A6 19            [ 1]  252     ld a,#BYTES_PER_LINE
      0086E1 6B 01            [ 1]  253     ld (BPL,sp),a
      0086E3 72 5F 52 04      [ 1]  254     clr SPI_DR  
      0086E7 F6               [ 1]  255 1$: ld a,(x)
      0086E8 5C               [ 1]  256     incw x 
      0086E9 C7 52 04         [ 1]  257     ld SPI_DR,a 
      0086EC 72 03 52 03 FB   [ 2]  258     btjf SPI_SR,#SPI_SR_TXE,. 
      0086F1 0A 01            [ 1]  259     dec (BPL,sp)
      0086F3 26 F2            [ 1]  260     jrne 1$ 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 55.
Hexadecimal [24-Bits]



      0086F5 72 5F 52 04      [ 1]  261     clr SPI_DR
      0086F9 72 03 52 03 FB   [ 2]  262     btjf SPI_SR,#SPI_SR_TXE,. 
      0086FE 72 0E 52 03 FB   [ 2]  263     btjt SPI_SR,#SPI_SR_BSY,.
                                    264 ;    bres SPI_CR1,#SPI_CR1_SPE  
      000683                        265     _ldxz scan_line 
      008703 BE 71                    1     .byte 0xbe,scan_line 
      008705 5C               [ 1]  266     incw x 
      000686                        267     _strxz scan_line 
      008706 BF 71                    1     .byte 0xbf,scan_line 
      008708 A3 00 F7         [ 2]  268     cpw x,#FIRST_VIDEO_LINE+VIDEO_LINES
      00870B 2B 08            [ 1]  269     jrmi 4$ 
      00870D 72 15 52 54      [ 1]  270     bres TIM1_IER,#TIM1_IER_CC2IE
      008711 72 10 52 54      [ 1]  271     bset TIM1_IER,#TIM1_IER_UIE
      000695                        272 4$: _drop VAR_SIZE
      008715 5B 01            [ 2]    1     addw sp,#VAR_SIZE 
      008717 80               [11]  273     iret 
                                    274 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 56.
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
      008718                         31 tv_cls:
      008718 90 89            [ 2]   32     pushw y 
      00871A AE 12 C0         [ 2]   33     ldw x,#VBUFF_SIZE 
      00871D 90 AE 00 80      [ 2]   34     ldw y,#tv_buffer
      008721 90 7F            [ 1]   35 1$: clr (y)
      008723 90 5C            [ 1]   36     incw y 
      008725 5A               [ 2]   37     decw x 
      008726 26 F9            [ 1]   38     jrne 1$
      0006A8                         39     _clrz cx 
      008728 3F 74                    1     .byte 0x3f, cx 
      0006AA                         40     _clrz cy   
      00872A 3F 73                    1     .byte 0x3f, cy 
      00872C 90 85            [ 2]   41     popw y 
      00872E 81               [ 4]   42     ret 
                                     43 
                                     44 ;------------------------
                                     45 ; build bitmask from 
                                     46 ; bit position 
                                     47 ; input:
                                     48 ;    A    position {0..7}
                                     49 ;------------------------
      00872F                         50 bit_mask:
      00872F 88               [ 1]   51     push a 
      008730 A6 80            [ 1]   52     ld a,#128 
      008732 0D 01            [ 1]   53 1$: tnz (1,sp)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 57.
Hexadecimal [24-Bits]



      008734 27 05            [ 1]   54     jreq 9$ 
      008736                         55 2$:
      008736 44               [ 1]   56     srl a 
      008737 0A 01            [ 1]   57     dec (1,sp)
      008739 26 FB            [ 1]   58     jrne 2$
      0006BB                         59 9$: _drop 1 
      00873B 5B 01            [ 2]    1     addw sp,#1 
      00873D 81               [ 4]   60     ret 
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
      00873E                         79 pixel_addr:
      0006BE                         80     _vars VAR_SIZE
      00873E 52 05            [ 2]    1     sub sp,#VAR_SIZE 
      008740 1F 01            [ 2]   81     ldw (YCOOR,sp),x 
      008742 5F               [ 1]   82     clrw x 
      008743 1F 03            [ 2]   83     ldw (BOFS,sp),x 
      008745 7B 02            [ 1]   84     ld a,(XCOOR,sp)
      008747 97               [ 1]   85     ld xl,a 
      008748 A6 08            [ 1]   86     ld a,#8 
      00874A 62               [ 2]   87     div x,a 
                                     88 ;    sub a,#7 
                                     89 ;    neg a 
      00874B 6B 05            [ 1]   90     ld (BPOS,sp),a
      00874D 9F               [ 1]   91     ld a,xl 
      00874E 6B 04            [ 1]   92     ld (BOFSL,sp),a 
      008750 7B 01            [ 1]   93     ld a,(YCOOR,sp)
      008752 AE 00 19         [ 2]   94     ldw x,#BYTES_PER_LINE 
      008755 42               [ 4]   95     mul x,a 
      008756 1C 00 80         [ 2]   96     addw x,#tv_buffer
      008759 72 FB 03         [ 2]   97     addw x,(BOFS,sp)
      00875C 7B 05            [ 1]   98     ld a,(BPOS,sp)
      00875E CD 87 2F         [ 4]   99     call bit_mask 
      0006E1                        100     _drop VAR_SIZE  
      008761 5B 05            [ 2]    1     addw sp,#VAR_SIZE 
      008763 81               [ 4]  101     ret 
                                    102 
                                    103 ;-------------------------
                                    104 ; set pixel 
                                    105 ; input:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 58.
Hexadecimal [24-Bits]



                                    106 ;     XH    y coord {0..63}
                                    107 ;     XL    x coord (0..95)
                                    108 ;---------------------------
      008764                        109 set_pixel:
      008764 CD 87 3E         [ 4]  110     call pixel_addr
      008767 FA               [ 1]  111     or a,(x)
      008768 F7               [ 1]  112     ld (x),a 
      008769 81               [ 4]  113     ret 
                                    114 
                                    115 ;-------------------------
                                    116 ; reset pixel 
                                    117 ; input:
                                    118 ;     XH    y coord {0..63}
                                    119 ;     XL    x coord (0..95)
                                    120 ;---------------------------
      00876A                        121 reset_pixel:
      00876A CD 87 3E         [ 4]  122     call pixel_addr
      00876D 43               [ 1]  123     cpl a 
      00876E F4               [ 1]  124     and a,(x)
      00876F F7               [ 1]  125     ld (x),a 
      008770 81               [ 4]  126     ret 
                                    127 
                                    128 ;-------------------------
                                    129 ; invert pixel 
                                    130 ; input:
                                    131 ;     XH    y coord {0..63}
                                    132 ;     XL    x coord (0..95)
                                    133 ;---------------------------
      008771                        134 invert_pixel:
      008771 CD 87 3E         [ 4]  135     call pixel_addr 
      008774 F8               [ 1]  136     xor a,(x)
      008775 F7               [ 1]  137     ld (x),a 
      008776 81               [ 4]  138     ret 
                                    139 
                                    140 
                                    141 ;-----------------------------
                                    142 ; move text 1 line up 
                                    143 ; clear bottom line 
                                    144 ;-----------------------------
      008777                        145 scroll_text_up:
      008777 88               [ 1]  146     push a 
      008778 89               [ 2]  147     pushw x 
      008779 90 89            [ 2]  148     pushw y 
                                    149 ; count bytes to copy     
      00877B AE 11 F8         [ 2]  150     ldw x,#(VRES-FONT_HEIGHT)*BYTES_PER_LINE
      0006FE                        151     _strxz acc16  
      00877E BF 64                    1     .byte 0xbf,acc16 
                                    152 ; destination address     
      008780 AE 00 80         [ 2]  153     ldw x,#tv_buffer 
      008783 90 93            [ 1]  154     ldw y,x 
                                    155 ; source address     
      008785 72 A9 00 C8      [ 2]  156     addw y,#BYTES_PER_LINE*FONT_HEIGHT 
      008789 CD 8A 2F         [ 4]  157     call move 
                                    158 ; clear bottom text line 
      00878C 4F               [ 1]  159     clr a 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 59.
Hexadecimal [24-Bits]



      00878D AE 00 C8         [ 2]  160     ldw x,#(FONT_HEIGHT*BYTES_PER_LINE) 
      008790 90 AE 00 80      [ 2]  161     ldw y,#tv_buffer 
      008794 72 A2 11 F8      [ 2]  162     subw y,#VBUFF_SIZE-(FONT_HEIGHT*BYTES_PER_LINE)
      008798 CD 8A 73         [ 4]  163     call fill 
      00879B 81               [ 4]  164     ret 
                                    165 
                                    166 ;----------------------------
                                    167 ; move text cursor to 
                                    168 ; next line 
                                    169 ;----------------------------
      00879C                        170 crlf:
      00071C                        171     _clrz cx 
      00879C 3F 74                    1     .byte 0x3f, cx 
      00071E                        172     _ldaz cy 
      00879E B6 73                    1     .byte 0xb6,cy 
      0087A0 4C               [ 1]  173     inc a
      0087A1 A1 18            [ 1]  174     cp a,#LINE_PER_SCREEN
      0087A3 2B 04            [ 1]  175     jrmi 1$
      0087A5 CD 87 77         [ 4]  176     call scroll_text_up
      0087A8 81               [ 4]  177     ret  
      0087A9                        178 1$: 
      000729                        179     _straz cy 
      0087A9 B7 73                    1     .byte 0xb7,cy 
      0087AB 81               [ 4]  180     ret 
                                    181 
                                    182 ;------------------------------
                                    183 ; move text cursor right 
                                    184 ;------------------------------
      0087AC                        185 cursor_right:
      00072C                        186     _incz cx 
      0087AC 3C 74                    1     .byte 0x3c, cx 
      00072E                        187     _ldaz cx 
      0087AE B6 74                    1     .byte 0xb6,cx 
      0087B0 A1 21            [ 1]  188     cp a,#CHAR_PER_LINE  
      0087B2 2A E8            [ 1]  189     jrpl crlf 
      0087B4 81               [ 4]  190     ret 
                                    191 
                                    192 ;-------------------------
                                    193 ; put character on tv 
                                    194 ; input:
                                    195 ;    A    character 
                                    196 ;------------------------
                           000001   197     XCOORH=1
                           000002   198     XCOOR=XCOORH+1
                           000003   199     BYTECNT=XCOOR+1
                           000004   200     SHIFT=BYTECNT+1
                           000005   201     MASK=SHIFT+1
                           000007   202     ROW=MASK+2
                           000008   203     VAR_SIZE=ROW+1  
      0087B5                        204 tv_putc:
      0087B5 90 89            [ 2]  205     pushw y 
      000737                        206     _vars VAR_SIZE 
      0087B7 52 08            [ 2]    1     sub sp,#VAR_SIZE 
      0087B9 A1 0D            [ 1]  207     cp a,#CR 
      0087BB 26 06            [ 1]  208     jrne 1$ 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 60.
Hexadecimal [24-Bits]



      0087BD CD 87 9C         [ 4]  209     call crlf 
      0087C0 CC 88 2A         [ 2]  210     jp 9$
      0087C3                        211  1$:
      0087C3 A0 20            [ 1]  212     sub a,#SPACE 
      0087C5 AE 00 08         [ 2]  213     ldw x,#FONT_HEIGHT
      0087C8 42               [ 4]  214     mul x,a 
      0087C9 1C 82 20         [ 2]  215     addw x,#font_6x8
      0087CC 90 93            [ 1]  216     ldw y,x 
      0087CE AE 03 FF         [ 2]  217     ldw x,#0x03ff
      0087D1 1F 05            [ 2]  218     ldw (MASK,sp),x 
      0087D3 A6 08            [ 1]  219     ld a,#FONT_HEIGHT
      0087D5 6B 03            [ 1]  220     ld (BYTECNT,sp),a 
      000757                        221     _ldaz cx 
      0087D7 B6 74                    1     .byte 0xb6,cx 
      0087D9 AE 00 06         [ 2]  222     ldw x,#FONT_WIDTH  
      0087DC 42               [ 4]  223     mul x,a
      0087DD A6 08            [ 1]  224     ld a,#8 
      0087DF 62               [ 2]  225     div x,a 
      0087E0 6B 04            [ 1]  226     ld (SHIFT,sp),a 
      0087E2 1F 01            [ 2]  227     ldw (XCOORH,sp),x     
      000764                        228     _ldaz cy 
      0087E4 B6 73                    1     .byte 0xb6,cy 
      0087E6 AE 00 08         [ 2]  229     ldw x,#FONT_HEIGHT
      0087E9 42               [ 4]  230     mul x,a 
      0087EA A6 19            [ 1]  231     ld a,#BYTES_PER_LINE
      0087EC 42               [ 4]  232     mul x,a 
      0087ED 72 FB 01         [ 2]  233     addw x,(XCOORH,sp)
      0087F0 1C 00 80         [ 2]  234     addw x,#tv_buffer 
                                    235 ; shift MASK 
      0087F3 7B 04            [ 1]  236     ld a,(SHIFT,sp)
      0087F5 27 08            [ 1]  237     jreq 4$
      0087F7 99               [ 1]  238     scf 
      0087F8 06 05            [ 1]  239 3$: rrc (MASK,sp)
      0087FA 06 06            [ 1]  240     rrc (MASK+1,sp)
      0087FC 4A               [ 1]  241     dec a 
      0087FD 26 F9            [ 1]  242     jrne 3$
                                    243 ; get font row 
                                    244 ; and shift it 
      0087FF                        245 4$:     
      0087FF 90 F6            [ 1]  246     ld a,(y)
      008801 90 5C            [ 1]  247     incw y 
      008803 6B 07            [ 1]  248     ld (ROW,sp),a 
      008805 0F 08            [ 1]  249     clr (ROW+1,sp)
      008807 7B 04            [ 1]  250     ld a,(SHIFT,sp)
      008809 27 07            [ 1]  251     jreq 6$ 
      00880B                        252 5$:  
      00880B 04 07            [ 1]  253     srl (ROW,sp)
      00880D 06 08            [ 1]  254     rrc (ROW+1,sp)
      00880F 4A               [ 1]  255     dec a 
      008810 26 F9            [ 1]  256     jrne 5$ 
      008812                        257 6$: 
      008812 7B 05            [ 1]  258     ld a,(MASK,sp)
      008814 F4               [ 1]  259     and a,(x)
      008815 1A 07            [ 1]  260     or a,(ROW,sp)
      008817 F7               [ 1]  261     ld (x),a 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 61.
Hexadecimal [24-Bits]



      008818 E6 01            [ 1]  262     ld a,(1,x)
      00881A 14 06            [ 1]  263     and a,(MASK+1,sp)
      00881C 1A 08            [ 1]  264     or a,(ROW+1,sp)
      00881E E7 01            [ 1]  265     ld (1,x),a 
      008820 1C 00 19         [ 2]  266     addw x,#BYTES_PER_LINE
      008823 0A 03            [ 1]  267     dec (BYTECNT,sp)
      008825 26 D8            [ 1]  268     jrne 4$ 
      008827 CD 87 AC         [ 4]  269     call cursor_right
      00882A                        270 9$:
      0007AA                        271     _drop VAR_SIZE 
      00882A 5B 08            [ 2]    1     addw sp,#VAR_SIZE 
      00882C 90 85            [ 2]  272     popw y 
      00882E 81               [ 4]  273     ret 
                                    274 
                                    275 ;--------------------------
                                    276 ; put string on tv 
                                    277 ; input:
                                    278 ;   Y     *aciz 
                                    279 ;--------------------------
      00882F                        280 tv_puts:
      00882F 90 F6            [ 1]  281     ld a,(y)
      008831 27 07            [ 1]  282     jreq 9$
      008833 90 5C            [ 1]  283     incw y 
      008835 CD 87 B5         [ 4]  284     call tv_putc 
      008838 20 F5            [ 2]  285     jra tv_puts 
      00883A                        286 9$:
      00883A 81               [ 4]  287     ret
                                    288 
                                    289 
                                    290 ;-------------------------------
                                    291 ; line drawing 
                                    292 ;  X0<=X1 
                                    293 ;  Y0<=Y1 
                                    294 ; input:
                                    295 ;     XH  x0 
                                    296 ;     XL  x1 
                                    297 ;     YH  y0 
                                    298 ;     YL  y1 
                                    299 ;--------------------------------
                           000001   300     X0=1  ; int8 
                           000002   301     X1=2  ; int8 
                           000003   302     Y0=3  ; int8 
                           000004   303     Y1=4  ; int8 
                           000005   304     DX=5   ; int16 
                           000007   305     DY=7   ; int16 
                           000009   306     DELTA=9 ; int16 
                           00000A   307     VAR_SIZE=10
      00883B                        308 line:
      0007BB                        309     _vars VAR_SIZE 
      00883B 52 0A            [ 2]    1     sub sp,#VAR_SIZE 
      00883D 1F 01            [ 2]  310     ldw (X0,sp),x
      00883F 17 03            [ 2]  311     ldw (Y0,sp),y
      008841 9E               [ 1]  312     ld a,xh 
      008842 11 02            [ 1]  313     cp a,(X1,sp)
      008844 27 41            [ 1]  314     jreq 3$ ; vertical line 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 62.
Hexadecimal [24-Bits]



      008846 90 9E            [ 1]  315     ld a,yh 
      008848 11 04            [ 1]  316     cp a,(Y1,sp)
      00884A 27 4E            [ 1]  317     jreq 4$ ; horizontal line
      00884C 7B 02            [ 1]  318     ld a,(X1,sp)
      00884E 10 01            [ 1]  319     sub a,(X0,sp)
      008850 5F               [ 1]  320     clrw x 
      008851 97               [ 1]  321     ld xl,a 
      008852 1F 05            [ 2]  322     ldw (DX,sp),x 
      008854 7B 04            [ 1]  323     ld a,(Y1,sp)
      008856 10 03            [ 1]  324     sub a,(Y0,sp)
      008858 97               [ 1]  325     ld xl,a 
      008859 1F 07            [ 2]  326     ldw (DY,sp),x 
      00885B 58               [ 2]  327     sllw x 
      00885C 72 F0 05         [ 2]  328     subw x,(DX,sp)
      00885F 1F 09            [ 2]  329     ldw (DELTA,sp),x 
      008861                        330 1$:  
      008861 7B 01            [ 1]  331     ld a,(X0,sp)
      008863 11 02            [ 1]  332     cp a,(X1,sp)
      008865 27 44            [ 1]  333     jreq 9$ 
      008867 97               [ 1]  334     ld xl,a 
      008868 7B 03            [ 1]  335     ld a,(Y0,sp)
      00886A 95               [ 1]  336     ld xh,a
      00886B CD 87 64         [ 4]  337     call set_pixel 
      00886E 1E 09            [ 2]  338     ldw x,(DELTA,sp)
      008870 5D               [ 2]  339     tnzw x
      008871 2B 08            [ 1]  340     jrmi 2$
      008873 0C 03            [ 1]  341     inc (Y0,sp)
      008875 72 F0 05         [ 2]  342     subw x,(DX,sp)
      008878 72 F0 05         [ 2]  343     subw x,(DX,sp)
      00887B                        344 2$: 
      00887B 72 FB 07         [ 2]  345     addw x,(DY,sp)
      00887E 72 FB 07         [ 2]  346     addw x,(DY,sp)
      008881 1F 09            [ 2]  347     ldw (DELTA,sp),x  
      008883 0C 01            [ 1]  348     inc (X0,sp)
      008885 20 DA            [ 2]  349     jra 1$
      008887                        350 3$: ; vertical line 
      008887 7B 01            [ 1]  351     ld a,(X0,sp)
      008889 97               [ 1]  352     ld xl,a 
      00888A 7B 03            [ 1]  353     ld a,(Y0,sp)
      00888C 95               [ 1]  354     ld xh,a 
      00888D CD 87 64         [ 4]  355     call set_pixel 
      008890 0C 03            [ 1]  356     inc (Y0,sp)
      008892 7B 03            [ 1]  357     ld a,(Y0,sp)
      008894 11 04            [ 1]  358     cp a,(Y1,sp)
      008896 25 EF            [ 1]  359     jrult 3$ 
      008898 20 11            [ 2]  360     jra 9$ 
      00889A                        361 4$: ; horizontal line 
      00889A 7B 01            [ 1]  362     ld a,(X0,sp)
      00889C 97               [ 1]  363     ld xl, a 
      00889D 7B 03            [ 1]  364     ld a,(Y0,sp)
      00889F 95               [ 1]  365     ld xh,a 
      0088A0 CD 87 64         [ 4]  366     call set_pixel
      0088A3 0C 01            [ 1]  367     inc (X0,sp)
      0088A5 7B 01            [ 1]  368     ld a,(X0,sp)
      0088A7 11 02            [ 1]  369     cp a,(X1,sp)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 63.
Hexadecimal [24-Bits]



      0088A9 25 EF            [ 1]  370     jrult 4$  
      0088AB                        371 9$:
      00082B                        372     _drop VAR_SIZE 
      0088AB 5B 0A            [ 2]    1     addw sp,#VAR_SIZE 
      0088AD 81               [ 4]  373     ret 
                                    374 
                                    375 
                                    376 ;----------------------------
                                    377 ; print unsigned integer 
                                    378 ; input:
                                    379 ;    X uint16_t 
                                    380 ;-----------------------------
                           000001   381     UINT=1
                           000003   382     ISTR=UINT+2 
                           000008   383     VAR_SIZE=ISTR+5
      0088AE                        384 put_uint16:
      0088AE 90 89            [ 2]  385     pushw y 
      000830                        386     _vars VAR_SIZE 
      0088B0 52 08            [ 2]    1     sub sp,#VAR_SIZE 
      0088B2 1F 01            [ 2]  387     ldw (UINT,sp),x 
      0088B4 96               [ 1]  388     ldw x,sp 
      0088B5 1C 00 08         [ 2]  389     addw x,#ISTR+5
      0088B8 90 93            [ 1]  390     ldw y,x 
      0088BA 90 7F            [ 1]  391     clr (y)
      0088BC 1E 01            [ 2]  392     ldw x,(UINT,sp) 
      0088BE 90 5A            [ 2]  393 1$: decw y 
      0088C0 A6 0A            [ 1]  394     ld a,#10 
      0088C2 62               [ 2]  395     div x,a 
      0088C3 AB 30            [ 1]  396     add a,#'0 
      0088C5 90 F7            [ 1]  397     ld (y),a
      0088C7 5D               [ 2]  398     tnzw x 
      0088C8 26 F4            [ 1]  399     jrne 1$ 
      0088CA CD 88 2F         [ 4]  400     call tv_puts 
      00084D                        401     _drop VAR_SIZE 
      0088CD 5B 08            [ 2]    1     addw sp,#VAR_SIZE 
      0088CF 90 85            [ 2]  402     popw y 
      0088D1 81               [ 4]  403     ret 
                                    404 
                                    405 
                                    406 ;--------------------------------------
                                    407 ; use invert_pixel 
                                    408 ; to put sprite on screen 
                                    409 ; normal sprite are 8 bits wide 
                                    410 ; n rows 
                                    411 ; input:
                                    412 ;     A     row count 
                                    413 ;     XH    ycoord 
                                    414 ;     XL    xcoord
                                    415 ;     Y     sprite address  
                                    416 ; output:
                                    417 ;     A     collision if not null
                                    418 ;     Z     if not zero the collision  
                                    419 ;-------------------------------------
                           000001   420     ROWS=1
                           000002   421     SPRITE=ROWS+1 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 64.
Hexadecimal [24-Bits]



                           000004   422     SHIFT=SPRITE+2
                           000005   423     COLL=SHIFT+1
                           000005   424     VAR_SIZE=COLL
      0088D2                        425 put_sprite:
      000852                        426     _vars VAR_SIZE 
      0088D2 52 05            [ 2]    1     sub sp,#VAR_SIZE 
      0088D4 0F 05            [ 1]  427     clr (COLL,sp) 
      0088D6 6B 01            [ 1]  428     ld (ROWS,sp),a 
      0088D8 CD 87 3E         [ 4]  429     call pixel_addr 
      0088DB 6B 04            [ 1]  430     ld (SHIFT,sp),a
      0088DD                        431 1$:    
      0088DD 0F 03            [ 1]  432     clr (SPRITE+1,sp)
      0088DF 90 F6            [ 1]  433     ld a,(y)
      0088E1 90 5C            [ 1]  434     incw y 
      0088E3 6B 02            [ 1]  435     ld (SPRITE,sp),a 
      0088E5 7B 04            [ 1]  436     ld a,(SHIFT,sp)
      0088E7 2B 07            [ 1]  437 2$: jrmi 4$
      0088E9                        438 3$: ; shift sprite and mask
      0088E9 04 02            [ 1]  439     srl (SPRITE,sp)
      0088EB 06 03            [ 1]  440     rrc (SPRITE+1,sp)
      0088ED 48               [ 1]  441     sll a
      0088EE 2A F9            [ 1]  442     jrpl 3$ 
      0088F0                        443 4$: 
      0088F0 7B 02            [ 1]  444     ld a,(SPRITE,sp)
      0088F2 F8               [ 1]  445     xor a,(x)
      0088F3 F7               [ 1]  446     ld (x),a
      0088F4 14 02            [ 1]  447     and a,(SPRITE,sp)
      0088F6 11 02            [ 1]  448     cp a,(SPRITE,sp)
      0088F8 27 02            [ 1]  449     jreq 5$
      0088FA 0C 05            [ 1]  450     inc (COLL,sp)
      0088FC 7B 03            [ 1]  451 5$: ld a,(SPRITE+1,sp)
      0088FE E8 01            [ 1]  452     xor a,(1,x)
      008900 E7 01            [ 1]  453     ld (1,x),a 
      008902 14 03            [ 1]  454     and a,(SPRITE+1,sp) 
      008904 11 03            [ 1]  455     cp a,(SPRITE+1,sp)
      008906 27 02            [ 1]  456     jreq 6$
      008908 0C 05            [ 1]  457     inc (COLL,sp)
      00890A 1C 00 19         [ 2]  458 6$: addw x,#BYTES_PER_LINE 
      00890D 0A 01            [ 1]  459     dec (ROWS,sp)
      00890F 26 CC            [ 1]  460     jrne 1$
      008911 7B 05            [ 1]  461     ld a,(COLL,sp)
      000893                        462     _drop VAR_SIZE 
      008913 5B 05            [ 2]    1     addw sp,#VAR_SIZE 
      008915 81               [ 4]  463     ret 
                                    464 
                                    465 
                                    466 ;---------------------
                                    467 ; scroll up 1 line 
                                    468 ; from [XL..XH[
                                    469 ; input: 
                                    470 ;   XL  first line 
                                    471 ;   XH  last line 
                                    472 ;---------------------
      008916                        473 scroll_up:
      008916 88               [ 1]  474     push a 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 65.
Hexadecimal [24-Bits]



      008917 90 89            [ 2]  475     pushw y 
      008919 89               [ 2]  476     pushw x 
                                    477 ; move bytes count     
      00891A 9E               [ 1]  478     ld a,xh 
      00891B 10 02            [ 1]  479     sub a,(2,sp)
      00891D AE 00 19         [ 2]  480     ldw x,#BYTES_PER_LINE
      008920 42               [ 4]  481     mul x,a 
      008921 1D 00 19         [ 2]  482     subw x,#BYTES_PER_LINE 
      0008A4                        483     _strxz acc16 
      008924 BF 64                    1     .byte 0xbf,acc16 
                                    484 ; dest addr 
      008926 7B 02            [ 1]  485     ld a,(2,sp)
      008928 AE 00 19         [ 2]  486     ldw x,#BYTES_PER_LINE
      00892B 42               [ 4]  487     mul x, a 
      00892C 1C 00 80         [ 2]  488     addw x,#tv_buffer
                                    489 ; source addr 
      00892F 90 93            [ 1]  490     ldw y,x 
      008931 72 A9 00 19      [ 2]  491     addw y,#BYTES_PER_LINE
      008935 CD 8A 2F         [ 4]  492     call move 
                                    493 ; clear line XH-1 
      008938 7B 01            [ 1]  494     ld a,(1,sp)
      00893A 4A               [ 1]  495     dec a 
      00893B AE 00 19         [ 2]  496     ldw x,#BYTES_PER_LINE
      00893E 90 93            [ 1]  497     ldw y,x 
      008940 90 42            [ 4]  498     mul y,a 
      008942 72 A9 00 80      [ 2]  499     addw y,#tv_buffer
      008946 4F               [ 1]  500     clr a 
      008947 CD 8A 73         [ 4]  501     call fill  
      00894A 85               [ 2]  502     popw x  
      00894B 90 85            [ 2]  503     popw y 
      00894D 84               [ 1]  504     pop a 
      00894E 81               [ 4]  505     ret 
                                    506 
                                    507 ;----------------------
                                    508 ; scroll down 1 line 
                                    509 ; from [XL..XH[
                                    510 ; input:
                                    511 ;    XL   first line 
                                    512 ;    XH   last line 
                                    513 ;----------------------
      00894F                        514 scroll_down: 
      00894F 88               [ 1]  515     push a 
      008950 90 89            [ 2]  516     pushw y 
      008952 89               [ 2]  517     pushw x 
                                    518 ; move bytes count 
      008953 9E               [ 1]  519     ld a,xh 
      008954 10 02            [ 1]  520     sub a,(2,sp) ; XL 
      008956 AE 00 19         [ 2]  521     ldw x,#BYTES_PER_LINE
      008959 42               [ 4]  522     mul x,a
      00895A 1D 00 19         [ 2]  523     subw x,#BYTES_PER_LINE  
      0008DD                        524     _strxz acc16 
      00895D BF 64                    1     .byte 0xbf,acc16 
                                    525 ; source addr 
      00895F 7B 02            [ 1]  526     ld a,(2,sp) ; XL 
      008961 90 AE 00 19      [ 2]  527     ldw y,#BYTES_PER_LINE
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 66.
Hexadecimal [24-Bits]



      008965 90 42            [ 4]  528     mul y,a 
      008967 72 A9 00 80      [ 2]  529     addw Y,#tv_buffer
                                    530 ; destinaton addr     
      00896B 93               [ 1]  531     ldw x,y 
      00896C 1C 00 19         [ 2]  532     addw x,#BYTES_PER_LINE 
      00896F CD 8A 2F         [ 4]  533     call move 
                                    534 ; clear line XL 
      008972 7B 02            [ 1]  535     ld a,(2,sp) ; XL  
      008974 AE 00 19         [ 2]  536     ldw x,#BYTES_PER_LINE
      008977 90 93            [ 1]  537     ldw y,x 
      008979 90 42            [ 4]  538     mul y,a 
      00897B 72 A9 00 80      [ 2]  539     addw y,#tv_buffer
      00897F 4F               [ 1]  540     clr a 
      008980 CD 8A 73         [ 4]  541     call fill  
      008983 85               [ 2]  542     popw x  
      008984 90 85            [ 2]  543     popw y 
      008986 84               [ 1]  544     pop a 
      008987 81               [ 4]  545     ret 
                                    546 
                                    547 ;------------------------------
                                    548 ; shift video line 
                                    549 ; 4 pixels left 
                                    550 ; input:
                                    551 ;    A   video line {0..VRES-1}
                                    552 ;-------------------------------
                                    553 
      008988                        554 left_4pixels:
      008988 89               [ 2]  555     pushw x 
      008989 90 89            [ 2]  556     pushw y 
      00898B AE 00 19         [ 2]  557     ldw x,#BYTES_PER_LINE
      00898E 90 93            [ 1]  558     ldw y,x 
      008990 42               [ 4]  559     mul x,a 
      008991 1C 00 80         [ 2]  560     addw x,#tv_buffer
      008994                        561 1$:
      008994 F6               [ 1]  562     ld a,(x)
      008995 4E               [ 1]  563     swap a 
      008996 A4 F0            [ 1]  564     and a,#0xf0 
      008998 88               [ 1]  565     push a 
      008999 E6 01            [ 1]  566     ld a,(1,x)
      00899B 4E               [ 1]  567     swap a 
      00899C A4 0F            [ 1]  568     and a,#0xf 
      00899E 1A 01            [ 1]  569     or a,(1,sp)
      000920                        570     _drop 1 
      0089A0 5B 01            [ 2]    1     addw sp,#1 
      0089A2 90 5A            [ 2]  571     decw y 
      0089A4 27 04            [ 1]  572     jreq 2$
      0089A6 F7               [ 1]  573     ld (x),a 
      0089A7 5C               [ 1]  574     incw x
      0089A8 20 EA            [ 2]  575     jra 1$
      0089AA A4 F0            [ 1]  576 2$: and a,#0xf0
      0089AC F7               [ 1]  577     ld (x),a 
      0089AD 90 85            [ 2]  578     popw y 
      0089AF 85               [ 2]  579     popw x 
      0089B0 81               [ 4]  580     ret 
                                    581 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 67.
Hexadecimal [24-Bits]



                                    582 ;-------------------
                                    583 ; scroll left  4 pixels
                                    584 ; from [XL..XH[ 
                                    585 ; input:
                                    586 ;   XL   first line 
                                    587 ;   XH   last line 
                                    588 ;-------------------
      0089B1                        589 scroll_left:
      0089B1 89               [ 2]  590     pushw x 
      0089B2 7B 02            [ 1]  591     ld a,(2,sp)
      0089B4                        592 1$:
      0089B4 CD 89 88         [ 4]  593     call left_4pixels 
      0089B7 0C 02            [ 1]  594     inc (2,sp)
      0089B9 7B 02            [ 1]  595     ld a,(2,sp)
      0089BB 11 01            [ 1]  596     cp a,(1,sp)
      0089BD 2B F5            [ 1]  597     jrmi 1$
      0089BF 85               [ 2]  598     popw x 
      0089C0 81               [ 4]  599     ret 
                                    600 
                                    601 ;-------------------
                                    602 ; shift video line 
                                    603 ; 4 pixels right 
                                    604 ; input:
                                    605 ;     A   line 
                                    606 ;-------------------
      0089C1                        607 right_4pixels:
      0089C1 90 89            [ 2]  608     pushw y 
      0089C3 89               [ 2]  609     pushw x 
      0089C4 4C               [ 1]  610     inc a 
      0089C5 AE 00 19         [ 2]  611     ldw x,#BYTES_PER_LINE
      0089C8 90 93            [ 1]  612     ldw y,x 
      0089CA 42               [ 4]  613     mul x,a
      0089CB 1D 00 02         [ 2]  614     subw x,#2  
      0089CE 1C 00 80         [ 2]  615     addw x,#tv_buffer 
      0089D1 E6 01            [ 1]  616 1$: ld a,(1,x)
      0089D3 A4 F0            [ 1]  617     and a,#0xf0
      0089D5 4E               [ 1]  618     swap a 
      0089D6 88               [ 1]  619     push a
      0089D7 F6               [ 1]  620     ld a,(x)
      0089D8 A4 0F            [ 1]  621     and a,#0xf 
      0089DA 4E               [ 1]  622     swap a 
      0089DB 1A 01            [ 1]  623     or a,(1,sp)
      0089DD E7 01            [ 1]  624     ld (1,x),a
      00095F                        625     _drop 1
      0089DF 5B 01            [ 2]    1     addw sp,#1 
      0089E1 90 5A            [ 2]  626     decw y 
      0089E3 27 03            [ 1]  627     jreq 2$ 
      0089E5 5A               [ 2]  628     decw x 
      0089E6 20 E9            [ 2]  629     jra 1$
      0089E8 A6 0F            [ 1]  630 2$: ld a,#0xf 
      0089EA E4 01            [ 1]  631     and a,(1,x)
      0089EC E7 01            [ 1]  632     ld (1,x),a 
      0089EE 85               [ 2]  633     popw x 
      0089EF 90 85            [ 2]  634     popw y 
      0089F1 81               [ 4]  635     ret 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 68.
Hexadecimal [24-Bits]



                                    636 
                                    637 ;-------------------
                                    638 ; scroll right 
                                    639 ; 4 pixels 
                                    640 ; input:
                                    641 ;   XL   first line 
                                    642 ;   XH   last line 
                                    643 ;-------------------
      0089F2                        644 scroll_right:
      0089F2 89               [ 2]  645     pushw x 
      0089F3 7B 02            [ 1]  646     ld a,(2,sp)
      0089F5                        647 1$: 
      0089F5 CD 89 C1         [ 4]  648     call right_4pixels 
      0089F8 0C 02            [ 1]  649     inc (2,sp)
      0089FA 7B 02            [ 1]  650     ld a,(2,sp)
      0089FC 11 01            [ 1]  651     cp a,(1,sp)
      0089FE 2B F5            [ 1]  652     jrmi 1$
      008A00 85               [ 2]  653     popw x 
      008A01 81               [ 4]  654     ret 
                                    655 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 69.
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
                           000001    19 .if DEBUG 
                           000001    20     CURPOS=1 
                           000002    21     VAR_SIZE=2
      008A02                         22 dbg_print:
      008A02 89               [ 2]   23     pushw x 
      000983                         24     _vars VAR_SIZE 
      008A03 52 02            [ 2]    1     sub sp,#VAR_SIZE 
      000985                         25     _ldxz cy 
      008A05 BE 73                    1     .byte 0xbe,cy 
      008A07 1F 01            [ 2]   26     ldw (CURPOS,sp),x 
      008A09 AE 07 08         [ 2]   27     ldw x,#(7<<8)+8
      00098C                         28     _strxz cy 
      008A0C BF 73                    1     .byte 0xbf,cy 
      00098E                         29     _ldxz acc16 
      008A0E BE 64                    1     .byte 0xbe,acc16 
      008A10 CD 88 AE         [ 4]   30     call put_uint16
      008A13 1E 01            [ 2]   31     ldw x,(CURPOS,sp)
      000995                         32     _strxz cy 
      008A15 BF 73                    1     .byte 0xbf,cy 
      000997                         33     _drop VAR_SIZE 
      008A17 5B 02            [ 2]    1     addw sp,#VAR_SIZE 
      008A19 85               [ 2]   34     popw x 
      008A1A 81               [ 4]   35     ret 
                                     36 
      008A1B                         37 print_hex:
      008A1B 88               [ 1]   38 	push a 
      008A1C 4E               [ 1]   39 	swap a 
      008A1D CD 8A 21         [ 4]   40 	call hex_digit 
      008A20 84               [ 1]   41 	pop a 
      008A21                         42 hex_digit:
      008A21 A4 0F            [ 1]   43 	and a,#15
      008A23 AB 30            [ 1]   44 	add a,#'0 
      008A25 A1 3A            [ 1]   45 	cp a,#'9+1
      008A27 2B 02            [ 1]   46 	jrmi 1$
      008A29 AB 07            [ 1]   47 	add a,#7 
      008A2B CD 87 B5         [ 4]   48 1$: call tv_putc 
      008A2E 81               [ 4]   49 	ret 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 70.
Hexadecimal [24-Bits]



                                     50 
                                     51 .endif 
                                     52 
                                     53 ;---------------------------------------
                                     54 ; move memory block 
                                     55 ; input:
                                     56 ;   X 		destination 
                                     57 ;   Y 	    source 
                                     58 ;   acc16	bytes count 
                                     59 ; output:
                                     60 ;   X       destination 
                                     61 ;--------------------------------------
                           000001    62 	INCR=1 ; incrament high byte 
                           000002    63 	LB=2 ; increment low byte 
                           000002    64 	VSIZE=2
      008A2F                         65 move::
      008A2F 88               [ 1]   66 	push a 
      008A30 89               [ 2]   67 	pushw x 
      0009B1                         68 	_vars VSIZE 
      008A31 52 02            [ 2]    1     sub sp,#VSIZE 
      008A33 0F 01            [ 1]   69 	clr (INCR,sp)
      008A35 0F 02            [ 1]   70 	clr (LB,sp)
      008A37 90 89            [ 2]   71 	pushw y 
      008A39 13 01            [ 2]   72 	cpw x,(1,sp) ; compare DEST to SRC 
      008A3B 90 85            [ 2]   73 	popw y 
      008A3D 27 2F            [ 1]   74 	jreq move_exit ; x==y 
      008A3F 2B 0E            [ 1]   75 	jrmi move_down
      008A41                         76 move_up: ; start from top address with incr=-1
      008A41 72 BB 00 64      [ 2]   77 	addw x,acc16
      008A45 72 B9 00 64      [ 2]   78 	addw y,acc16
      008A49 03 01            [ 1]   79 	cpl (INCR,sp)
      008A4B 03 02            [ 1]   80 	cpl (LB,sp)   ; increment = -1 
      008A4D 20 05            [ 2]   81 	jra move_loop  
      008A4F                         82 move_down: ; start from bottom address with incr=1 
      008A4F 5A               [ 2]   83     decw x 
      008A50 90 5A            [ 2]   84 	decw y
      008A52 0C 02            [ 1]   85 	inc (LB,sp) ; incr=1 
      008A54                         86 move_loop:	
      0009D4                         87     _ldaz acc16 
      008A54 B6 64                    1     .byte 0xb6,acc16 
      008A56 CA 00 65         [ 1]   88 	or a, acc8
      008A59 27 13            [ 1]   89 	jreq move_exit 
      008A5B 72 FB 01         [ 2]   90 	addw x,(INCR,sp)
      008A5E 72 F9 01         [ 2]   91 	addw y,(INCR,sp) 
      008A61 90 F6            [ 1]   92 	ld a,(y)
      008A63 F7               [ 1]   93 	ld (x),a 
      008A64 89               [ 2]   94 	pushw x 
      0009E5                         95 	_ldxz acc16 
      008A65 BE 64                    1     .byte 0xbe,acc16 
      008A67 5A               [ 2]   96 	decw x 
      008A68 CF 00 64         [ 2]   97 	ldw acc16,x 
      008A6B 85               [ 2]   98 	popw x 
      008A6C 20 E6            [ 2]   99 	jra move_loop
      008A6E                        100 move_exit:
      0009EE                        101 	_drop VSIZE
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 71.
Hexadecimal [24-Bits]



      008A6E 5B 02            [ 2]    1     addw sp,#VSIZE 
      008A70 85               [ 2]  102 	popw x 
      008A71 84               [ 1]  103 	pop a 
      008A72 81               [ 4]  104 	ret 	
                                    105 
                                    106 ;--------------------
                                    107 ; fill memory block 
                                    108 ; input: 
                                    109 ;     A   fill value 
                                    110 ;     X   count 
                                    111 ;     Y   addr (incr)
                                    112 ;---------------------
      008A73                        113 fill:
      008A73 90 F7            [ 1]  114 	ld (y),a 
      008A75 90 5C            [ 1]  115 	incw y 
      008A77 5A               [ 2]  116 	decw x 
      008A78 26 F9            [ 1]  117 	jrne fill
      008A7A 81               [ 4]  118 	ret 
                                    119 
                                    120 ;--------------------------
                                    121 ; application entry point 
                                    122 ;--------------------------
      008A7B                        123 main:
                           000000   124 .if 0
                                    125 ; kpad test 
                                    126 	call tv_cls 
                                    127 1$:	call wait_key 
                                    128 	call print_hex 
                                    129 	call wait_key_release
                                    130 	clrw x 
                                    131 	_strxz cy 
                                    132 	jra 1$ 
                                    133 .endif  
      008A7B CD 8A 81         [ 4]  134     call menu 
      008A7E FD               [ 4]  135     call (x)
      008A7F 20 FA            [ 2]  136     jra main 
                                    137 
                                    138 
                                    139 
                                    140 ;---------------------------
                                    141 ; display list of games
                                    142 ;--------------------------
                           000001   143 	GAM_ADR=1
                           000011   144 	KPAD=GAM_ADR+16
                           000012   145 	SEL=KPAD+1 
                           000013   146 	COUNT=SEL+1
                           000013   147 	VAR_SIZE=COUNT 
      008A81                        148 menu:
      000A01                        149 	_vars VAR_SIZE 
      008A81 52 13            [ 2]    1     sub sp,#VAR_SIZE 
      008A83 0F 12            [ 1]  150 	clr (SEL,sp)
      008A85 0F 13            [ 1]  151 	clr (COUNT,sp)
      008A87 96               [ 1]  152 	ldw x,sp 
      008A88 5C               [ 1]  153 	incw x 
      000A09                        154 	_strxz ptr16 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 72.
Hexadecimal [24-Bits]



      008A89 BF 68                    1     .byte 0xbf,ptr16 
      008A8B CD 87 18         [ 4]  155 	call tv_cls  
      008A8E 90 AE 8B 17      [ 2]  156 	ldw y,#prog_list
                                    157 ; build games list on stack     
      008A92 90 F6            [ 1]  158 1$: ld a,(y)
      008A94 27 27            [ 1]  159     jreq user_select 
      008A96 7B 13            [ 1]  160 	ld a,(COUNT,sp)
      008A98 95               [ 1]  161 	ld xh,a 
      008A99 A6 20            [ 1]  162 	ld a,#SPACE  
      008A9B CD 8B 0D         [ 4]  163 	call select_mark 
      008A9E CD 88 2F         [ 4]  164 	call tv_puts  
      008AA1 90 5C            [ 1]  165 	incw y 
      008AA3 7B 13            [ 1]  166 	ld a,(COUNT,sp)
      008AA5 48               [ 1]  167 	sll a 
      008AA6 5F               [ 1]  168 	clrw x 
      008AA7 97               [ 1]  169 	ld xl,a 
      008AA8 90 F6            [ 1]  170 	ld a,(y)
      008AAA 90 5C            [ 1]  171 	incw y 
      008AAC 72 D7 00 68      [ 4]  172 	ld ([ptr16],X),a 
      008AB0 5C               [ 1]  173 	incw x 
      008AB1 90 F6            [ 1]  174 	ld a,(y)
      008AB3 90 5C            [ 1]  175 	incw y 
      008AB5 72 D7 00 68      [ 4]  176 	ld ([ptr16],x),a
      008AB9 0C 13            [ 1]  177 	inc (COUNT,sp)
      008ABB 20 D5            [ 2]  178 	jra 1$ 
                                    179 ; display selection cursor and 
                                    180 ; wait for user input    
      008ABD                        181 user_select:
      008ABD AE 02 00         [ 2]  182     ldw x,#0x200 
      008AC0 CD 81 61         [ 4]  183 	call wait_key_release
      008AC3 7B 12            [ 1]  184 	ld a,(SEL,sp)
      008AC5 95               [ 1]  185 	ld xh,a 
      008AC6 A6 3E            [ 1]  186 	ld a,#'>
      008AC8 CD 8B 0D         [ 4]  187 	call select_mark
      008ACB CD 81 5B         [ 4]  188 	call wait_key 
      008ACE 6B 11            [ 1]  189 	ld (KPAD,sp),a
      008AD0 7B 12            [ 1]  190 	ld a,(SEL,sp)
      008AD2 95               [ 1]  191 	ld xh,a
      008AD3 A6 20            [ 1]  192 	ld a,#SPACE 
      008AD5 CD 8B 0D         [ 4]  193 	call select_mark
      008AD8 7B 11            [ 1]  194 	ld a,(KPAD,sp)
      008ADA A4 02            [ 1]  195 	and a,#BTN_DOWN ; down button? 
      008ADC 27 0B            [ 1]  196 	jreq 4$ 
                                    197 ; down button 
      008ADE 7B 12            [ 1]  198 	ld a,(SEL,sp)
      008AE0 4C               [ 1]  199 	inc a 
      008AE1 11 13            [ 1]  200 	cp a,(COUNT,sp)
      008AE3 27 D8            [ 1]  201 	jreq user_select
      008AE5 6B 12            [ 1]  202 	ld (SEL,sp),a 
      008AE7 20 D4            [ 2]  203 	jra user_select 
                                    204 ; up button ?
      008AE9                        205 4$: 
      008AE9 7B 11            [ 1]  206 	ld a,(KPAD,sp)
      008AEB A4 08            [ 1]  207 	and a,#BTN_UP
      008AED 27 09            [ 1]  208 	jreq 6$ 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 73.
Hexadecimal [24-Bits]



      008AEF 7B 12            [ 1]  209 	ld a,(SEL,sp)
      008AF1 4A               [ 1]  210 	dec a 
      008AF2 2B C9            [ 1]  211 	jrmi user_select 
      008AF4 6B 12            [ 1]  212 	ld (SEL,sp),a 
      008AF6 20 C5            [ 2]  213 	jra user_select 
      008AF8                        214 6$:
      008AF8 7B 11            [ 1]  215 	ld a,(KPAD,sp)
      008AFA A4 20            [ 1]  216 	and a,#BTN_A
      008AFC 27 BF            [ 1]  217 	jreq user_select
      008AFE CD 81 61         [ 4]  218 	call wait_key_release 
      008B01 7B 12            [ 1]  219 	ld a,(SEL,sp)
      008B03 48               [ 1]  220 	sll a 
      008B04 5F               [ 1]  221 	clrw x 
      008B05 97               [ 1]  222 	ld xl,a 
      008B06 72 DE 00 68      [ 5]  223 	ldw x,([ptr16],x)
      000A8A                        224 	_drop VAR_SIZE 
      008B0A 5B 13            [ 2]    1     addw sp,#VAR_SIZE 
      008B0C 81               [ 4]  225 	ret 
                                    226 
                                    227 ;-------------------------------
                                    228 ; display or erase 
                                    229 ; selection marker 
                                    230 ; input:
                                    231 ;    A    char to diplay 
                                    232 ;    XH   selected item {0..7}
                                    233 ;------------------------------
      008B0D                        234 select_mark:
      008B0D 88               [ 1]  235     push a 
      008B0E 4F               [ 1]  236     clr a 
      008B0F 97               [ 1]  237     ld xl,a 
      000A90                        238 	_strxz cy 
      008B10 BF 73                    1     .byte 0xbf,cy 
      008B12 84               [ 1]  239     pop a 
      008B13 CD 87 B5         [ 4]  240 	call tv_putc 
      008B16 81               [ 4]  241 	ret 
                                    242 
                                    243 
      008B17                        244 prog_list:
      008B17 53 4E 41 4B 45 00      245 .asciz "SNAKE"
      008B1D 8E 76                  246 .word snake
      008B1F 46 41 4C 4C 00         247 .asciz "FALL"
      008B24 8F A1                  248 .word fall
      008B26 51 55 49 43 4B 20 42   249 .asciz "QUICK BROWN FOX"
             52 4F 57 4E 20 46 4F
             58 00
      008B36 8B 3A                  250 .word quick
      008B38 00 00                  251 .word 0 
                                    252 
      008B3A                        253 quick:
      008B3A CD 87 18         [ 4]  254     call tv_cls 
      008B3D 90 AE 8B 4B      [ 2]  255     ldw y,#qbf 
      008B41 CD 88 2F         [ 4]  256     call tv_puts 
      008B44 CD 81 5B         [ 4]  257     call wait_key 
      008B47 CD 81 61         [ 4]  258     call wait_key_release 
      008B4A 81               [ 4]  259     ret 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 74.
Hexadecimal [24-Bits]



                                    260 
      008B4B 54 48 45 20 51 55 49   261 qbf: .asciz "THE QUICK BROWN FOX JUMP OVER THE LAZY DOG.\r"
             43 4B 20 42 52 4F 57
             4E 20 46 4F 58 20 4A
             55 4D 50 20 4F 56 45
             52 20 54 48 45 20 4C
             41 5A 59 20 44 4F 47
             2E 0D 00
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 75.
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
      000006                         14 speed: .blkb 1 ; snake speed delay
      000007                         15 max_score: .blkw 1 ; maximum score 
      000009                         16 game_flags: .blkb 1 ; game boolean flags 
      00000A                         17 snake_len: .blkb 1 ; snake length 
      00000B                         18 snake_dir: .blkb 1 ; head direction 
      00000C                         19 food_coord: .blkw 1 ; food coordinates
      00000E                         20 snake_body: .blkw 32 ;  snake rings coords 
                                     21 
                                     22     .area CODE 
                                     23 
                           000001    24 MIN_SPEED=1 
                           000009    25 MAX_SPEED=9 
                                     26 
                                     27 ; game boolean flags 
                           000000    28 F_FOOD_COLL=0  ; collision with food, earn point
                           000001    29 F_NO_FOOD=1    ; no food available 
                           000002    30 F_GAME_OVER=2  ; game ended
                           000003    31 F_POO=3        ; snake poo 
                                     32 
                                     33 ; snake heading 
                           000000    34 NORTH=0 
                           000001    35 EAST=1
                           000002    36 SOUTH=2 
                           000004    37 WEST=4 
                                     38 
                                     39 ; game sprites 
                                     40 ; first 2 numbers: width,height 
                           000004    41 SNAKE_SPRITE_WIDTH=4 
                           000004    42 SNAKE_SPRITE_HEIGHT=4
      008B78 04 04 60 60 90 60       43 HEAD_UP:    .byte SNAKE_SPRITE_WIDTH,SNAKE_SPRITE_HEIGHT,0X60,0X60,0X90,0X60
      008B7E 04 04 40 B0 B0 40       44 HEAD_RIGHT: .byte SNAKE_SPRITE_WIDTH,SNAKE_SPRITE_HEIGHT,0X40,0XB0,0XB0,0X40 
      008B84 04 04 60 90 60 60       45 HEAD_DOWN:  .byte SNAKE_SPRITE_WIDTH,SNAKE_SPRITE_HEIGHT,0X60,0X90,0X60,0X60 
      008B8A 04 04 20 D0 D0 20       46 HEAD_LEFT:  .byte SNAKE_SPRITE_WIDTH,SNAKE_SPRITE_HEIGHT,0X20,0XD0,0XD0,0X20 
      008B90 04 04 60 90 90 60       47 RING:       .byte SNAKE_SPRITE_WIDTH,SNAKE_SPRITE_HEIGHT,0x60,0x90,0X90,0X60 
                           000005    48 MOUSE_WIDTH=5 
                           000004    49 MOUSE_HEIGHT=4
      008B96 05 04 00 70 F8 A0       50 MOUSE:      .byte MOUSE_WIDTH,MOUSE_HEIGHT,0X00,0X70,0XF8,0XA0 
                           000007    51 POO_WIDTH=7
                           000004    52 POO_HEIGHT=4
      008B9C 07 04 10 38 7C FE       53 POO:    .byte POO_WIDTH,POO_HEIGHT,0x10,0x38,0x7c,0xfe
                                     54 
                                     55 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 76.
Hexadecimal [24-Bits]



                                     56 ;----------------------
                                     57 ; draw walls around 
                                     58 ; game area 
                                     59 ;---------------------
      008BA2                         60 draw_walls:
                                     61 ; top wall 
      008BA2 AE 00 C8         [ 2]   62     ldw x,#HRES 
      008BA5 90 AE 08 08      [ 2]   63     ldw y,#8*256+8  
      008BA9 CD 88 3B         [ 4]   64     call line
                                     65 ; bottom wall 
      008BAC AE 00 C8         [ 2]   66     ldw x,#HRES 
      008BAF 90 AE BF BF      [ 2]   67     ldw y,#(VRES-1)*256+(VRES-1)
      008BB3 CD 88 3B         [ 4]   68     call line 
                                     69 ; left wall     
      008BB6 AE 00 00         [ 2]   70     ldw x,#0 
      008BB9 90 AE 08 BF      [ 2]   71     ldw y,#8*256+(VRES-1)
      008BBD CD 88 3B         [ 4]   72     call line 
                                     73 ; right wall     
      008BC0 AE C7 C7         [ 2]   74     ldw x,#((HRES-1)*256)+(HRES-1)
      008BC3 90 AE 08 BF      [ 2]   75     ldw y,#8*256+(VRES-1)
      008BC7 CD 88 3B         [ 4]   76     call line 
      008BCA 81               [ 4]   77     ret 
                                     78 
                                     79 ;---------------------------
                                     80 ; draw sprite 
                                     81 ; input:
                                     82 ;   XH   y coord 
                                     83 ;   XL   x coord 
                                     84 ;   Y    sprite data 
                                     85 ;----------------------------
      008BCB                         86 draw_sprite:
      008BCB 90 E6 01         [ 1]   87     ld a,(1,y)
      008BCE 72 A9 00 02      [ 2]   88     addw y,#2
      008BD2 CC 88 D2         [ 2]   89     jp put_sprite
                                     90 
                                     91 ;---------------------------
                                     92 ; select head sprite from 
                                     93 ; value of snake_dir 
                                     94 ; and draw it 
                                     95 ; input:
                                     96 ;    X    position 
                                     97 ;---------------------------
      008BD5                         98 draw_head:
      008BD5 90 AE 00 06      [ 2]   99     ldw y,#6 
      000B59                        100     _ldaz snake_dir 
      008BD9 B6 0B                    1     .byte 0xb6,snake_dir 
      008BDB 90 42            [ 4]  101     mul y,a 
      008BDD 72 A9 8B 78      [ 2]  102     addw y,#HEAD_UP 
      008BE1 20 E8            [ 2]  103     jra draw_sprite  
                                    104 
                                    105 
                                    106 ;--------------------------
                                    107 ; snake initial draw 
                                    108 ;--------------------------
                           000001   109     LEN=1
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 77.
Hexadecimal [24-Bits]



                           000002   110     IDX=LEN+1 
                           000003   111     VAR_SIZE=IDX+1
      008BE3                        112 draw_snake:
      000B63                        113     _vars VAR_SIZE
      008BE3 52 03            [ 2]    1     sub sp,#VAR_SIZE 
      008BE5 CE 00 0E         [ 2]  114     ldw x,snake_body  
      008BE8 CD 8B D5         [ 4]  115     call draw_head 
      000B6B                        116     _ldaz snake_len
      008BEB B6 0A                    1     .byte 0xb6,snake_len 
      008BED 4A               [ 1]  117     dec a  
      008BEE 6B 01            [ 1]  118     ld (LEN,sp),a  
      008BF0 AE 00 10         [ 2]  119     ldw x,#snake_body+2 
      008BF3                        120 1$:
      008BF3 1F 02            [ 2]  121     ldw (IDX,sp),x ; array index  
      008BF5 90 AE 8B 90      [ 2]  122     ldw y,#RING 
      008BF9 FE               [ 2]  123     ldw x,(x)
      008BFA CD 8B CB         [ 4]  124     call draw_sprite
      008BFD 0A 01            [ 1]  125     dec (LEN,sp) 
      008BFF 27 07            [ 1]  126     jreq 9$
      008C01 1E 02            [ 2]  127     ldw x,(IDX,sp)
      008C03 1C 00 02         [ 2]  128     addw x,#2 ; next element  
      008C06 20 EB            [ 2]  129     jra 1$
      008C08                        130 9$:
      000B88                        131     _drop VAR_SIZE 
      008C08 5B 03            [ 2]    1     addw sp,#VAR_SIZE 
      008C0A 81               [ 4]  132     ret 
                                    133 
                                    134 ;---------------------
                                    135 ; shit happen 
                                    136 ;---------------------
      008C0B                        137 snake_poo:
      008C0B 88               [ 1]  138     push a 
      008C0C 89               [ 2]  139     pushw x 
      000B8D                        140     _ldaz snake_len 
      008C0D B6 0A                    1     .byte 0xb6,snake_len 
      008C0F 4A               [ 1]  141     dec a 
      008C10 5F               [ 1]  142     clrw x 
      008C11 97               [ 1]  143     ld xl,a 
      008C12 1C 00 0E         [ 2]  144     addw x,#snake_body
      008C15 FE               [ 2]  145     ldw x,(x)
      008C16 90 AE 8B 9C      [ 2]  146     ldw y,#POO 
      008C1A CD 8B CB         [ 4]  147     call draw_sprite 
      008C1D 85               [ 2]  148     popw x 
      008C1E 84               [ 1]  149     pop a
      008C1F 72 17 00 09      [ 1]  150     bres game_flags,#F_POO 
      008C23 81               [ 4]  151     ret 
                                    152 
                                    153 ;-----------------------------
                                    154 ; check for collision object
                                    155 ; if not mouse then game over.
                                    156 ; if MOUSE increase score and 
                                    157 ; delete mouse. 
                                    158 ; input:  
                                    159 ;    X   position 
                                    160 ; output:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 78.
Hexadecimal [24-Bits]



                                    161 ;    game_flags:F_FOOD_COLL
                                    162 ;    X   unchanged 
                                    163 ;-------------------------------
                           000001   164     POS=1
                           000002   165     GAIN=2
                           000002   166     VAR_SIZE=2 
      008C24                        167 food_collision:
      008C24 89               [ 2]  168     pushw x
      000BA5                        169     _vars VAR_SIZE 
      008C25 52 02            [ 2]    1     sub sp,#VAR_SIZE 
      008C27 0F 02            [ 1]  170     clr (GAIN,sp)  
      000BA9                        171     _clrz game_flags 
      008C29 3F 09                    1     .byte 0x3f, game_flags 
      008C2B A6 05            [ 1]  172     ld a,#MOUSE_WIDTH
      008C2D AB 04            [ 1]  173     add a,#SNAKE_SPRITE_WIDTH
      008C2F 6B 01            [ 1]  174     ld (POS,sp),a 
      008C31 9F               [ 1]  175     ld a,xl ; snake head x coord 
      008C32 C0 00 0D         [ 1]  176     sub a,food_coord+1 ; food x coord 
      008C35 2A 01            [ 1]  177     jrpl 1$ 
      008C37 40               [ 1]  178     neg a  ; abs(delta)
      008C38                        179 1$: ; delta X 
      008C38 11 01            [ 1]  180     cp a,(POS,sp) 
      008C3A 2A 11            [ 1]  181     jrpl 3$ ; if delta X >= 0 collision object not mouse 
      008C3C A6 04            [ 1]  182     ld a,#MOUSE_HEIGHT
      008C3E AB 04            [ 1]  183     add a,#SNAKE_SPRITE_HEIGHT
      008C40 6B 01            [ 1]  184     ld (POS,sp),a 
      008C42 9E               [ 1]  185     ld a,xh   ; head y coord 
      008C43 C0 00 0C         [ 1]  186     sub a,food_coord ; food y coord 
      008C46 2A 01            [ 1]  187     jrpl 2$
      008C48 40               [ 1]  188     neg a 
      008C49                        189 2$: ; delta Y 
      008C49 11 01            [ 1]  190     cp a,(POS,sp)
      008C4B 2B 06            [ 1]  191     jrmi 4$ 
      008C4D                        192 3$: ; if delta Y >= 0 collision object not mouse 
      008C4D 72 14 00 09      [ 1]  193     bset game_flags,#F_GAME_OVER
      008C51 2A 54            [ 1]  194     jrpl 9$ 
      008C53                        195 4$:  ; collision with mouse
                                    196 ; erase food 
      008C53 CE 00 0C         [ 2]  197     ldw x,food_coord
      008C56 90 AE 8B 96      [ 2]  198     ldw y,#MOUSE 
      008C5A CD 8B CB         [ 4]  199     call draw_sprite
      008C5D 72 12 00 09      [ 1]  200     bset game_flags,#F_NO_FOOD 
      008C61 72 10 00 09      [ 1]  201     bset game_flags,#F_FOOD_COLL
      000BE5                        202     _incz snake_len 
      008C65 3C 0A                    1     .byte 0x3c, snake_len 
      008C67 0C 02            [ 1]  203     inc (GAIN,sp)
      008C69 C6 00 0C         [ 1]  204     ld a,food_coord ; mouse y coord 
      008C6C A1 09            [ 1]  205     cp a,#9 
      008C6E 26 02            [ 1]  206     jrne 5$
      008C70 0C 02            [ 1]  207     inc (GAIN,sp) ; food at top border     
      008C72 A1 BB            [ 1]  208 5$: cp a,#VRES-MOUSE_HEIGHT-1
      008C74 26 02            [ 1]  209     jrne 6$ 
      008C76 0C 02            [ 1]  210     inc (GAIN,sp) ; food at bottom border 
      008C78 C6 00 0D         [ 1]  211 6$: ld a,food_coord+1 ; mouse x coord
      008C7B A1 01            [ 1]  212     cp a,#1 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 79.
Hexadecimal [24-Bits]



      008C7D 26 02            [ 1]  213     jrne 7$ 
      008C7F 0C 02            [ 1]  214     inc (GAIN,sp) ; food at left border 
      008C81 A1 C2            [ 1]  215 7$: cp a,#HRES-MOUSE_WIDTH-1
      008C83 26 02            [ 1]  216     jrne 8$
      008C85 0C 02            [ 1]  217     inc (GAIN,sp) ; food at right border 
      008C87                        218 8$: ; score+=(MAX_SPEED+1-speed)*(GAIN,sp)
      008C87 A6 0A            [ 1]  219     ld a,#MAX_SPEED+1
      008C89 C0 00 06         [ 1]  220     sub a,speed 
      008C8C 5F               [ 1]  221     clrw x 
      008C8D 97               [ 1]  222     ld xl,a 
      008C8E 7B 02            [ 1]  223     ld a,(GAIN,sp)
      008C90 42               [ 4]  224     mul x,a ; gain 
      008C91 9F               [ 1]  225     ld a,xl 
      008C92 72 BB 00 04      [ 2]  226     addw x,score
      000C16                        227     _strxz score
      008C96 BF 04                    1     .byte 0xbf,score 
      008C98 A1 06            [ 1]  228     cp a,#6
      008C9A 2B 04            [ 1]  229     jrmi 81$ 
      008C9C 72 16 00 09      [ 1]  230     bset game_flags,#F_POO 
      008CA0                        231 81$:
      000C20                        232     _clrz food_coord 
      008CA0 3F 0C                    1     .byte 0x3f, food_coord 
      000C22                        233     _clrz food_coord+1     
      008CA2 3F 0D                    1     .byte 0x3f, food_coord+1 
      008CA4 CD 80 FC         [ 4]  234     call beep 
      008CA7                        235 9$:
      000C27                        236     _drop VAR_SIZE
      008CA7 5B 02            [ 2]    1     addw sp,#VAR_SIZE 
      008CA9 85               [ 2]  237     popw x 
      008CAA 81               [ 4]  238     ret 
                                    239 
                                    240 
                                    241 ;---------------------
                                    242 ; according to 
                                    243 ; actual head position 
                                    244 ; and direction compute 
                                    245 ; next snake head 
                                    246 ; coordinates
                                    247 ; input:
                                    248 ;   X     actual position
                                    249 ; output:
                                    250 ;   X     next position 
                                    251 ;---------------------
      008CAB                        252 next_head_pos:
      000C2B                        253     _ldaz snake_dir 
      008CAB B6 0B                    1     .byte 0xb6,snake_dir 
      008CAD A1 00            [ 1]  254     cp a,#NORTH 
      008CAF 26 05            [ 1]  255     jrne 2$ 
                                    256 ; going north 
      008CB1 1D 04 00         [ 2]  257     subw x,#SNAKE_SPRITE_HEIGHT<<8
      008CB4 20 15            [ 2]  258     jra 9$        
      008CB6 A1 01            [ 1]  259 2$: cp a,#EAST 
      008CB8 26 05            [ 1]  260     jrne 4$ 
                                    261 ;going east 
      008CBA 1C 00 04         [ 2]  262     addw x,#SNAKE_SPRITE_WIDTH 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 80.
Hexadecimal [24-Bits]



      008CBD 20 0C            [ 2]  263     jra 9$ 
      008CBF A1 02            [ 1]  264 4$: cp a,#SOUTH 
      008CC1 26 05            [ 1]  265     jrne 6$
                                    266 ;going south 
      008CC3 1C 04 00         [ 2]  267     addw x,#SNAKE_SPRITE_HEIGHT<<8
      008CC6 20 03            [ 2]  268     jra 9$ 
      008CC8                        269 6$: ; going west 
      008CC8 1D 00 04         [ 2]  270     subw x,#SNAKE_SPRITE_WIDTH 
      008CCB                        271 9$:
      008CCB 81               [ 4]  272     ret 
                                    273 
                                    274 ;------------------------------
                                    275 ; move memory block from 
                                    276 ; low address to higher address    
                                    277 ; input:
                                    278 ;    A   count 
                                    279 ;    X   destination 
                                    280 ;    Y   source 
                                    281 ;-------------------------------
      008CCC                        282 move_array_up:
      008CCC 88               [ 1]  283     push a 
      008CCD 90 F6            [ 1]  284 1$: ld a,(y)
      008CCF 90 5A            [ 2]  285     decw y 
      008CD1 F7               [ 1]  286     ld (x),a 
      008CD2 5A               [ 2]  287     decw x 
      008CD3 0A 01            [ 1]  288     dec (1,sp)
      008CD5 26 F6            [ 1]  289     jrne 1$ 
      000C57                        290     _drop 1 
      008CD7 5B 01            [ 2]    1     addw sp,#1 
      008CD9 81               [ 4]  291     ret 
                                    292 
                                    293 ;-----------------------
                                    294 ; move snake 
                                    295 ;-----------------------
                           000001   296     POS=1 ; new head coordinates 
                           000003   297     HEAD=POS+2 ; actual head position 
                           000003   298     TAIL=HEAD 
                           000004   299     VAR_SIZE=HEAD+1
      008CDA                        300 move_snake:
      008CDA 89               [ 2]  301     pushw x 
      008CDB 90 89            [ 2]  302     pushw y 
      000C5D                        303     _vars VAR_SIZE 
      008CDD 52 04            [ 2]    1     sub sp,#VAR_SIZE 
                                    304 ; erase head by drawing over it 
      008CDF CE 00 0E         [ 2]  305     ldw x,snake_body 
      008CE2 1F 03            [ 2]  306     ldw (HEAD,sp),x 
      008CE4 CD 8B D5         [ 4]  307     call draw_head 
                                    308 ; draw ring at head position     
      008CE7 1E 03            [ 2]  309     ldw x,(HEAD,sp)  ; head position 
      008CE9 90 AE 8B 90      [ 2]  310     ldw y,#RING 
      008CED CD 8B CB         [ 4]  311     call draw_sprite 
                                    312 ;draw head at new position 
      008CF0 1E 03            [ 2]  313     ldw x,(HEAD,sp)
      008CF2 CD 8C AB         [ 4]  314     call next_head_pos
      008CF5 1F 01            [ 2]  315     ldw (POS,sp),x
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 81.
Hexadecimal [24-Bits]



      008CF7 CD 8B D5         [ 4]  316     call draw_head
      008CFA 27 0A            [ 1]  317     jreq 1$
                                    318 ;collision deteted  
      008CFC 1E 01            [ 2]  319     ldw x,(POS,sp)
      008CFE CD 8C 24         [ 4]  320     call food_collision 
      008D01 72 04 00 09 36   [ 2]  321     btjt game_flags,#F_GAME_OVER,9$
      008D06                        322 1$: 
                                    323 ; move array elements 1 cell toward tail 
      000C86                        324     _ldaz snake_len
      008D06 B6 0A                    1     .byte 0xb6,snake_len 
      008D08 4A               [ 1]  325     dec a
      008D09 48               [ 1]  326     sll a 
      008D0A 5F               [ 1]  327     clrw x 
      008D0B 97               [ 1]  328     ld xl,a 
      008D0C 1C 00 0E         [ 2]  329     addw x,#snake_body ; last array element 
      008D0F 90 93            [ 1]  330     ldw y,x 
      008D11 FE               [ 2]  331     ldw x,(x)
      008D12 1F 03            [ 2]  332     ldw (TAIL,sp),x ; last ring position  
      008D14 93               [ 1]  333     ldw x,y 
      008D15 90 5A            [ 2]  334     decw y 
      008D17 5C               [ 1]  335     incw x 
      000C98                        336     _ldaz snake_len 
      008D18 B6 0A                    1     .byte 0xb6,snake_len 
      008D1A 4A               [ 1]  337     dec a 
      008D1B 48               [ 1]  338     sll a     
      008D1C CD 8C CC         [ 4]  339     call move_array_up 
                                    340 ; set 1 element as new head position 
      008D1F 1E 01            [ 2]  341     ldw x,(POS,sp)
      008D21 CF 00 0E         [ 2]  342     ldw snake_body,x    
      008D24 72 00 00 09 0B   [ 2]  343     btjt game_flags,#F_FOOD_COLL,8$
                                    344 ; erase last ring 
      008D29 1E 03            [ 2]  345     ldw x,(TAIL,sp)
      008D2B 90 AE 8B 90      [ 2]  346     ldw y,#RING
      008D2F CD 8B CB         [ 4]  347     call draw_sprite
      008D32 20 08            [ 2]  348     jra 9$ 
      008D34                        349 8$:
      008D34 72 07 00 09 03   [ 2]  350     btjf game_flags,#F_POO,9$ 
      008D39 CD 8C 0B         [ 4]  351     call snake_poo 
      008D3C                        352 9$:
      000CBC                        353     _drop VAR_SIZE 
      008D3C 5B 04            [ 2]    1     addw sp,#VAR_SIZE 
      008D3E 90 85            [ 2]  354     popw y 
      008D40 85               [ 2]  355     popw x  
      008D41 81               [ 4]  356     ret 
                                    357 
                                    358 
                                    359 ;--------------------------
                                    360 ; rotate snake head 
                                    361 ; input
                                    362 ;     A   {LEFT,RIGHT}
                                    363 ;--------------------------
      008D42                        364 rotate_head:
      008D42 88               [ 1]  365     push a 
      000CC3                        366     _ldaz snake_dir 
      008D43 B6 0B                    1     .byte 0xb6,snake_dir 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 82.
Hexadecimal [24-Bits]



      008D45 90 AE 00 06      [ 2]  367     ldw y,#6 
      008D49 90 42            [ 4]  368     mul y,a 
      008D4B 72 A9 8B 78      [ 2]  369     addw y,#HEAD_UP
      008D4F CE 00 0E         [ 2]  370     ldw x,snake_body 
      008D52 CD 8B CB         [ 4]  371     call draw_sprite 
      008D55 84               [ 1]  372     pop a 
      008D56 A1 01            [ 1]  373     cp a,#BTN_LEFT 
      008D58 26 05            [ 1]  374     jrne 2$ 
      000CDA                        375     _ldaz snake_dir 
      008D5A B6 0B                    1     .byte 0xb6,snake_dir 
      008D5C 4A               [ 1]  376     dec a 
      008D5D 20 03            [ 2]  377     jra 4$ 
      000CDF                        378 2$: _ldaz snake_dir 
      008D5F B6 0B                    1     .byte 0xb6,snake_dir 
      008D61 4C               [ 1]  379     inc a 
      008D62 A4 03            [ 1]  380 4$: and a,#3 
      000CE4                        381     _straz snake_dir 
      008D64 B7 0B                    1     .byte 0xb7,snake_dir 
      008D66 90 AE 00 06      [ 2]  382     ldw y,#6
      008D6A 90 42            [ 4]  383     mul y,a 
      008D6C 72 A9 8B 78      [ 2]  384     addw y,#HEAD_UP 
      008D70 CE 00 0E         [ 2]  385     ldw x,snake_body 
      008D73 CD 8B CB         [ 4]  386     call draw_sprite 
      008D76 81               [ 4]  387     ret 
                                    388 
                                    389 ;--------------------------
                                    390 ; read keypad 
                                    391 ; LEFT turn left 
                                    392 ; RIGHT turn right 
                                    393 ;--------------------------
                           000001   394     KPAD=1
      008D77                        395 user_input:
      008D77 4B 00            [ 1]  396     push #0 
      008D79 CD 81 38         [ 4]  397     call read_keypad
      008D7C 27 44            [ 1]  398     jreq 8$ 
      008D7E 6B 01            [ 1]  399     ld (KPAD,sp),a  
      008D80 A6 01            [ 1]  400     ld a,#BTN_LEFT 
      008D82 14 01            [ 1]  401     and a,(KPAD,sp)
      008D84 27 05            [ 1]  402     jreq 2$ 
      008D86 CD 8D 42         [ 4]  403     call rotate_head
      008D89 20 31            [ 2]  404     jra 6$
      008D8B A6 04            [ 1]  405 2$: ld a,#BTN_RIGHT 
      008D8D 14 01            [ 1]  406     and a,(KPAD,sp)
      008D8F 27 05            [ 1]  407     jreq 3$ 
      008D91 CD 8D 42         [ 4]  408     call rotate_head
      008D94 20 26            [ 2]  409     jra 6$ 
      008D96                        410 3$:
      008D96 A6 08            [ 1]  411     ld a,#BTN_UP 
      008D98 14 01            [ 1]  412     and a,(KPAD,sp)
      008D9A 27 0E            [ 1]  413     jreq 4$
      008D9C A6 01            [ 1]  414     ld a,#MIN_SPEED 
      008D9E C1 00 06         [ 1]  415     cp a,speed 
      008DA1 27 19            [ 1]  416     jreq 6$  
      000D23                        417     _decz speed
      008DA3 3A 06                    1     .byte 0x3a,speed 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 83.
Hexadecimal [24-Bits]



      008DA5 CD 8D F4         [ 4]  418     call prt_info 
      008DA8 20 12            [ 2]  419     jra 6$ 
      008DAA A6 02            [ 1]  420 4$: ld a,#BTN_DOWN 
      008DAC 14 01            [ 1]  421     and a,(KPAD,sp)
      008DAE 27 0C            [ 1]  422     jreq 6$
      008DB0 A6 09            [ 1]  423     ld a,#MAX_SPEED 
      008DB2 C1 00 06         [ 1]  424     cp a,speed 
      008DB5 27 05            [ 1]  425     jreq 6$
      000D37                        426     _incz speed
      008DB7 3C 06                    1     .byte 0x3c, speed 
      008DB9 CD 8D F4         [ 4]  427     call prt_info  
      008DBC                        428 6$:
      008DBC AE 00 0A         [ 2]  429     ldw x,#10
      008DBF CD 81 61         [ 4]  430     call wait_key_release
      008DC2                        431 8$:
      000D42                        432     _drop 1 
      008DC2 5B 01            [ 2]    1     addw sp,#1 
      008DC4 81               [ 4]  433     ret 
                                    434 
                                    435 ;-------------------------
                                    436 ; create a new mouse 
                                    437 ; at random position 
                                    438 ;-------------------------
      008DC5                        439 new_food:
      008DC5 CD 81 E4         [ 4]  440     call prng
      008DC8 A6 B2            [ 1]  441     ld a,#VRES-MOUSE_HEIGHT-FONT_HEIGHT-2 
      008DCA 62               [ 2]  442     div x,a 
      008DCB AB 09            [ 1]  443     add a,#FONT_HEIGHT+1
      000D4D                        444     _straz food_coord 
      008DCD B7 0C                    1     .byte 0xb7,food_coord 
      008DCF CD 81 E4         [ 4]  445     call prng 
      008DD2 A6 C1            [ 1]  446     ld a,#HRES-MOUSE_WIDTH-2 
      008DD4 62               [ 2]  447     div x,a 
      008DD5 4C               [ 1]  448     inc a 
      000D56                        449     _straz food_coord+1
      008DD6 B7 0D                    1     .byte 0xb7,food_coord+1 
      008DD8 CE 00 0C         [ 2]  450     ldw x,food_coord 
      008DDB 90 AE 8B 96      [ 2]  451     ldw y,#MOUSE 
      008DDF CD 8B CB         [ 4]  452     call draw_sprite 
      008DE2 4D               [ 1]  453     tnz a 
      008DE3 27 0C            [ 1]  454     jreq 9$ 
      008DE5 CE 00 0C         [ 2]  455     ldw x,food_coord 
      008DE8 90 AE 8B 96      [ 2]  456     ldw y,#MOUSE 
      008DEC CD 8B CB         [ 4]  457     call draw_sprite 
      008DEF 20 D4            [ 2]  458     jra new_food 
      000D71                        459 9$: _clrz game_flags
      008DF1 3F 09                    1     .byte 0x3f, game_flags 
      008DF3 81               [ 4]  460     ret 
                                    461 
                                    462 ;----------------------
                                    463 ; print score top left 
                                    464 ; corner 
                                    465 ;----------------------
      008DF4                        466 prt_info:
      008DF4 89               [ 2]  467     pushw x 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 84.
Hexadecimal [24-Bits]



      000D75                        468     _clrz cx 
      008DF5 3F 74                    1     .byte 0x3f, cx 
      000D77                        469     _clrz cy 
      008DF7 3F 73                    1     .byte 0x3f, cy 
      008DF9 90 AE 8E 2D      [ 2]  470     ldw y,#score_str
      008DFD CD 88 2F         [ 4]  471     call tv_puts 
      000D80                        472     _ldxz score 
      008E00 BE 04                    1     .byte 0xbe,score 
      008E02 CD 88 AE         [ 4]  473     call put_uint16
      008E05 A6 0C            [ 1]  474     ld a,#12
      000D87                        475     _straz cx 
      008E07 B7 74                    1     .byte 0xb7,cx 
      008E09 90 AE 8E 34      [ 2]  476     ldw y,#speed_str 
      008E0D CD 88 2F         [ 4]  477     call tv_puts
      008E10 A6 0A            [ 1]  478     ld a,#MAX_SPEED+1 
      008E12 C0 00 06         [ 1]  479     sub a,speed 
      008E15 5F               [ 1]  480     clrw x 
      008E16 97               [ 1]  481     ld xl,a 
      008E17 CD 88 AE         [ 4]  482     call put_uint16
      008E1A A6 18            [ 1]  483     ld a,#24
      000D9C                        484     _straz cx 
      008E1C B7 74                    1     .byte 0xb7,cx 
      008E1E 90 AE 8E 3B      [ 2]  485     ldw y,#max_str 
      008E22 CD 88 2F         [ 4]  486     call tv_puts 
      008E25 CE 00 07         [ 2]  487     ldw x,max_score
      008E28 CD 88 AE         [ 4]  488     call put_uint16
      008E2B 85               [ 2]  489     popw x
      008E2C 81               [ 4]  490     ret 
      008E2D 53 43 4F 52 45 3A 00   491 score_str: .asciz "SCORE:"
      008E34 53 50 45 45 44 3A 00   492 speed_str: .asciz "SPEED:"  
      008E3B 6D 61 78 3A 00         493 max_str: .asciz "max:"
                                    494 
                                    495 ;-------------------------
                                    496 ; game initialization
                                    497 ;-------------------------
      008E40                        498 snake_init:
      008E40 A6 02            [ 1]  499     ld a,#(1<<F_NO_FOOD)
      000DC2                        500     _straz game_flags 
      008E42 B7 09                    1     .byte 0xb7,game_flags 
      008E44 A6 05            [ 1]  501     ld a,#5 
      000DC6                        502     _straz speed
      008E46 B7 06                    1     .byte 0xb7,speed 
      008E48 5F               [ 1]  503     clrw x 
      000DC9                        504     _strxz score 
      008E49 BF 04                    1     .byte 0xbf,score 
      000DCB                        505     _strxz food_coord
      008E4B BF 0C                    1     .byte 0xbf,food_coord 
      008E4D CD 82 06         [ 4]  506     call set_seed  ; using ticks 
      008E50 A6 03            [ 1]  507     ld a,#3
      000DD2                        508     _straz snake_len 
      008E52 B7 0A                    1     .byte 0xb7,snake_len 
      008E54 A6 01            [ 1]  509     ld a,#EAST
      000DD6                        510     _straz snake_dir
      008E56 B7 0B                    1     .byte 0xb7,snake_dir 
      008E58 AE 00 0E         [ 2]  511     ldw x,#snake_body 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 85.
Hexadecimal [24-Bits]



      008E5B 90 AE 1F 30      [ 2]  512     ldw y,#(31<<8)+48 
      008E5F FF               [ 2]  513     ldw (x),y
      008E60 72 A2 00 04      [ 2]  514     subw y,#SNAKE_SPRITE_WIDTH
      008E64 EF 02            [ 2]  515     ldw (2,x),y 
      008E66 72 A2 00 04      [ 2]  516     subw y,#SNAKE_SPRITE_WIDTH
      008E6A EF 04            [ 2]  517     ldw (4,x),y 
      008E6C CD 87 18         [ 4]  518     call tv_cls
      008E6F CD 8B A2         [ 4]  519     call draw_walls 
      008E72 CD 8B E3         [ 4]  520     call draw_snake 
      008E75 81               [ 4]  521     ret 
                                    522 
                                    523 ;-------------------------
                                    524 ; game main routine
                                    525 ;-------------------------
      008E76                        526 snake:
      008E76 CD 8E 40         [ 4]  527     call snake_init
      008E79 A6 1E            [ 1]  528     ld a,#30
      008E7B CD 80 B3         [ 4]  529     call pause
      008E7E                        530 1$: 
      008E7E 72 03 00 09 06   [ 2]  531     btjf game_flags,#F_NO_FOOD,2$
      008E83 CD 8D F4         [ 4]  532     call prt_info 
      008E86 CD 8D C5         [ 4]  533     call new_food 
      008E89                        534 2$:
      008E89 CD 8C DA         [ 4]  535     call move_snake 
      008E8C 72 04 00 09 0A   [ 2]  536     btjt game_flags,#F_GAME_OVER,game_over  
      008E91 CD 8D 77         [ 4]  537     call user_input
      000E14                        538     _ldaz speed 
      008E94 B6 06                    1     .byte 0xb6,speed 
      008E96 CD 80 B3         [ 4]  539     call pause 
      008E99 20 E3            [ 2]  540     jra 1$
      008E9B                        541 game_over:
      008E9B A6 05            [ 1]  542     ld a,#5
      008E9D CD 81 09         [ 4]  543     call noise 
      000E20                        544     _ldxz score 
      008EA0 BE 04                    1     .byte 0xbe,score 
      008EA2 C3 00 07         [ 2]  545     cpw x,max_score 
      008EA5 2B 02            [ 1]  546     jrmi 4$ 
      000E27                        547     _strxz max_score
      008EA7 BF 07                    1     .byte 0xbf,max_score 
      008EA9                        548 4$:
      008EA9 AE FF FF         [ 2]  549     ldw x,#0xffff 
      008EAC CD 81 61         [ 4]  550     call wait_key_release
      008EAF CD 87 18         [ 4]  551     call tv_cls 
      008EB2 90 AE 8E DD      [ 2]  552     ldw y,#gover 
      008EB6 CD 88 2F         [ 4]  553     call tv_puts 
      008EB9 90 AE 8E 2D      [ 2]  554     ldw y,#score_str
      008EBD CD 88 2F         [ 4]  555     call tv_puts 
      000E40                        556     _ldxz score 
      008EC0 BE 04                    1     .byte 0xbe,score 
      008EC2 CD 88 AE         [ 4]  557     call put_uint16
      008EC5 CD 87 9C         [ 4]  558     call crlf 
      008EC8 90 AE 8E E8      [ 2]  559     ldw y,#prompt 
      008ECC CD 88 2F         [ 4]  560     call tv_puts 
      008ECF                        561 6$:
      008ECF CD 81 5B         [ 4]  562     call wait_key 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 86.
Hexadecimal [24-Bits]



      008ED2 A1 20            [ 1]  563     cp a,#BTN_A 
      008ED4 27 A0            [ 1]  564     jreq snake 
      008ED6 A1 10            [ 1]  565     cp a,#BTN_B 
      008ED8 27 02            [ 1]  566     jreq 9$
      008EDA 20 F3            [ 2]  567     jra 6$
      008EDC                        568 9$:     
      008EDC 81               [ 4]  569     ret 
                                    570 
      008EDD 67 61 6D 65 20 6F 76   571 gover: .asciz "game over\r"
             65 72 0D 00
      008EE8 41 20 6E 65 77 20 67   572 prompt: .asciz "A new game\rB exit"
             61 6D 65 0D 42 20 65
             78 69 74 00
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 87.
Hexadecimal [24-Bits]



                                      1 ;-------------------
                                      2 ; FALL 
                                      3 ; TRETIS  inspired  
                                      4 ;-------------------
                                      5 
                           000008     6 TETRA_WIDTH=8 ; 8x8 pixels tetrahedrons blocks 
                           000050     7 WELL_WIDTH=TETRA_WIDTH*10
                           0000B0     8 WELL_DEPTH=TETRA_WIDTH*22
                                      9  
                                     10 
                                     11 ; sprites 
      008EFA 04 01 FF FF FF FF       12 I0: .byte 4,1,0xff,0xff,0xff,0xff; horizontal I 
      008F00 01 04 FF FF FF FF       13 I1: .byte 1,4,0xff,0xff,0xff,0xff ; vertical I 
      008F06 02 02 FF FF FF FF       14 SQUARE: .byte 2,2,0xff,0xff,0xff,0xff 
      008F0C 06 04 FC FC 30 30       15 T0: .byte 6,4,0xfc,0xfc,0x30,0x30 ; normal T 
      008F12 04 06 30 30 F0 F0 30    16 T1: .byte 4,6,0x30,0x30,0xf0,0xf0,0x30,0x30 ; T rotated right  
             30
      008F1A 04 06 C0 C0 F0 F0 C0    17 T2: .byte 4,6,0xc0,0xc0,0xf0,0xf0,0xc0,0xc0 ; T rotated left 
             C0
      008F22 06 04 30 30 F0 F0       18 T3: .byte 6,4,0x30,0x30,0xf0,0xf0 ; T upside down 
      008F28 06 04 FC FC C0 C0       19 L0: .byte 6,4,0xfc,0xfc,0xc0,0xc0 ; L rotated right 
      008F2E 04 06 F0 F0 30 30 30    20 L1: .byte 4,6,0xf0,0xf0,0x30,0x30,0x30,0x30 ; L upside down 
             30
      008F36 06 04 0C 0C FC FC       21 L2: .byte 6,4,0xc,0xc,0xfc,0xfc ; L rotated left 
      008F3C 04 06 C0 C0 C0 FC FC    22 L3: .byte 4,6,0xc0,0xc0,0xc0,0xfc,0xfc ; L upside 
      008F43 06 04 FC FC 0C 0C       23 J0: .byte 6,4,0xfc,0xfc,0xc,0xc ; J rotated left 
      008F49 04 06 C0 C0 C0 C0 FC    24 J1:  .byte 4,6,0xc0,0xc0,0xc0,0xc0,0xfc,0xfc ; J upside 
             FC
      008F51 06 04 C0 C0 FC FC       25 J2: .byte 6,4,0xc0,0xc0,0xfc,0xfc ; j rotated right 
      008F57 04 06 FC FC 0C 0C 0C    26 J3: .byte 4,6,0xfc,0xfc,0xc,0xc,0xc,0xc  ; j upside down 
             0C
      008F5F 06 04 F0 F0 3C 3C       27 Z0: .byte 6,4,0xf0,0xf0,0x3c,0x3c ; 
      008F65 04 06 30 30 3C 30 C0    28 Z1: .byte 4,6,0x30,0x30,0x3c,0x30,0xc0,0xc0 
             C0
      008F6D 06 04 3C 3C F0 F0       29 S0: .byte 6,4,0x3c,0x3c,0xf0,0xf0 
      008F73 04 06 C0 C0 F0 F0 0C    30 S1: .byte 4,6,0xc0,0xc0,0xf0,0xf0,0xc,0xc 
             0C
                                     31 
                                     32 ;--------------------
                                     33 ; draw the well in 
                                     34 ; wich tetrahedrons 
                                     35 ; falls.
                                     36 ;--------------------
      008F7B                         37 draw_well:
                                     38 ; left side 
      008F7B AE 00 00         [ 2]   39     ldw x,#(0<<8)+0
      008F7E 90 AE 10 C0      [ 2]   40     ldw y,#((VRES-WELL_DEPTH)<<8)+VRES
      008F82 CD 88 3B         [ 4]   41     call line
                                     42 ;bottom  
      008F85 AE 01 51         [ 2]   43     ldw x,#(1<<8)+WELL_WIDTH+1 
      008F88 90 AE BF BF      [ 2]   44     ldw y,#((VRES-1)<<8)+VRES-1
      008F8C CD 88 3B         [ 4]   45     call line 
                                     46 ;right side
      008F8F AE 51 51         [ 2]   47     ldw x,#((WELL_WIDTH+1)<<8)+WELL_WIDTH+1
      008F92 90 AE 10 C0      [ 2]   48     ldw y,#((VRES-WELL_DEPTH)<<8)+VRES
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 88.
Hexadecimal [24-Bits]



      008F96 CD 88 3B         [ 4]   49     call line 
      008F99 81               [ 4]   50     ret 
                                     51 
                                     52 ;-------------------------
                                     53 ; initialize game 
                                     54 ;-------------------------
      008F9A                         55 fall_init:
      008F9A CD 87 18         [ 4]   56     call tv_cls  
      008F9D CD 8F 7B         [ 4]   57     call draw_well 
      008FA0 81               [ 4]   58     ret 
                                     59 
      008FA1                         60 fall:
      008FA1 CD 8F 9A         [ 4]   61     call fall_init
      008FA4 20 FE            [ 2]   62 jra .
      008FA6 81               [ 4]   63     ret 
                                     64 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 89.
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
    BIT6    =  000006     |     BIT7    =  000007     |     BIT_A   =  000005 
    BIT_B   =  000004     |     BIT_DOWN=  000001     |     BIT_LEFT=  000000 
    BIT_RIGH=  000002     |     BIT_UP  =  000003     |     BLOCK_SI=  000080 
    BOFS    =  000003     |     BOFSL   =  000004     |     BOOT_ROM=  006000 
    BOOT_ROM=  007FFF     |     BPL     =  000001     |     BPOS    =  000005 
    BS      =  000008     |     BTN_A   =  000020     |     BTN_B   =  000010 
    BTN_DOWN=  000002     |     BTN_LEFT=  000001     |     BTN_MASK=  00003F 
    BTN_RIGH=  000004     |     BTN_UP  =  000008     |     BUTTONS =  000003 
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
    CLK_PCKE=  000004     |     CLK_PCKE=  000002     |     CLK_PCKE=  000003 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 90.
Hexadecimal [24-Bits]

Symbol Table

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
    DC4     =  000014     |     DEBOUNCE=  000001     |     DEBUG   =  000001 
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
    EEPROM_B=  004000     |     EEPROM_E=  0043FF     |     EEPROM_S=  000400 
    EM      =  000019     |     ENQ     =  000005     |     EOF     =  00001A 
    EOT     =  000004     |     EPULSE  =  000025     |     ESC     =  00001B 
    ETB     =  000017     |     ETX     =  000003     |     EXTI_CR1=  0050A0 
    EXTI_CR2=  0050A1     |     FF      =  00000C     |     FHSI    =  F42400 
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
    FLASH_WS=  00480D     |     FLSI    =  01F400     |     FMSTR   =  F42400 
    FONT_HEI=  000008     |     FONT_WID=  000006     |     FR_HORZ =  003D76 
    FR_T3_CL=  00F424     |     FS      =  00001C     |     F_CURSOR=  000001 
    F_CUR_VI=  000002     |     F_DISP_M=  000005     |     F_EVEN  =  000000 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 91.
Hexadecimal [24-Bits]

Symbol Table

    F_FOOD_C=  000000     |     F_GAME_O=  000002     |     F_GAME_T=  000007 
    F_NO_FOO=  000001     |     F_POO   =  000003     |     F_SOUND_=  000006 
    F_VIDEO =  000004     |     GAIN    =  000002     |     GAM_ADR =  000001 
    GPIO_BAS=  005000     |     GPIO_CR1=  000003     |     GPIO_CR2=  000004 
    GPIO_DDR=  000002     |     GPIO_IDR=  000001     |     GPIO_ODR=  000000 
    GPIO_SIZ=  000005     |     GS      =  00001D     |     HALF_LIN=  0001FC 
    HEAD    =  000003     |   7 HEAD_DOW   000B04 R   |   7 HEAD_LEF   000B0A R
  7 HEAD_RIG   000AFE R   |   7 HEAD_UP    000AF8 R   |     HLINE   =  0003F8 
    HPULSE  =  00004B     |     HRES    =  0000C8     |     HSECNT  =  004809 
  7 I0         000E7A R   |   7 I1         000E80 R   |     I2C_BASE=  005210 
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
    I2C_WRIT=  000000     |     IDX     =  000002     |     INCR    =  000001 
    INPUT_DI=  000000     |     INPUT_EI=  000001     |     INPUT_FL=  000000 
    INPUT_PU=  000001     |     INT_ADC2=  000016     |     INT_AUAR=  000012 
    INT_AWU =  000001     |     INT_CAN_=  000008     |     INT_CAN_=  000009 
    INT_CLK =  000002     |     INT_EXTI=  000003     |     INT_EXTI=  000004 
    INT_EXTI=  000005     |     INT_EXTI=  000006     |     INT_EXTI=  000007 
    INT_FLAS=  000018     |     INT_I2C =  000013     |     INT_SPI =  00000A 
    INT_TIM1=  00000C     |     INT_TIM1=  00000B     |     INT_TIM2=  00000E 
    INT_TIM2=  00000D     |     INT_TIM3=  000010     |     INT_TIM3=  00000F 
    INT_TIM4=  000017     |     INT_TLI =  000000     |     INT_UART=  000011 
    INT_UART=  000015     |     INT_UART=  000014     |     INT_VECT=  008060 
    INT_VECT=  00800C     |     INT_VECT=  008028     |     INT_VECT=  00802C 
    INT_VECT=  008010     |     INT_VECT=  008014     |     INT_VECT=  008018 
    INT_VECT=  00801C     |     INT_VECT=  008020     |     INT_VECT=  008024 
    INT_VECT=  008068     |     INT_VECT=  008054     |     INT_VECT=  008000 
    INT_VECT=  008030     |     INT_VECT=  008038     |     INT_VECT=  008034 
    INT_VECT=  008040     |     INT_VECT=  00803C     |     INT_VECT=  008048 
    INT_VECT=  008044     |     INT_VECT=  008064     |     INT_VECT=  008008 
    INT_VECT=  008004     |     INT_VECT=  008050     |     INT_VECT=  00804C 
    INT_VECT=  00805C     |     INT_VECT=  008058     |     ISTR    =  000003 
    ITC_SPR1=  007F70     |     ITC_SPR2=  007F71     |     ITC_SPR3=  007F72 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 92.
Hexadecimal [24-Bits]

Symbol Table

    ITC_SPR4=  007F73     |     ITC_SPR5=  007F74     |     ITC_SPR6=  007F75 
    ITC_SPR7=  007F76     |     ITC_SPR8=  007F77     |     ITC_SPR_=  000001 
    ITC_SPR_=  000000     |     ITC_SPR_=  000003     |     IWDG_KEY=  000055 
    IWDG_KEY=  0000CC     |     IWDG_KEY=  0000AA     |     IWDG_KR =  0050E0 
    IWDG_PR =  0050E1     |     IWDG_RLR=  0050E2     |   7 J0         000EC3 R
  7 J1         000EC9 R   |   7 J2         000ED1 R   |   7 J3         000ED7 R
    KERNEL_V=  000060     |     KPAD    =  000001     |     KPAD_IDR=  005006 
    KPAD_POR=  005005     |   7 L0         000EA8 R   |   7 L1         000EAE R
  7 L2         000EB6 R   |   7 L3         000EBC R   |     LB      =  000002 
    LEN     =  000001     |     LF      =  00000A     |     LINE_DEL=  000082 
    LINE_PER=  000018     |     MAJOR   =  000001     |     MASK    =  000005 
    MAX_SPEE=  000009     |     MINOR   =  000001     |     MIN_SPEE=  000001 
  7 MOUSE      000B16 R   |     MOUSE_HE=  000004     |     MOUSE_WI=  000005 
    NAFR    =  004804     |     NAK     =  000015     |     NCLKOPT =  004808 
    NFLASH_W=  00480E     |     NHSECNT =  00480A     |     NOPT1   =  004802 
    NOPT2   =  004804     |     NOPT3   =  004806     |     NOPT4   =  004808 
    NOPT5   =  00480A     |     NOPT6   =  00480C     |     NOPT7   =  00480E 
    NOPTBL  =  00487F     |     NORTH   =  000000     |     NUBC    =  004802 
    NWDGOPT =  004806     |     NWDGOPT_=  FFFFFFFD     |     NWDGOPT_=  FFFFFFFC 
    NWDGOPT_=  FFFFFFFF     |     NWDGOPT_=  FFFFFFFE     |   7 NonHandl   000000 R
    OFS_UART=  000002     |     OFS_UART=  000003     |     OFS_UART=  000004 
    OFS_UART=  000005     |     OFS_UART=  000006     |     OFS_UART=  000007 
    OFS_UART=  000008     |     OFS_UART=  000009     |     OFS_UART=  000001 
    OFS_UART=  000009     |     OFS_UART=  00000A     |     OFS_UART=  000000 
    OPT0    =  004800     |     OPT1    =  004801     |     OPT2    =  004803 
    OPT3    =  004805     |     OPT4    =  004807     |     OPT5    =  004809 
    OPT6    =  00480B     |     OPT7    =  00480D     |     OPTBL   =  00487E 
    OPTION_B=  004800     |     OPTION_E=  00487F     |     OPTION_S=  000080 
    OUTPUT_F=  000001     |     OUTPUT_O=  000000     |     OUTPUT_P=  000001 
    OUTPUT_S=  000000     |     PA      =  000000     |     PA_BASE =  005000 
    PA_CR1  =  005003     |     PA_CR2  =  005004     |     PA_DDR  =  005002 
    PA_IDR  =  005001     |     PA_ODR  =  005000     |     PB      =  000005 
    PB_BASE =  005005     |     PB_CR1  =  005008     |     PB_CR2  =  005009 
    PB_DDR  =  005007     |     PB_IDR  =  005006     |     PB_ODR  =  005005 
    PC      =  00000A     |     PC_BASE =  00500A     |     PC_CR1  =  00500D 
    PC_CR2  =  00500E     |     PC_DDR  =  00500C     |     PC_IDR  =  00500B 
    PC_ODR  =  00500A     |     PD      =  00000F     |     PD_BASE =  00500F 
    PD_CR1  =  005012     |     PD_CR2  =  005013     |     PD_DDR  =  005011 
    PD_IDR  =  005010     |     PD_ODR  =  00500F     |     PE      =  000014 
    PE_BASE =  005014     |     PE_CR1  =  005017     |     PE_CR2  =  005018 
    PE_DDR  =  005016     |     PE_IDR  =  005015     |     PE_ODR  =  005014 
    PF      =  000019     |     PF_BASE =  005019     |     PF_CR1  =  00501C 
    PF_CR2  =  00501D     |     PF_DDR  =  00501B     |     PF_IDR  =  00501A 
    PF_ODR  =  005019     |     PG      =  00001E     |     PG_BASE =  00501E 
    PG_CR1  =  005021     |     PG_CR2  =  005022     |     PG_DDR  =  005020 
    PG_IDR  =  00501F     |     PG_ODR  =  00501E     |     PH      =  000023 
    PH_BASE =  005023     |     PH_CR1  =  005026     |     PH_CR2  =  005027 
    PH_DDR  =  005025     |     PH_IDR  =  005024     |     PH_ODR  =  005023 
    PH_POST_=  000003     |     PH_PRE_V=  000001     |     PH_VIDEO=  000002 
    PH_VSYNC=  000000     |     PI      =  000028     |     PI_BASE =  005028 
    PI_CR1  =  00502B     |     PI_CR2  =  00502C     |     PI_DDR  =  00502A 
    PI_IDR  =  005029     |     PI_ODR  =  005028     |   7 POO        000B1C R
    POO_HEIG=  000004     |     POO_WIDT=  000007     |     POS     =  000001 
    RAM_BASE=  000000     |     RAM_END =  0017FF     |     RAM_SIZE=  001800 
    REV     =  000000     |   7 RING       000B10 R   |     ROP     =  004800 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 93.
Hexadecimal [24-Bits]

Symbol Table

    ROW     =  000007     |     ROWS    =  000001     |     RS      =  00001E 
    RST_SR  =  0050B3     |   7 S0         000EED R   |   7 S1         000EF3 R
    SEL     =  000012     |     SEMIC   =  00003B     |     SFR_BASE=  005000 
    SFR_END =  0057FF     |     SHARP   =  000023     |     SHIFT   =  000004 
    SI      =  00000F     |     SNAKE_SP=  000004     |     SNAKE_SP=  000004 
    SO      =  00000E     |     SOH     =  000001     |     SOUND_BI=  000000 
    SOUND_PO=  00500F     |     SOUTH   =  000002     |     SPACE   =  000020 
    SPI_CR1 =  005200     |     SPI_CR1_=  000003     |     SPI_CR1_=  000000 
    SPI_CR1_=  000001     |     SPI_CR1_=  000007     |     SPI_CR1_=  000002 
    SPI_CR1_=  000006     |     SPI_CR2 =  005201     |     SPI_CR2_=  000007 
    SPI_CR2_=  000006     |     SPI_CR2_=  000005     |     SPI_CR2_=  000004 
    SPI_CR2_=  000002     |     SPI_CR2_=  000000     |     SPI_CR2_=  000001 
    SPI_CRCP=  005205     |     SPI_DR  =  005204     |     SPI_ICR =  005202 
    SPI_RXCR=  005206     |     SPI_SR  =  005203     |     SPI_SR_B=  000007 
    SPI_SR_C=  000004     |     SPI_SR_M=  000005     |     SPI_SR_O=  000006 
    SPI_SR_R=  000000     |     SPI_SR_T=  000001     |     SPI_SR_W=  000003 
    SPI_TXCR=  005207     |     SPRITE  =  000002     |   7 SQUARE     000E86 R
    STACK_EM=  0017FF     |     STACK_SI=  000080     |     STX     =  000002 
    SUB     =  00001A     |     SWIM_CSR=  007F80     |     SYN     =  000016 
  7 T0         000E8C R   |   7 T1         000E92 R   |   7 T2         000E9A R
  7 T3         000EA2 R   |     TAB     =  000009     |     TAIL    =  000003 
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 94.
Hexadecimal [24-Bits]

Symbol Table

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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 95.
Hexadecimal [24-Bits]

Symbol Table

    TIM4_PSC=  000005     |     TIM4_PSC=  000002     |     TIM4_PSC=  000006 
    TIM4_PSC=  000003     |     TIM4_PSC=  000000     |     TIM4_PSC=  000001 
    TIM4_PSC=  000002     |     TIM4_SR =  005342     |     TIM4_SR_=  000000 
    UART1   =  000000     |     UART1_BA=  005230     |     UART1_BR=  005232 
    UART1_BR=  005233     |     UART1_CR=  005234     |     UART1_CR=  005235 
    UART1_CR=  005236     |     UART1_CR=  005237     |     UART1_CR=  005238 
    UART1_DR=  005231     |     UART1_GT=  005239     |     UART1_PO=  000000 
    UART1_PS=  00523A     |     UART1_RX=  000004     |     UART1_SR=  005230 
    UART1_TX=  000005     |     UART2   =  000001     |     UART3   =  000002 
    UART3_BA=  005240     |     UART3_BR=  005242     |     UART3_BR=  005243 
    UART3_CR=  005244     |     UART3_CR=  005245     |     UART3_CR=  005246 
    UART3_CR=  005247     |     UART3_CR=  004249     |     UART3_DR=  005241 
    UART3_PO=  00000F     |     UART3_RX=  000006     |     UART3_SR=  005240 
    UART3_TX=  000005     |     UART_CR1=  000004     |     UART_CR1=  000002 
    UART_CR1=  000000     |     UART_CR1=  000001     |     UART_CR1=  000007 
    UART_CR1=  000006     |     UART_CR1=  000005     |     UART_CR1=  000003 
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
    UART_SR_=  000001     |     UART_SR_=  000004     |     UART_SR_=  000002 
    UART_SR_=  000003     |     UART_SR_=  000000     |     UART_SR_=  000005 
    UART_SR_=  000006     |     UART_SR_=  000007     |     UBC     =  004801 
    UINT    =  000001     |     US      =  00001F     |     VAR_SIZE=  000004 
    VBUFF_SI=  0012C0     |     VIDEO_LI=  0000C0     |     VPULSE  =  0001B4 
    VRES    =  0000C0     |     VSIZE   =  000002     |     VT      =  00000B 
    WDGOPT  =  004805     |     WDGOPT_I=  000002     |     WDGOPT_L=  000003 
    WDGOPT_W=  000000     |     WDGOPT_W=  000001     |     WELL_DEP=  0000B0 
    WELL_WID=  000050     |     WEST    =  000004     |     WWDG_CR =  0050D1 
    WWDG_WR =  0050D2     |     X0      =  000001     |     X1      =  000002 
    XCOOR   =  000002     |     XCOORH  =  000001     |     XOFF    =  000013 
    XON     =  000011     |     Y0      =  000003     |     Y1      =  000004 
    YCOOR   =  000001     |   7 Z0         000EDF R   |   7 Z1         000EE5 R
  5 acc16      000064 GR  |   5 acc8       000065 GR  |   9 app_vari   000004 R
  7 beep       00007C R   |   7 bit_mask   0006AF R   |   7 clock_in   000004 R
  7 cold_sta   0000F8 R   |   7 crlf       00071C R   |   7 cursor_r   00072C R
  5 cx         000074 R   |   5 cy         000073 R   |   7 dbg_prin   000982 R
  5 delay_ti   000062 R   |   7 draw_hea   000B55 R   |   7 draw_sna   000B63 R
  7 draw_spr   000B4B R   |   7 draw_wal   000B22 R   |   7 draw_wel   000EFB R
  7 fall       000F21 R   |   7 fall_ini   000F1A R   |   7 fill       0009F3 R
  5 flags      00006A GR  |   5 fmstr      000066 GR  |   7 font_6x8   0001A0 R
  7 font_end   0004D8 R   |   7 food_col   000BA4 R   |   9 food_coo   00000C R
  9 game_fla   000009 R   |   7 game_ove   000E1B R   |   7 gover      000E5D R
  7 hex_digi   0009A1 R   |   7 invert_p   0006F1 R   |   7 jitter_c   00064C R
  7 kpad_inp   0000B0 R   |   7 left_4pi   000908 R   |   7 line       0007BB R
  7 main       0009FB R   |   9 max_scor   000007 R   |   7 max_str    000DBB R
  7 menu       000A01 R   |   7 move       0009AF GR  |   7 move_arr   000C4C R
  7 move_dow   0009CF R   |   7 move_exi   0009EE R   |   7 move_loo   0009D4 R
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 96.
Hexadecimal [24-Bits]

Symbol Table

  7 move_sna   000C5A R   |   7 move_up    0009C1 R   |   7 new_food   000D45 R
  7 next_hea   000C2B R   |   7 noise      000089 R   |   5 ntsc_fla   00006F R
  7 ntsc_ini   0004D8 R   |   5 ntsc_pha   000070 R   |   7 ntsc_syn   000558 R
  7 ntsc_vid   000635 R   |   7 pause      000033 R   |   7 pixel_ad   0006BE R
  7 post_vid   000611 R   |   7 print_he   00099B R   |   7 prng       000164 GR
  7 prog_lis   000A97 R   |   7 prompt     000E68 R   |   7 prt_info   000D74 R
  5 ptr16      000068 GR  |   5 ptr8       000069 R   |   7 put_spri   000852 R
  7 put_uint   00082E R   |   7 qbf        000ACB R   |   7 quick      000ABA R
  7 read_key   0000B8 R   |   7 reset_pi   0006EA R   |   7 right_4p   000941 R
  7 rotate_h   000CC2 R   |   5 scan_lin   000071 R   |   9 score      000004 R
  7 score_st   000DAD R   |   7 scroll_d   0008CF R   |   7 scroll_l   000931 R
  7 scroll_r   000972 R   |   7 scroll_t   0006F7 R   |   7 scroll_u   000896 R
  5 seedx      00006B R   |   5 seedy      00006D R   |   7 select_m   000A8D R
  7 set_pixe   0006E4 R   |   7 set_seed   000186 R   |   7 sll_xy_3   000156 R
  7 snake      000DF6 R   |   9 snake_bo   00000E R   |   9 snake_di   00000B R
  7 snake_in   000DC0 R   |   9 snake_le   00000A R   |   7 snake_po   000B8B R
  5 sound_ti   000063 R   |   9 speed      000006 R   |   7 speed_st   000DB4 R
  7 srl_xy_3   00015D R   |   2 stack_fu   001780 GR  |   2 stack_un   001800 R
  7 sync_exi   000632 R   |   7 test_pre   0005C4 R   |   5 ticks      000060 R
  7 timer3_i   00001A R   |   7 tone       00003F R   |   6 tv_buffe   000080 R
  7 tv_cls     000698 R   |   7 tv_putc    000735 R   |   7 tv_puts    0007AF R
  7 user_inp   000CF7 R   |   7 user_sel   000A3D R   |   7 video_on   00053F R
  7 wait_key   0000DB R   |   7 wait_key   0000E1 R   |   7 xor_seed   00013A R

ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 97.
Hexadecimal [24-Bits]

Area Table

   0 _CODE      size      0   flags    0
   1 SSEG       size      0   flags    8
   2 SSEG0      size     80   flags    8
   3 HOME       size     80   flags    0
   4 DATA       size      0   flags    8
   5 DATA1      size     15   flags    8
   6 DATA2      size   12C0   flags    8
   7 CODE       size    F27   flags    0
   8 G_DATA     size      0   flags    8
   9 G_DATA3    size     4A   flags    8

