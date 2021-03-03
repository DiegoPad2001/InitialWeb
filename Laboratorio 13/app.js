console.log('hola, mundo!');
console.log('Ya no tuve que detener el servidor');
console.log('Genial!');

//¿Qué es json?
//json: javascript object notation
//{nombre_atributo: valor}

const express = require('express');
const bodyParser = require('body-parser');
const path = require('path');
const app = express();

app.set('view engine', 'ejs');
app.set('views', 'views');

const rutasProductos = require('./routes/productos');

//Middleware
app.use(bodyParser.urlencoded({extended: false}));

//Para acceder a los recursos de la carpeta public
app.use(express.static(path.join(__dirname, 'public')));

app.use((request, response, next) => {
    console.log('Middleware!');
    next(); //Le permite a la petición avanzar hacia el siguiente middleware
});

app.use('/productos', rutasProductos);

app.get('/', (request, response, next) => {
    response.send('<h1>Pagina default</h1>'); 
});


app.use( (request, response, next) => {
    //response.statusCode = 404;
    response.status(404);
    response.send('Aqui no hay nada, busca en otro sitio'); //Manda la respuesta
} );

app.listen(3000);