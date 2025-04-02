/*
*	Lab2
* FILE: main.c
* THMMY, 8th semester, Microprocessors & Peripherals
*  
* Authors:
*   Aimilia Xakoustou, 10324, xakoustou@ece.auth.gr
*   Maria Mamougiorgi , 10533, mmamougi@ece.auth.gr
*
* 
*/

#include "platform.h"
#include <stdio.h>
#include <stdint.h> 
#include "uart.h"
#include "queue.h"
#include "gpio.h" 
#include "timer.h"

#define BUFF_SIZE 128 //read buffer length
#define LED_PIN PA_5 //THIS IS THE GREEN LED. CHOOSE IT BECAUSE THE PDF WRITES THAT PA_5 IS FOR USERS @@@
#define BUTTON_PIN PC_13   // BUTTON  // SO AS TO DEFINE WHICH OF EACH IS ON THE BOARD @@@


Queue rx_queue; // Queue for storing received characters

static uint32_t counter=0; //HOW MANY TIMES THE BUTTON HAS PRESSED, USE THIS TYPE TO HAVE MORE INSTEAD OF INT @@@
static char str[100]={};		//INITIALIZE STRING FOR UART PRINT @@@
//static int last_digit = 0; //THE LAST DIGIT OF AEM INITIALIZED WITH 0 @@@
	
	
// Interrupt Service Routine for UART receive
void uart_rx_isr(uint8_t rx) {
	// Check if the received character is a printable ASCII character from 0 to 9 and enter space
	if ((rx >= '0' && rx <= '9') || (rx=='\r')) {
		// Store the received character
		queue_enqueue(&rx_queue, rx);
	}
}
// @@@

void timer_isr(){ // THE ISR OF TIMER @@@
	gpio_toggle(LED_PIN); //IT IS A FUNCTION FROM GPIO.H WHICH TOGGLE THE LED_PIN 
	//WHEN THE LED_PIN IS HIGH THEN IT TURNS IT TO LOW AND VISE VERSA
	//I USE IT SO AS TO HAVE ,DEPENDING ON TIMER, THE ON-OFF SITUATION
}

// @@@
void odd_isr(){ //@@@ THE ISR OF ODD AEM'S LAST DIGIT
	timer_enable(); // ENABLE THE TIMER
	gpio_toggle(LED_PIN);  //CALL ESSENTIALLY THE TIMER ISR SO AS TO DO THE TOGGLED SITUATION 
	uart_print("\n\rLED is toggled.");
}

void even_isr(){ //@@@ THE ISR OF EVEN AEM'S LAST DIGIT
	timer_disable(); //DISABLE THE TIMER
	//THE LED_PIN HOLDS THE LAST STATUS OF LED_PIN
	//LED_PIN TAKES THE LAST STATUS OF LED
	if(gpio_get(LED_PIN)) //IF THE LED_PIN=HIGH=ON 
		uart_print("\n\rLED is ON.");
	else //OTHERWISE THE LED_PIN=LOW=OFF
		uart_print("\n\rLED is OFF.");
}
//I ONLY NEED TIMER ENABLE WHEN LAST_DIGIT%2!=0
void button_press_isr(){ //@@@ THE ISR OF BUTTON PRESS
	
	timer_disable(); //DISABLE THE TIMER
	counter++; //INCREASE COUNTER BY 1 SINCE BUTTON HAS BEEN PRESSED
	
	if(!gpio_get(LED_PIN)){ //IF LED_PIN=LOW=OFF
		gpio_set(LED_PIN,LED_ON); // SET LET_PIN=HIGH=ON
		sprintf(str, "\n\rThe button pressed %u times.\n\rLED is ON.\n\n\rGive me your AEM: ",counter);
		uart_print(str); //dynamic memory allocation within UART
	}
	else { //OTHERWISE THE LED_PIN=HIGH=ON
		 gpio_set(LED_PIN,LED_OFF); //SET LET_PIN=LOW=OFF
		 sprintf(str, "\n\rThe button pressed %u times.\n\rLED is OFF.\n\n\rGive me your AEM: ",counter);
     uart_print(str); //dynamic memory allocation within UART
	}
}

