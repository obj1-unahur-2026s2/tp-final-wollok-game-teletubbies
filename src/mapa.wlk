import wollok.game.*
import Timoty.*
import mochila.*
import Teletubbie.*

object mapa {
    method facil() {
        /*agrega el personaje y le añade movimiento con las flechas*/
        game.addVisual(piso)
        game.addVisual(pared_frontal)
        game.addVisual(mesa)
        game.addVisual(silla_derecha)
        game.addVisualCharacter(timoty)
        game.addVisual(pared_lateral)
        game.addVisual(mochila)
        /*cambia direccion del sprite*/
        keyboard.up().onPressDo({ timoty.cambiarDireccion("back") })
        keyboard.down().onPressDo({ timoty.cambiarDireccion("front") })
        keyboard.left().onPressDo({ timoty.cambiarDireccion("right") }) 
        keyboard.right().onPressDo({ timoty.cambiarDireccion("left") })  
        
        game.onTick(150, "animarTimoty", { timoty.animarCaminata() })

        //Teletubbies
        const laalaa = new Teletubbie(nombre = "laa-laa", color = "amarillo", patron = new PatrullaVertical(), position = game.at(10, 5))
        laalaa.aparecer() //muchachos esta parte es temporal, estoy testeando el movimiento. Si le cambian el PatrullaVertical por PatrullaHorizontal se va a mover de izquierda a derecha
    }
}
object piso{
    var property position=game.at(0,2)
    method image()="./assets/tiles/cocina_piso.png" 
}
object pared_frontal {
    var property position=game.at(0,9)
    method image()="./assets/tiles/cocina_pared.png"
}
object pared_lateral{
    var property position =game.at(6, 2)
    method image() ="./assets/tiles/pared_lateral.png" 
}
object mesa {
    var property position =game.at(1, 4)
    method image() ="./assets/tiles/mesa.png" 
}
object silla_derecha{
    var property position =game.at(2, 4)
    method image() ="./assets/tiles/silla_derecha.png" 
}

