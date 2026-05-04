//
//  Teacher.swift
//  PC2
//
//  Created by Tecsup on 4/05/26.
//

import UIKit

class Teacher: NSObject {
    var Nombre: String = ""
    var Curso: String = ""
    
    init(Nombre: String, Curso: String) {
        self.Nombre = Nombre
        self.Curso = Curso
    }
    
    override init() {
        self.Nombre = ""
        self.Curso = ""
    }
}
