console.log("Ejecutado con exito");

const filesystem = require('fs');
const express = require('express');
const bodyParser = require('body-parser');
const rutasPaginas = require('./routes/paginas');
const app = express();

//Middleware

app.use(bodyParser.urlencoded({extended: false}));

app.use((request, response, next) => {
    console.log('Middleware!');
    next(); //Le permite a la petición avanzar hacia el siguiente middleware
});



app.use(rutasPaginas);


app.get('/', (request, response, next) => {
    response.send('Pagina default'); 
});

app.use( (request, response, next) => {
    response.statusCode = 404;
    response.send('Pagina no encontrada :p'); 
});




               

app.listen(3000);