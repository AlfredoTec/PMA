import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var cultures: [CultureModel] = []
      
      override func viewDidLoad() {
          super.viewDidLoad()
          tableView.delegate = self
          tableView.dataSource = self
          loadCultures()
      }
      
      func loadCultures() {
          let chavinDescription = "La cultura Chavín se desarrolló en los Andes centrales del Perú (Áncash) entre 1200 y 400 a.C. Fue conocida como la 'cultura matriz' del Perú antiguo por su gran influencia religiosa y artística. Su principal centro ceremonial fue Chavín de Huántar, un complejo arquitectónico con templos subterráneos y galerías. Su arte se caracteriza por representaciones de seres felínicos, serpientes y cóndores, siendo el Lanzón Monolítico su escultura más representativa."
          
          let nazcaDescription = "La cultura Nazca floreció en la costa sur del Perú (Ica) entre 100 a.C. y 800 d.C. Son mundialmente famosos por sus geoglifos, conocidos como las Líneas de Nazca, enormes figuras trazadas en el desierto que representan animales como el colibrí, el mono y la araña. También destacan por su cerámica policromada de alta calidad y sus avanzados sistemas de acueductos subterráneos llamados puquios, que aún funcionan hoy en día."
          
          cultures = [
              CultureModel(name: "Chavin", image: UIImage(named: "chavin"), description: chavinDescription),
              CultureModel(name: "Nazca", image: UIImage(named: "nazca"), description: nazcaDescription)
          ]
      }
      
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return cultures.count
      }
      
      func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 300
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "culturalCell", for: indexPath) as! CultureTableViewCell
          let culture = cultures[indexPath.row]
          cell.CulturalName.text = culture.name
          cell.CulturalImage.image = culture.image
          
          // Asignar el tag y el target al botón
          cell.descriptionButton.tag = indexPath.row
          cell.descriptionButton.addTarget(self, action: #selector(descriptionButtonPressed(_:)), for: .touchUpInside)
          
          return cell
      }
      
      @objc func descriptionButtonPressed(_ sender: UIButton) {
          let culture = cultures[sender.tag]
          performSegue(withIdentifier: "showDescription", sender: culture)
      }
      
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if segue.identifier == "showDescription" {
              if let destinationVC = segue.destination as? CulturalDescriptionViewController,
                 let culture = sender as? CultureModel {
                  destinationVC.pCulture = culture
                  print("✅ Enviando cultura: \(culture.name)")
              }
          }
      }
  }
