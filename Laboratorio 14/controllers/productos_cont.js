const Producto = require('../models/producto');

exports.getNuevoProducto = (request, response, next) => {
    response.render('nuevo-producto', {
        titulo: 'Nuevo Producto',
        isLoggedIn: request.session.isLoggedIn === true ? true : false
    });
};

exports.postNuevoProducto = (request, response, next) => {
    const nuevo_producto = new Producto(request.body.nombre_producto, request.body.imagen_producto, request.body.descripcion_producto, request.body.precio_producto);
    
    nuevo_producto.save();
    
    response.setHeader('Set-Cookie', ['ultimoProductoAgregado='+nuevo_producto.nombre+"; HttpOnly"]);
    
    response.redirect('/productos');
}

exports.get = (request, response, next) => {
    const productos = Producto.fetchAll();
    
    console.log(request.cookies.ultimoProductoAgregado);
    
    response.render('productos', { 
        lista_productos: productos, 
        titulo: 'Productos',
        isLoggedIn: request.session.isLoggedIn === true ? true : false
    });
};

