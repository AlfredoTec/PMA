//
//  ProductModel.swift
//  CalcularIgv
//
//  Created by Luis Marca on 4/05/26.
//

import UIKit

class ProductModel: NSObject {
    var Nombre: String = ""
    var Precio: Double = 0.0
    var Cantidad: Int = 0
    var Meses: Int = 0
    var Interes: Double = 0.0
    
    init(Nombre: String, Precio: Double, Cantidad: Int, Meses: Int, Interes: Double) {
        self.Nombre = Nombre
        self.Precio = Precio
        self.Cantidad = Cantidad
        self.Meses = Meses
        self.Interes = Interes
    }
}
