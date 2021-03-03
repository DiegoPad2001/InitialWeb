//DOM: Document Object Model

function dar_espada() {
    console.log("Darle una espada a Link");
    let espada = document.getElementById("espada");
    espada.innerHTML = "<li>Espada</li>";

    let boton =  document.getElementById("acciones_link");
    boton.innerHTML = "¡A luchar!";

    boton.onclick = () => {
        console.log("A luchar!!!!!");
        let resultado = document.getElementById("link_luchando");
        resultado.innerHTML = '<img alt="gif retro animado de Link Luchando" src="https://steemitimages.com/p/2gsjgna1uruvUuS7ndh9YqVwYGPLVszbFLwwpAYXZoZbh6aBvoQj9NjW3onDQDqG6HHpeWNewo4T2z9RXPgLvmtFM43hgQp5anwL7oY84nBZhwY81s?format=match&mode=fit">';
        boton.innerHTML = "Dejar de luchar";
        boton.onclick = () => {
            resultado.innerHTML = "<br><br><h4>Link derrotó a " +  Math.floor(Math.random() * 4) + "monstruos</h4>";
            let div = document.getElementById("boton");
            div.innerHTML = "";
        }
    } 

}

let password = document.getElementById("password");

password.onkeyup = () => {
    let valor_password = password.value;
}