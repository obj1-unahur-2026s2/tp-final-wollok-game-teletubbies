import wollok.game.*

object pantallaDeInicio {
/*
Hice que al ejecutar el programa se inicie con alguno
de los fondos seleccionados, y que con una chance
del 5% te pueda salir una version macabra del menú
*/
  var property position = game.origin()
  const chance = 0.randomUpTo(99)
  const menus = [
    "./assets/Fondo/Menu_inicio_morado_TLTB.png",
    "./assets/Fondo/Menu_inicio_rojo_TLTB.png", 
    "./assets/Fondo/Menu_inicio_amarillo_TLTB.png", 
    "./assets/Fondo/Menu_inicio_verde_TLTB.png"
    ]
  var property image = self.elegirFondo()
    method elegirFondo(){
        if (chance < 5){
            return "./assets/Fondo/Menu_inicio_especial_TLTB.jpg"

        }else{
            return menus.anyOne()
        }
    }
}
/*
Estoy haciendo pruebas, sientanse libres de cambiar lo
que viene a continuacion, total quedo sin estructura; intenté
crear las opciones del menú y que sea interactivo, intenté
una navegación circular y que sea escalable con clases para
agregarle mas opciones al menú
*/
class OpcionesDelMenú {
  var property position = game.at(0,0)
  var textoBase = ""
  var property text = ""
  var property textColor = "000000FF"

}
/* cambie de text a imagenes porque los textos no se pueden cambiar
 el tamaño y se veian muy chicos*/
object opciónSeleccionada {
  var property position = game.at(13,11)
  method image() = "./assets/botones/botonSeleccionado.png"
}
object opciónJugar {
  var property position = game.at(13,11)
  method image() = "./assets/botones/botonJugar.png"
}

object opciónOpciones {
  var property position = game.at(13,9)
  method image() = "./assets/botones/botonOpciones.png"
}
object opciónSalir {
  var property position = game.at(13,7)
  method image() = "./assets/botones/botonSalir.png"
}

object menuManager {
    var opciónActual = 0
    const ultimaOpción = 1
    method iniciar(){
        game.addVisual(pantallaDeInicio)
        game.addVisual(opciónJugar)
        game.addVisual(opciónOpciones)
        //self.configurarTeclas()
    }
    method moverAbajo(){
        if (opciónActual == ultimaOpción){
            opciónActual = 0
            opciónJugar.text("> JUGAR <")
            opciónOpciones.text("Opciones")
        }else{
            opciónActual = opciónActual + 1
            opciónJugar.text("Jugar")
            opciónOpciones.text("> OPCIONES <")
        }
    }

    method moverArriba(){
        if (opciónActual == 0){
            opciónActual = ultimaOpción
            opciónJugar.text("Jugar")
            opciónOpciones.text("> OPCIONES <")
        }else{
            opciónActual = opciónActual - 1
            opciónJugar.text("> JUGAR <")
            opciónOpciones.text("Opciones")
        }
    }

    //method seleccionar(){
    //   if (opciónActual() == 0){
    //        self.comenzarJuego()
    //    }else{
    //        self.abrirOpciones()
    //    }
    //}
}
