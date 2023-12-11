#include "port_device.h"

PortDevice::PortDevice(volatile uint8_t& port, uint8_t pin) : _port(port), _pin(pin) {};

void PortDevice::initialize(){
    _port |= _BV(_pin);
};

void PortDevice::setOutput(bool value){
    if (value){
        _port |= _BV(_pin);
    } 
    else{
        _port &= ~_BV(_pin);
    };
};