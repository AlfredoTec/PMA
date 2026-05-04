//
//  ViewController.swift
//  PasarDatosEntrePantallas
//
//  Created by Luis Marca on 3/05/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tfNombre: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func btnContinuar(_ sender: Any) {}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            
            let destino = segue.destination as! ConfirmationViewController
            
            let oCliente: ClienteModel = ClienteModel(nombre: self.tfNombre.text!)
            
            destino.pCliente = oCliente
        }
    }
    
}

