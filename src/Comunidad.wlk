import Razas.*


object comunidadDelAnillo {
	const property miembros = #{}
	const property razas = #{hobbit, humano, enano, elfo, istar}
	const property miembrosDifuntos = #{}
	
	method agregarMiembros(unConjunto){
		if (miembros.size() + unConjunto.size() > 10)
			self.error ("No se puede superar los 10 miembros")
		miembros.addall (unConjunto)
	}
	
	method retirarMiembrosDifuntos(){
		miembros.forEach({
		m => self.trasladarMiembroDifunto(m)		
		})
	}
	
	method trasladarMiembroDifunto(unMiembro){
		if (!unMiembro.estaVivo()) {
			miembros.remove(unMiembro)
			miembrosDifuntos.add(unMiembro)
		}
	}
	
	method estaLista() = miembros.size() >= 8 and self.existenTodasLasRazas() // si tiene por lo menos 8 miembros y existen todas la razas
	//method existenTodasLasRazas() = razas.all({r=> self.miembrosSiTiene(r)}) // si todos las razas tienen un miembro en la comunidad.
	//method miembrosSiTiene(unaRaza) = miembros.any({m=>m.raza()== unaRaza}) //si alguno de los miembros es la raza por parametro
	method existenTodasLasRazas() = razas.difference (miembros.map({m=> m.raza()}).isEmpty())
	
	method poderDeAtaque()= miembros.sum ({m=>m.poderDeAtaque()})
	method poderDeDefensa()= miembros.sum ({m=>m.poderDeDefensa()})
	
	method atacarA (unPersonaje){
		if (self.estaLista() and unPersonaje.estaVivo())
			self.producirAtaque (unPersonaje)
		}	

	method producirAtaque (victima){	
		if (self.mayorPoderQue(victima)) // si el que ataque tiene mas poder que la victima
			victima.reducirEnergia(self.diferenciaDePoderes(victima)) //se reduce el poder de la victima
		else self.reducirEnergia(self.diferenciaDePoderes(victima)) //sino se reduce el poder de self
		
	}
	
	method mayorPoderQue (unPersonaje) = self.poderDeAtaque() > unPersonaje.poderDeDefensa() 
	method diferenciaDePoderes (unPersonaje) = self.poderDeAtaque() - unPersonaje.poderDeDefensa().abs()
	method reducirEnergia (unValor) {
		miembros.forEach({
			m => m.reducirEnergia(unValor/miembros.size())
			})
	}
	method cantidadDeMiembros()=miembros.size()
	method cantidadDeMiembrosDifuntos()=miembrosDifuntos.size()
	
	method miembrosConPoderDeDefensaMayorAlPromedio()= miembros.filter(
		{m => m.poderDeDefensa() > self.promedioDeDefensa()})
	
	method promedioDeDefensa()= self.poderDeDefensa() / self.cantidadDeMiembros() //ambos metodos ya los teniamos
	method todosConMasaMuscularMayorA(unValor) = miembros.all({m=> m.masaMuscular() > unValor})
	method miembroActivoEnLaComunidad(unMiembro) = miembros.contains (unMiembro)
	method vaPerdiendo () = self.cantidadDeMiembrosDifuntos() > self.cantidadDeMiembros() and sauron.estaVivo() 
	method miembroConMayorPoderDeAtaque ()= miembros.max({m => m.poderDeAtaque()})
	method maximoPoderDeDefensa()= miembros.max({m=>m.poderDeDefensa()}).poderDeDefensa()
	method algunMiembroConChispaMenorA(unValor) = miembros.any ({m => m.chispaVital() < unValor})
	method razaConMasMiembros () = self.razas().max({r=>self.cantidadDeMiembrosDeUnaRaza(r)})
	method razas () = miembros.map({m => m.raza()}).asSet()
	method cantidadDeMiembrosDeUnaRaza(unaRaza) = miembros.count({m=>m.raza()==unaRaza})
	method poderDeAtaqueCreciente() = 
	(1..self.cantidadDeMiembros()-1).all({
		indice => miembros.get(indice).poderDeAtaque() >= miembros.get(indice-1).poderDeAtaque()
	})

	 
}
