import wollok.mirror.*
import mapa.*
import screamer.*
object timoty {
    var property position = game.at(1, 2)
    var property image = "./assets/timoty_sprites/timoty_front.png" 

    var estaVivo = true
    var direccionActual = "front"
    var paso = 0
    var posicionAnterior = game.at(1, 2)
    var property habitacionActual = cocina

    method esEnemigo() = false
    method direccionActual() = direccionActual
    method cambiarDireccion(nuevaDireccion) {
        const proximaPosicion = self.calcularProximaPosicion(nuevaDireccion)
        direccionActual = nuevaDireccion
        self.actualizarSprite()

        if (self.puedeMoverseA(proximaPosicion) && estaVivo) {
            position = proximaPosicion
            habitacionActual = mapa.habitacionEn(position)
        }
    }

    method animarCaminata() {
        // si la posición actual es distinta a la anterior, significa que estamos caminando
        if (position != posicionAnterior) {
            paso = (paso + 1) % 4
            posicionAnterior = position
        } else {
            paso = 0
        }
        self.actualizarSprite()
    }
    
    method actualizarSprite() {
        const rutaBase = "./assets/timoty_sprites/timoty_" + direccionActual

        if (paso == 1) {
            image = rutaBase + "_left_foot.png"
        } else if (paso == 2) {
            image = rutaBase + "_right_foot.png"
        } else {
            image = rutaBase + ".png" 
        }
    }

    method caminar() {
        keyboard.up().onPressDo({ self.cambiarDireccion("back") })
        keyboard.down().onPressDo({ self.cambiarDireccion("front") })
        keyboard.left().onPressDo({ self.cambiarDireccion("right") }) 
        keyboard.right().onPressDo({ self.cambiarDireccion("left") })
        keyboard.w().onPressDo({ self.cambiarDireccion("back") })
        keyboard.s().onPressDo({ self.cambiarDireccion("front") })
        keyboard.a().onPressDo({ self.cambiarDireccion("right") }) 
        keyboard.d().onPressDo({ self.cambiarDireccion("left") })
    }

    method calcularProximaPosicion(direccion) {
        if (direccion == "back") return position.up(1)
        if (direccion == "front") return position.down(1)
        if (direccion == "left") return position.right(1)
        if (direccion == "right") return position.left(1)
        return position
    }

    method puedeMoverseA(pos) {
        return not habitacionActual.estaCeldaBloqueada(pos)
    }

    method morir() {
      if (estaVivo) {
        estaVivo = false
        console.println("Timoty fue atrapado")
        game.addVisual(screamer)
      }
    }

    method agarrarObjeto() {
        const posAdelante = self.calcularProximaPosicion(direccionActual)
        const objetosAdelante = game.getObjectsIn(posAdelante)
        const objetoUsable = objetosAdelante.filter({ o => o.esUsable() })
        
        if (not objetoUsable.isEmpty()) {
        const objetoAAgarrar = objetoUsable.uniqueElement()

        objetoAAgarrar.mostrarDescripcion()
        objetoAAgarrar.guardar()
        }
    }

    method interactuarConObjeto() {
        const posAdelante = self.calcularProximaPosicion(direccionActual)
        const objetosAdelante = game.getObjectsIn(posAdelante)
        const objetoPuzzle = objetosAdelante.filter({ o => o.esPuzzle() })

        if (not objetoPuzzle.isEmpty()) {
            const objetoAInteractuar = objetoPuzzle.uniqueElement()
            objetoAInteractuar.interactuar()
        }
    }
}
