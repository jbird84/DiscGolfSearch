//
//  DiscInBagCell.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 12/25/23.
//

import UIKit

class DiscInBagCell: UITableViewCell {

    @IBOutlet weak var discImageColorImageView: UIImageView!
    @IBOutlet weak var discNameLabel: UILabel!
    @IBOutlet weak var usedForLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
