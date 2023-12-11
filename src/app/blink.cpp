#include "port_device.h"
#include <util/delay.h>

int main(){
    volatile uint8_t& devicePort = PORTB;
    uint8_t devicePin = PORTB5;

    PortDevice device(devicePort, devicePin);

    device.initialize();

    while (1){
        device.setOutput(true);

        _delay_ms(500);

        device.setOutput(false);

        _delay_ms(500);
    }

    return 0;
}