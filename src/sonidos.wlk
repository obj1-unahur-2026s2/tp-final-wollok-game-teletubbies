import wollok.game.*

object gestorVFX { 
// Variables y sus getters
    var sonidos = 1
    var ambiente = 1
    var musica = 1
    var principal = 1

    method sonidos() = sonidos
    method ambiente() = ambiente
    method musica() = musica
    method principal() = principal

// Volumenes de los sonidos en su valor total
    method volumenDeSonidos() {return sonidos * principal}
    method volumenDelAmbiente() {return ambiente * principal}
    method volumenDeMusica() {return musica * principal}

// Controles de los volumenes de cada sonido
    method bajarVolumenDelSonido(){sonidos = (sonidos - 0.1).max(0)}
    method subirVolumenDelSonido(){sonidos = (sonidos + 0.1).min(1)}

    method bajarVolumenDelAmbiente(){ambiente = (ambiente - 0.1).max(0)}
    method subirVolumenDelAmbiente(){ambiente = (ambiente + 0.1).min(1)}

    method bajarVolumenDeLaMusica(){musica = (musica - 0.1).max(0)}
    method subirVolumenDeLaMusica(){musica = (musica + 0.1).min(1)}

    method bajarVolumenPrincipal(){principal = (principal - 0.1).max(0)}
    method subirVolumenPrincipal(){principal = (principal + 0.1).min(1)}

// Los reproductores de cada sonido
    method reproducirSonido(sonidoAReproducir) {
        const sonido = game.sound(sonidoAReproducir)

        sonido.volume(self.volumenDeSonidos())
        sonido.play()
    }

    method reproducirAmbiente(sonidoAmbiente) {
        const sonido = game.sound(sonidoAmbiente)

        sonido.shouldLoop(true)
        sonido.volume(self.volumenDelAmbiente())
        sonido.play()
    }

    method reproducirMusica(musicaARproducir) {
        const musicon = game.sound(musicaARproducir)

        musicon.shouldLoop(true)
        musicon.volume(self.volumenDeMusica())
        musicon.play()
    }

    method reproducirMusicaUnica(musicaARproducir) {
        const musicon = game.sound(musicaARproducir)

        musicon.volume(self.volumenDeMusica())
        musicon.play()
    }

}