import wollok.game.*
import MainTittle.*
import mapa.*

object pantallaVictoria {
        method pantallaVictoria(){
            game.clear()
            game.addVisual(fondoVictoria)
            /*
            game.addVisual(botonReiniciar)
            game.addVisual(botonIrAlMenu)
            game.addVisual(botonSeleccionado)
            botonSeleccionado.moverSeleccionado([botonReiniciar, botonIrAlMenu])
            botonSeleccionado.ejecutar()
            */
    }
}
object pantallaPerdida {
        method pantallaPerdida(){
            game.clear()
            game.addVisual(fondoPerdida)
            /*
            game.addVisual(botonReiniciar)
            game.addVisual(botonIrAlMenu)
            game.addVisual(botonSeleccionado)
            botonSeleccionado.moverSeleccionado([botonReiniciar, botonIrAlMenu])
            botonSeleccionado.ejecutar()
            */
    }
}

object fondoVictoria {
    const property position = game.origin()
    const property image = "ui/Escapaste.png"
}
object fondoPerdida {
    const property position = game.origin()
    const property image = "ui/game_over.png"
}

const botonReiniciar= new OpcionesDelMenu(    
    position = game.at(13, 4), 
    image = "botones/boton_reiniciar.png",
    accion = { 
      game.clear()
      mapa.dificultad()
      })
const botonIrAlMenu= new OpcionesDelMenu(    
    position = game.at(13, 1), 
    image = "botones/boton_volver_al_menu.png",
    accion = { 
      game.clear()
      menuInterfaz.menuInicio()
    }
)

