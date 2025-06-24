let dark = false;
function toggleDarkMode() {
  dark = !dark;
  document.documentElement.classList.toggle('dark', dark);
}

const commonOptions = {
  responsive: true,
  maintainAspectRatio: false,  // Important to fill container height properly
  animation: false,
  scales: {
    x: { display: false },
    y: {
      min: 0,
      //max: 50,
      ticks: { color: '#888' }
    }
  },
  plugins: {
    legend: { labels: { color: '#888' } }
  }
};

const ctxTemp = document.getElementById('tempChart').getContext('2d');
const tempChart = new Chart(ctxTemp, {
  type: 'line',
  data: {
    labels: [],
    datasets: [{
      label: 'Temperature (°C)',
      borderColor: '#f87171',
      backgroundColor: 'rgba(248,113,113,0.1)',
      data: [],
      fill: true,
      tension: 0.3
    }]
  },
  options: { ...commonOptions, scales: {...commonOptions.scales, y: {...commonOptions.scales.y, max: 50}} }
});

const ctxHum = document.getElementById('humidityChart').getContext('2d');
const humidityChart = new Chart(ctxHum, {
  type: 'line',
  data: {
    labels: [],
    datasets: [{
      label: 'Humidity (%)',
      borderColor: '#3b82f6',
      backgroundColor: 'rgba(59,130,246,0.1)',
      data: [],
      fill: true,
      tension: 0.3
    }]
  },
  options: { ...commonOptions, scales: {...commonOptions.scales, y: {...commonOptions.scales.y, max: 100}} }
});


if (!!window.EventSource) {
  // Create a new EventSource to listen for events from the ESP32
  //var source = new EventSource('/events');
  var source = new EventSource('http://192.168.1.217/events');

  source.addEventListener('open', function(e) {
    document.getElementById("status").textContent = "🟢 Connected to ESP32";
  });

  source.addEventListener('error', function(e) {
    if (e.target.readyState !== EventSource.OPEN) {
      document.getElementById("status").textContent = "🔴 Disconnected";
    }
  });


  // Handle temperature event
  source.addEventListener('temperature', function(e) {
        console.log("temperature", e.data);
    const temp = parseFloat(e.data);
    document.getElementById("temp").textContent = temp.toFixed(1) + " °C";

    const timestamp = new Date().toLocaleTimeString();
    if (tempChart.data.labels.length > 20) {
      tempChart.data.labels.shift();
      tempChart.data.datasets[0].data.shift();
    }
    tempChart.data.labels.push(timestamp);
    tempChart.data.datasets[0].data.push(temp);
    tempChart.update();
  });

  // Handle humidity event
  source.addEventListener('humidity', function(e) {
        console.log("humidity", e.data);
    const humidity = parseFloat(e.data);
    document.getElementById("humidity").textContent = humidity.toFixed(1) + " %";

    const timestamp = new Date().toLocaleTimeString();
    if (humidityChart.data.labels.length > 20){
      humidityChart.data.labels.shift();
      humidityChart.data.datasets[0].data.shift();
    }
    humidityChart.data.labels.push(timestamp);
    humidityChart.data.datasets[0].data.push(humidity);
    humidityChart.update();
  });


  // Handle pressure event
  source.addEventListener('pressure', function(e) {
        console.log("pressure", e.data);
    const pressure = parseFloat(e.data);
    document.getElementById("pressure").textContent = pressure.toFixed(1) + " hPa";
    //document.getElementById("pressure").innerHTML = e.data + " hPa";
  });

  // Handle UV event
  source.addEventListener('UV', function(e) {
          console.log("UV", e.data);

    const UV = parseInt(e.data);
    document.getElementById("UV").textContent = UV;
  });



  // Optional: ignore ping or hello messages to avoid console spam
  source.addEventListener('ping', () => {});
  source.addEventListener('message', () => {});
}
