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

$(TARGET):
	$(CC) -Os -DF_CPU=16000000UL -mmcu=atmega328p \
	-I $(INCLUDE_DIRS) \
	-L $(LIB_DIRS) \
	-g -w src/app/port_device.cpp src/app/blink.cpp -o blink
	avr-g++ -o blink.bin blink
	avr-objcopy -O ihex -R .eeprom blink.bin blink.hex
	sudo avrdude -F -V -c arduino -p ATMEGA328P -P /dev/ttyACM0 -b 115200 -U flash:w:blink.hex