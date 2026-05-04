//
//  ViewController.swift
//  CalcularIgv
//
//  Created by Luis Marca on 4/05/26.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var tfProducto: UITextField!
    @IBOutlet weak var tfPrecio: UITextField!
    @IBOutlet weak var tfCantidad: UITextField!
    @IBOutlet weak var tfMeses: UITextField!
    @IBOutlet weak var tfInteres: UITextField!
    
    @IBAction func btnCalcular(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCalculate" {
            let destino = segue.destination as! CalculateViewController
            
            let oProducto: ProductModel = ProductModel(
                Nombre: self.tfProducto.text ?? "",
                Precio: Double(tfPrecio.text ?? "0") ?? 0,
                Cantidad: Int(tfCantidad.text ?? "0") ?? 0,
                Meses: Int(tfMeses.text ?? "0") ?? 0,
                Interes: Double(tfInteres.text ?? "0") ?? 0
            )
            
            destino.producto = oProducto
        }
    }


}

