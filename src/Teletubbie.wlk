import wollok.game.*
import Timoty.*
import mapa.*

class Teletubbie {
  const nombre
  const color
  const habitacion
  var property position
  var direccionActual = "front"
  var indice = 0
  var paso = 0

  method image() =
    "./assets/teletubbies_sprites/" + nombre + "(" + color + ")/" + nombre + "_" + direccionActual + self.sufijoPaso() + ".png"

  method sufijoPaso() =
    if (paso == 1) "_left_foot" else if (paso == 2) "_right_foot" else ""

  method aparecer() {
    game.addVisual(self)
    game.onTick(200, "ruta" + nombre, { self.avanzar() })
  }

  method avanzar() {
    self.cambiarDireccion(self.ruta().get(indice))
    indice = (indice + 1) % self.ruta().size()
    paso = (paso + 1) % 4
  }

  method cambiarDireccion(direccion) {
    const proximaPosicion = self.calcularProximaPosicion(direccion)
    direccionActual = direccion
    if (self.puedeMoverseA(proximaPosicion)) {
      position = proximaPosicion
    }
  }

  method calcularProximaPosicion(direccion) {
    if (direccion == "back") return position.up(1)
    if (direccion == "front") return position.down(1)
    if (direccion == "left") return position.left(1)
    if (direccion == "right") return position.right(1)
    return position
  }

  method puedeMoverseA(pos) = not habitacion.estaCeldaBloqueada(pos)

  method ruta()

  method repetir(unPaso, veces) = (1..veces).map({ i => unPaso })

    
}

// Voy creando las subclasses a medida que añadamos los niveles
class LaaLaa inherits Teletubbie(nombre = "laa-laa", color = "amarillo") {
  const ruta =
    self.repetir("right", 10) +
    self.repetir("back", 4) +
    self.repetir("left", 10) +
    self.repetir("front", 4)

  override method ruta() = ruta
}

class Dipsy inherits Teletubbie(nombre = "dipsy", color = "verde") {
  const ruta = 
    self.repetir("right", 4) + 
    self.repetir("back", 3) +
    self.repetir("front", 3) + 
    self.repetir("left", 4)

  override method ruta() = ruta
}