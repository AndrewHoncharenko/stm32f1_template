CC=~/Desktop/gcc-arm-none-eabi-6-2017-q2-update/bin/arm-none-eabi-gcc
LD=~/Desktop/gcc-arm-none-eabi-6-2017-q2-update/bin/arm-none-eabi-gcc
CP=~/Desktop/gcc-arm-none-eabi-6-2017-q2-update/bin/arm-none-eabi-objcopy


########################################################################
LDSCRIPT=-T ./system/STM32F103RB_FLASH.ld

########################################################################
INC+=-I ./system/inc

SRC+=./main.c
SRC+=./system/src/system_stm32f10x.c

ASM+=./system/src/startup_stm32f10x_md.s

#######################################################################
OBJ=$(SRC:%.c=%.o)
OBJ+=$(ASM:%.s=%.o)

#######################################################################
CFLAGS += -mcpu=cortex-m3 
CFLAGS += -mlittle-endian
CFLAGS += -mthumb
CFLAGS += -g
CFLAGS += $(INC)

LDFLAGS += -mcpu=cortex-m3
LDFLAGS += -mlittle-endian
LDFLAGS += -mthumb
LDFLAGS += $(LDSCRIPT)
LDFLAGS += -Wl,--gc-section

######################################################################
all: start
	@echo "\n"
	@echo "END"

start: main.elf
	@echo "\n"
	@echo "OUT"
	@echo "********************************************************"
	$(CP) -Oihex main.elf main.hex 
	@echo "********************************************************"

main.elf: $(OBJ)
	@echo "\n"
	@echo "LINK"
	@echo "********************************************************"
	$(LD) $(LDFLAGS) $(OBJ) -o main.elf
	@echo "********************************************************"

%.o: %.c
	@echo "\n"
	@echo "COMPILE C"
	@echo "********************************************************"
	$(CC) $(CFLAGS) -c $< -o $@
	@echo "********************************************************"

%.o: %.s
	@echo "\n"
	@echo "COMPILE S"
	@echo "********************************************************"
	$(CC) $(CFLAGS) -c $< -o $@
	@echo "********************************************************"

clean:
	@echo "Removing output files"
	@echo "********************************************************"
	rm -f $(OBJ) main.elf main.hex
	@echo "********************************************************"
