#include "port_device.h"
#include <util/delay.h>
#include <avr/io.h>

int main(void){
    //PortDevice device(PORTB, PORTB5);
    volatile uint8_t& devicePort = PORTB;
    volatile uint8_t devicePin = PORTB5;
    DDRB |= (1 << DDB5);

    while (1){
        devicePort |= (1 << devicePin);

        _delay_ms(1000);

        devicePort &= ~(1 << devicePin);

        _delay_ms(1000);
    }

    return 0;
}