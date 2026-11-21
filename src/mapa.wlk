import wollok.game.*
import Timoty.*
import mochila.*
import Teletubbie.*
import elementos.*
import sonidos.ContadorVisual

object cuadroDeTexto{
    const property position = game.at(23,2)
    const property image = "ui/FondoDescripcion.png"
}
object uiLateral {
    const property position = game.at(0,2)
    const property image = "ui/fondo_negro.png"
}
object fondo {
    const property position = game.at(0,0)
    const property image = "ui/fondo.png"
}

object filtroNoche{
    const property position = game.origin()
    const property image = "ui/filtroNoche.png"
}
class Habitacion{
    const property objetosConColision=[]
    const property objetosSinColision=[]
    const property pisoHabitacion
    const property paredAtras
    const nombre
    method nombre()=nombre
    var property estaOculto
    var property puertas=[]
    var property xMin
    var property xMax
    var property yMin
    var property yMax

    method dibujarObjetosConOrden(orden) {
        objetosConColision
            .filter({ obj => obj.ordenDeDibujado() == orden })
            .forEach({ obj => game.addVisual(obj) })

        objetosSinColision
            .filter({ obj => obj.ordenDeDibujado() == orden })
            .forEach({ obj => game.addVisual(obj) })
    }

    method dibujarHabitacion(){
        game.addVisual(pisoHabitacion)
        game.addVisual(paredAtras)
        puertas.forEach({ p => game.addVisual(p) })
        self.dibujarObjetosConOrden(1)
        self.dibujarObjetosConOrden(2)
        self.dibujarObjetosConOrden(3)
    }
    method estaCeldaBloqueada(unaPosicion) {
        const puertaEnDestino = puertas.findOrDefault({ p => p.truePosition() == unaPosicion }, null)

        if (puertaEnDestino != null) {
            return not puertaEnDestino.estaAbierta()
        }

        // Validamos primero si la posición se sale de los bordes permitidos para esta habitación
        const seSalioDeLosBordes = unaPosicion.x() < xMin 
                                or unaPosicion.x() > xMax 
                                or unaPosicion.y() < yMin 
                                or unaPosicion.y() > yMax

        if (seSalioDeLosBordes) {
            return true // Bloqueado, es una pared del cuarto
        }
          return objetosConColision.any({ obj => obj.estaOcupando(unaPosicion)})
    }
}

class Piso{
    var property position
    const image

    method image()=image
    method tieneColision()=false  
    method esUsable() = false
    method esPuzzle() = false
}
class Pared{
    var property position
    const superficie=[]
    const image
    const property ordenDeDibujado = 1

    method image()=image
    method tieneColision()=true
    method superficie()=superficie
    method esUsable() = false
    method esPuzzle() = false

    method estaOcupando(unaPosicion) {
        // superficie.get(0) es el ancho, superficie.get(1) es el alto
        const xMax = position.x() + superficie.get(0) - 1
        const yMax = position.y() + superficie.get(1) - 1
        
        return unaPosicion.x().between(position.x(), xMax) 
           and unaPosicion.y().between(position.y(), yMax)
    }
}
class Objetos{
    var property position
    const superficie=[]
    const image
    const property ordenDeDibujado
    const property vaAdelanteDeTimothy 
    var property tieneColision
    method image()=image
    method superficie()=superficie

    method esUsable() = false
    method esPuzzle() = false
    method esEnemigo() = false
    method estaOcupando(unaPosicion) {
        // superficie.get(0) es el ancho, superficie.get(1) es el alto
        const xMax = position.x() + superficie.get(0) - 1
        const yMax = position.y() + superficie.get(1) - 1
        
        return unaPosicion.x().between(position.x(), xMax) 
           and unaPosicion.y().between(position.y(), yMax)
    }
}

class ObjetoUsable inherits Objetos {
    var property imagenesInventario = []
    var property spritesInstanciados = []
    const property descripcion

