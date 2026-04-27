import UIKit

class CulturalDescriptionViewController: UIViewController {

    var pCulture: CultureModel = CultureModel()
    
    @IBOutlet weak var tfName: UILabel!
    @IBOutlet weak var tfImage: UIImageView!
    @IBOutlet weak var tfDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tfName.text = pCulture.name
        self.tfImage.image = pCulture.image
        self.tfDescription.text = pCulture.description
        self.tfDescription.numberOfLines = 0 // Para que el texto se ajuste
    }
}
