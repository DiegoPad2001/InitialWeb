const express = require('express');

const isAuth = require('../util/is-auth');

const router = express.Router();

const path = require('path');

const productosController = require('../controllers/productos_cont');


router.get('/nuevo-producto', isAuth, productosController.getNuevoProducto);

router.post('/nuevo-producto', isAuth, productosController.postNuevoProducto);

router.get('/:producto_id', productosController.getProducto);

router.get('/', productosController.get);


module.exports = router;