
import cumbre.*

class Pais {
	const property paisesEnConflicto = #{}
	
	method registrarConflicto(unPais) {
		paisesEnConflicto.add(unPais)
	}
	
	method estaEnConflictoCon(unPais) = paisesEnConflicto.contains(unPais)
	
	method esConflictivoParaLaCumbre() = cumbre.paisesAuspiciantes().any({p => self.estaEnConflictoCon(p)})
}
