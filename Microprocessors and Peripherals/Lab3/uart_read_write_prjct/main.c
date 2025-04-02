/*
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
#define LED_PIN PB_5 //THIS IS THE GREEN LED. CHOOSE IT BECAUSE THE PDF WRITES THAT PA_5 IS FOR USERS @@@
#define TOUCH_PIN PA_10   // BUTTON  // SO AS TO DEFINE WHICH OF EACH IS ON THE BOARD @@@
#define TEMP_PIN PA_8

int period=2; //Timer period
int counter=0; //Timer counter
float temperature=0.0; //Temperature value
float humidity=0.0; // Humidity value
char str[100]={}; // Buffer for UART output
int touch_counter=0; // Counter for touch button presses
int sum=0; //the sum of the two last digits of AEM
int last_digit=0; // Last digit of the entered AEM
int prelast_digit=0; // Second to last digit of the entered AEM

Queue rx_queue; // Queue for storing received characters

// Interrupt Service Routine for UART receive
void uart_rx_isr(uint8_t rx) {
	// Check if the received character is a printable ASCII character
	if (rx >= 0x0 && rx <= 0x7F ) {
		// Store the received character
		queue_enqueue(&rx_queue, rx);
	}
}

void temp_gt(){ //Function to set the LED ?? when temperature is greater than 25°C
    gpio_set(LED_PIN,1);

}

void temp_lt() { //Function to clear the LED OFF when temperature is less than 20°C
    gpio_set(LED_PIN,0);

}

void temp_mid(){ //Function to toggle the LED for temperatures between 20°C and 25°C
    gpio_toggle(LED_PIN);
}
void timer_isr(){ // Timer ISR
    counter++; // Increment the counter
	
	
    if(counter>=period){
        counter=0; // Reset counter if it reaches the period

     // Start reading temperature and humidity from DHT sensor
    int i;
    gpio_set_mode(TEMP_PIN, Output);
    gpio_set(TEMP_PIN, 0);
    delay_ms(18);  // The sensor remains in PullDown mode for 18ms

    gpio_set(TEMP_PIN, 1); // After that delay the pin is set at PullUp mode again
    delay_us(30);  // Remains in that mode for 30us (synchronization reasons)

    gpio_set_mode(TEMP_PIN, Input);  // Sets at Input mode to read the data
    delay_us(40);  // 40us delay before reading data

    if (!gpio_get(TEMP_PIN)) {
        delay_us(80); // Wait for sensor response
    }

    while (gpio_get(TEMP_PIN)); // Wait for sensor to pull down

    uint8_t humidity_int = 0; // Variables to store sensor data
    uint8_t humidity_dec = 0;
    uint8_t temp_int = 0;
    uint8_t temp_dec = 0;

    // Read 40 bits from the sensor
    for (i = 0; i < 40; i++) {  // 40 bits are read
        while (!gpio_get(TEMP_PIN)); // Wait for the signal to go high
        delay_us(40);  // wait 40us to read the bit

    // Read the bit and store in appropriate variable(the first 16bits belong to humidity)
        if (gpio_get(TEMP_PIN) == 0) {  // If the signal is low (bit is 0)
            if (i / 8 == 0) {
                humidity_int &= ~(1 << (7 - i % 8));  // Stores the integer part of the humidity
            } else if (i / 8 == 1) {
                humidity_dec &= ~(1 << (7 - i % 8));  // Stores the decimal part of the humidity
            } else if (i / 8 == 2) {
                temp_int &= ~(1 << (7 - i % 8));  // Stores the integer part of the temperature
            } else if (i / 8 == 3) {
                temp_dec &= ~(1 << (7 - i % 8));  // Stores the decimal part
            }
        } else {  // If the signal is high (bit is 1)
            if (i / 8 == 0) {
                humidity_int |= (1 << (7 - i % 8)); //humidity_int |= (1 << (7 - i % 8)): The |= operator performs a bitwise OR operation between humidity_int and the mask. This operation sets the specific bit to 1 and leaves all other bits unchanged.
            } else if (i / 8 == 1) {
                humidity_dec |= (1 << (7 - i % 8)); 
								//(1 << (7 - i % 8)); //As before, this shifts the number 1 left by (7 - i % 8) positions to create a mask with only the desired bit position set to 1.
            } else if (i / 8 == 2) {
                temp_int |= (1 << (7 - i % 8));
            } else if (i / 8 == 3) {
                temp_dec |= (1 << (7 - i % 8));
            }
            while (gpio_get(TEMP_PIN)); // Wait for the signal to go low
        }
       /* The bits are grouped in bytes, so the code uses i / 8 to determine which byte the current bit belongs to:
i / 8 == 0 corresponds to the integer part of humidity.
i / 8 == 1 corresponds to the decimal part of humidity.
i / 8 == 2 corresponds to the integer part of temperature.
i / 8 == 3 corresponds to the decimal part of temperature.
The bit within the byte is determined by 7 - i % 8. This gives the correct position of the bit within the current byte, as the most significant bit (MSB) is read first.
   */ }

    gpio_set_mode(TEMP_PIN, PullUp); // return the DHT pin to PullUp mode after the data is read
