//
//  TeachersViewController.swift
//  PC2
//
//  Created by Tecsup on 4/05/26.
//

import UIKit

class TeachersViewController: UIViewController,
                              UITableViewDelegate, UITableViewDataSource{
    var TeacherList = [
        Teacher(Nombre: "Juan Leon", Curso: "Kotlin"),
        Teacher(Nombre: "Jaime Gomez", Curso: "Swift"),
        Teacher(Nombre: "Jaime Farfan", Curso: "AWS"),
        Teacher(Nombre: "Elliot Garamendi", Curso: "React"),
        Teacher(Nombre: "Silvia Montoya", Curso: "Oracle DB"),
        Teacher(Nombre: "Edwin Huerto", Curso: "Node.js"),
        Teacher(Nombre: "Luis Sigueñas", Curso: "ISE"),
        Teacher(Nombre: "Diego Ccaihuari", Curso: "CSS"),
    ]
    var personasImagenarreglo = [
        "avatar1",
        "avatar2",
        "avatar3",
        "avatar4",
        "avatar5",
        "avatar1",
        "avatar2",
        "avatar3"
    ]
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TeacherList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeacherCell")as?TeacherTableViewCell
        cell?.TeacherName.text = TeacherList[indexPath.row].Nombre
        cell?.TeacherCourse.text = TeacherList[indexPath.row].Curso
        cell?.TeacherImage.image = UIImage(named: "\(personasImagenarreglo[indexPath.row])")
        return cell!
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Teachers"

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
