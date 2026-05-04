//
//  ViewController.swift
//  PasarDatosEntrePantallas
//
//  Created by Luis Marca on 3/05/26.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var tfApellido: UITextField!
    @IBOutlet weak var tfNombre: UITextField!
    @IBOutlet weak var tfDni: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func btnContinuar(_ sender: Any) {}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Nombre de la linea que une la primera vista con la segunda
        if segue.identifier == "showDetail" {
            
            // A donde te va a redirigir
            let destino = segue.destination as! ConfirmationViewController
            
            let oCliente: ClienteModel = ClienteModel(Codigo: 0, Apellido: self.tfApellido.text!, Nombre: self.tfNombre.text!, Dni: self.tfDni.text!)
            
            // Aqui se pasan los datos introducidos
            // a la pantalla destinataria
            destino.pCliente = oCliente
        }
    }
    
}

