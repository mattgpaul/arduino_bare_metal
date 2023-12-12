#include "port_device.h"

PortDevice::PortDevice(volatile uint8_t& port, volatile uint8_t pin, volatile uint8_t direction):_port(port), _pin(pin), _direction(direction){}

void PortDevice::initialize(){
    DDRB |= (1 << _direction);
}

void PortDevice::setOutput(bool value){
    if (value){
        _port |= (1 << _pin);
    } 
    else{
        _port &= ~(1 << _pin);
    }
}