// Convert the read data to temperature and humidity values
    temperature = temp_int;
    if (temp_dec & 0x80) { //This checks if the most significant bit (MSB) of temp_dec is set
    // Check if the most significant bit (MSB) of the decimal part of the temperature is set
// If the MSB is set, it indicates a negative temperature
        temperature = -1 - temperature; // Convert the temperature to negative
    }
// Add the fractional part of the temperature to the temperature variable
// Only the lower 4 bits (0x0F) are used to get the decimal part
    temperature += (temp_dec & 0x0f) * 0.1;

    humidity = humidity_int + (humidity_dec * 0.1); //humidity = humidity_int + (humidity_dec * 0.1);

		if(touch_counter==0){
			sprintf(str,"Temperature: %lf and period: %d\n\r",temperature,period);
			uart_print(str);
		}
		else if ((touch_counter%2)==1){
					sprintf(str,"Temperature: %lf and period: %d\n\r",temperature,period);
					uart_print(str);
			 }
		else{ //if ((touch_counter%2)==0){
			sprintf(str,"Temperature: %lf C and Humidity: %lf %% period:%d \n\r",temperature,humidity,period);
			uart_print(str);
		}
	} 
    if(temperature>25) // Check and act on the temperature
        temp_gt();
    else if (temperature<20)
        temp_lt();
    else
        temp_mid();

}


void touch_isr(){ // Touch sensor ISR

    touch_counter++;
    //Change temperature reading period based on the sum of last and second to last digit
    if (touch_counter==1){ //allagi rithmou thermokrasias last + pre_last
        
			if(sum==2){
				period=4;  //4sec
			}				
			else{
				period=sum;
			}
		}
	else if ((touch_counter%2)==1){
		period=3; //an einai even --> T=3 sec
	}
}


int main() {

	// Variables to help with UART read
	uint8_t rx_char = 0;
	char buff[BUFF_SIZE]; // The UART read string will be stored here
	uint32_t buff_index;

	// Initialize the receive queue and UART
	queue_init(&rx_queue, 128);
	uart_init(115200);
	uart_set_rx_callback(uart_rx_isr); // Set the UART receive callback function
	uart_enable(); // Enable UART module

	// Initialize TOUCH
	gpio_set_mode(TOUCH_PIN, Input);
	gpio_set_trigger(TOUCH_PIN, Rising);
	gpio_set_callback(TOUCH_PIN,touch_isr);


	//Initialize TIMER
	timer_init(1000000); //INITIALIZE TIMER IN MICROSEC (1SEC) @@@
	timer_disable();
	timer_set_callback(timer_isr);

	//Initialize LED
	gpio_set_mode(LED_PIN,Output);
	gpio_set(LED_PIN, 0);


	__enable_irq(); // Enable interrupts

	uart_print("\r\n");// Print newline

	// Prompt the user to enter their full name
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
		} else {
			// Store and echo the received character back
			buff[buff_index++] = (char)rx_char; // Store character in buffer
			uart_tx(rx_char); // Echo character back to terminal
		}
	} while (rx_char != '\r' && buff_index < BUFF_SIZE); // Continue until Enter key or buffer full

	// Replace the last character with null terminator to make it a valid C string
	buff[buff_index - 1] = '\0';
	uart_print("\r\n"); // Print newline


  last_digit=buff[buff_index - 2]-'0'; // Extract the last two digits from the entered AEM
  prelast_digit=buff[buff_index - 3]-'0'; //SUB the '0' so as to take the ASCII character because the buff is a string and i want an integer
	sum = last_digit + prelast_digit;
	timer_enable();
	
	// Check if buffer overflow occurred
	if (buff_index > BUFF_SIZE) {
		uart_print("Stop trying to overflow my buffer! I resent that!\r\n");
	}
	while(1){
		__WFI(); // Wait for interrupt											
	}
}

