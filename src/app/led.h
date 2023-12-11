#pragma once

#include <string>
#include <avr/io.h>
#include <util/delay.h>

class PortDevice{
private:
    char _port_char;
    int _port_num;
    bool _direction;
    std::string _name;

public:
    PortDevice(char port_char, int port_num, bool data_direction, std::string device_name);
    char get_port_char();
    int get_port_num();
    bool get_data_direction();
    std::string get_device_name();
};