# Distributed Generation
# Smart Weather Station with ESP32 and Sensors

## 10th Semester, Aristotle University of Thessaloniki, 2024

A complete real-time environmental monitoring system using the ESP32 microcontroller. 
![dashboard_with_uv](https://github.com/user-attachments/assets/7b738173-c7ef-41d6-95eb-3c60f0e8e74d)


## 🧪 Sensors & Components

| Component     | Description                                     |
|---------------|-------------------------------------------------|
| **ESP32**     | Microcontroller with Wi-Fi, acts as web server  |
| **DHT22**     | Temperature and humidity sensor                 |
| **BMP280**    | Atmospheric pressure sensor (I2C)               |
| **GUVA-S12SD**| Analog UV sensor                                |
| **Other**     | Breadboard, jumper wires, 10kΩ pull-up resistor, power bank |

---


## 🌐 System Overview

- The **ESP32** runs as a **web server**, hosting a static dashboard webpage.
- It reads data from sensors every 5 seconds.
- Data is pushed to connected clients using **Server-Sent Events (SSE)**.
- The browser updates the UI and charts in real time using **Chart.js**.
- **Dark mode** support using TailwindCSS.

---


## 📁 Project Structure

```
├── ESP32_Web_Server.ino      # ESP32 code with Web Server + SSE
├── data/
│   ├── index.html            # HTML dashboard interface
│   ├── script.js             # Real-time updates + Chart.js
│   └── (optional) style.css
```

> 📦 All dashboard files are stored in the ESP32's **LittleFS** filesystem.

---


## 🚀 Getting Started

1. **Arduino IDE Setup**
   - Board: ESP32 Dev Module
   - Required libraries:
     - `ESPAsyncWebServer.h`
     - `AsyncTCP.h`
     - `Adafruit_BMP280.h`
     - `DHT.h`
     - `LittleFS.h`

2. **Upload Static Files**
   - Use the **ESP32 Sketch Data Upload Tool** to upload `data/` contents to LittleFS.

3. **Upload Sketch**
   - Flash the `ESP32_Web_Server.ino` code to your ESP32.

4. **Access Dashboard**
   - Open a web browser and visit the ESP32’s local IP address.

---

## 📊 Dashboard Features

- 🌡️ Real-time temperature reading
- 💧 Humidity display
- ☀️ UV index monitoring
- 🧭 Atmospheric pressure
- 📈 Live temperature & humidity charts
- 🌙 Toggleable dark mode

---

## 🛠 Technologies Used

- **ESP32 + Arduino IDE**
- **LittleFS** (for serving static files)
- **Server-Sent Events (SSE)** for live updates
- **Chart.js** (live graphs)
- **TailwindCSS** (responsive UI and dark mode)

---

## 🎓 Academic Info

- 📚 Course: *Distributed Generation*  
- 🧑‍💻 Students: Maria Mamougiouri (10533), Aimilia Xakoustou (10324)

📎 [Presentation (PDF)](Smart-Weather-Station-with-ESP32-and-Sensors.pdf)  
📹 [Demo Video](https://drive.google.com/file/d/1KuAOw3-lOCTJUKhis-x3DrCXrxjpNN44/view?usp=sharing)

---
