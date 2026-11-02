import mapa.*
object mochila {
  var property position = game.at(0,0)
  const items = []

  method image()="./assets/ui/fondoMochila.png"
  method agregarItem(nuevoItem) { items.add(nuevoItem) }
  method sacarItem(nuevoItem) { items.remove(nuevoItem) }
}