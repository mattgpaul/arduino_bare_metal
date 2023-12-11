#ifndef PORT_DEVICE_H
#define PORT_DEVICE_H

#include <avr/io.h>

class PortDevice{
public:
    PortDevice(volatile uint8_t& port, uint8_t pin);
    void initialize();
    void setOutput(bool value);

private:
    volatile uint8_t& _port;
    uint8_t _pin;
};