import participantes.*
import paises.*


object cumbre {
	
	const property paisesAuspiciantes = #{}
	const property participantes = #{}
	const property participantesRegistrados = #{}
	const property actividadesRealizadas = []
	var property cantidadMinimaDeCommits = 300
	
	method tieneRestringidoElAcceso(unParticipante)=
		unParticipante.nacionalidad().esConflictivoParaLaCumbre() or 
		self.cantidadDeParticipantesExtranjeros(unParticipante.nacionalidad()) > 2
	
	
	method registrarParticipantes(listaDeParticipantes) {
		participantesRegistrados.addAll(listaDeParticipantes)
	}
	
	method puedeIngresar(unParticipante)=
		!self.tieneRestringidoElAcceso(unParticipante) and unParticipante.cumpleRequisitos()
	
	
	method esSegura()= participantesRegistrados.all({p => self.puedeIngresar(p)})
	
	method registrarIngreso(unParticipante) {
		if (self.tieneRestringidoElAcceso(unParticipante) and
			!unParticipante.cumpleRequisitos()){
				self.error("El participante no puede entrar a la cumbre")
			}
		participantes.add(unParticipante)
		
	}
	
	method agregarPaisesAuspiciantes(listaDePaises) {
		paisesAuspiciantes.addAll(listaDePaises)
	}
	
	method agregarActividad(unaActividad) {
		actividadesRealizadas.add(unaActividad)
	}
	
	method totalDeHorasDeActividades() {
		actividadesRealizadas.sum({a => a.horas()})	
	}
	
	method paisesDeLosParticipantes()= participantes.map({p=> p.nacionalidad()}).asSet()
	method cantidadDeParticipantesDeUnPais(pais) = participantes.count({p=>p.nacionalidad() == pais})
	
	method paisConMasParticipantes() = self.paisesDeLosParticipantes().max({p=> self.cantidadDeParticipantesDeUnPais(p)})
	
	method coincideNacionalidad(unParticipante) = paisesAuspiciantes.contains(unParticipante.nacionalidad())
	
	method participantesExtranjeros() = participantes.filter({p =>!self.coincideNacionalidad(p)})
	
	method esRelevante() = participantes.all({p => p.esCape()})
	
	method cantidadDeParticipantesExtranjeros(unPais) = 
		self.participantesExtranjeros().count({p => p.nacionalidad() == unPais})
}
