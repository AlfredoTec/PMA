//
//  ViewController.swift
//  Actividad01Sem05
//
//  Created by Tecsup on 15/04/26.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var txtCapital: UITextField!
    @IBOutlet weak var txtTasa: UITextField!
    
    
    @IBOutlet weak var txtPlazo: UITextField!
    
    
    
    @IBOutlet weak var lblMontoTotal: UILabel!
    @IBOutlet weak var mensual: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
    }
    
    @IBAction func calcularPressed(_ sender: Any) {
        guard
                    let capitalStr = txtCapital.text, !capitalStr.isEmpty,
                    let tasaStr    = txtTasa.text,    !tasaStr.isEmpty,
                    let plazoStr   = txtPlazo.text,   !plazoStr.isEmpty,
                    let P          = Double(capitalStr),
                    let tasaAnual  = Double(tasaStr),
                    let años       = Double(plazoStr)
                else {
                    let alert = UIAlertController(title: "Error",
                                                  message: "Completa todos los campos.",
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    present(alert, animated: true)
                    return
                }

                let r = (tasaAnual / 100) / 12
                let n = años * 12
                let cuota = P * (r * pow(1+r, n)) / (pow(1+r, n) - 1)
                let total = cuota * n

                lblCuotaMensual.text = String(format: "Cuota Mensual: S/ %.2f", cuota)
                lblMontoTotal.text   = String(format: "Monto Total:   S/ %.2f", total)
            }

            override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
                view.endEditing(true)
            }
        }
    
        
    
    




