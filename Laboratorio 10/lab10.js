console.log("Laboratorio 10");


const http = require('http');

const requestHandler = require('./routes.js');

const server = http.createServer( requestHandler );

server.listen(3000);