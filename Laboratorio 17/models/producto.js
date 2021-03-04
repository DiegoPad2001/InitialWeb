const db = require('../util/database');


module.exports = class Producto {

    //Constructor de la clase. Sirve para crear un nuevo objeto, y en él se definen las propiedades del modelo
    constructor(nombre, imagen, descripcion, precio) {
        this.nombre = nombre;
        this.imagen = imagen;
        this.descripcion = descripcion;
        this.precio = precio;
    }

    //Este método servirá para guardar de manera persistente el nuevo objeto. 
    save() {
        return db.execute('INSERT INTO productos (nombre, imagen, descripcion, precio) VALUES (?, ?, ?, ?   )',
                          [this.nombre, this.imagen, this.descripcion, this.precio]
        );
    }

    //Este método servirá para devolver los objetos del almacenamiento persistente.
    static fetchAll() {
        return db.execute('SELECT * FROM productos');
    }
    
    static fetchOne(idProducto) {
        return db.execute('SELECT * FROM productos WHERE idProducto=?', [idProducto]);
    }

}