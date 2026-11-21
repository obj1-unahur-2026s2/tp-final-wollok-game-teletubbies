import wollok.game.*
import mapa.*
import sonidos.*

object pantallaDeInicio {
/*
Hice que al ejecutar el programa se inicie con alguno
de los fondos seleccionados, y que con una chance
del 5% te pueda salir una version macabra del menú
*/
  var property position = game.origin()
  const chance = 0.randomUpTo(99)
  const menus = [
    "fondo/Menu_inicio_morado_TLTB.png",
    "fondo/Menu_inicio_rojo_TLTB.png", 
    "fondo/Menu_inicio_verde_TLTB.png",
    "fondo/Menu_inicio_amarillo_TLTB.png" 
    ]
  var property image = self.elegirFondo()
    method elegirFondo(){
        if (chance < 5){
            return "fondo/Menu_inicio_especial_TLTB.jpg"

        }else{
            return menus.anyOne()
        }
    }
}
object titulo{
    var property position = game.at(9,13)
    method image()="Titulo.png"
}
object sonido{
    var property position = game.at(5,12)
    method image()="ui/sonido.png"
}
object ambiente{
    var property position = game.at(5,10)
    method image()="ui/ambiente.png"
}
object musica{
    var property position = game.at(5,8)
    method image()="ui/musica.png"
}
object principal{
    var property position = game.at(5,6)
    method image()="ui/principal.png"
}
object fondoContador{
    var property position = game.at(18,6)
    method image()="ui/fondo_contador.png"
}
object instruccionesMenu { 
    var property position = game.at(0,0) 
    method image()="ui/instruccionesMenu.png" 
}

class OpcionesDelMenu {
    const position
    const image
    const accion
    const offsetSeleccion = 0

    method position() = position
    method image() = image
    method posicionDeSeleccion() = game.at(position.x() + offsetSeleccion, position.y())
    method interactuar(){
        accion.apply() 
    }
}

object botonSeleccionado {
    var property position = game.at(13,10)
    const image = "botones/botonSeleccionado.png"
    var opciones = []
    var indiceActual  = 0

    method image() = image
    method moverSeleccionado(listaOpciones) {
        opciones = listaOpciones

        keyboard.down().onPressDo({ self.irALaSiguiente() })
        keyboard.up().onPressDo({ self.irALaAnterior() })
    }
    method ejecutar() {
        indiceActual = 0
        self.actualizarPosicion()

        keyboard.enter().onPressDo({
            const opcionActual = opciones.get(indiceActual)
            opcionActual.interactuar() 
        })
    }

    method irALaSiguiente() {
        if(indiceActual < opciones.size() - 1) {
            gestorSFX.reproducirSonido("sonidos/sonidoDeMenu2.mp3")
            indiceActual += 1
            self.actualizarPosicion()
        }
    }
    method irALaAnterior() {
        if(indiceActual > 0) {
            gestorSFX.reproducirSonido("sonidos/sonidoDeMenu2.mp3")
            indiceActual -= 1
            self.actualizarPosicion()
        }
    }

    method actualizarPosicion() {
        const opcionDestino = opciones.get(indiceActual)
        position = opcionDestino.posicionDeSeleccion()
    }
}

//se instancian los botones

