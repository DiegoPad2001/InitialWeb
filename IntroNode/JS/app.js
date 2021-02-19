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
    response.write("<main> <section> </section> <section> <h2>Git</h2> <p> Comandos de git para actualizar el repositorio: </p> <ol> <li><strong>git add -A</strong>: Sirve para rastrear los archivos y agregar los cambios la transacción.</li> <li><strong>git commit -m 'mensaje corto y descriptivo del cambio'</strong>: Sirve para completar la transacción y guardar los cambios de manera local.</li> <li><strong>git push</strong>: Sirve para 'empujar' todas las transacciones del repositorio local al repositorio remoto.</li> </ol> <p>Entonces, cada vez que trabajemos, debemos escribir en la consola:</p> <code><pre>git add -A git commit -m 'mensaje corto y descriptivo del cambio' git push</pre></code> </section> </main>");
    response.write("</html>");
    response.end();
});

server.listen(3000);