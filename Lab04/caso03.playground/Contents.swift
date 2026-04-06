class Persona {
    var nombre: String
    var edad: Int
    
    init(nombre: String, edad: Int) {
        self.nombre = nombre
        self.edad = edad
    }
    
    func presentarse() {
        print("👋 Hola, soy \(nombre) y tengo \(edad) años.")
    }
}

class Estudiante: Persona {
    var curso: String
    
    init(nombre: String, edad: Int, curso: String) {
        self.curso = curso
        super.init(nombre: nombre, edad: edad)
    }
    
    override func presentarse() {
        print("👨‍🎓 Soy la estudiante \(nombre), tengo \(edad) años y estudio \(curso).")
    }
}

class Profesor: Persona {
    var especialidad: String
    
    init(nombre: String, edad: Int, especialidad: String) {
        self.especialidad = especialidad
        super.init(nombre: nombre, edad: edad)
    }
    
    override func presentarse() {
        print("👨‍🏫 Soy el profesor \(nombre), tengo \(edad) años y enseño \(especialidad).")
    }
}

// Simulacion

let estudiante1 = Estudiante(nombre: "Ana", edad: 20, curso: "Matemáticas")
let profesor1 = Profesor(nombre: "Carlos", edad: 45, especialidad: "Matemáticas")

estudiante1.presentarse()
profesor1.presentarse()
