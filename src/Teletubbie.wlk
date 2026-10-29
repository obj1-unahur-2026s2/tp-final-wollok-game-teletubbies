import wollok.game.*

class Teletubbie {
  const nombre
  const color
  const patron
  var property position
  var paso = 0

  method image() =
    "./assets/teletubbies_sprites/" + nombre + "(" + color + ")/" + nombre + "_" + patron.direccion() + self.sufijoPaso() + ".png"

  method sufijoPaso() =
    if (paso == 1) "_left_foot" else if (paso == 2) "_right_foot" else ""

  method aparecer() {
    game.addVisual(self)
    game.onTick(200, "patrulla" + nombre, { self.patrullar() })
  }

  method patrullar() {
    paso = (paso + 1) % 4
    position = patron.siguiente(position)
  }
}

class PatrullaHorizontal {
  var avance = 1

  method siguiente(posicionActual) {
    const posicionSiguiente = posicionActual.right(avance)
    if (posicionSiguiente.x() < 0 || posicionSiguiente.x() > game.width() - 1) {
      avance = -avance
      return posicionActual
    }
    return posicionSiguiente
  }

  method direccion() = if (avance == 1) "right" else "left"
}

class PatrullaVertical {
  var avance = 1

  method siguiente(posicionActual) {
    const posicionSiguiente = posicionActual.up(avance)

    if (posicionSiguiente.y() < 0 || posicionSiguiente.y() > game.height() - 1) {
      avance = -avance
      return posicionActual
    }

    return posicionSiguiente
  }

  method direccion() =
    if (avance == 1) "back" else "front"
}