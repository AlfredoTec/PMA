//
//  ConfirmationViewController.swift
//  PasarDatosEntrePantallas
//
//  Created by Luis Marca on 3/05/26.
//

import UIKit

class ConfirmationViewController: UIViewController {

    var pCliente = ClienteModel()
    
    
    @IBOutlet weak var tfNombre: UILabel!
    
    
    @IBAction func btnVolver(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tfNombre.text = pCliente.nombre
    }

}
