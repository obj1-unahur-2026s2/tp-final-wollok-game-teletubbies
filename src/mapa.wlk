import wollok.game.*
import Timoty.*
import mochila.*
import Teletubbie.*
/*
object piso{
    var property position=game.at(1,2)
    method image()="./assets/tiles/cocina_piso.png"
    method tieneColision() = false
}
object pared_frontal {
    var property position=game.at(1,9)
    method image()="./assets/tiles/cocina_pared.png"
    method tieneColision() = true
} */
object luz{
    var property position =game.at(1, 2)
    method image() ="./assets/tiles/cocina_ventana_luz.png"
    method tieneColision() = false
}
object carta{
    var property position =game.at(1,3)
    method image() ="./assets/objetos/carta.gif"
    method tieneColision() = false
}

object cuadroDeTexto{
    const property position=game.at(23,2)
    const property image="./assets/ui/cuadro_de_texto.png"
}
object uiLateral {
    const property position=game.at(0,2)
    const property image="./assets/ui/fondo_negro.png"
}
object fondo {
    const property position=game.at(0,0)
    const property image="./assets/ui/fondo.png"
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

    method dibujarHabitacion(){
        game.addVisual(pisoHabitacion)
        game.addVisual(paredAtras)
        puertas.forEach({ p => game.addVisual(p) })
        objetosConColision.forEach({ o => game.addVisual(o) })
        objetosSinColision.forEach({ o => game.addVisual(o) })
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
}

class ObjetoPuzzle inherits Objetos {
    const accion

