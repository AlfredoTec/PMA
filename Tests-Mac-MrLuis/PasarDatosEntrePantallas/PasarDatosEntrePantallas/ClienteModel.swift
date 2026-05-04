//
//  ClienteModel.swift
//  PasarDatosEntrePantallas
//
//  Created by Luis Marca on 3/05/26.
//

import UIKit

class ClienteModel: NSObject {
    var Codigo: Int32 = 0
    var Apellido: String = ""
    var Nombre: String = ""
    var Dni: String = ""
    
    override init() {
        
    }
    
    init(Codigo: Int32, Apellido: String, Nombre: String, Dni: String) {
        self.Codigo = Codigo
        self.Apellido = Apellido
        self.Nombre = Nombre
        self.Dni = Dni
    }
}