    override method esUsable() = true
    method guardar() {
        game.removeVisual(self)
        mochila.agregarItem(self)
        const habitacionActual = mapa.habitacionEn(self.position())
        habitacionActual.objetosConColision().remove(self)
        habitacionActual.objetosSinColision().remove(self)
    }
    method serChocadoPorEnemigo() {
        game.removeVisual(self) 
        const habitacionActual = mapa.habitacionEn(self.position())
        habitacionActual.objetosSinColision().remove(self)
    }
    method mostrarDescripcion() {
        cartelDescripcion.mostrar(descripcion)
    }
}
object cartelDescripcion {
    const property position = game.at(23, 2)
    var property image = null
    var estaVisible = false

    method mostrar(nuevaImagen) {
        if (nuevaImagen != null) {
            if (estaVisible) {
                game.removeVisual(self)
            }
            image = nuevaImagen
            game.addVisual(self)
            estaVisible = true
        }
    }
    method ocultar() {
        if (estaVisible) {
            game.removeVisual(self)
            estaVisible = false
        }
    }
    method reiniciar() {
        estaVisible = false
        image = null
    }
}

class ObjetoInteractuable  inherits Objetos {
    const accion

    override method esPuzzle() = true
    method interactuar() {
        accion.apply()
        mapa.actualizarFiltroNoche()
    }
}

class ObjetoAnimable inherits ObjetoInteractuable{
    var imagenActual
    override method image()=imagenActual

    method cambiarImagen(nuevaImagen) {
        imagenActual = nuevaImagen
    }
}
class Puerta{
    const property position
    const property truePosition 
    const property image
    var estaAbierta = false
   
    method esPuzzle() = false
    method esUsable() = false
    method estaAbierta() = estaAbierta
    method desbloquearPuerta() {
        estaAbierta = true
    }
    method reiniciar() {
        estaAbierta = false
    }
}

const laalaa = new Teletubbie(nombre = "laa-laa",color = "amarillo",habitacion = salon,position = game.at(9, 3),ruta = constructorRutas.repetir("right", 10) + constructorRutas.repetir("back", 4) + constructorRutas.repetir("left", 10) + constructorRutas.repetir("front", 4))
const dipsy = new Teletubbie(nombre = "dipsy",color = "verde",habitacion = pelotero,position = game.at(14, 11),ruta = constructorRutas.repetir("right", 4) + constructorRutas.repetir("back", 3) + constructorRutas.repetir("front", 3) + constructorRutas.repetir("left", 4))
const po = new Teletubbie(nombre = "po",color = "rojo",habitacion = pelotero,position = game.at(14,11),ruta = constructorRutas.repetir("right", 4) + constructorRutas.repetir("back", 3) + constructorRutas.repetir("front", 3) + constructorRutas.repetir("left", 4))
const tinkywinky = new Teletubbie(nombre = "tinky_winky",color = "morado",habitacion = salon,position = game.at(9,3),ruta = constructorRutas.repetir("right", 4) + constructorRutas.repetir("back", 3) + constructorRutas.repetir("front", 3) + constructorRutas.repetir("left", 4))

object mapa {
    var dificultadActual = "facil"

    const habitaciones = [cocina,salon,pelotero]
    const interactuar = { 
        timoty.agarrarObjeto()
        timoty.interactuarConObjeto() 
    }
    method dificultad() = if(dificultadActual == "facil") self.facil() else self.dificil()
    method dificultadActual(cambiarDificultad) { dificultadActual = cambiarDificultad }
    method actualizarFiltroNoche(){
        if (dificultadActual == "dificil") {
            game.removeVisual(filtroNoche)
            game.addVisual(filtroNoche)
        }
    }
    method facil() {
        game.addVisual(fondo)
        game.addVisual(uiLateral)
        game.addVisual(cuadroDeTexto)
        cocina.dibujarHabitacion()
        salon.dibujarHabitacion()
        pelotero.dibujarHabitacion()
        game.addVisual(mochila)
        zonaDeVictoria.aparecer()

        game.addVisual(timoty)
        timoty.caminar()
        keyboard.enter().onPressDo(interactuar)
        keyboard.e().onPressDo(interactuar)
        game.onTick(150, "animarTimoty", { timoty.animarCaminata() })

        laalaa.aparecer()
        game.onTick(400, "rutaLaaLaa", { laalaa.avanzar() })
        dipsy.aparecer()
        game.onTick(400, "rutaDipsy", { dipsy.avanzar() })

        temporizador.iniciar(300)
    }
    method dificil() {
        game.addVisual(fondo)
        game.addVisual(uiLateral)
        game.addVisual(cuadroDeTexto)
        cocina.dibujarHabitacion()
        salon.dibujarHabitacion()
        pelotero.dibujarHabitacion()
        game.addVisual(mochila)
        zonaDeVictoria.aparecer()

        game.addVisual(timoty)
        timoty.caminar()
        keyboard.enter().onPressDo(interactuar)
        keyboard.e().onPressDo(interactuar)
        game.onTick(150, "animarTimoty", { timoty.animarCaminata() })
        
        tinkywinky.aparecer()
        game.onTick(500, "perseguirTinkywinky", { tinkywinky.perseguir() })
        po.aparecer()
        game.onTick(500, "perseguirPo", { po.perseguir() })
        
        self.actualizarFiltroNoche()
        temporizador.iniciar(180)
    }
    
