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
    "./assets/Fondo/Menu_inicio_verde_TLTB.png",
    "./assets/Fondo/Menu_inicio_amarillo_TLTB.png" 
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

class OpcionesDelMenu {
    const position
    const image

    method position() = position
    method image() = image
}

object botonSeleccionado {
    var property position = game.at(13,11)
    const image = "./assets/botones/botonSeleccionado.png"
    var opciones = []
    var indiceActual  = 0

    method image() = image
    method moverSeleccionado(listaOpciones) {
        opciones = listaOpciones

        keyboard.down().onPressDo({ self.irALaSiguiente() })
        keyboard.up().onPressDo({ self.irALaAnterior() })
    }

    method irALaSiguiente() {
        if(indiceActual < opciones.size() - 1) {
            indiceActual += 1
            self.actualizarPosicion()
        }
    }
    method irALaAnterior() {
        if(indiceActual > 0) {
            indiceActual -= 1
            self.actualizarPosicion()
        }
    }

    method actualizarPosicion() {
        const opcionDestino = opciones.get(indiceActual)
        position = opcionDestino.position()
    }
}