'use strict';

var path = require('path');
var http = require('http');

//DATABASE
// Import the database connection
const db = require('./db');
require('dotenv').config();

// Example query to verify connection
// db.query('SELECT 1 + 1 AS solution')
//   .then(([rows]) => {
//     console.log('The solution is:', rows[0].solution);
//   })
//   .catch((err) => {
//     console.error('Error connecting to the database:', err.message);
//   });
// Test database connection
db.query('SELECT 1 + 1 AS solution')
  .then(([rows]) => {
    console.log('Database connected successfully! Test query result:', rows[0].solution);
  })
  .catch((err) => {
    console.error('Database connection failed:', err.message);
    process.exit(1); // Exit the process if the connection fails
  });


var oas3Tools = require('oas3-tools');
var serverPort = 8080;

// swaggerRouter configuration
var options = {
    routing: {
        controllers: path.join(__dirname, './controllers')
    },
};

var expressAppConfig = oas3Tools.expressAppConfig(path.join(__dirname, 'api/openapi.yaml'), options);
var app = expressAppConfig.getApp();

// Initialize the Swagger middleware
http.createServer(app).listen(serverPort, function () {
    console.log('Your server is listening on port %d (http://localhost:%d)', serverPort, serverPort);
    console.log('Swagger-ui is available on http://localhost:%d/docs', serverPort);
});


// //Check the DB connection
// db.query('SELECT * FROM synapses LIMIT 1')
//   .then(([rows]) => {
//     if (rows.length > 0) {
//       console.log('Synapses table is accessible. Example row:', rows[0]);
//     } else {
//       console.log('Synapses table is accessible but has no data.');
//     }
//   })
//   .catch((err) => {
//     console.error('Error querying the synapses table:', err.message);
//   });