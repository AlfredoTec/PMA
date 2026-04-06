import Foundation

class Producto {
    var nombre: String
    var precioUnitario: Double
    var cantidad: Int
    
    init(nombre: String, precioUnitario: Double, cantidad: Int) {
        self.nombre = nombre
        self.precioUnitario = precioUnitario
        self.cantidad = cantidad
    }
    
    func subtotal() -> Double {
        return precioUnitario * Double(cantidad)
    }
}

class Cliente {
    var nombre: String
    var ruc: String
    
    init(nombre: String, ruc: String) {
        self.nombre = nombre
        self.ruc = ruc
    }
}

class Factura {
    var cliente: Cliente
    var productos: [Producto]
    let igvRate: Double = 0.18
    
    init(cliente: Cliente, productos: [Producto]) {
        self.cliente = cliente
        self.productos = productos
    }
    
    func calcularSubtotal()-> Double {
        return productos.reduce(0){ $0 + $1.subtotal() }
    }
    
    func calcularIGV()-> Double {
        return calcularSubtotal() * igvRate
    }
    
    func calcularTotal()-> Double {
        return calcularSubtotal() + calcularIGV()
    }
    
    func imprimirFactura() {
        print("📄 FACTURA")
        print("Cliente: \(cliente.nombre)")
        print("RUC: \(cliente.ruc)")
        print("----------------------------------")
        
        for producto in productos {
            print("\(producto.nombre) x\(producto.cantidad) - S/ \(String(format: "%.2f", producto.subtotal()))")
        }
        
        print("----------------------------------")
        print("Subtotal: S/ \(String(format: "%.2f", calcularSubtotal()))")
        print("IGV (18%): S/ \(String(format: "%.2f", calcularIGV()))")
        print("TOTAL: S/ \(String(format: "%.2f", calcularTotal()))")
    }
}

// Simulacion

let cliente = Cliente(nombre: "Tecsup", ruc: "20111222333")
let p1 = Producto(nombre: "Monitor", precioUnitario: 750.0, cantidad: 2)
let p2 = Producto(nombre: "Teclado", precioUnitario: 150.0, cantidad: 1)

let factura = Factura(cliente: cliente, productos: [p1, p2])
factura.imprimirFactura()
