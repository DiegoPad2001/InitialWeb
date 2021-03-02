const express = require('express');
const router = express.Router();
const filesystem = require('fs');
const bodyParser = require('body-parser');


router.use('/inicio', (request, response, next) => {
    response.send('<h1>Aqui deberia de ir una pagina de inicio, pero pues nadamas es un laboratorio y podria pergar el codigo de una pagina, pero la verdad es que tengo sueño -.- ZZZzzzz</h1>'); 
});

router.use('/indice', (request, response, next) => {
    response.send('<html><head><meta charset="UTF-8"><title>Indice del sitio</title></head><body><h1>Laboratorio 10 </h1> <h2> Indice: </h2> <ul> <li>/inicio, para visitar la pagina de inicio</li> <li>/mensaje para guardar un mensaje dentro del sistema</li> <li>/indice solo sera un F5 a esta pagina pero mas tardado :S</li> </ul>  </body></html>'); 
});

router.get('/mensaje', (request, response, next) => {
    response.send('<body><h1>Ingresa el mensaje que deseas guardar</h1><form action="mensaje" method="POST"><input type="text" name="mensaje"><input type="submit" value="Guardar"></form>'); 
});

router.post('/mensaje', (request, response, next) => {
    console.log(request.body.mensaje);
    filesystem.writeFileSync('input.txt', request.body.mensaje)
    response.send('<h1>Guardado con exito</h1>'); 
});

module.exports = router;