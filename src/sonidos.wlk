import wollok.game.*

object gestorSonido {
    const cancion = game.sound("./assets/sonidos/cancion1.mp3")
    var reproduciendo = false

    method musica() {
        if (!reproduciendo) {
            cancion.shouldLoop(true)
            cancion.play()
            reproduciendo = true
        }
    }
}