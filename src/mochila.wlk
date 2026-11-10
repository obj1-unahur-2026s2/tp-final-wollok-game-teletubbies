import mapa.*
object mochila {
  var property position = game.at(0,0)
  var cantidadSpritesEnBarra = 0 
  const items = []

  method image()="./assets/ui/fondoMochila.png"
  method agregarItem(nuevoItem) { 
    items.add(nuevoItem) 
    self.dibujarSpritesEnBarra(nuevoItem)
  }
  method sacarItem(nuevoItem) { 
    items.remove(nuevoItem)
    nuevoItem.spritesInstanciados().forEach({ sprite =>
      game.removeVisual(sprite)
    })
    
    nuevoItem.spritesInstanciados().clear()
    cantidadSpritesEnBarra = 0.max(cantidadSpritesEnBarra - nuevoItem.imagenesInventario().size())
  }

  method dibujarSpritesEnBarra(nuevoItem) {
    nuevoItem.imagenesInventario().forEach({ img =>
      const spriteInventario = new SpriteMochila(
        image = img,
        position = game.at(cantidadSpritesEnBarra, 0)
      )
      game.addVisual(spriteInventario)
      nuevoItem.spritesInstanciados().add(spriteInventario)
      cantidadSpritesEnBarra += 1
    })
  }
}

class SpriteMochila {
  var property image
  var property position
}