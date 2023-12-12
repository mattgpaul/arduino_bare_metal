# Directories
ATMEGA328P_ROOT_DIR = /home/matthew/dev/tools/atmega328p
ATMEGA328P_BIN_DIR = $(ATMEGA328P_ROOT_DIR)/bin
ATMEGA328P_INCLUDE_DIR = $(ATMEGA328P_ROOT_DIR)/include
INCLUDE_DIRS = $(ATMEGA328P_INCLUDE_DIR)
LIB_DIRS = $(ATMEGA328P_INCLUDE_DIR)

# Toolchain
CC = $(ATMEGA328P_BIN_DIR)/avr-g++

# Files
TARGET = blink

# Flags
MCU = atmega328p
CPU_CLOCK = 16000000UL
WFLAGS = -Wall -Wextra -Werror -Wshadow
CFLAGS = -mmcu=$(MCU) -DF_CPU=$(CPU_CLOCK) $(WFLAGS) $(addprefix -I,$(INCLUDE_DIRS)) -Os -g
LDFLAGS = -mmcu=$(MCU) -DF_CPU=$(CPU_CLOCK) $(addprefix -L,$(LIB_DIRS)) -Os -g

$(TARGET): blink.o port_device.o
	$(CC) $(LDFLAGS) src/app/port_device.o src/app/blink.o -o $(TARGET)
	avr-g++ -o blink.bin blink
	avr-objcopy -O ihex -R .eeprom blink.bin blink.hex
	sudo avrdude -F -V -c arduino -p ATMEGA328P -P /dev/ttyACM0 -b 115200 -U flash:w:blink.hex

## Compiling
blink.o: src/app/blink.cpp
	$(CC) $(CFLAGS) -c -o src/app/blink.o src/app/blink.cpp

port_device.o: src/app/port_device.cpp
	$(CC) $(CFLAGS) -c -o src/app/port_device.o src/app/port_device.cpp
