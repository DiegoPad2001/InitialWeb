let edad_link=17;
let arma_link="Espada Maestra";
let estatura=1.58;
let color_ropa="Verde"

console.log(edad_link);
console.info(arma_link);
console.error(estatura);
console.warn(color_ropa);

for (let i=0; i<10; i++){
    console.log(i);
}

document.write("<h3>"+arma_link+"</h3>");

alert("Hola Mundo");

const nombre = prompt("Como te llamas");
document.write(nombre);



function pregunta_hambre() {
    let respuesta = confirm("¿Tienes hambre?");

    if (respuesta === true){
        document.write("Pide una pizza");
    } else {
        document.write("Ponte a programar");
}
}

pregunta_hambre();

const cumple_años = (edad) => edad +1;


console.log("Nueva edad de link", cumple_años(edad_link));

const arreglo=[];
arreglo.push(arma_link);
console.log(arreglo);