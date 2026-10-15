import wollok.game.*
import Timoty.*

object mapa {
    method facil() {
        /*agrega el personaje y le añade movimiento con las flechas*/
        game.addVisualCharacter(timoty)
        /*cambia direccion del sprite*/
        keyboard.up().onPressDo({ timoty.cambiarDireccion("back") })
        keyboard.down().onPressDo({ timoty.cambiarDireccion("front") })
        keyboard.left().onPressDo({ timoty.cambiarDireccion("right") }) 
        keyboard.right().onPressDo({ timoty.cambiarDireccion("left") })  
        
        game.onTick(150, "animarTimoty", { timoty.animarCaminata() })
    }
}
