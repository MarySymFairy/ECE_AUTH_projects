#include "platform.h"
#include <stdint.h>
#include "delay.h"


extern void delay_cycles(unsigned int cycles);

void delay_ms(unsigned int ms) {
	unsigned int max_step = 1000 * (UINT32_MAX / SystemCoreClock);
	unsigned int max_sleep_cycles = max_step * (SystemCoreClock / 1000);
	while (ms > max_step) {
		ms -= max_step;
		delay_cycles(max_sleep_cycles);
	}
	delay_cycles(ms * (SystemCoreClock / 1000));
}

void delay_us(unsigned int us) {
	unsigned int max_step = 1000000 * (UINT32_MAX / SystemCoreClock);
	unsigned int max_sleep_cycles = max_step * (SystemCoreClock / 1000000);
	while (us > max_step) {
		us -= max_step;
		delay_cycles(max_sleep_cycles);
	}
	delay_cycles(us * (SystemCoreClock / 1000000));
}



// *******************************ARM University Program Copyright © ARM Ltd 2016*************************************
