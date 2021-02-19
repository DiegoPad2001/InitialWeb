console.log("Hola desde node");


//Imprimir el arreglo en orden con código asíncrono
//const arreglo = [5000, 60, 90, 100, 10, 20, 0, 120, 2000, 340, 1000, 50];
//for (let item of arreglo) {
//    setTimeout( () => {
//        console.log(item);
//    }, item);
//}

//Imprimir el promedio de un arreglo

const averageArreglo = [10,15,20];
suma=0;
for(i=0; i<averageArreglo.length; i++){
    suma=suma+averageArreglo[i];
}
promedio=suma/averageArreglo.length;
console.log(promedio);

//Mandar texto a un txt

const filesystem = require('fs');
filesystem.writeFileSync('hola.txt', 'Hola, estoy escribiendo en un txt');

//sucesion fibonacci

let cant=10;
let numeros=[0,1];
for (let i = 2; i < cant; i++) {
    numeros[i] = numeros[i - 2] + numeros[i - 1];
    
}
console.log(numeros)
        


const http = require('http');

const server = http.createServer( (request, response) => {
    console.log("hola desde el servidor");
    console.log(request.url);
    response.setHeader('Content-Type', 'text/html');
    response.write("<html>");
    response.write("<head><title>Servidor node</title></head>");
    response.write("<body><h1>Hola desde el servidor</h1></body>");
    response.write("</html>");
    response.end();
});

server.listen(3000);