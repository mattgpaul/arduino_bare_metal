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
OBJ_COPY = $(ATMEGA328P_BIN_DIR)/avr-objcopy

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

## Compiling
$(OBJ_DIR)/%.o: %.cpp
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c -o $@ $^

# Phonies
.PHONY: all clean

all: $(TARGET)

clean:
	$(RM) -r $(BUILD_DIR)

flash: $(TARGET)
	$(CC) -o $(TARGET).bin $(TARGET)
	$(OBJ_COPY) -O ihex -R .eeprom $(TARGET).bin $(TARGET).hex
	sudo avrdude -F -V -c arduino -p ATMEGA328P -P /dev/ttyACM0 -b 115200 -U flash:w:$(TARGET).hex
