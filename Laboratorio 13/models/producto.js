const productos = [{nombre: "Audifonos", imagen: "https://images-na.ssl-images-amazon.com/images/I/51AASYsbSRL._AC_SX425_.jpg", descripcion: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Inventore porro cupiditate nisi earum, beatae quas!", precio: '1300'}, 
{nombre: "Lavadora", imagen: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRnyI0oCRbbOSzUfMePr8j0zgccMOOrr6p_SQ&usqp=CAU", descripcion: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Inventore porro cupiditate nisi earum, beatae quas!", precio: '3500'}, 
{nombre: "Laptop", imagen: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0zXXGNoHzXWSdS2qsG0ko3ojuY-PE8WrGdg&usqp=CAU", descripcion: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Inventore porro cupiditate nisi earum, beatae quas!", precio: '16000'}, 
{nombre: "Mouse", imagen: "https://lh3.googleusercontent.com/proxy/RBTqY2rFaZ8rtXxZbo8lfdtM9Mgi8RLi1mv_b-p1kUsJn3ALs_1lOuT7srDNVYxYURkRVbgV8m5yCBWiGimxHIcLwD8z_Psd_KSh-hJBk4dnhImPD2zXHkDIJbhUEsCqOv6oXPQi4aRUxib7TI9LUzqOcr_XU0c_hRe2lIQ6nQTxX82psSTbNvlASDPhDwey", descripcion: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Inventore porro cupiditate nisi earum, beatae quas!", precio: '$125'}]

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
        productos.push(this);
    }

    //Este método servirá para devolver los objetos del almacenamiento persistente.
    static fetchAll() {
        return productos;
    }

}