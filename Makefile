CC := avr-gcc
OBJCOPY := avr-objcopy
AVRDUDE := sudo avrdude

MCU := atmega328p
F_CPU := 16000000UL
PORT := /dev/ttyACM0

CFLAGS := -Os -DF_CPU=$(F_CPU) -mmcu=$(MCU)

SRC_DIR := src/app
BUILD_DIR := build

SRC := $(wildcard $(SRC_DIR)/*.cpp)
OBJ := $(patsubst $(SRC_DIR)/%.cpp,$(BUILD_DIR)/%.o,$(SRC))
ELF := $(BUILD_DIR)/blink.elf
HEX := $(BUILD_DIR)/blink.hex

all: $(HEX)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp
    $(CC) $(CFLAGS) -c $< -o $@

$(ELF): $(OBJ)
    $(CC) -o $@ $^

$(HEX): $(ELF)
    $(OBJCOPY) -O ihex -R .eeprom $< $@

flash: $(HEX)
    $(AVRDUDE) -F -V -c arduino -p $(MCU) -P $(PORT) -b 115200 -U flash:w:$<

clean:
    rm -f $(BUILD_DIR)/*.o $(ELF) $(HEX)
