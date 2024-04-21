//
//  CartTableViewCell.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 11/6/23.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var discImageView: UIImageView!
    @IBOutlet weak var discNameLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var discStabilityLabel: UILabel!
    @IBOutlet weak var discSpeedLabel: UILabel!
    @IBOutlet weak var discGlideLabel: UILabel!
    @IBOutlet weak var discTurnLabel: UILabel!
    @IBOutlet weak var discFadeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
