import wollok.game.*
import Timoty.*
import mochila.*
import MainTittle.menuInterfaz
import pantallasFinDeJuego.*
import src.sonidos.*
import mapa.*

object puzzleDados {
    var estaResuelto = false

    method verificar() {
        if (not estaResuelto and not dados.spritesInstanciados().isEmpty()) {
            const dado3 = dados.spritesInstanciados().get(0)
            const dado6 = dados.spritesInstanciados().get(1)
            const dado5 = dados.spritesInstanciados().get(2)

            const dado3Correcto = dado3.position() == game.at(13, 15)
            const dado5Correcto = dado5.position() == game.at(14, 12)
            const dado6Correcto = dado6.position() == game.at(15, 15)

            if (dado3Correcto and dado5Correcto and dado6Correcto) {
                estaResuelto = true
                self.resolver()
            }
        }
    }
    method resolver() {
        puerta_pelotero.desbloquearPuerta()
        puerta_pelotero2.desbloquearPuerta()
        gestorSFX.reproducirSonido("sonidos/puertaAbriendose.mp3")
    }
    method reiniciar() {
        estaResuelto = false
    }
}

const puerta_cocina = new Puerta(position=game.at(6,4),truePosition=game.at(7,4),image="tiles/puerta2.png")
const puerta_cocinaYSalon = new Puerta(position=game.at(7,4),truePosition=game.at(6,4),image="tiles/puerta.png")
const puerta_salonYpelotero = new Puerta(position=game.at(18,9),truePosition=game.at(18,9),image="tiles/puerta3.png")
const puerta_peloteroYsalon = new Puerta(position=game.at(18,9),truePosition=game.at(18,8),image="tiles/puerta4.png")
const puerta_pelotero = new Puerta(position=game.at(12,11),truePosition=game.at(12,11),image="tiles/puerta2.png")
const puerta_pelotero2 = new Puerta(position=game.at(13,11),truePosition=game.at(12,11),image="tiles/puerta.png")


const luz = new Objetos(position = game.at(1, 2), superficie =[1,1], image = "tiles/cocina_ventana_luz.png", ordenDeDibujado = 1, vaAdelanteDeTimothy = false, tieneColision = false)
const mesa = new Objetos(position = game.at(2, 4), superficie =[1,4], image = "tiles/mesa.png", ordenDeDibujado = 1, vaAdelanteDeTimothy = false, tieneColision = true)
const silla_derecha = new Objetos(position = game.at(3, 4), superficie =[1,2], image = "tiles/silla_derecha.png", ordenDeDibujado = 1, vaAdelanteDeTimothy = false, tieneColision = true)
const silla_izquierda = new Objetos(position = game.at(1, 5), superficie =[1,2], image = "tiles/silla_izquierda.png", ordenDeDibujado = 1, vaAdelanteDeTimothy = false, tieneColision = true)

const sillones= new Objetos(position = game.at(17, 16), superficie =[1,1], image = "objetos/sillones.png", ordenDeDibujado = 1, vaAdelanteDeTimothy = false, tieneColision = true)
const patitas = new Objetos(position = game.at(9, 4), superficie =[1,2], image = "tiles/patitas.png", ordenDeDibujado = 1, vaAdelanteDeTimothy = false, tieneColision = false)
const linea_pelotas1 = new Objetos(position = game.at(20,16),superficie=[3,1], image="tiles/linea_pelotas.png",ordenDeDibujado = 2, vaAdelanteDeTimothy = false, tieneColision = false)
const linea_pelotas2 = new Objetos(position = game.at(20,15),superficie=[3,1], image="tiles/linea_pelotas.png",ordenDeDibujado = 2, vaAdelanteDeTimothy = false, tieneColision = false)
const linea_pelotas3 = new Objetos(position = game.at(20,14),superficie=[3,1], image="tiles/linea_pelotas.png",ordenDeDibujado = 2, vaAdelanteDeTimothy = false, tieneColision = false)
const arco_pelotas = new Objetos(position = game.at(22,15),superficie=[1,3], image="tiles/arco_pelotas.png",ordenDeDibujado = 3, vaAdelanteDeTimothy = false, tieneColision = false)

