// ARREGLOS

let CALIFICACIONES: [Int] = [85, 90, 78, 92, 88]
var suma: Int = 0

for calificacion in CALIFICACIONES {
    suma += calificacion
}

let promedio: Double = Double(suma) / Double(CALIFICACIONES.count)
print("El promedio del estudiante es: \(promedio)")

var estudiantes: [String] = ["Jaime", "Juan", "Elena", "David", "Sofia"]
var calificaciones: [Double] = []

calificaciones.append(8.5)
calificaciones.append(13.0)
calificaciones.append(16.5)
calificaciones.append(13.5)
calificaciones.append(9.0)

// SET

let FUTBOL: Set = ["Ana", "Luis", "Carlos", "Lucia"]
let BASQUETBOL: Set = ["Carlos", "Lucia", "Pedro", "Maria"]

let ESTUDIANTES_UNICOS = FUTBOL.union(BASQUETBOL)
print("Numero de estudiantes unicos en actividades: \(ESTUDIANTES_UNICOS.count)")

// DICCIONARIO

var inventario = [
    "Cien anios de soledad": 3,
    "Don Quijote": 5,
    "La casa de los espiritus": 2
]

let LIBRO_BUSCADO = "Don Quijote"

if let CANTIDAD = inventario[LIBRO_BUSCADO] {
    print("Hay \(CANTIDAD) copias de '\(LIBRO_BUSCADO)' disponibles")
} else {
    print("El libro ¿\(LIBRO_BUSCADO)' no esta disponible")
}
