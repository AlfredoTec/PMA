//
//  ViewController.swift
//  Lab06
//
//  Created by Tecsup on 20/04/26.
//

import UIKit

class FirstViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "First Screen"
    }
    @IBOutlet weak var messageTexField: UITextField!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let destinationVC = segue.destination as? SecondViewController {
                destinationVC.receivedMessage = messageTexField.text ?? ""
            }
        }
    }
}
