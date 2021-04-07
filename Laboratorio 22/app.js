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

const csrf = require('csurf');
const csrfProtection = csrf();

app.set('view engine', 'ejs');
app.set('views', 'views');

const rutasProductos = require('./routes/productos');
const rutasUsers = require('./routes/users');

//Middleware
app.use(bodyParser.urlencoded({extended: false}));

const multer = require('multer');

//fileStorage: Es nuestra constante de configuración para manejar el almacenamiento
const fileStorage = multer.diskStorage({
    destination: (request, file, callback) => {
        //'uploads': Es el directorio del servidor donde se subirán los archivos 
        callback(null, 'public');
    },
    filename: (request, file, callback) => {
        //aquí configuramos el nombre que queremos que tenga el archivo en el servidor, 
        //para que no haya problema si se suben 2 archivos con el mismo nombre concatenamos el timestamp
        callback(null, 'uploads/'+ new Date().toISOString().replace(/:/g, '-') + '-' + file.originalname);
    },
});

//En el registro, pasamos la constante de configuración y
//usamos single porque es un sólo archivo el que vamos a subir, 
//pero hay diferentes opciones si se quieren subir varios archivos. 
//'archivo' es el nombre del input tipo file de la forma
app.use(multer(
    { storage: fileStorage }
    //{ dest: 'uploads' }
    ).single('imagen_producto'));  

//Para acceder a los recursos de la carpeta public
app.use(express.static(path.join(__dirname, 'public')));

//Para acceder a los recursos de la carpeta uploads
app.use(express.static(path.join(__dirname, 'uploads')));






app.use(cookieParser());

app.use(session({
    secret: 'qwertyasdfzxcv', 
    resave: false, //La sesión no se guardará en cada petición, sino sólo se guardará si algo cambió 
    saveUninitialized: false, //Asegura que no se guarde una sesión para una petición que no lo necesita
}));



app.use(csrfProtection); 

app.use((request, response, next) => {
    console.log('Middleware!');
    next(); //Le permite a la petición avanzar hacia el siguiente middleware
});


app.use('/productos', rutasProductos);

app.use('/users', rutasUsers);

app.get('/', (request, response, next) => {
    console.log(request.session);
    response.redirect('/productos');
});


app.use( (request, response, next) => {
    //response.statusCode = 404;
    response.status(404);
    response.send('Aqui no hay nada, ve a ver a otro sitio'); //Manda la respuesta
} );

app.listen(3000);