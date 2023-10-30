import conocimientos.*
import cumbre.*

class Participante {
	const property nacionalidad
	const property conocimientos = #{}
	const property actividadesRealizadas = []
	var commits 
	
	method esCape()
	
	
	method tieneConocimientos(unConocimiento) = conocimientos.contains(unConocimiento)
	method cumpleRequisitos() = self.tieneConocimientos(programacionBasica)
	
	method incorporarConocimiento(unConocimiento){
		conocimientos.add(unConocimiento)
	}
	
	method registrarActividad(unaActividad) {
		actividadesRealizadas.add(unaActividad)
	}	
	
	method hacerActividad(unaActividad) {
		self.incorporarConocimiento(unaActividad.tema())
		commits += unaActividad.tema().commitsPorHora() * unaActividad.horas()
		self.registrarActividad(unaActividad)
	}
	
}


class Programador inherits Participante {
	var horasDeCapacitacion = 0
	
	override method esCape() = commits >= 500
	
	override method cumpleRequisitos() = 
		super() and commits > cumbre.cantidadMinimaDeCommits()
	
	override method hacerActividad(unaActividad) {
		super(unaActividad)
		horasDeCapacitacion += unaActividad.horas()
	}
}

class Especialista inherits Participante {
	
	method cantidadDeConocimientos() = conocimientos.size()
	override method esCape() = self.cantidadDeConocimientos() > 2
	
	override method cumpleRequisitos() = 
		super() and commits > (cumbre.cantidadMinimaDeCommits() - 100) and self.tieneConocimientos(objetos)
}


class Gerente inherits Participante {
	var empresa
	
	
	method empresa() = empresa
	override method esCape() = empresa.esMultinacional()
	
	override method cumpleRequisitos() = 
		super() and self.tieneConocimientos(manejoDeGrupos)
}










