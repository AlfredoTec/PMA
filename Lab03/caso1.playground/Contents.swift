let COUNTRIES: [String] = [
    "Argentina",
    "Bolivia",
    "Brazil",
    "Chile",
    "Colombia",
    "Ecuador",
    "Mexico",
    "Peru",
    "Paraguay",
    "Uruguay",
    "Venezuela"
]

var gdp: [Float] = [
    683.371,
    57.086,
    2256.910,
    347.174,
    438.121,
    130.529,
    1862.740,
    318.480,
    47.398,
    84.986,
    82.767
]

// 1.0 - Mostrar el GDP de Bolivia
print("\(COUNTRIES[1]): \(gdp[1]) billions")

// 2.1 - Actualizar el GDP de Peru al del 2026
gdp[7] = 326.608

// 2.2 - Muestra el cambio
print("\(COUNTRIES[7]): \(gdp[7]) billions")

// 2.3 - Actualizar el GDP de Peru al del 2025
gdp[7] = 318.480

// 3.0 - Promedio de GDP
let GDP_AVG: Float = gdp.reduce(0, +) / Float(gdp.count)
print("GDP average: \(GDP_AVG)")

// 4.0 - Analiza otra forma de calcular el promedio mediante el metodo - REDUCE
/*
 reduce(0, +) -> Suma todos los datos de un array
 gdp.count -> Retorna un Int de la cantidad de elementos de un array
 promedio = (la suma de todos los numeros) / (la cantidad de numeros)
 promedio = reduce(0, +) / Float(gdp.count)
*/

// 5.0 - Mostrar el mayor GDP
print(gdp.max()!)

// 6.0 - Filtrar los que tengan un GDP mayor a 300 billones
let GREATER_300B: [Float] = gdp.filter{ $0 > 300}

// 6.1 - Mostrarlo
for value in GREATER_300B {
    print(value)
}

// 7.0 - Ordenar y mostrar los paises por GDP
var orderedCountries = COUNTRIES
var orderedGdp = gdp

// Tuve que usar bubble sort, tambien se puede con zip() pero eso ya no es array
for i in 0..<orderedGdp.count {
    for j in 0..<orderedGdp.count - 1 {
        if orderedGdp[j] < orderedGdp[j + 1] {
            
            // Intercambiar GDP
            let tempGDP = orderedGdp[j]
            orderedGdp[j] = orderedGdp[j + 1]
            orderedGdp[j + 1] = tempGDP
            
            // Intercambiar países
            let tempPais = orderedGdp[j]
            orderedGdp[j] = orderedGdp[j + 1]
            orderedGdp[j + 1] = tempPais
        }
    }
}

for i in 0..<orderedCountries.count {
    print("\(orderedCountries[i]): \(orderedGdp[i])")
}
