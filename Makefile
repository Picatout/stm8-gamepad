#############################
# oled display test 
# based on ssd1306
# 128x64 graphic display 
#############################

ifdef DEBUG
NAME=stm8-gamepad
else 
NAME=app
endif 
SDAS=sdasstm8
SDCC=sdcc
SDAR=sdar
OBJCPY=objcpy 
CFLAGS=-mstm8 -lstm8 -L$(LIB_PATH) -I../inc
INC=inc/
INCLUDES=$(BOARD_INC) $(INC)gen_macros.inc $(INC)app_macros.inc config.inc 
GAMES=snake.asm fall.asm conway.asm
SRC=hardware_init.asm xor_prng.asm font_6x8.asm tvout.asm display.asm $(NAME).asm splash.asm $(GAMES)
OBJECT=$(BUILD_DIR)$(NAME).rel
OBJECTS=$(BUILD_DIR)$(SRC:.asm=.rel)
LIST=$(BUILD_DIR)$(NAME).lst
FLASH=stm8flash

.PHONY: all

all: clean 
	#
	# "*************************************"
	# "compiling $(NAME)  for $(MCU)      "
	# "*************************************"
	$(SDAS) -g -l -o $(BUILD_DIR)$(NAME).rel $(SRC)
	$(SDCC) $(CFLAGS) -Wl-u -o $(BUILD_DIR)$(NAME).ihx $(OBJECT)
	objcopy -Iihex -Obinary  $(BUILD_DIR)$(NAME).ihx $(BUILD_DIR)$(NAME).bin 
	# 
	@ls -l  $(BUILD_DIR)$(NAME).bin 
	# 

alt_func: alt_func.asm 
	$(SDAS) -g -l -o $(BUILD_DIR)alt_func.rel alt_func.asm 
	$(SDCC) $(CFLAGS) -Wl-u -o $(BUILD_DIR)alt_func.ihx $(BUILD_DIR)alt_func.rel
	objcopy -Iihex -Obinary  $(BUILD_DIR)alt_func.ihx $(BUILD_DIR)alt_func.bin 
	$(FLASH) -c $(PROGRAMMER) -p $(MCU) -s opt -w $(BUILD_DIR)alt_func.bin  

.PHONY: clean 
clean:
	#
	# "***************"
	# "cleaning files"
	# "***************"
	-rm -f $(BUILD_DIR)*

flash: $(LIB)
	#
	# "******************"
	# "flashing $(MCU) "
	# "******************"
	$(FLASH) -c $(PROGRAMMER) -p $(MCU) -s flash -w $(BUILD_DIR)$(NAME).bin 

# read flash memory 
read: 
	$(FLASH) -c $(PROGRAMMER) -p $(MCU) -s flash -b 16384 -r flash.dat 

# read option bytes 
opt:
	$(FLASH) -c $(PROGRAMMER) -p $(MCU) -s opt -b 11 -r opt.bin
