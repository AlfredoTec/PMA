class Mascota{
    var nombre: String
    var edad: Int
    var tipo: String
    
    init(nombre: String, edad: Int, tipo: String) {
        self.nombre = nombre
        self.edad = edad
        self.tipo = tipo
    }
    
    func obtenerDescripcion() -> String{
        return "Soy un \(tipo) llamado \(nombre) y tengo \(edad) años"
    }
    
    func asignarEdad(nueva_edad: Int){
        print("Me estan asignando una nueva edad: \(nueva_edad)")
        self.edad = nueva_edad
    }
}

let miMascota = Mascota(nombre: "Coco", edad: 2, tipo: "Gato")
print(miMascota.obtenerDescripcion())
miMascota.asignarEdad(nueva_edad: 5)
print(miMascota.obtenerDescripcion())
