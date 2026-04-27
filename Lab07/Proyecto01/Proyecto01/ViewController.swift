//
//  ViewController.swift
//  Proyecto01
//
//  Created by Tecsup on 27/04/26.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var listaProfesores = [
        Profesor(nombre: "Jaime Gomez", cargo: "Coordinador de Software", foto: UIImage(named: "Profesor1")),
        Profesor(nombre: "Jaime Farfan", cargo: "Docente de Software TC", foto: UIImage(named: "Profesor2")),
        Profesor(nombre: "Juan León", cargo: "Docente de Software TC", foto: UIImage(named: "Profesor3")),
        Profesor(nombre: "Silvia Montoya", cargo: "Docente de Software TC", foto: UIImage(named: "Profesora1")),
        Profesor(nombre: "Theobaldo Diaz", cargo: "Docente de Software TC", foto: UIImage(named: "Profesor4")),
        Profesor(nombre: "Elliot Garamendi", cargo: "Docente de Software TC", foto: UIImage(named: "Profesor5")),
        Profesor(nombre: "Edwin Huerto", cargo: "Docente de Redes TC", foto: UIImage(named: "Profesor6"))
    ]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listaProfesores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda")!
        cell.textLabel?.text = listaProfesores[indexPath.row].nombre
        cell.detailTextLabel?.text = String(listaProfesores[indexPath.row].cargo)
        cell.imageView?.image = listaProfesores[indexPath.row].foto!
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

