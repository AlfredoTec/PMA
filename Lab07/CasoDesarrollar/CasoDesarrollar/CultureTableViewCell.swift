//
//  CultureTableViewCell.swift
//  CasoDesarrollar
//
//  Created by Tecsup on 27/04/26.
//

import UIKit

class CultureTableViewCell: UITableViewCell {

    @IBOutlet weak var CulturalImage: UIImageView!
    @IBOutlet weak var CulturalName: UILabel!
    
    @IBOutlet weak var descriptionButton: UIButton!
    
    var buttonAction: (() -> Void)? // Esta es la propiedad que te falta
    
    @IBAction func descriptionButtonTapped(_ sender: Any) {
        buttonAction?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
