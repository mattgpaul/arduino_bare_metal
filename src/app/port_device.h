#ifndef PORT_DEVICE_H
#define PORT_DEVICE_H

#include <avr/io.h>

class PortDevice{
public:
    PortDevice(volatile uint8_t& port, volatile uint8_t pin, volatile uint8_t _direction);
    void initialize();
    void setOutput(bool value);

private:
    volatile uint8_t& _port;
    volatile uint8_t _pin;
    volatile uint8_t _direction;
};

#endif // PORT_DEVICE_H