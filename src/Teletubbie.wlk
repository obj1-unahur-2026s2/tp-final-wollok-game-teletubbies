import src.sonidos.*
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
  var turnoHorizontal=true

  method image() =
    "teletubbies_sprites/" + nombre + "(" + color + ")/" + nombre + "_" + direccionActual + self.sufijoPaso() + ".png"

  method sufijoPaso() =
    if (paso == 1) "_left_foot" else if (paso == 2) "_right_foot" else ""

  method aparecer() {
    game.addVisual(self)
    game.onTick(50, "captura" + nombre, { self.verificarCaptura() })
  }

  method verificarCaptura() {
    if (position == timoty.position()) {
      timoty.morir()
      gestorSFX.reproducirSonido("sonidos/jumpscare1.mp3")
    }
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

  method esEnemigo() = true

  var xTimoty = 0
  var yTimoty= 0

  method estaALaDerecha() {
    if (xTimoty > self.position().x()) {
        self.cambiarDireccion("right")
    }
  }
  method estaALaIzquierda() {
    if (xTimoty < self.position().x()) {
        self.cambiarDireccion("left")
    }
  }
  method estaArriba() {
    if (yTimoty > self.position().y()) {
        game.schedule(1800, { => self.cambiarDireccion("back") })
    }
  }
  method estaAbajo() {
    if (yTimoty < self.position().y()) {
        game.schedule(1800, { => self.cambiarDireccion("front") })
    }
  }

  method timotyEstaEnEstaHabitacion() =timoty.habitacionActual() == habitacion
  
  method darUnPaso(){    
    if (turnoHorizontal) {
        self.estaALaDerecha()
        self.estaALaIzquierda()
    } else {
        self.estaArriba()
        self.estaAbajo()
    }
    turnoHorizontal = not turnoHorizontal
  }

  method perseguir() {
    if (self.timotyEstaEnEstaHabitacion()) {
        xTimoty = timoty.position().x()
        yTimoty = timoty.position().y()

      self.darUnPaso()
    } else {
        self.avanzar()
    }
  }
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