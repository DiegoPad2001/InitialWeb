const filesystem = require('fs');


const requestHandler = (request, response) => {
    console.log("hola desde el servidor");
    console.log(request.url);
        // pagina de inicio es la pagina del laboratorio 1
    if (request.url === "/inicio") {
        response.setHeader('Content-Type', 'text/html');
        response.write("Aqui deberia de ir una pagina de inicio, pero pues nadamas es un laboratorio y podria pergar el codigo de una pagina, pero la verdad es que tengo sueño -.- ZZZzzzz");
        response.end();
        
        
    } else if (request.url === "/mensaje" && request.method === "GET") {
        response.setHeader('Content-Type', 'text/html');
        response.write("<html>");
        response.write('<head><meta charset="UTF-8"><title>Mensaje super importante</title></head>');
        response.write("<body><h1>Ingresa el dato que deseas guardar dentro del sistema</h1>");
        response.write('<form action="mensaje" method="POST"><input type="text" name="mensaje"><input type="submit" value="Guardar"></form>');
        response.write("</body>");
        response.write("</html>");
        response.end();
    } else if (request.url === "/mensaje" && request.method === "POST") {
        request.on('data', (dato) => {
            console.log(dato);
            filesystem.writeFileSync('input.txt', dato);
            response.write("<html> <h1> El mensaje a sido guardado </h1> </html>")
        });
        return request.on('end', () => {
            
            return response.end();
        });

    } else if (request.url === "/indice") {
        response.setHeader('Content-Type', 'text/html');
        response.write("<html>");
        response.write('<head><meta charset="UTF-8"><title>Indice del sitio</title></head>');
        response.write("<body><h1>Laboratorio 10 </h1> <h2> Indice: </h2> <ul> <li>/inicio, para visitar la pagina de inicio</li> <li>/mensaje para guardar un mensaje dentro del sistema</li> <li>/indice solo sera un F5 a esta pagina pero mas tardado :S</li> </ul>  </body>");
        response.write("</html>");
        response.end();
    }
     else if (request.url === "/") {
        response.setHeader('Content-Type', 'text/html');
        response.write("<html>");
        response.write('<head><meta charset="UTF-8"><title>Servidor node</title></head>');
        response.write("<body><h1>Aqui no hay nada</h1> Coloca /indice para ir al indice de la pagina web</body>");
        response.write("</html>");
        response.end();
    }
    else {
        response.statusCode = 404;
        response.setHeader('Content-Type', 'text/html');
        response.write("<html>");
        response.write('<head><meta charset="UTF-8"><title>Page not found</title></head>');
        response.write("<body><h1>Aqui no hay nada... pero talvez en el futuro si lo haya</h1></body>");
        response.write("</html>");
        return response.end();
    }   
}

module.exports = requestHandler;