blink:
	avr-g++ -Os -DF_CPU=16000000UL -mmcu=atmega328p \
	-I/home/matthew/dev/tools/avr8-gnu-toolchain-linux_x86_64/include \
	-L/home/matthew/dev/tools/avr8-gnu-toolchain-linux_x86_64/include \
	-g -w src/app/port_device.cpp src/app/blink.cpp -o blink
	avr-g++ -o blink.bin blink
	avr-objcopy -O ihex -R .eeprom blink.bin blink.hex
	sudo avrdude -F -V -c arduino -p ATMEGA328P -P /dev/ttyACM0 -b 115200 -U flash:w:blink.hex