    //metodo que ayuda a saber en que posicion estamos actualmente
    method habitacionEn(unaPosicion) {
        return habitaciones.find({ hab => 
            unaPosicion.x().between(hab.xMin(), hab.xMax()) and 
            unaPosicion.y().between(hab.yMin(), hab.yMax()) 
        })
    }

    method limpiarEstado() {
        game.clear()
        temporizador.detener()
        timoty.reiniciar()
        mochila.reiniciar()
        cartelDescripcion.reiniciar()
        puzzleDados.reiniciar()

        habitaciones.forEach({ hab => hab.puertas().forEach({ p => p.reiniciar() }) })

        cocina.objetosConColision().clear()
        cocina.objetosConColision().addAll([mesa,silla_derecha,silla_izquierda2,silla_izquierda,mazo,regalos])
        cocina.objetosSinColision().clear()
        cocina.objetosSinColision().addAll([carta, luz, globos])

        salon.objetosConColision().clear()
        salon.objetosConColision().addAll([pastel,monopatin,noo_noo,tacho,pelota_regalos,sillones_sala,mesa_sala,baberos])
        salon.objetosSinColision().clear()
        salon.objetosSinColision().addAll([pared_lateral,pared_lateral_salon,bloqueoPuertaCocinaSalon,areaPastel,grieta,patitas,papeles])

        pelotero.objetosConColision().clear()
        pelotero.objetosConColision().addAll([paredInvisible1,paredInvisible2,dados,sillones,paredAtrasPelotas,paredAdelantePelotas,arco_pelotas])
        pelotero.objetosSinColision().clear()
        pelotero.objetosSinColision().addAll([pared_lateral_pelotero,baldosa1,baldosa2,baldosa3,baldosa4,baldosa5,baldosa6,baldosa7,baldosa8,baldosa9,baldosa10,bloqueoPuertaSalonPelotero,pared_lateral_pelotero2,linea_pelotas1,linea_pelotas2,linea_pelotas3])
    }
    method reiniciar() {
        self.limpiarEstado()
        self.dificultad()
    }
}

object dosPuntos {
  var property position = game.at(5, 13)
  method image() = "ui/dos_puntos.png"
}

object temporizador {
    var segundosRestantes = 120

    const contadorMinutos = new ContadorVisual(
        position = game.at(3, 13),
        bloqueValor = { segundosRestantes.div(60) }
    )

    const contadorSegundos = new ContadorVisual(
        position = game.at(6, 13),
        bloqueValor = { segundosRestantes % 60 }
    )

    method iniciar(tiempoInicial) {
        segundosRestantes = tiempoInicial
    
        contadorMinutos.agregarAlJuego()
        game.addVisual(dosPuntos)
        contadorSegundos.agregarAlJuego()

        game.onTick(1000, "cuentaRegresiva", {
            segundosRestantes -= 1
            contadorMinutos.actualizar()
            contadorSegundos.actualizar()

        if (segundosRestantes <= 0) {
            self.detener()
            timoty.morir()
        }
        })
    }

    method detener() {
        game.removeTickEvent("cuentaRegresiva")
    }
}