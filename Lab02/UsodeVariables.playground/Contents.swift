/*
 === CASO 01 ===
 var capital: Float = 50000
 let TASA: Float = 0.2
 
 let INTERES = capital * TASA

 print("Interes generado: \(interes)")
 
 if interes > 7000 {
     capital += INTERES
     print("Los intereses fueron reinvertidos")
 } else {
     print("Los intereses no superan 7000, no se reinvierte")
 }

 print("Capital final: \(capital)")
 */

/*
 === CASO 02 ===
 
let PESO: Int = 70
let TIEMPO: Int = 180
let ACTIVIDAD: String = "REPOSO"
let CALORIAS: Float = ACTIVIDAD == "DORMIR" ? 1.08 : 1.66

if (ACTIVIDAD == "DORMIR" || ACTIVIDAD == "REPOSO"){
    if (TIEMPO < 1) {
        print("❌ Error: El tiempo debe ser un numero entero positivo")
    } else {
        var caloriasConsumidas = CALORIAS * Float(TIEMPO)
        print("✅ Actividad: \(ACTIVIDAD)")
        print(" ⏳Tiempo: \(TIEMPO) minutos")
        print("🔥 Calorías consumidas: \(caloriasConsumidas)")
    }
} else {
    print("❌ Error: Actividad invalida. Solo se permite 'DORMIR' o 'REPOSO'")
}
*/
 
/*
 === CASO 04 ===
let PRECIO_UNITARIO: Float = 50
let CANTIDAD: Int = 4
let DESCUENTO: Float = 0.1

var subtotal: Float = PRECIO_UNITARIO * Float(CANTIDAD)
var montoDescuento: Float = subtotal * Float(DESCUENTO)
var pagoTotal = subtotal - montoDescuento

print("Subtotal: S/\(subtotal)")
print("Monto del Descuento: S/\(montoDescuento)")
print("Pago Total: S/\(pagoTotal)")
*/
