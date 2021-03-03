console.log("Ejecutado con exito");

const filesystem = require('fs');
const express = require('express');
const bodyParser = require('body-parser');
const rutasPaginas = require('./routes/paginas');
const rutasPersonajes = require('./routes/personajes');
const path = require('path');
const app = express();

//Middleware

app.use(bodyParser.urlencoded({extended: false}));
app.use(express.static(path.join(__dirname, 'public')));

app.set('view engine', 'ejs');
app.set('views', 'views');

app.use((request, response, next) => {
    console.log('Middleware!');
    next();
});

app.get('/paginahtml', (request, response, next) => {
    response.sendFile(path.join(__dirname, 'views', 'htmlcode.html'));
});

app.use('/personajes', rutasPersonajes);




app.use(rutasPaginas);

app.get('/', (request, response, next) => {
    response.send('Pagina default'); 
});

app.use( (request, response, next) => {
    response.statusCode = 404;
    response.send('Pagina no encontrada :p'); 
});

app.listen(3000);