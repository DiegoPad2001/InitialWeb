document.write("<b>Ejercicio 1</b>");

let numero = prompt("Dame un numero");

i=1;
document.write("<table>")
while(i<=numero){
    document.write("<tr>");
    x=i*i;
    document.write("<td>"+x+"</td>");
    x=i*i*i;
    document.write("<td>"+x+"</td>");
    document.write("</tr>");
    i++;
}

document.write("</table>");

document.write("<br><b>Ejercicio 2</b> <br>");

function NumeroAleatorio(min,max){
    return Math.floor(Math.random()*(max-min+1)+min);
}

na1=NumeroAleatorio(1,10);
na2=NumeroAleatorio(1,10);
resc=na1+na2;

resu = prompt(na1+'+'+na2);

if(resu==resc){
    document.write("Correcto");
}else{
    document.write("Incorrecto");
}

document.write("<br><br><b>Ejercicio 3</b><br>");

const arreglo = [];

function Contador(arreglo){
    pos=0;
    neg=0;
    cero=0;
    for(i=0; i<arreglo.length; i++){
        n = arreglo[i];
        if (n>0){
            pos++;
        }else if(n<0){
            neg++;
        }else{
            cero++;
        }
    }
    document.write("Positivos:"+pos+"<br>Negativos:"+neg+"<br>Cero:"+cero);
}

cantN=prompt("Cuantos numero quiere poner en el arreglo?");

for(i=0; i<cantN; i++){
    arreglo[i]= prompt("Ingrese el numero");
}

Contador(arreglo);

document.write("<br><br><b>Ejercicio 5</b><br>");

function invertirNumero(numero){
    v=numero;
    revertir=0;
    while(v>0){
        residuo=v%10;
        revertir=(revertir*10)+residuo;
        v=Math.trunc(v/10);
    }
    document.write("El numero inverso es "+revertir);
}

numero=prompt("Ingresa el numero a invertir");

invertirNumero(numero);

function auto(modelo, matricula){
    
    this.modelo = modelo;
    this.matricula = matricula;

    
    this.arrancar = function(){
        document.write("Carro encendido");
    }
    
    this.apagar = function(){
        document.write("Carro apagado");
    }
}


document.write("<br><br><b>Ejercicio 6</b><br>");
document.write("<p>Crear un programa en donde puedas dar de alta el modelo y matricula de un automovil, ademas de que puedas elegir encender o dejar apagado el carro, y si lo enciendes tener la opción de apagarlo</p>");

modeloAuto = prompt("Modelo del auto");
matriculaAuto = prompt("Matricula del auto");

var newAuto = new auto(modeloAuto,matriculaAuto);

document.write("<br>Modelo del auto:"+newAuto.modelo+"<br>"+"Matricula del auto:"+newAuto.matricula+"<br>");

respuesta = confirm("Desea encender el carro?");

if (respuesta === true){
    auto.arrancar;
} else {
    auto.apagar;
}

        


