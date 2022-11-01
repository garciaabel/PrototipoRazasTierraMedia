import Comunidad.*
// Definir los objetos y clases que correspondan para modelar los personajes

class Humanoide {
	var chispaVital = 20
	var property estaVivo = true
	
	method chispaVital ()= chispaVital
	method resistencia ()
	method poderDeAtaque () = self.suerte()
	method suerte () = -10.randomUpTo(11).truncate(0)
	method poderDeDefensa() = self.poderDeAtaque () * 1.1
	method raza()
	
	method atacarA (unPersonaje){
		if (estaVivo and unPersonaje.estaVivo())
			self.producirAtaque (unPersonaje)
			chispaVital = 0.max(chispaVital-1)
	}
	
	method producirAtaque (victima){
		if (self.mayorPoderQue(victima)) // si el que ataque tiene mas poder que la victima
			victima.reducirEnergia(self.diferenciaDePoderes(victima)) //se reduce el poder de la victima
		else self.reducirEnergia(self.diferenciaDePoderes(victima)) //sino se reduce el poder de self
		
	}
	
	method mayorPoderQue (unPersonaje) = self.poderDeAtaque() > unPersonaje.poderDeDefensa() 
	method diferenciaDePoderes (unPersonaje) = self.poderDeAtaque() - unPersonaje.poderDeDefensa().abs()
	method reducirEnergia (unValor) 
}


class Humano inherits Humanoide {
	var edad
	var energiaVital = chispaVital + 80.randomUpTo(100).truncate(0)
	var masaMuscular = 30.randomUpTo(71).truncate(0)
	
	method masaMuscular()= masaMuscular
	method raza () = humano
	
	method energiaVital() = energiaVital
	override method resistencia (){ return
		if (edad < 4) energiaVital * 0.2
		else if (edad < 12) energiaVital * 0.5
		else if (edad < 15) energiaVital * 0.6
		else if (edad < 17) energiaVital * 0.8
		else if (edad > 70) energiaVital * 0.7
		else energiaVital
	}
	override method poderDeAtaque () = super() + masaMuscular + self.resistencia()
		
	method desarrollarMusculatura(){
		if (energiaVital > 80){
			masaMuscular = 60.min(masaMuscular + 2)
			energiaVital --
		}
	}
	override method reducirEnergia (unValor){
		energiaVital = 0.max(energiaVital - unValor)
		if (energiaVital==0) estaVivo = false
	}
}

class Elfo inherits Humanoide {
	var energiaVital = chispaVital + 90.randomUpTo(110).truncate(0)
	var masaMuscular = 20.randomUpTo(71).truncate(0)
	var nivelDeMagia = 1.randomUpTo(8).truncate(0)
	
	method masaMuscular()= masaMuscular
	method raza () = elfo
	override method resistencia()= energiaVital
	override method poderDeAtaque()= super() + masaMuscular + self.resistencia()
	override method poderDeDefensa() = super()+ nivelDeMagia
	 
	override method reducirEnergia (unValor){
		energiaVital = 0.max(energiaVital - unValor)
		if (energiaVital==0) estaVivo = false
	}
	
	method desarrollarPoderMagico(){
		if (energiaVital > 60){
			nivelDeMagia = 40.min(nivelDeMagia + 3)
			energiaVital--
		}
	}
}


class Enano inherits Humanoide {
	const edad
	var energiaVital = chispaVital + 75.randomUpTo(100).truncate(0)
	var masaMuscular = 35.randomUpTo(45).truncate(0)
	var nivelDeIra = 1.randomUpTo(1.3).truncate(2)

	method masaMuscular()= masaMuscular	
	method raza () = enano
	override method resistencia () = energiaVital * (nivelDeIra + (18.min(edad)).max(350)/50 )
	
	override method poderDeAtaque() = super()+ masaMuscular * 0.5 + self.resistencia()
	override method poderDeDefensa() = super() * nivelDeIra
	method practicarRitoSiginTarag() {
		nivelDeIra = 2.min(nivelDeIra + 0.1)
	}
	override method reducirEnergia (unValor){
		energiaVital = 0.max(energiaVital - unValor)
		if (energiaVital==0) estaVivo = false
	}

}

class Orco inherits Elfo {
	override method poderDeDefensa() = self.poderDeAtaque()
	override method desarrollarPoderMagico(){
			if (energiaVital > 60)energiaVital--
	} 

	method raza () = orco
	override method reducirEnergia (unValor){
		energiaVital = 0.max(energiaVital - unValor)
		if (energiaVital==0) estaVivo = false
	}
}

class Istar inherits Humanoide {

	var masaMuscular = 30.randomUpTo(71).truncate(0)
	var destrezaConLaEspada = 10.randomUpTo(20).truncate(0)
	var energiaVital = chispaVital + 80.randomUpTo(120).truncate(0)
	var property color
	
	method masaMuscular()= masaMuscular
	method raza () = istar
	method poderMagico ()= color.poderMagico()

	method evolucionar(){return
		if (color == pardo) color = azul
		else if (color == azul) color = gris
		else if (color == gris) color = blanco
		else color = blanco
	}
	
	override method resistencia() = energiaVital
	override method reducirEnergia (unValor){
		energiaVital = 0.max(energiaVital - unValor)
		if (energiaVital==0) estaVivo = false
	}
	override method poderDeAtaque () = super () + destrezaConLaEspada + self.resistencia() + self.poderMagico()
	
}

object sauron inherits Humanoide {
	var energiaVital = 1300

	method masaMuscular()= 0
	override method resistencia () = energiaVital
	override method poderDeAtaque() = super() + self.resistencia ()
	override method reducirEnergia (unValor){
		energiaVital = 0.max(energiaVital - unValor)
		if (energiaVital==0) estaVivo = false
	}
	override method raza() =  self
}

class Hobbit inherits Humanoide {
	var edad
	var energiaVital = chispaVital + 50.randomUpTo(90).truncate(0)
	const masaMuscular = 20.randomUpTo(30).truncate(0)
	var nivelDeAgilidad = (1.1).randomUpTo(1.8).truncate(2)
	
	method masaMuscular()= masaMuscular
	override method raza()= hobbit
	method energiaVital()= energiaVital
	
	override method resistencia () = energiaVital * (nivelDeAgilidad + 20.max(200.min(edad))/50)
	override method poderDeAtaque() = super()+ masaMuscular /2 + self.resistencia()
	override method poderDeDefensa() = super() * nivelDeAgilidad
	
	override method reducirEnergia(valorARestar){
		energiaVital = 0.max(energiaVital-valorARestar)
		if (energiaVital ==0) estaVivo = false
	}
	
	method entrenarAgilidad(){
		nivelDeAgilidad = 2.min(nivelDeAgilidad + 0.1)
	}
}



// Estas son algunas de las razas, completar lo que falte:

object humano {method raza() = self}
object elfo {method raza() = self}
object enano {method raza() = self}
object orco {method raza() = self}
object istar {method raza() = self}
object hobbit {method raza() = self}


object blanco{method poderMagico () = 60}
object gris{method poderMagico () = 40}
object azul{method poderMagico () = 30}
object pardo{method poderMagico () = 20}





