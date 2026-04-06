// Entidades

class Sede {
    let codigo: String
    let nombre: String
    let direccion: String
    var departamentos: [Departamento] = []
    
    init(codigo: String, nombre: String, direccion: String) {
        self.codigo = codigo
        self.nombre = nombre
        self.direccion = direccion
    }
}

class Departamento {
    let codigo: String
    var sede: Sede? = nil
    let nombre: String
    var jefe: Jefe
    
    init(codigo: String, nombre: String, jefe: Jefe) {
        self.codigo = codigo
        self.nombre = nombre
        self.jefe = jefe
    }
}

// Personas

class Persona {
    let codigo: String
    let dni: String
    let nombre: String
    let apellido_paterno: String
    let apellido_materno: String
    var direccion: String
    var phone: Int
    
    init(codigo: String, dni: String, nombre: String, apellido_paterno: String, apellido_materno: String, direccion: String, phone: Int) {
        self.codigo = codigo
        self.dni = dni
        self.nombre = nombre
        self.apellido_paterno = apellido_paterno
        self.apellido_materno = apellido_materno
        self.direccion = direccion
        self.phone = phone
    }
    
    func obtenerInformacion() -> String {
        return "Codigo: \(codigo), DNI: \(dni), Nombre: \(nombre), Apellidos: \(apellido_paterno) \(apellido_materno), Direccion: \(direccion), Telefono: \(phone)"
    }
}

class Estudiante: Persona {
    var colegios: String
    
    init(codigo: String, dni: String, nombre: String, apellido_paterno: String, apellido_materno: String, direccion: String, phone: Int, colegios: String) {
        self.colegios = colegios
        super.init(codigo: codigo, dni: dni, nombre: nombre, apellido_paterno: apellido_paterno, apellido_materno: apellido_materno, direccion: direccion, phone: phone)
    }
}

class Jefe: Persona {
    
    override init(codigo: String, dni: String, nombre: String, apellido_paterno: String, apellido_materno: String, direccion: String, phone: Int) {
        super.init(codigo: codigo, dni: dni, nombre: nombre, apellido_paterno: apellido_paterno, apellido_materno: apellido_materno, direccion: direccion, phone: phone)
    }
}

// Demostracion

// === PERSONAS ===

let personaVar = Persona(codigo: "123", dni: "09213512", nombre: "Diego", apellido_paterno: "Ccaihuari", apellido_materno: "Tintaya", direccion: "SJM", phone: 943564663)

print(personaVar.obtenerInformacion())

let estudianteVar = Estudiante(codigo: "124", dni: "87312012", nombre: "Leonardo", apellido_paterno: "Olortegui", apellido_materno: "Padilla", direccion: "Ñaña", phone: 921134754, colegios: "IE 1213")

print(estudianteVar.obtenerInformacion())

let jefeVar = Jefe(codigo: "875", dni: "70631303", nombre: "Alfredo", apellido_paterno: "Navarro", apellido_materno: "Tejeda", direccion: "Gloria Grande", phone: 943391168)

print(jefeVar.obtenerInformacion())

// === ENTIDADES ===

let departametoVar = Departamento(codigo: "1213", nombre: "TD", jefe: jefeVar)

let sedeVar = Sede(codigo: "125", nombre: "Santa Anita", direccion: "Cascanueces")

departametoVar.sede = sedeVar
sedeVar.departamentos.append(departametoVar)
