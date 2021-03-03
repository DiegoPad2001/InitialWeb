const express = require('express');

const router = express.Router();

const path = require('path');

const personajes = ["Zelda", "Link", "Ganon"];

router.get('/nuevo-personaje', (request, response, next) => {
    response.send('<h1>Nuevo Personaje</h1><body><h1>Agrega un personaje</h1><form action="nuevo-personaje" method="POST"><input type="text" name="nombre"><input type="submit" value="Guardar personaje"></form>'); 
});

router.post('/nuevo-personaje', (request, response, next) => {
    console.log(request.body.nombre);
    personajes.push(request.body.nombre);
    response.redirect('/personajes');
});

router.use('/', (request, response, next) => {
    response.render('personajes', {lista_personajes: personajes});
});

module.exports = router;