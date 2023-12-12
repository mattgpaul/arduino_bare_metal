# Directories
ATMEGA328P_ROOT_DIR = /home/matthew/dev/tools/atmega328p
ATMEGA328P_BIN_DIR = $(ATMEGA328P_ROOT_DIR)/bin
ATMEGA328P_INCLUDE_DIR = $(ATMEGA328P_ROOT_DIR)/include
INCLUDE_DIRS = $(ATMEGA328P_INCLUDE_DIR)
LIB_DIRS = $(ATMEGA328P_INCLUDE_DIR)
BUILD_DIR = build
OBJ_DIR = $(BUILD_DIR)/obj
BIN_DIR = $(BUILD_DIR)/bin

# Toolchain
CC = $(ATMEGA328P_BIN_DIR)/avr-g++

# Files
TARGET = $(BIN_DIR)/blink

SOURCES = src/app/blink.cpp src/app/port_device.cpp

OBJECT_NAMES = $(SOURCES:.cpp=.o)
OBJECTS = $(patsubst %, $(OBJ_DIR)/%,$(OBJECT_NAMES))

# Flags
MCU = atmega328p
CPU_CLOCK = 16000000UL
WFLAGS = -Wall -Wextra -Werror -Wshadow
CFLAGS = -mmcu=$(MCU) -DF_CPU=$(CPU_CLOCK) $(WFLAGS) $(addprefix -I,$(INCLUDE_DIRS)) -Os -g
LDFLAGS = -mmcu=$(MCU) -DF_CPU=$(CPU_CLOCK) $(addprefix -L,$(LIB_DIRS)) -Os -g

$(TARGET): $(OBJECTS)
	@mkdir -p $(dir $@)
	$(CC) $(LDFLAGS) $^ -o $@
	avr-g++ -o blink.bin blink
	avr-objcopy -O ihex -R .eeprom blink.bin blink.hex
	sudo avrdude -F -V -c arduino -p ATMEGA328P -P /dev/ttyACM0 -b 115200 -U flash:w:blink.hex

## Compiling
$(OBJ_DIR)/%.o: %.cpp
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c -o $@ $^