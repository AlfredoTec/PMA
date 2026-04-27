//
//  ViewController.swift
//  Semana05m
//
//  Created by Tecsup on 15/04/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var TxtPeso: UITextField!
    
    @IBOutlet weak var TxtAltura: UITextField!
    
    
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    
    @IBAction func BtnMostar(_ sender: Any) {
        
            // Obtener los valores de peso y altura
            let weight = Double(TxtPeso.text ?? "") ?? 0
            let height = Double(TxtAltura.text ?? "") ?? 0

            // Verificar si los valores de entrada son válidos
            if weight == 0 || height == 0 {
                resultLabel.text = "Por favor, ingresa valores válidos."
                return
            }

            // Calcular el IMC (usamos la fórmula estándar)
            let bmi = weight / (height * height)

            // Determinar si el peso es adecuado según el IMC
            var status = ""
            if bmi < 18.5 {
                status = "Bajo peso"
            } else if bmi < 24.9 {
                status = "Peso normal"
            } else if bmi < 29.9 {
                status = "Sobrepeso"
            } else {
                status = "Obesidad"
            }

            // Mostrar el resultado
            resultLabel.text = "IMC: \(String(format: "%.2f", bmi)) - \(status)"
        }
        
    }


