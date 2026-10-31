import wollok.game.*
import Timoty.*
import mochila.*
import Teletubbie.*

object piso{
    var property position=game.at(1,2)
    method image()="./assets/tiles/cocina_piso.png"
    method tieneColision() = false
}
object pared_frontal {
    var property position=game.at(1,9)
    method image()="./assets/tiles/cocina_pared.png"
    method tieneColision() = true
}
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
}
class Pared{
    var property position
    const superficie=[]
    const image
    method image()=image
    method tieneColision()=true
    method superficie()=superficie

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

    method estaOcupando(unaPosicion) {
        // superficie.get(0) es el ancho, superficie.get(1) es el alto
        const xMax = position.x() + superficie.get(0) - 1
        const yMax = position.y() + superficie.get(1) - 1
        
        return unaPosicion.x().between(position.x(), xMax) 
           and unaPosicion.y().between(position.y(), yMax)
    }
}
class Puerta{
   const property position
   const property truePosition 
   const property image
   var estaAbierta=true
   method estaAbierta()=estaAbierta
   method desbloquearPuerta(){estaAbierta=true}
}
const puerta_cocina = new Puerta(position=game.at(6,4),truePosition=game.at(7,4),image="./assets/tiles/puerta2.png")
const puerta_cocinaYSalon = new Puerta(position=game.at(7,4),truePosition=game.at(6,4),image="./assets/tiles/puerta.png")
const puerta_salonYpelotero= new Puerta(position=game.at(18,9),truePosition=game.at(18,9),image="./assets/tiles/puerta3.png")
const puerta_peloteroYsalon= new Puerta(position=game.at(18,9),truePosition=game.at(18,8),image="./assets/tiles/puerta4.png")

const mesa = new Objetos(position = game.at(2, 4), superficie =[1,4], image = "./assets/tiles/mesa.png", ordenDeDibujado = 1, vaAdelanteDeTimothy = false, tieneColision = true)
const silla_derecha = new Objetos(position = game.at(3, 4), superficie =[1,2], image = "./assets/tiles/silla_derecha.png", ordenDeDibujado = 1, vaAdelanteDeTimothy = false, tieneColision = true)
const pared_lateral = new Pared(position = game.at(7, 2), superficie =[1,8], image = "./assets/tiles/pared_lateral.png") 
const paredAtrasSalon=new Pared(position=game.at(7,9),image="./assets/tiles/salon_pared.png",superficie=[16,1])
const paredAtrasPelotero=new Pared(position=game.at(13,17),image="./assets/tiles/pelotero_pared.png",superficie=[16,1])


const piso_salon=new Piso(position=game.at(7,2),image="./assets/tiles/piso_salon.png")
const piso_pelotero=new Piso(position=game.at(13,10),image="./assets/tiles/piso_pelotero.png")



const paredInvisible1=new Pared(position=game.at(13,9),superficie=[5,1],image="./assets/tiles/puerta4.png")
const paredInvisible2=new Pared(position=game.at(19,9),superficie=[4,1],image="./assets/tiles/puerta3.png")

const cocina=new Habitacion(xMin=1,xMax=6,yMin=2,yMax=8,puertas=[puerta_cocina],pisoHabitacion=piso,paredAtras=pared_frontal,objetosConColision=[mesa,silla_derecha,pared_lateral],objetosSinColision=[piso],nombre="cocina",estaOculto=false)
const salon=new Habitacion(xMin=7,xMax=22,yMin=2,yMax=8,puertas=[puerta_cocinaYSalon,puerta_salonYpelotero],pisoHabitacion=piso_salon,paredAtras=paredAtrasSalon,nombre="salon",estaOculto=false,objetosConColision=[paredAtrasSalon],objetosSinColision=[piso_salon])
const pelotero=new Habitacion(xMin=13,xMax=22,yMin=9,yMax=16,puertas=[puerta_peloteroYsalon],pisoHabitacion=piso_pelotero,paredAtras=paredAtrasPelotero,nombre="pelotero",estaOculto=false,objetosConColision=[paredAtrasPelotero,paredInvisible1,paredInvisible2],objetosSinColision=[piso_pelotero])


object mapa {
    var dificultadActual = "facil"

    const habitaciones=[cocina,salon,pelotero]
    method dificultad() = if(dificultadActual == "facil") self.facil() else self.dificil()
    method dificultadActual(cambiarDificultad) { dificultadActual = cambiarDificultad }
    method facil() {
        cocina.dibujarHabitacion()
        salon.dibujarHabitacion()
        pelotero.dibujarHabitacion()
        game.addVisual(mesa)
        game.addVisual(silla_derecha)
        game.addVisual(timoty)
        game.addVisual(carta)
        game.addVisual(luz)
        game.addVisual(pared_lateral)
        game.addVisual(mochila)
        timoty.caminar()
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