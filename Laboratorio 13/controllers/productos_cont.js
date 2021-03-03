const Producto = require('../models/producto');

exports.getNuevoProducto = (request, response, next) => {
    response.render('nuevo-producto', {
        titulo: 'Nuevo Producto' 
    });
};

exports.postNuevoProducto = (request, response, next) => {
    console.log(request.body.nombre_producto);
    console.log(request.body.imagen_producto);
    console.log(request.body.descripcion_producto);
    console.log(request.body.precio_producto);
    const nuevo_producto = new Producto(request.body.nombre_producto, request.body.imagen_producto, request.body.descripcion_producto, request.body.precio_producto);
    nuevo_producto.save();
    response.redirect('/productos');
}

exports.get = (request, response, next) => {
    const productos = Producto.fetchAll();
    response.render('productos', { 
        lista_productos: productos, 
        titulo: 'Productos' 
    });
};