//
int main() {
	
	// Variables to help with UART read
	uint8_t rx_char = 0;
	char buff[BUFF_SIZE]; // The UART read string will be stored here
	uint32_t buff_index;
	int last_digit=0; //the last digit of AEM @@@

	// Initialize the receive queue and UART
	queue_init(&rx_queue, 128);
	uart_init(115200);
	uart_set_rx_callback(uart_rx_isr); // Set the UART receive callback function
	uart_enable(); // Enable UART module
	
	//@@@//USE THESE FUNCTIONS FROM TIMER.H
	timer_init(500000); //INITIALIZE TIMER IN MICROSEC (0.5SEC) @@@
	timer_disable(); //DISABLE THE TIMER BECAUSE I'VE NOT NEEDED IT YET.I ENABLE IT ONLY WHEN ODD_ISR CALLED
	timer_set_callback(timer_isr); //SO AS TO PASS A CALL BACK TO THE API
	//WHEN A TIMER INTERRUPT OCCURS THEN THE TIMER_ISR CALLED AUTOMACALLY BY THIS FUNCTION
	
	gpio_set_mode(LED_PIN,Output); //SET THE LED_PIN AS AN OUTPUT SO AS TO CONTROLL IT
	gpio_set(LED_PIN,LED_OFF); //INITIALIAZE THE LED_PIN TO BE OFF SO AS TO ENSURE THE WANTED BEHAVIOR
	
	gpio_set_mode(BUTTON_PIN, PullUp);  // BUTTON_PIN IS SET TO BE 1 AKA NOT PRESSED
	gpio_set_trigger(BUTTON_PIN, Rising);  // ISR IS SET TO TRIGGER ON 0 TO 1.TRIGGER AN INTERRUPT ON A RISING EDGE.LOW --> HIGH
	gpio_set_callback(BUTTON_PIN, button_press_isr); //CALLBACK FUNCTION SO AS EVERY TIME THE BUTTON IS PRESSES, TO CALL THE BUTTON_PRESS_ISR
	//@@@//
	
	__enable_irq(); // Enable interrupts
	
	while(1) {
		uart_print("\r\n");// Print newline
		// Prompt the user to enter their AEM
		uart_print("\n\rGive me your AEM: ");
		buff_index = 0; // Reset buffer index
		
		do {
			// Wait until a character is received in the queue
			while (!queue_dequeue(&rx_queue, &rx_char))
				__WFI(); // Wait for Interrupt

			if (rx_char == 0x7F) { // Handle backspace character
				if (buff_index > 0) {
					buff_index--; // Move buffer index back
					uart_tx(rx_char); // Send backspace character to erase on terminal
				}
			}
      
			else {
				// Store and echo the received character back
				buff[buff_index++] = (char)rx_char; // Store character in buffer
				uart_tx(rx_char); // Echo character back to terminal
			}
		} while (rx_char != '\r' && buff_index < BUFF_SIZE); // Continue until Enter key or buffer full
		
		// Replace the last character with null terminator to make it a valid C string
		buff[buff_index - 1] = '\0';
		//@@@
		last_digit=buff[buff_index - 2];//BUFF[BUFF_INDEX -2] BECAUSE I WANT THE LAST DIGIT OF MY STRING AND THE BUFF[BUFF_INDEX -1] AS GIVEN IS THE NULL CHARACTER SO I TAKE THE PREVIOUS @@@
	
		last_digit=last_digit%2; //SO AS TO TAKE THE MODULO OF THE LAST DIGIT OF AEM SO AS TO SEE IF IT IS AN ODD OR EVEN NUMBER @@@
			if(last_digit == 0) //IF IT IS AN EVEN NUMBER
					even_isr(); //CALL EVEN ISR
			else //OTHERWISE AN ODD ISR
					odd_isr(); //CALL ODD ISR
		//@@@
			
		// Check if buffer overflow occurred
		if (buff_index > BUFF_SIZE) {
			uart_print("Stop trying to overflow my buffer! I resent that!\r\n");
		}
	}
}