const carta = new ObjetoUsable(position = game.at(1, 3), superficie =[1,1], image = "objetos/carta.gif", ordenDeDibujado = 1, vaAdelanteDeTimothy = false, tieneColision = false, imagenesInventario = ["objetos/objetos_mochila/carta_mochila.png"], descripcion = "ui/instrucciones.png")
const dados = new ObjetoUsable(position = game.at(22,13), superficie = [1,1], image = "objetos/dados.png", ordenDeDibujado = 3, vaAdelanteDeTimothy = false, tieneColision = true, imagenesInventario = ["objetos/objetos_mochila/dado3_mochila.png","objetos/objetos_mochila/dado6_mochila.png","objetos/objetos_mochila/dado5_mochila.png"], descripcion = "ui/descripcionDados.png")
const mazo = new ObjetoUsable(position = game.at(2,4), superficie = [1,1], image = "objetos/martillo.png", ordenDeDibujado = 2, vaAdelanteDeTimothy = false, tieneColision = true, imagenesInventario = ["objetos/objetos_mochila/martillo_mochila.png"], descripcion = "ui/descripcionMazo.png")
const pastel = new ObjetoUsable(position = game.at(15,4), superficie = [1,1], image = "objetos/pastel_cuchillo.png", ordenDeDibujado = 1, vaAdelanteDeTimothy = false, tieneColision = true, imagenesInventario = ["objetos/objetos_mochila/pastel_cuchillo_mochila.png"], descripcion = "ui/descripcionPastel.png")
const cuchillo = new ObjetoUsable(position = game.at(8,4), superficie = [1,1], image = "objetos/cuchillo.png", ordenDeDibujado = 1, vaAdelanteDeTimothy = false, tieneColision = true, imagenesInventario = ["objetos/objetos_mochila/cuchillo_mochila.png"], descripcion = "ui/descripcionCuchillo.png")
const llave = new ObjetoUsable(position = game.at(14,9), superficie = [1,1], image = "objetos/llave.png", ordenDeDibujado = 1, vaAdelanteDeTimothy = false, tieneColision = false, imagenesInventario = ["objetos/objetos_mochila/llave_mochila.png"], descripcion = "ui/descripcionLlave.png")

const baldosa1 = new Objetos(position = game.at(13,13), superficie = [1,1], image = "tiles/numeros/baldosa1.png", ordenDeDibujado = 1, vaAdelanteDeTimothy = false, tieneColision = false)
const baldosa2 = new Objetos(position = game.at(14,14), superficie = [1,1], image = "tiles/numeros/baldosa2.png", ordenDeDibujado = 1, vaAdelanteDeTimothy = false, tieneColision = false)
const baldosa4 = new Objetos(position = game.at(15,13), superficie = [1,1], image = "tiles/numeros/baldosa4.png", ordenDeDibujado = 1, vaAdelanteDeTimothy = false, tieneColision = false)
const baldosa7 = new Objetos(position = game.at(15,14), superficie = [1,1], image = "tiles/numeros/baldosa7.png", ordenDeDibujado = 1, vaAdelanteDeTimothy = false, tieneColision = false)
const baldosa8 = new Objetos(position = game.at(14,15), superficie = [1,1], image = "tiles/numeros/baldosa8.png", ordenDeDibujado = 1, vaAdelanteDeTimothy = false, tieneColision = false)
const baldosa9 = new Objetos(position = game.at(14,13), superficie = [1,1], image = "tiles/numeros/baldosa9.png", ordenDeDibujado = 1, vaAdelanteDeTimothy = false, tieneColision = false)
const baldosa10 = new Objetos(position = game.at(13,14), superficie = [1,1], image = "tiles/numeros/baldosa10.png", ordenDeDibujado = 1, vaAdelanteDeTimothy = false, tieneColision = false)

