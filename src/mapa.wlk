import wollok.game.*
import Timoty.*
import mochila.*
import Teletubbie.*

object mapa {
    var dificultadActual = "facil"

    method dificultad() = if(dificultadActual == "facil") self.facil() else self.dificil()
    method dificultadActual(cambiarDificultad) { dificultadActual = cambiarDificultad }
    method facil() {
        cocina.dibujarHabitacion()
        game.addVisual(mesa)
        game.addVisual(silla_derecha)
        game.addVisual(timoty)
        game.addVisual(carta)
        game.addVisual(luz)
        game.addVisual(pared_lateral)
        game.addVisual(mochila)
        timoty.caminar()
        game.onTick(150, "animarTimoty", { timoty.animarCaminata() })

        //Teletubbies
        const laalaa = new Teletubbie(nombre = "laa-laa", color = "amarillo", patron = new PatrullaVertical(), position = game.at(10, 5))
        laalaa.aparecer() //muchachos esta parte es temporal, estoy testeando el movimiento. Si le cambian el PatrullaVertical por PatrullaHorizontal se va a mover de izquierda a derecha
    }
    method dificil() {}
}
object piso{
    var property position=game.at(0,2)
    method image()="./assets/tiles/cocina_piso.png"
    method tieneColision() = false
}
object pared_frontal {
    var property position=game.at(0,9)
    method image()="./assets/tiles/cocina_pared.png"
    method tieneColision() = true
}
object pared_lateral{
    var property position =game.at(6, 2)
    method image() ="./assets/tiles/pared_lateral.png"
    method tieneColision() = true
}
object mesa {
    var property position =game.at(1, 4)
    method image() ="./assets/tiles/mesa.png"
    method tieneColision() = true 
}
object silla_derecha{
    var property position =game.at(2, 4)
    method image() ="./assets/tiles/silla_derecha.png" 
    method tieneColision() = true
}
object luz{
    var property position =game.at(0, 2)
    method image() ="./assets/tiles/cocina_ventana_luz.png"
    method tieneColision() = false
}
object carta{
    var property position =game.at(0,3)
    method image() ="./assets/objetos/carta.gif"
    method tieneColision() = true
}

class Habitacion{
    const property objetosConColision=[]
    const property objetosSinColision=[]
    const property pisoHabitacion
    const property paredAtras
    const nombre
    method nombre()=nombre
    var property estaOculto

    var property xMin = 0
    var property xMax = 10
    var property yMin = 0
    var property yMax = 10

    method dibujarHabitacion(){
        game.addVisual(pisoHabitacion)
        game.addVisual(paredAtras)
    }
    method estaCeldaBloqueada(unaPosicion) {
        // 1. Validamos primero si la posición se sale de los bordes permitidos para esta habitación
        const seSalioDeLosBordes = unaPosicion.x() < xMin 
                                or unaPosicion.x() > xMax 
                                or unaPosicion.y() < yMin 
                                or unaPosicion.y() > yMax

        if (seSalioDeLosBordes) {
            return true // Bloqueado, es una pared del cuarto
        }

          return objetosConColision.any({ obj => obj.estaOcupando(unaPosicion) })
    }
}
class Piso{
    var property position
    const image
    method image()=image
    method tieneColision()=false  
}
class Pared{
    var property position
    const superficie=[]
    const image
    method image()=image
    method tieneColision()=true
    method superficie()=superficie

    method estaOcupando(unaPosicion) {
        // superficie.get(0) es el ancho, superficie.get(1) es el alto
        const xMax = position.x() + superficie.get(0) - 1
        const yMax = position.y() + superficie.get(1) - 1
        
        return unaPosicion.x().between(position.x(), xMax) 
           and unaPosicion.y().between(position.y(), yMax)
    }
}
class Objetos{
    var property position
    const superficie=[]
    const image
    const property ordenDeDibujado
    const property vaAdelanteDeTimothy 
    var property tieneColision
    method image()=image
    method superficie()=superficie

    method estaOcupando(unaPosicion) {
        // superficie.get(0) es el ancho, superficie.get(1) es el alto
        const xMax = position.x() + superficie.get(0) - 1
        const yMax = position.y() + superficie.get(1) - 1
        
        return unaPosicion.x().between(position.x(), xMax) 
           and unaPosicion.y().between(position.y(), yMax)
    }
}

const cocina=new Habitacion(pisoHabitacion=piso,paredAtras=pared_frontal,objetosConColision=[mesa,silla_derecha,pared_lateral],objetosSinColision=[piso],nombre="cocina",estaOculto=false)

