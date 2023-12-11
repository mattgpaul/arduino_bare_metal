#include "port_device.h"

PortDevice::PortDevice(volatile uint8_t& port, volatile uint8_t pin):_port(port), _pin(pin){}

void PortDevice::initialize(){
    DDRB |= _BV(DDB5);
}

void PortDevice::setOutput(bool value){
    if (value){
        _port |= (1 << _pin);
    } 
    else{
        _port &= ~(1 << _pin);
    }
}