const baldosa3 = new ObjetoInteractuable(position = game.at(13,15), superficie = [1,1], image = "tiles/numeros/baldosa3.png", ordenDeDibujado = 1, vaAdelanteDeTimothy = false, tieneColision = false, accion = {
    if (not dados.spritesInstanciados().isEmpty()) {
        const dado3 = dados.spritesInstanciados().get(0)
        dado3.position(game.at(13,15))
        gestorSFX.reproducirSonido("sonidos/dado.mp3")
        game.removeVisual(timoty)
        game.addVisual(timoty)
        puzzleDados.verificar()
    }
})
const baldosa5 = new ObjetoInteractuable(position = game.at(14,12), superficie = [1,1], image = "tiles/numeros/baldosa5.png", ordenDeDibujado = 1, vaAdelanteDeTimothy = false, tieneColision = false, accion = {
    if (not dados.spritesInstanciados().isEmpty()) {
        const dado5 = dados.spritesInstanciados().get(2)
        dado5.position(game.at(14,12))
        gestorSFX.reproducirSonido("sonidos/dado.mp3")
        game.removeVisual(timoty)
        game.addVisual(timoty)
        puzzleDados.verificar()
    }
})
const baldosa6 = new ObjetoInteractuable(position = game.at(15,15), superficie = [1,1], image = "tiles/numeros/baldosa6.png", ordenDeDibujado = 1, vaAdelanteDeTimothy = false, tieneColision = false, accion = {
    if (not dados.spritesInstanciados().isEmpty()) {
        const dado6 = dados.spritesInstanciados().get(1)
        dado6.position(game.at(15,15))
        gestorSFX.reproducirSonido("sonidos/dado.mp3")
        game.removeVisual(timoty)
        game.addVisual(timoty)
        puzzleDados.verificar()
    }
})

const bloqueoPuertaCocinaSalon = new ObjetoInteractuable(position = game.at(7,4), superficie = [1,1], image = "tiles/puerta4.png", ordenDeDibujado = 1, vaAdelanteDeTimothy = false, tieneColision = false, accion = {
    if (not mazo.spritesInstanciados().isEmpty()) {
        const habitacionActual = mapa.habitacionEn(bloqueoPuertaCocinaSalon.position())
        habitacionActual.objetosSinColision().remove(bloqueoPuertaCocinaSalon)
        puerta_cocinaYSalon.desbloquearPuerta()
        puerta_cocina.desbloquearPuerta()
        gestorSFX.reproducirSonido("sonidos/puertaRota.mp3")
        gestorSFX.reproducirSonido("sonidos/golpeConEco.mp3")
        mochila.sacarItem(mazo)
    }
})

const areaPastel = new ObjetoInteractuable(position = game.at(9,4), superficie = [1,1], image = "tiles/puerta4.png", ordenDeDibujado = 1, vaAdelanteDeTimothy = false, tieneColision = false, accion = {
    if (not pastel.spritesInstanciados().isEmpty()) {
        mochila.sacarItem(pastel)
        const pastelEnSuelo = new ObjetoUsable(position = game.at(9,4),superficie =[1,1],image = "objetos/pastel_cuchillo.png",ordenDeDibujado = 1,vaAdelanteDeTimothy = false,tieneColision = false,imagenesInventario = ["objetos/pastel_cuchillo.png"],descripcion = ["ui/cuadro_de_texto.png"])
        
        game.addVisual(pastelEnSuelo)
        
        const habitacionActual = mapa.habitacionEn(pastelEnSuelo.position())
        habitacionActual.objetosSinColision().add(pastelEnSuelo)
        
        game.onCollideDo(pastelEnSuelo, { alguien => if (alguien.esEnemigo()) { 
            pastelEnSuelo.serChocadoPorEnemigo()
            gestorSFX.reproducirSonido("sonidos/pastel.mp3")
            game.addVisual(cuchillo)
            habitacionActual.objetosConColision().add(cuchillo)
            mapa.actualizarFiltroNoche()
        }})
    }    
})

