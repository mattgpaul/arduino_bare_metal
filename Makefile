default:
	avr-gcc -Os -DF_CPU=16000000UL -mmcu=atmega328p -c -o blink.o src/app/blink.cpp
	avr-gcc -Os -DF_CPU=16000000UL -mmcu=atmega328p -c -o test.o src/app/port_device.cpp
	avr-gcc -o blink.bin blink.o port_device.o
	avr-objcopy -O ihex -R .eeprom blink.bin blink.hex
	sudo avrdude -F -V -c arduino -p ATMEGA328P -P /dev/ttyACM0 -b 115200 -U flash:w:blink.hex