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
    
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var glideLabel: UILabel!
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var fadeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with disc: DiscDataModel) {
            discImageColorImageView.tintColor = UIColor(hex: disc.selectedColor)
            discNameLabel.text = disc.name
            usedForLabel.text = disc.usedFor
            speedLabel.text = disc.speed
            glideLabel.text = disc.glide
            turnLabel.text = disc.turn
            fadeLabel.text = disc.fade
        }
}
