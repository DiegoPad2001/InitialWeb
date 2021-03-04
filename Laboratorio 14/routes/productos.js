const express = require('express');

const router = express.Router();

const path = require('path');

const productosController = require('../controllers/productos_cont');


router.get('/nuevo-producto', productosController.getNuevoProducto);

router.post('/nuevo-producto', productosController.postNuevoProducto);

router.get('/', productosController.get);


module.exports = router;