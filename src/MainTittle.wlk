import wollok.game.*
import mapa.*

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
object titulo{
    var property position = game.at(9,13)
    method image()="./assets/Titulo.png"
}

class OpcionesDelMenu {
    const position
    const image
    const accion

    method position() = position
    method image() = image
    method interactuar(){
        accion.apply() 
    }
}

object botonSeleccionado {
    var property position = game.at(13,10)
    const image = "./assets/botones/botonSeleccionado.png"
    var opciones = []
    var indiceActual  = 0

    method image() = image
    method moverSeleccionado(listaOpciones) {
        opciones = listaOpciones

        keyboard.down().onPressDo({ self.irALaSiguiente() })
        keyboard.up().onPressDo({ self.irALaAnterior() })
    }
    method ejecutar() {
        indiceActual = 0
        self.actualizarPosicion()

        keyboard.enter().onPressDo({
            const opcionActual = opciones.get(indiceActual)
            opcionActual.interactuar() 
        })
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
        position = game.at(self.position().x(), opcionDestino.position().y())
    }
}

//se instancian los botones

const opcionJugar = new OpcionesDelMenu(
    position = game.at(13, 10), 
    image = "./assets/botones/botonJugar.png",
    accion = { 
      game.clear()
      mapa.dificultad()
      })
const opcionOpciones = new OpcionesDelMenu(
    position = game.at(13,8) , 
    image = "./assets/botones/botonOpciones.png", 
    accion = {
        game.clear()
        menuInterfaz.menuOpciones()
    })
const opcionSalir = new OpcionesDelMenu(
    position = game.at(13,6), 
    image = "./assets/botones/botonSalir.png", 
    accion = {game.stop()})

const opcionFacil = new OpcionesDelMenu(
    position = game.at(13,10),
    image = "./assets/botones/botonFacil.png",
    accion = {
        mapa.dificultadActual("facil")
        game.clear()
        menuInterfaz.menuInicio()
    })
const opcionDificil = new OpcionesDelMenu(
    position = game.at(13,8),
    image = "./assets/botones/botonDificil.png",
    accion = {
        mapa.dificultadActual("dificil")
        game.clear()
        menuInterfaz.menuInicio()
    })
const opcionInstrucciones = new OpcionesDelMenu(
    position = game.at(11.5,6),
    image = "./assets/botones/botonInstrucciones.png",
    accion = {
        game.clear()
        menuInterfaz.menuInstrucciones()
    })
const opcionAtras = new OpcionesDelMenu(
    position = game.at(13,6),
    image = "./assets/botones/botonAtras.png",
    accion = {
        game.clear()
        menuInterfaz.menuOpciones()
    })

object menuInterfaz {
    method menuInicio(){
        game.addVisual(pantallaDeInicio)
        game.addVisual(opcionJugar)
        game.addVisual(opcionOpciones)
        game.addVisual(opcionSalir)
        game.addVisual(botonSeleccionado)
        game.addVisual(titulo)
        botonSeleccionado.moverSeleccionado([opcionJugar, opcionOpciones, opcionSalir])
        botonSeleccionado.ejecutar()
    }
    method menuOpciones() {
        game.addVisual(pantallaDeInicio)
        game.addVisual(opcionFacil)
        game.addVisual(opcionDificil)
        game.addVisual(opcionInstrucciones)
        game.addVisual(botonSeleccionado)
        botonSeleccionado.moverSeleccionado([opcionFacil, opcionDificil, opcionInstrucciones])
        botonSeleccionado.ejecutar()
    }
    method menuInstrucciones() {
        game.addVisual(pantallaDeInicio)
        game.addVisual(opcionAtras)
        game.addVisual(botonSeleccionado)
        botonSeleccionado.moverSeleccionado([opcionAtras])
        botonSeleccionado.ejecutar()
    }
}