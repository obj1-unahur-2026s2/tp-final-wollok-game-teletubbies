object gestorSonido {
    method musica() {
        const musica = game.sound("./assets/musica/MusicaMenu.mp3")
        
        musica.shouldLoop(true)
        game.schedule(500, {musica.play()})
    }
}