    override method esPuzzle() = true
    method interactuar() {
        accion.apply()
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
   method desbloquearPuerta() { estaAbierta = true }
}

const puerta_cocina = new Puerta(position=game.at(6,4),truePosition=game.at(7,4),image="./assets/tiles/puerta2.png")
const puerta_cocinaYSalon = new Puerta(position=game.at(7,4),truePosition=game.at(6,4),image="./assets/tiles/puerta.png")
const puerta_salonYpelotero = new Puerta(position=game.at(18,9),truePosition=game.at(18,9),image="./assets/tiles/puerta3.png")
const puerta_peloteroYsalon = new Puerta(position=game.at(18,9),truePosition=game.at(18,8),image="./assets/tiles/puerta4.png")
const puerta_pelotero = new Puerta(position=game.at(12,11),truePosition=game.at(13,11),image="./assets/tiles/puerta2.png")
const puerta_pelotero2 = new Puerta(position=game.at(13,11),truePosition=game.at(12,11),image="./assets/tiles/puerta.png")

const mesa = new Objetos(position = game.at(2, 4), superficie =[1,4], image = "./assets/tiles/mesa.png", ordenDeDibujado = 1, vaAdelanteDeTimothy = false, tieneColision = true)
const silla_derecha = new Objetos(position = game.at(3, 4), superficie =[1,2], image = "./assets/tiles/silla_derecha.png", ordenDeDibujado = 1, vaAdelanteDeTimothy = false, tieneColision = true)

const dados = new ObjetoUsable(position = game.at(22,13), superficie = [1,1], image = "./assets/objetos/dados.png", ordenDeDibujado = 1, vaAdelanteDeTimothy = false, tieneColision = true, imagenesInventario = ["./assets/objetos/objetos_mochila/dado3.png","./assets/objetos/objetos_mochila/dado6.png","./assets/objetos/objetos_mochila/dado5.png"])
const mazo = new ObjetoUsable(position = game.at(2,4), superficie = [1,1], image = "./assets/objetos/objetos_mochila/martillo.png", ordenDeDibujado = 2, vaAdelanteDeTimothy = false, tieneColision = true, imagenesInventario = ["./assets/objetos/objetos_mochila/martillo.png"])
const pastel = new ObjetoUsable(position = game.at(15,4), superficie = [1,1], image = "./assets/objetos/objetos_mochila/pastel.png", ordenDeDibujado = 1, vaAdelanteDeTimothy = false, tieneColision = true, imagenesInventario = ["./assets/objetos/objetos_mochila/pastel.png"])
const cuchillo = new ObjetoUsable(position = game.at(8,4), superficie = [1,1], image = "./assets/objetos/objetos_mochila/cuchillo.png", ordenDeDibujado = 1, vaAdelanteDeTimothy = false, tieneColision = true, imagenesInventario = ["./assets/objetos/objetos_mochila/cuchillo.png"])

const baldosa1 = new Objetos(position = game.at(13,13), superficie = [1,1], image = "./assets/tiles/numeros/baldosa1.png", ordenDeDibujado = 1, vaAdelanteDeTimothy = false, tieneColision = false)
const baldosa2 = new Objetos(position = game.at(14,14), superficie = [1,1], image = "./assets/tiles/numeros/baldosa2.png", ordenDeDibujado = 1, vaAdelanteDeTimothy = false, tieneColision = false)
const baldosa4 = new Objetos(position = game.at(15,13), superficie = [1,1], image = "./assets/tiles/numeros/baldosa4.png", ordenDeDibujado = 1, vaAdelanteDeTimothy = false, tieneColision = false)
const baldosa7 = new Objetos(position = game.at(15,14), superficie = [1,1], image = "./assets/tiles/numeros/baldosa7.png", ordenDeDibujado = 1, vaAdelanteDeTimothy = false, tieneColision = false)
const baldosa8 = new Objetos(position = game.at(14,15), superficie = [1,1], image = "./assets/tiles/numeros/baldosa8.png", ordenDeDibujado = 1, vaAdelanteDeTimothy = false, tieneColision = false)
const baldosa9 = new Objetos(position = game.at(14,13), superficie = [1,1], image = "./assets/tiles/numeros/baldosa9.png", ordenDeDibujado = 1, vaAdelanteDeTimothy = false, tieneColision = false)
const baldosa10 = new Objetos(position = game.at(13,14), superficie = [1,1], image = "./assets/tiles/numeros/baldosa10.png", ordenDeDibujado = 1, vaAdelanteDeTimothy = false, tieneColision = false)

const baldosa3 = new ObjetoPuzzle(position = game.at(13,15), superficie = [1,1], image = "./assets/tiles/numeros/baldosa3.png", ordenDeDibujado = 1, vaAdelanteDeTimothy = false, tieneColision = false, accion = {
    if (not dados.spritesInstanciados().isEmpty()) {
        const dado3 = dados.spritesInstanciados().get(0)
        dado3.position(game.at(13,15))
        game.removeVisual(timoty)
        game.addVisual(timoty)
    }
})
const baldosa5 = new ObjetoPuzzle(position = game.at(14,12), superficie = [1,1], image = "./assets/tiles/numeros/baldosa5.png", ordenDeDibujado = 1, vaAdelanteDeTimothy = false, tieneColision = false, accion = {
    if (not dados.spritesInstanciados().isEmpty()) {
        const dado5 = dados.spritesInstanciados().get(2)
        dado5.position(game.at(14,12))
        game.removeVisual(timoty)
        game.addVisual(timoty)
    }
})
const baldosa6 = new ObjetoPuzzle(position = game.at(15,15), superficie = [1,1], image = "./assets/tiles/numeros/baldosa6.png", ordenDeDibujado = 1, vaAdelanteDeTimothy = false, tieneColision = false, accion = {
    if (not dados.spritesInstanciados().isEmpty()) {
        const dado6 = dados.spritesInstanciados().get(1)
        dado6.position(game.at(15,15))
        game.removeVisual(timoty)
        game.addVisual(timoty)
    }
})

const bloqueoPuertaCocinaSalon = new ObjetoPuzzle(position = game.at(7,4), superficie = [1,1], image = "./assets/tiles/puerta4.png", ordenDeDibujado = 1, vaAdelanteDeTimothy = false, tieneColision = false, accion = {
    if (not mazo.spritesInstanciados().isEmpty()) {
        const habitacionActual = mapa.habitacionEn(bloqueoPuertaCocinaSalon.position())
        habitacionActual.objetosSinColision().remove(bloqueoPuertaCocinaSalon)
        puerta_cocinaYSalon.desbloquearPuerta()
        puerta_cocina.desbloquearPuerta()
        mochila.sacarItem(mazo)
    }
})

const areaPastel = new ObjetoPuzzle(position = game.at(9,4), superficie = [1,1], image = "./assets/tiles/puerta4.png", ordenDeDibujado = 1, vaAdelanteDeTimothy = false, tieneColision = false, accion = {
    if (not pastel.spritesInstanciados().isEmpty()) {
        mochila.sacarItem(pastel)
        const pastelEnSuelo = new ObjetoUsable(
            position = game.at(9,4),
            superficie =[1,1],
            image = "./assets/objetos/objetos_mochila/pastel.png",
            ordenDeDibujado = 1,
            vaAdelanteDeTimothy = false,
            tieneColision = false,
            imagenesInventario = ["./assets/objetos/objetos_mochila/pastel.png"]
        )
        
        game.addVisual(pastelEnSuelo)
        
        const habitacionActual = mapa.habitacionEn(pastelEnSuelo.position())
        habitacionActual.objetosSinColision().add(pastelEnSuelo)
        
        game.onCollideDo(pastelEnSuelo, { alguien => if (alguien.esEnemigo()) { 
            pastelEnSuelo.serChocadoPorEnemigo()
            game.addVisual(cuchillo)
            habitacionActual.objetosConColision().add(cuchillo)
        }})
    }    
})

const pared_cocina = new Pared(position = game.at(1,9), image = "./assets/tiles/cocina_pared.png", superficie = [6,1])
const pared_lateral = new Pared(position = game.at(7,2), superficie =[1,8], image = "./assets/tiles/pared_lateral.png") 
const paredAtrasSalon = new Pared(position=game.at(7,9),image="./assets/tiles/salon_pared.png",superficie=[16,1])
const paredAtrasPelotero = new Pared(position=game.at(13,17),image="./assets/tiles/pelotero_pared.png",superficie=[16,1])
const pared_lateral_salon = new Pared(position=game.at(23,2),image="./assets/tiles/pared_lateral.png",superficie=[1,8])
const pared_lateral_pelotero = new Pared(position=game.at(23,10),image="./assets/tiles/pared_lateral.png",superficie=[1,8])
const pared_lateral_cocina2 = new Pared(position=game.at(0,2),image="./assets/tiles/pared_lateral.png",superficie=[1,8])


const piso_cocina = new Piso(position=game.at(1,2),image="./assets/tiles/cocina_piso.png")
const piso_salon = new Piso(position=game.at(7,2),image="./assets/tiles/piso_salon.png")
const piso_pelotero = new Piso(position=game.at(13,10),image="./assets/tiles/piso_pelotero.png")

const paredInvisible1 = new Pared(position=game.at(13,9),superficie=[5,1],image="./assets/tiles/puerta4.png")
const paredInvisible2 = new Pared(position=game.at(19,9),superficie=[4,1],image="./assets/tiles/puerta4.png")

const cocina = new Habitacion(xMin=1,xMax=6,yMin=2,yMax=8,puertas=[puerta_cocina],pisoHabitacion=piso_cocina,paredAtras=pared_cocina,objetosConColision=[mesa,silla_derecha,mazo],objetosSinColision=[],nombre="cocina",estaOculto=false)
const salon = new Habitacion(xMin=7,xMax=22,yMin=2,yMax=8,puertas=[puerta_cocinaYSalon,puerta_salonYpelotero],pisoHabitacion=piso_salon,paredAtras=paredAtrasSalon,nombre="salon",estaOculto=false,objetosConColision=[pastel],objetosSinColision=[pared_lateral,pared_lateral_salon,bloqueoPuertaCocinaSalon,areaPastel])
const pelotero = new Habitacion(xMin=13,xMax=22,yMin=9,yMax=16,puertas=[puerta_peloteroYsalon,puerta_pelotero,puerta_pelotero2],pisoHabitacion=piso_pelotero,paredAtras=paredAtrasPelotero,nombre="pelotero",estaOculto=false,objetosConColision=[paredInvisible1,paredInvisible2,dados],objetosSinColision=[pared_lateral_pelotero,baldosa1,baldosa2,baldosa3,baldosa4,baldosa5,baldosa6,baldosa7,baldosa8,baldosa9,baldosa10])


object mapa {
    var dificultadActual = "facil"

