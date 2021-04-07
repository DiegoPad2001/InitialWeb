const Productos = require('../models/producto');

exports.getNuevoProductos = (request, response, next) => {
    response.render('nuevo-producto', {
        titulo: 'Nuevo Productos',
        isLoggedIn: request.session.isLoggedIn === true ? true : false
    });
};

exports.postNuevoProductos = (request, response, next) => {
    const nuevo_producto = new Producto(request.body.nombre_producto, request.body.imagen_producto, request.body.descripcion_producto, request.body.precio_producto);
    nuevo_producto.save()
        .then(() => {
            response.setHeader('Set-Cookie', ['ultimo_producto='+nuevo_producto.nombre+'; HttpOnly']);
            response.redirect('/productos');
        }).catch(err => console.log(err));

}

exports.get = (request, response, next) => {
    


    console.log(request.ultimoProductoAgregado);

    Productos.fetchAll()
        .then(([rows, fieldData]) => {
            response.render('productos', { 
                lista_productos: rows, 
                titulo: 'Productoss',
                isLoggedIn: request.session.isLoggedIn === true ? true : false
            });
        })
        .catch(err => {
            console.log(err);
        });
};