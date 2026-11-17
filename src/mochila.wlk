import src.sonidos.*
import mapa.*
object mochila {
  var property position = game.at(0,0)
  var cantidadSpritesEnBarra = 0 
  const items = []

  method image()="ui/fondoMochila.png"
  method agregarItem(nuevoItem) { 
    gestorSFX.reproducirSonido("sonidos/agarrarItem.mp3")
    items.add(nuevoItem) 
    self.dibujarSpritesEnBarra(nuevoItem)
  }
  method sacarItem(nuevoItem) { 
    items.remove(nuevoItem)
    nuevoItem.spritesInstanciados().forEach({ sprite =>
      game.removeVisual(sprite)
    })
    
    nuevoItem.spritesInstanciados().clear()
    self.reorganizarBarra()
  }

  method dibujarSpritesEnBarra(nuevoItem) {
     nuevoItem.imagenesInventario().forEach({ img =>
      const spriteInventario = new SpriteMochila(
        image = img,
        position = game.at(cantidadSpritesEnBarra, 0)
      )
      game.addVisual(spriteInventario)
      nuevoItem.spritesInstanciados().add(spriteInventario)
      cantidadSpritesEnBarra += 2
    })
  }

  method reorganizarBarra() {
    cantidadSpritesEnBarra = 0
    
    items.forEach({ item =>
      item.spritesInstanciados().forEach({ sprite =>
        sprite.position(game.at(cantidadSpritesEnBarra, 0))
        cantidadSpritesEnBarra += 2
      })
    })
  }
}

class SpriteMochila {
  var property image
  var property position 
}