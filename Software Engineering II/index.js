'use strict';

const path = require('path');
const http = require('http');
const oas3Tools = require('oas3-tools');
var serverPort = process.env.PORT || 8080; // Allow for environment-based port

// swaggerRouter configuration
var options = {
    routing: {
        controllers: path.join(__dirname, './controllers')
    },
};

var expressAppConfig = oas3Tools.expressAppConfig(path.join(__dirname, 'api/openapi.yaml'), options);
var app = expressAppConfig.getApp();


    // Initialize the Swagger middleware
if(process.env.NODE_ENV !== 'test') { 
    http.createServer(app).listen(serverPort, function () {
        console.log('Your server is listening on port %d (http://localhost:%d)', serverPort, serverPort);
        console.log('Swagger-ui is available on http://localhost:%d/docs', serverPort);
    });
}

module.exports = app;