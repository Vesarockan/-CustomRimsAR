//
//  RimCell.swift
//  CustomRimsAR
//
//  Created by Robert Vesa on 24.01.2022.
//

import UIKit

class RimCell: UITableViewCell {

    @IBOutlet weak var rimImage: UIImageView!
    @IBOutlet weak var rimName: UILabel!
    @IBOutlet weak var price: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