const opcionJugar = new OpcionesDelMenu(
    position = game.at(13, 10), 
    image = "botones/botonJugar.png",
    accion = { 
      game.clear()
      gestorSFX.reproducirSonido("sonidos/sonidoDeMenu1.mp3")
      mapa.dificultad()
      gestorSFX.quitarMusica()
      gestorSFX.reproducirAmbiente("sonidos/cancion3.mp3")
})
const opcionOpciones = new OpcionesDelMenu(
    position = game.at(13,8) , 
    image = "botones/botonOpciones.png", 
    accion = {
        gestorSFX.reproducirSonido("sonidos/sonidoDeMenu1.mp3")
        game.clear()
        menuInterfaz.menuOpciones()
})
const opcionSalir = new OpcionesDelMenu(
    position = game.at(13,6), 
    image = "botones/botonSalir.png", 
    accion = {game.stop()
})
const opcionFacil = new OpcionesDelMenu(
    position = game.at(13,10),
    image = "botones/botonFacil.png",
    accion = {
        gestorSFX.reproducirSonido("sonidos/sonidoDeMenu1.mp3")
        mapa.dificultadActual("facil")
        game.clear()
        menuInterfaz.menuInicio()
})
const opcionDificil = new OpcionesDelMenu(
    position = game.at(13,8),
    image = "botones/botonDificil.png",
    accion = {
        gestorSFX.reproducirSonido("sonidos/sonidoDeMenu1.mp3")
        mapa.dificultadActual("dificil")
        game.clear()
        menuInterfaz.menuInicio()
})
const opcionInstrucciones = new OpcionesDelMenu(
    position = game.at(11.5,6),
    offsetSeleccion = 1,
    image = "botones/botonInstrucciones.png",
    accion = {
        gestorSFX.reproducirSonido("sonidos/sonidoDeMenu1.mp3")
        game.clear()
        menuInterfaz.menuInstrucciones()
})
const opcionAtras = new OpcionesDelMenu(
    position = game.at(13,4),
    image = "botones/botonAtras.png",
    accion = {
        gestorSFX.reproducirSonido("sonidos/sonidoDeMenu1.mp3")
        game.clear()
        menuInterfaz.menuOpciones()
})
const opcionAtras2 = new OpcionesDelMenu(
    position = game.at(13,2),
    image = "botones/botonAtras.png",
    accion = {
        gestorSFX.reproducirSonido("sonidos/sonidoDeMenu1.mp3")
        game.clear()
        menuInterfaz.menuInicio()
})
const opcionVolumen = new OpcionesDelMenu(
    position = game.at(13,4),
    image = "botones/boton_volumen.png",
    accion = {
        gestorSFX.reproducirSonido("sonidos/sonidoDeMenu1.mp3")
        game.clear()
        menuInterfaz.menuVolumen()
})
const masSonido = new OpcionesDelMenu(
    position = game.at(22,12),
    offsetSeleccion = -1.5,
    image = "botones/boton_mas.png",
    accion = {
        gestorSFX.reproducirSonido("sonidos/sonidoDeMenu1.mp3")
        gestorSFX.subirVolumenDelSonido()
        indicadorSonido.actualizar()
})
const menosSonido = new OpcionesDelMenu(
    position = game.at(14,12),
    offsetSeleccion = -1.5,
    image = "botones/boton_menos.png",
    accion = {
        gestorSFX.reproducirSonido("sonidos/sonidoDeMenu1.mp3")
        gestorSFX.bajarVolumenDelSonido()
        indicadorSonido.actualizar()
})
const masAmbiente = new OpcionesDelMenu(
    position = game.at(22,10),
    offsetSeleccion = -1.5,
    image = "botones/boton_mas.png",
    accion = {
        gestorSFX.reproducirSonido("sonidos/sonidoDeMenu1.mp3")
        gestorSFX.subirVolumenDelAmbiente()
        indicadorAmbiente.actualizar()
})
const menosAmbiente = new OpcionesDelMenu(
    position = game.at(14,10),
    offsetSeleccion = -1.5,
    image = "botones/boton_menos.png",
    accion = {
        gestorSFX.reproducirSonido("sonidos/sonidoDeMenu1.mp3")
        gestorSFX.bajarVolumenDelAmbiente()
        indicadorAmbiente.actualizar()
})
const masMusica = new OpcionesDelMenu(
    position = game.at(22,8),
    offsetSeleccion = -1.5,
    image = "botones/boton_mas.png",
    accion = {
        gestorSFX.reproducirSonido("sonidos/sonidoDeMenu1.mp3")
        gestorSFX.subirVolumenDeLaMusica()
        indicadorMusica.actualizar()
})
const menosMusica = new OpcionesDelMenu(
    position = game.at(14,8),
    offsetSeleccion = -1.5,
    image = "botones/boton_menos.png",
    accion = {
        gestorSFX.reproducirSonido("sonidos/sonidoDeMenu1.mp3")
        gestorSFX.bajarVolumenDeLaMusica()
        indicadorMusica.actualizar()
})
const masPrincipal = new OpcionesDelMenu(
    position = game.at(22,6),
    offsetSeleccion = -1.5,
    image = "botones/boton_mas.png",
    accion = {
        gestorSFX.reproducirSonido("sonidos/sonidoDeMenu1.mp3")
        gestorSFX.subirVolumenPrincipal()
        indicadorPrincipal.actualizar()
})
const menosPrincipal = new OpcionesDelMenu(
    position = game.at(14,6),
    offsetSeleccion = -1.5,
    image = "botones/boton_menos.png",
    accion = {
        gestorSFX.reproducirSonido("sonidos/sonidoDeMenu1.mp3")
        gestorSFX.bajarVolumenPrincipal()
        indicadorPrincipal.actualizar()
})

