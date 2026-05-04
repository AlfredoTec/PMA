//
//  TeacherTableViewCell.swift
//  PC2
//
//  Created by Tecsup on 4/05/26.
//

import UIKit

class TeacherTableViewCell: UITableViewCell {

    @IBOutlet weak var TeacherName: UILabel!
    @IBOutlet weak var TeacherCourse: UILabel!
    @IBOutlet weak var TeacherImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
