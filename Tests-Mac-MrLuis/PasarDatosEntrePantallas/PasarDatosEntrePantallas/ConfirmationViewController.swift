//
//  ConfirmationViewController.swift
//  PasarDatosEntrePantallas
//
//  Created by Luis Marca on 3/05/26.
//

import UIKit

class ConfirmationViewController: UIViewController {

    // Los datos del ViewController (oCliente)
    // se dan como propiedades del pCliente
    var pCliente = ClienteModel()
    
    @IBOutlet weak var tfNombre: UILabel!
    @IBOutlet weak var tfApellido: UILabel!
    @IBOutlet weak var tfDni: UILabel!
    
    @IBAction func btnVolver(_ sender: Any) {
        // Para regresar a la pantalla de atras
        // sin usar segues
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Se define el contenido de los labels
        self.tfNombre.text = pCliente.Nombre
        self.tfApellido.text = pCliente.Apellido
        self.tfDni.text = pCliente.Dni
    }

}
