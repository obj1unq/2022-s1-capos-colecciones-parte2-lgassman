object espada{
	var utilizada = false
	
	method poder(usuario) {
		return usuario.poderBase() * if(utilizada) {0.5} else {1}
	}
	
	method usar() {
		utilizada = true
	}	
}

object collar {
	var cantidadDeUsos = 0
	method poder(usuario) {
		return 3 + if(usuario.poderBase() > 6) cantidadDeUsos else 0 
	}
	method usar() {
		cantidadDeUsos = cantidadDeUsos + 1
	}
}

object armadura {
	method poder(usuario) {
		return 6
	}
	method usar() {
		
	}
}

object bendicion {
	method poder(usuario) {
		return 4
	}
}

object invisibilidad {
	method poder(usuario) {
		return usuario.poderBase()
	}
}

object invocacion {
	method poder(usuario) {
		const elMasPoderoso = usuario.artefactoMasPoderosoInvocable()
		return elMasPoderoso.poder(usuario)
	}
}

object libro {
	var property hechizos = []
	
	method poder(usuario) {
		return if (!hechizos.isEmpty()) hechizos.first().poder(usuario) else 0	
	}
	
	method usar() {
		hechizos.remove(hechizos.first())
		//hechizos = hechizos.drop(1)
	}
}

object castillo {
	
	const property artefactos = #{}
		
	method agregarArtefactos(_artefactos) {
		artefactos.addAll(_artefactos)		
	}
	
	method artefactoMasPoderoso(usuario) {
		return artefactos.max({artefacto => artefacto.poder(usuario)})
	}
	
}


object rolando {

	const property artefactos = #{}
	var property capacidad = 2
	const casa = castillo
	const property historia = []
	var property poderBase = 5
	
	method poder() {
		return poderBase + artefactos.sum({artefacto => artefacto.poder(self)})
	}
	
	method batalla() {
		poderBase = poderBase + 1
		artefactos.forEach({artefacto => artefacto.usar()})
	}

	method artefactoMasPoderosoInvocable() {
		return casa.artefactoMasPoderoso(self)
	}

	method encontrar(artefacto) {
		if(artefactos.size() < capacidad) {
			artefactos.add(artefacto)
		}
		historia.add(artefacto)
	}
	
	method volverACasa() {
		casa.agregarArtefactos(artefactos)
		artefactos.clear()
	}	
	
	method posesiones() {
		return self.artefactos() + casa.artefactos()
	}
	
	method posee(artefacto) {
		return self.posesiones().contains(artefacto)	
	}
	
	method puedeVencer(enemigo) {
		return self.poder() > enemigo.poder()
	}
	
	method tieneArmaFatal(enemigo) {
		return artefactos.any({ artefacto => self.esFatal(artefacto, enemigo) })
	}
	
	method esFatal(artefacto, enemigo) {
		return artefacto.poder(self) > enemigo.poder()
	}
	
	method armaFatal(enemigo) {
		return artefactos.find({ artefacto => self.esFatal(artefacto, enemigo)})
	}
	
		
}


object palacio {}
object fortaleza{}
object torre{}

object archibaldo {
	method poder()  = 16
	method morada() = palacio
}
object caterina {
    method poder() = 28
    method morada() = fortaleza
}

object astra {
	method poder() = 14
	method morada() = torre
}

object eretia {
	var property enemigos = #{archibaldo, caterina, astra} 
	
	method enemigosVencibles(capo) {
		return enemigos.filter({ enemigo => capo.puedeVencer(enemigo) })
	}
	
	method moradasConquistables(capo) {
		return self.enemigosVencibles(capo).map({enemigo => enemigo.morada() }).asSet()
	}
	
	method poderoso(capo) {
		return enemigos.all({enemigo => capo.puedeVencer(enemigo)})
	}
	
}



