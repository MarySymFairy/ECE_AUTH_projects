# Microcontrollers and Processors

## 8th Semester, Aristotle University of Thessaloniki, 2024

This repository contains the source code for three assignments completed as part of the "Microprocessors and Peripherals" course.

Use of:
- *STM32F4 - ARM Cortex-M4*
- *Keil uVision5*
- *PuTTY*

## Assignments

### *Lab 1: Hash Calculation & Recursive Summation in Assembly*  
📌 Objective: Develop an assembly program to process input strings and compute a hash using a predefined algorithm.  

🔍 *Key Concepts Covered:*  
- String manipulation and character classification (uppercase, lowercase, digits).  
- Hash function implementation using a lookup table.  
- Recursive summation of hash digits to obtain a single-digit result.  
- Debugging and validating the assembly code using Keil tools.  

💡 *Analytical Insight:*  
This lab introduced *low-level programming concepts* using Assembly, helping to understand *data handling, stack operations, and recursive functions*. The emphasis was on *efficiency and optimization*, ensuring correct computation while managing processor constraints.

---

### *Lab 2: UART-based User Input & ISR for LED Control*  
📌 Objective: Implement a system where a microcontroller processes user input via UART and controls an LED based on button presses and a timer.  

🔍 *Key Concepts Covered:*  
- *Interrupt handling (ISR) for user input* through UART.  
- *LED control using GPIO pins* based on the last digit of a user-entered ID (AEM).  
- *Timer-based event execution* to toggle LEDs periodically.  
- *Button press interrupts* to manually toggle LED state.  

💡 *Analytical Insight:*  
This lab demonstrated *real-time embedded system principles*, focusing on *event-driven programming* and *interrupt-driven execution*. The use of ISRs minimized CPU usage while ensuring *responsiveness* to user input. By incorporating *timers and button interrupts*, the lab reinforced concepts of *multitasking and hardware-software integration*.

---

### *Lab 3: Sensor Integration & Adaptive LED Control*  
📌 Objective: Develop a microcontroller system that reads *temperature/humidity sensor data (DHT11)* and adjusts LED behavior dynamically.  

🔍 *Key Concepts Covered:*  
- *UART-based user input* to provide an AEM number.  
- *Temperature and touch sensor integration* for real-time data collection.  
- *Multiple ISRs handling different conditions* (e.g., LED turns on/off/blinks based on temperature ranges).  
- *Adaptive timer configuration* based on the touch sensor to modify sampling rates dynamically.  

💡 *Analytical Insight:*  
This lab introduced *sensor integration* into the microcontroller system, incorporating *real-time data acquisition and processing*. The project also explored *dynamic system behavior*, where external events (temperature and touch input) directly influenced *timing and control logic*. The combination of *event-driven execution and adaptive timing* showcased the power of *embedded systems in automation*.

---

### *Overall Analysis & Progression*  

| *Lab*   | *Core Focus* | *Technical Skills Developed* |
|-----------|---------------|--------------------------------|
| *Lab 1* | Assembly & Recursive Computation | String handling, recursion, hashing, low-level memory operations |
| *Lab 2* | UART & ISR for LED Control | Interrupt-driven programming, real-time response, GPIO manipulation |
| *Lab 3* | Sensor-Based System & Adaptive Control | Sensor integration, real-time data processing, adaptive event handling |

🔹 *From Low-Level Assembly to High-Level C Programming:*  
- Lab 1 focused on *pure computation and algorithmic logic* in Assembly.  
- Lab 2 introduced *hardware interaction via interrupts and GPIO handling*.  
- Lab 3 expanded on *dynamic real-time processing using sensors and adaptive timing*.  

---

### *Final Takeaway*  
These labs collectively built a *strong foundation in embedded systems programming*, covering:  
✅ *Low-level Assembly and High-level C programming*  
✅ *Interrupts, Timers, and Real-time Processing*  
✅ *UART, GPIO, and Peripheral Device Integration*  
✅ *Dynamic System Control Based on External Inputs*  

Each lab progressively introduced *more complexity, real-time responsiveness, and hardware interaction*, making the transition from theory to practical embedded system development.