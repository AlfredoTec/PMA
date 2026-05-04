//
//  CalculateViewController.swift
//  CalcularIgv
//
//  Created by Luis Marca on 4/05/26.
//

import UIKit

class CalculateViewController: UIViewController {
    var producto: ProductModel?
    
    @IBOutlet weak var tfProducto: UILabel!
    @IBOutlet weak var tfSubtotal: UILabel!
    @IBOutlet weak var tfIgv: UILabel!
    @IBOutlet weak var tfTotal: UILabel!
    @IBOutlet weak var tfInteres: UILabel!
    @IBOutlet weak var tfMontoFinal: UILabel!
    @IBOutlet weak var tfCuota: UILabel!
    
    @IBAction func tfVolver(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let p = producto else { return }
        
        let precio = p.Precio
        let cantidad = Double(p.Cantidad)
        let meses = Double(p.Meses)
        let interes = p.Interes / 100
        
        let subtotal = precio * cantidad
        let igv = subtotal * 0.18
        let total = subtotal + igv
        let interesTotal = total * interes * meses
        let montoFinal = total + interesTotal
        let cuota = meses > 0 ? montoFinal / meses : 0
        
        tfProducto.text = "\(p.Nombre)"
        tfSubtotal.text = "S/ \(subtotal)"
        tfIgv.text = "S/ \(igv)"
        tfTotal.text = "S/ \(total)"
        tfInteres.text = "S/ \(interesTotal)"
        tfMontoFinal.text = "S/ \(montoFinal)"
        tfCuota.text = "S/ \(cuota)"
        
    }
}
