//
//  SecondViewController.swift
//  Lab06
//
//  Created by Tecsup on 20/04/26.
//

import UIKit

class SecondViewController: UIViewController {
    var receivedMessage: String = ""
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Second Screen"
        messageLabel.text = receivedMessage
        }

    
    
}
