const Producto = require('../models/producto');

exports.getNuevoProducto = (request, response, next) => {
    response.render('nuevo-producto', {
        titulo: 'Nuevo Producto',
        csrfToken: request.csrfToken(),
        isLoggedIn: request.session.isLoggedIn === true ? true : false
    });
};

exports.postNuevoProducto = (request, response, next) => {    
    const image = request.file;
    console.log(image);

    if(!image) {
        console.error('Error al subir la imagen');
        return response.status(422).redirect('/');
    }
    
    
    const nuevo_producto = new Producto(request.body.nombre_producto, image.filename, request.body.descripcion_producto, request.body.precio_producto);
    nuevo_producto.save()
        .then(() => {
            response.setHeader('Set-Cookie', ['ultimo_producto='+nuevo_producto.nombre+'; HttpOnly']);
            response.redirect('/productos');
        }).catch(err => console.log(err));

}


exports.getProducto = (request, response, next) => {
    const idProducto = request.params.producto_id;
    Producto.fetchOne(idProducto)
        .then(([rows, fieldData]) => {
            response.render('productos', { 
                lista_productos: rows, 
                titulo: 'Productos',
                csrfToken: request.csrfToken(),
                isLoggedIn: request.session.isLoggedIn === true ? true : false
            });
        })
        .catch(err => {
            console.log(err);
        });
};

exports.postBuscar = (request, response, next) => {
    console.log(request.body);
    console.log(request.body.valor_busqueda);
    const name = request.body.valor_busqueda;
    Producto.fetchByName(name)
        .then(([rows, fieldData]) => {
            console.log(rows);
            response.status(200).json(rows);
        })
        .catch(err => {
            console.log(err);
        });
    
};


exports.get = (request, response, next) => {
    

    console.log(request.ultimoProductoAgregado);

    Producto.fetchAll()
        .then(([rows, fieldData]) => {
            response.render('productos', { 
                lista_productos: rows, 
                titulo: 'Productos',
                csrfToken: request.csrfToken(),
                isLoggedIn: request.session.isLoggedIn === true ? true : false
            });
        })
        .catch(err => {
            console.log(err);
        });
};

