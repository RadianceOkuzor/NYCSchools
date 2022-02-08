//
//  SchoolNameTableViewCell.swift
//  20220127-RadianceOkuzor-NYCSchools
//
//  Created by Radiance Okuzor on 1/27/22.
//

import UIKit

class SchoolNameTableViewCell: UITableViewCell {

    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var cellNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        schoolNameLabel.titleLable()
        schoolNameLabel.adjustsFontForContentSizeCategory = true
        cellNumber.smallLable()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