    const habitaciones = [cocina,salon,pelotero]
    method dificultad() = if(dificultadActual == "facil") self.facil() else self.dificil()
    method dificultadActual(cambiarDificultad) { dificultadActual = cambiarDificultad }
    method facil() {
        game.addVisual(fondo)
        game.addVisual(uiLateral)
        game.addVisual(cuadroDeTexto)
        cocina.dibujarHabitacion()
        salon.dibujarHabitacion()
        pelotero.dibujarHabitacion()

        game.addVisual(carta)
        game.addVisual(luz)
        game.addVisual(mochila)
        game.addVisual(timoty)
        timoty.caminar()
        keyboard.enter().onPressDo({ 
            timoty.agarrarObjeto()
            timoty.interactuarConObjeto() 
        })
        game.onTick(150, "animarTimoty", { timoty.animarCaminata() })

        //Teletubbies, solo hay que poner el nombre y las coordenadas donde aparecen
       const laalaa = new LaaLaa(habitacion = salon, position = game.at(9, 3))
        laalaa.aparecer()
       const dipsy = new Dipsy(habitacion = pelotero, position = game.at(14, 11))
        dipsy.aparecer()
    }
    method dificil() {}
    

    //metodo que ayuda a saber en que posicion estamos actualmente
    method habitacionEn(unaPosicion) {
        return habitaciones.find({ hab => 
            unaPosicion.x().between(hab.xMin(), hab.xMax()) and 
            unaPosicion.y().between(hab.yMin(), hab.yMax()) 
        })
    }
}