const indicadorSonido = new ContadorVisual(
  position = game.at(18, 12),
  bloqueValor = { (gestorSFX.sonidos() * 10).round() }
)
const indicadorAmbiente = new ContadorVisual(
  position = game.at(18, 10),
  bloqueValor = { (gestorSFX.ambiente() * 10).round() }
)
const indicadorMusica = new ContadorVisual(
  position = game.at(18, 8),
  bloqueValor = { (gestorSFX.musica() * 10).round() }
)
const indicadorPrincipal = new ContadorVisual(
  position = game.at(18, 6),
  bloqueValor = { (gestorSFX.principal() * 10).round() }
)

object menuInterfaz {
    method menuInicio(){
        game.addVisual(pantallaDeInicio)
        game.addVisual(opcionJugar)
        game.addVisual(opcionOpciones)
        game.addVisual(opcionSalir)
        game.addVisual(botonSeleccionado)
        game.addVisual(titulo)
        botonSeleccionado.moverSeleccionado([opcionJugar, opcionOpciones, opcionSalir])
        botonSeleccionado.ejecutar()
    }
    method menuOpciones() {
        game.addVisual(pantallaDeInicio)
        game.addVisual(opcionFacil)
        game.addVisual(opcionDificil)
        game.addVisual(opcionInstrucciones)
        game.addVisual(opcionVolumen)
        game.addVisual(opcionAtras2)
        game.addVisual(botonSeleccionado)
        game.addVisual(titulo)
        botonSeleccionado.moverSeleccionado([opcionFacil, opcionDificil, opcionInstrucciones, opcionVolumen ,opcionAtras2])
        botonSeleccionado.ejecutar()
    }
    method menuInstrucciones() {
        game.addVisual(pantallaDeInicio)
        game.addVisual(opcionAtras)
        game.addVisual(instruccionesMenu)
        game.addVisual(botonSeleccionado)
        botonSeleccionado.moverSeleccionado([opcionAtras])
        botonSeleccionado.ejecutar()
    }
    method menuVolumen() {
        game.addVisual(pantallaDeInicio)
        game.addVisual(sonido)
        game.addVisual(ambiente)
        game.addVisual(musica)
        game.addVisual(principal)
        game.addVisual(masSonido)
        game.addVisual(masAmbiente)
        game.addVisual(masMusica)
        game.addVisual(masPrincipal)
        game.addVisual(menosSonido)
        game.addVisual(menosAmbiente)
        game.addVisual(menosMusica)
        game.addVisual(menosPrincipal)
        game.addVisual(fondoContador)
        game.addVisual(opcionAtras)
        game.addVisual(botonSeleccionado)
        botonSeleccionado.moverSeleccionado([menosSonido,masSonido,menosAmbiente,masAmbiente,menosMusica,masMusica,menosPrincipal,masPrincipal,opcionAtras])
        indicadorSonido.agregarAlJuego()
        indicadorAmbiente.agregarAlJuego()
        indicadorMusica.agregarAlJuego()
        indicadorPrincipal.agregarAlJuego()
        botonSeleccionado.ejecutar()
    }
}