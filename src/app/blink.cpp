#include "port_device.h"
#include <util/delay.h>
#include <avr/io.h>

int main(void){
    volatile uint8_t& devicePort = PORTB;
    volatile uint8_t devicePin = PORTB5;
    volatile uint8_t deviceDirection = DDB5;

    PortDevice led(devicePort, devicePin, deviceDirection);

    led.initialize();

    while (1){
        led.setOutput(true);

        _delay_ms(1000);

        led.setOutput(false);

        _delay_ms(1000);
    }

    return 0;
}