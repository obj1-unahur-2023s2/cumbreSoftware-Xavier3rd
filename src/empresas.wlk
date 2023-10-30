import participantes.*


class Empresa {
	const property paises = #{}
	
	method cantidadDePaises() = paises.size()
	method esMultinacional() = self.cantidadDePaises() >= 3
}