const grieta = new ObjetoInteractuable(position = game.at(14,9), superficie = [1,1], image = "tiles/grieta.png", ordenDeDibujado = 1, vaAdelanteDeTimothy = false, tieneColision = false, accion = {
    if (not cuchillo.spritesInstanciados().isEmpty()) {
        mochila.sacarItem(cuchillo)
        const grieta_abierta = new Objetos(position = game.at(14, 9), superficie =[1,1], image = "tiles/grieta_abierta.png", ordenDeDibujado = 1, vaAdelanteDeTimothy = false, tieneColision = false)
        game.addVisual(grieta_abierta)
        gestorSFX.reproducirSonido("sonidos/grieta.mp3")
        game.addVisual(llave)

        const habitacionActual = mapa.habitacionEn(grieta.position())
        habitacionActual.objetosSinColision().add(grieta_abierta)
        habitacionActual.objetosSinColision().add(llave)
        game.removeVisual(timoty)
        game.addVisual(timoty)
    }
})

const bloqueoPuertaSalonPelotero = new ObjetoInteractuable(position = game.at(18,9), superficie = [1,1], image = "tiles/puerta4.png", ordenDeDibujado = 1, vaAdelanteDeTimothy = false, tieneColision = true, accion = {
    if (not llave.spritesInstanciados().isEmpty()) {
        const habitacionActual = mapa.habitacionEn(bloqueoPuertaSalonPelotero.position())
        habitacionActual.objetosConColision().remove(bloqueoPuertaSalonPelotero)
        puerta_salonYpelotero.desbloquearPuerta()
        puerta_peloteroYsalon.desbloquearPuerta()
        mochila.sacarItem(llave)
        gestorSFX.reproducirSonido("sonidos/puertaAbriendose.mp3")

    }
})
object zonaDeVictoria {
    const property position = game.at(12, 11)
    const property image = "tiles/puerta4.png"

    method esPuzzle() = false
    method esUsable() = false

    method aparecer() {
        game.addVisual(self)
        game.onCollideDo(self, { alguien =>
            if (alguien.position() == timoty.position()) {
                pantallaVictoria.pantallaVictoria()
            }
        })
    }
}
const pared_cocina = new Pared(position = game.at(1,9), image = "tiles/cocina_pared.png", superficie = [6,1])
const pared_lateral = new Pared(position = game.at(7,2), superficie =[1,8], image = "tiles/pared_lateral.png") 
const paredAtrasSalon = new Pared(position=game.at(7,9),image="tiles/salon_pared.png",superficie=[16,1])
const paredAtrasPelotero = new Pared(position=game.at(13,17),image="tiles/pelotero_pared.png",superficie=[16,1])
const paredAtrasPelotas = new Pared(position=game.at(20,17),image="tiles/pelotas_pared.png",superficie=[3,1])
const paredAdelantePelotas = new Pared(position=game.at(20,14),image="tiles/pelotas_pared.png",superficie=[3,1],ordenDeDibujado=3)

const pared_lateral_salon = new Pared(position=game.at(23,2),image="tiles/pared_lateral.png",superficie=[1,8])
const pared_lateral_pelotero = new Pared(position=game.at(23,10),image="tiles/pared_lateral.png",superficie=[1,8])
const pared_lateral_pelotero2 = new Pared(position=game.at(13,10),image="tiles/pared_lateral.png",superficie=[1,8])
const pared_lateral_cocina2 = new Pared(position=game.at(0,2),image="tiles/pared_lateral.png",superficie=[1,8])

const piso_cocina = new Piso(position=game.at(1,2),image="tiles/cocina_piso.png")
const piso_salon = new Piso(position=game.at(7,2),image="tiles/piso_salon.png")
const piso_pelotero = new Piso(position=game.at(13,10),image="tiles/piso_pelotero.png")
const piso_pelotas = new Piso(position=game.at(20,14),image="tiles/pelotas_piso.png")

const paredInvisible1 = new Pared(position=game.at(13,9),superficie=[5,1],image="tiles/puerta4.png")
const paredInvisible2 = new Pared(position=game.at(19,9),superficie=[4,1],image="tiles/puerta4.png")