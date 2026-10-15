object timoty {
    var property position = game.at(1, 1)
    var property image = "./assets/timoty_sprites/timoty_front.png" 

    var direccionActual = "front"
    var paso = 0
    var posicionAnterior = game.at(1, 1)

    method cambiarDireccion(nuevaDireccion) {
        direccionActual = nuevaDireccion
        self.actualizarSprite()
    }

    method animarCaminata() {
        // si la posición actual es distinta a la anterior, significa que estamos caminando
        if (position != posicionAnterior) {
            paso = (paso + 1) % 4
            posicionAnterior = position
        } else {
            paso = 0
        }
        self.actualizarSprite()
    }
    
    method actualizarSprite() {
        const rutaBase = "./assets/timoty_sprites/timoty_" + direccionActual

        if (paso == 1) {
            image = rutaBase + "_left_foot.png"
        } else if (paso == 2) {
            image = rutaBase + "_right_foot.png"
        } else {
            image = rutaBase + ".png" 
        }
    }
}
