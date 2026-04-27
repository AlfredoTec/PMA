import UIKit

class CultureModel {
    var name: String = ""
    var image: UIImage?
    var description: String = ""
    
    init(name: String, image: UIImage?, description: String) {
        self.name = name
        self.image = image
        self.description = description
    }
    
    init() {}
}
