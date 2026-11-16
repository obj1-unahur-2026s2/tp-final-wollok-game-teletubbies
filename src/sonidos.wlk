import wollok.game.*

class Sonido{
    const sonido

    method reproducir(){
        sonido.play()
    }

}
// Puedes modificar a voluntad si se repite o no
class Musica inherits Sonido{
    method seRepite(bool){
        sonido.shouldLoop(bool)
    }
}
// Simplemente llamas al objeto y le pones "reproducir()"
const cancion1 = new Musica(sonido = game.sound("sonidos/cancion1.mp3"))
const cancion2 = new Musica(sonido = game.sound("sonidos/cancion2.mp3"))
const cancion3 = new Musica(sonido = game.sound("sonidos/cancion3.mp3"))
const paso1 = new Sonido(sonido = game.sound("sonidos/paso1.mp3")) 
const paso2 = new Sonido(sonido = game.sound("sonidos/paso2.mp3"))
const paso3 = new Sonido(sonido = game.sound("sonidos/paso3.mp3"))
const paso4 = new Sonido(sonido = game.sound("sonidos/paso4.mp3"))
const agarrarItem = new Sonido(sonido = game.sound("sonidos/agarrarItem.mp3"))
const ventanaDeDia = new Sonido(sonido = game.sound("sonidos/avesCantando.mp3"))
const jumpscare1 = new Sonido(sonido = game.sound("sonidos/jumpscare1.mp3"))
const dado = new Sonido(sonido = game.sound("sonidos/madera1.mp3"))
const sonidoAmbiente = new Sonido(sonido = game.sound("sonidos/sonidoDeTerror.mp3"))