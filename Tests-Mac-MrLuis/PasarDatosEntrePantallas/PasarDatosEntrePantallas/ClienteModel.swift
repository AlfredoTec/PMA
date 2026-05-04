//
//  ClienteModel.swift
//  PasarDatosEntrePantallas
//
//  Created by Luis Marca on 3/05/26.
//

import UIKit

class ClienteModel: NSObject {
    var nombre: String = ""
    
    override init() {
        
    }
    
    init(nombre: String) {
        self.nombre = nombre
    }
}
