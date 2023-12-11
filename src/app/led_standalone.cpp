#include <avr/io.h>
#include <util/delay.h>

#define MS_DELAY 1000

int main(void){
    // set PORTB5 as an output
    DDRB = DDRB | (1 << DDB5);

    // loop forever
    while(1){
        // set PORTB5
        PORTB = PORTB | (1 << PORTB5);

        // wait
        _delay_ms(MS_DELAY);

        // unset PORTB5
        PORTB = PORTB & ~(1 << PORTB5);

        // wait again
        _delay_ms(MS_DELAY);

    }
}