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

const cookieParser = require('cookie-parser')

const session = require('express-session');

app.set('view engine', 'ejs');
app.set('views', 'views');

const rutasProductos = require('./routes/productos');
const rutasUsers = require('./routes/users');

//Middleware
app.use(bodyParser.urlencoded({extended: false}));
app.use(cookieParser());

//Para acceder a los recursos de la carpeta public
app.use(express.static(path.join(__dirname, 'public')));

app.use((request, response, next) => {
    console.log('Middleware!');
    next(); //Le permite a la petición avanzar hacia el siguiente middleware
});

app.use(session({
    secret: 'qwertyasdfzxcv', 
    resave: false, //La sesión no se guardará en cada petición, sino sólo se guardará si algo cambió 
    saveUninitialized: false, //Asegura que no se guarde una sesión para una petición que no lo necesita
}));

app.use('/productos', rutasProductos);

app.use('/users', rutasUsers);

app.get('/', (request, response, next) => {
    console.log(request.session);
    response.send('<h1>Pagina default</h1>'); 
});


app.use( (request, response, next) => {
    //response.statusCode = 404;
    response.status(404);
    response.send('Aqui no hay nada, busca en otro sitio'); //Manda la respuesta
} );

app.listen(3000);