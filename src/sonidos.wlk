import wollok.game.*

object gestorVFX {

// Variables del volumen.

    var sonidos = 1
    var ambiente = 1
    var musica = 1
    var principal = 1

// Variables que guardan los sonidos actuales en reproduccion.

    var musicaEnReproduccion = null
    var musicaUnicaEnReproduccion = null
    const ambientesEnReproduccion = new Dictionary()

// Getters del volumen para la interfaz.

    method sonidos() = sonidos
    method ambiente() = ambiente
    method musica() = musica
    method principal() = principal

// Volumenes de los sonidos en su valor total.

    method volumenDeSonidos() {return sonidos * principal}
    method volumenDelAmbiente() {return ambiente * principal}
    method volumenDeMusica() {return musica * principal}

// Controles de los volumenes de cada sonido.

    method subirVolumenDelSonido(){sonidos = (sonidos + 0.1).min(1)}
    method bajarVolumenDelSonido(){sonidos = (sonidos - 0.1).max(0)}

    method subirVolumenDelAmbiente(){
        ambiente = (ambiente + 0.1).min(1)
        ambientesEnReproduccion.values().forEach({a => a.volume(self.volumenDelAmbiente())})
        }
    method bajarVolumenDelAmbiente(){
        ambiente = (ambiente - 0.1).max(0)
        ambientesEnReproduccion.values().forEach({a => a.volume(self.volumenDelAmbiente())})
        }

    method subirVolumenDeLaMusica(){
        musica = (musica + 0.1).min(1)
        if (musicaEnReproduccion != null) {musicaEnReproduccion.volume(self.volumenDeMusica())}
        if (musicaUnicaEnReproduccion != null) {musicaUnicaEnReproduccion.volume(self.volumenDeMusica())}
        }
    method bajarVolumenDeLaMusica(){
        musica = (musica - 0.1).max(0)
        if (musicaEnReproduccion != null) {musicaEnReproduccion.volume(self.volumenDeMusica())}
        if (musicaUnicaEnReproduccion != null) {musicaUnicaEnReproduccion.volume(self.volumenDeMusica())}
        }

    method subirVolumenPrincipal(){
        principal = (principal + 0.1).min(1)
        ambientesEnReproduccion.values().forEach({a => a.volume(self.volumenDelAmbiente())})
        if (musicaEnReproduccion != null) {musicaEnReproduccion.volume(self.volumenDeMusica())}
        if (musicaUnicaEnReproduccion != null) {musicaUnicaEnReproduccion.volume(self.volumenDeMusica())}
        }
    method bajarVolumenPrincipal(){
        principal = (principal - 0.1).max(0)
        ambientesEnReproduccion.values().forEach({a => a.volume(self.volumenDelAmbiente())})
        if (musicaEnReproduccion != null) {musicaEnReproduccion.volume(self.volumenDeMusica())}
        if (musicaUnicaEnReproduccion != null) {musicaUnicaEnReproduccion.volume(self.volumenDeMusica())}
        }

// Los reproductores de cada sonido.

    method reproducirSonido(sonidoAReproducir) {
        const sonido = game.sound(sonidoAReproducir)

        sonido.volume(self.volumenDeSonidos())
        sonido.play()
    }

    method reproducirAmbiente(sonidoAmbiente) {
        if (not ambientesEnReproduccion.containsKey(sonidoAmbiente)){
            const sonido = game.sound(sonidoAmbiente)

            sonido.shouldLoop(true)
            sonido.volume(self.volumenDelAmbiente())
            sonido.play()
            ambientesEnReproduccion.put(sonidoAmbiente, sonido)
        }
    }

    method reproducirMusica(musicaARproducir) { // permite sobreescribir musica sin problema alguno.
        const musicon = game.sound(musicaARproducir)

        self.quitarMusica()
        musicon.shouldLoop(true)
        musicon.volume(self.volumenDeMusica())
        musicon.play()
        musicaEnReproduccion = musicon
    }

    method reproducirMusicaUnica(musicaARproducir) {
        const musicon = game.sound(musicaARproducir)

        musicon.volume(self.volumenDeMusica())
        musicon.play()
        musicaUnicaEnReproduccion = musicon
    }

// Los metodo para pausar, reanudar, y quitar musica o sonido ambiente. No da error si no hay nada.

    method pausarMusica(){
        if (musicaEnReproduccion != null){
            musicaEnReproduccion.pause()
        }
    }
    method reanudarMusica(){
        if (musicaEnReproduccion != null){
            musicaEnReproduccion.resume()
        }
    }
    method quitarMusica(){
        if (musicaEnReproduccion != null){
            musicaEnReproduccion.stop()
            musicaEnReproduccion = null
        }
    }

    method pausarAmbiente(ambienteAPausar){
        if (ambientesEnReproduccion.containsKey(ambienteAPausar)){    
            ambientesEnReproduccion.get(ambienteAPausar).pause()
        }
    }
    method reanudarAmbiente(ambienteAReanudar){
        if (ambientesEnReproduccion.containsKey(ambienteAReanudar)){    
            ambientesEnReproduccion.get(ambienteAReanudar).resume()
        }
    }
    method quitarAmbiente(ambienteAQuitar){
        if (ambientesEnReproduccion.containsKey(ambienteAQuitar)){    
            ambientesEnReproduccion.get(ambienteAQuitar).stop()
            ambientesEnReproduccion.remove(ambienteAQuitar)
        }
    }

    method pausarTodosLosAmbiente(){
        ambientesEnReproduccion.values().forEach({a => a.pause()})
    }
    method reanudarTodosLosAmbiente(){
        ambientesEnReproduccion.values().forEach({a => a.resume()})
    }
    method quitarTodosLosAmbiente(){
        ambientesEnReproduccion.values().forEach({a => a.stop()})
        ambientesEnReproduccion.clear()
    }

} 