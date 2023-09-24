//
//  DiscTypesView.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 9/22/23.
//

import UIKit

class DiscTypesView: UIView {

    @IBOutlet weak var overstableDiscImageView: UIImageView!
    @IBOutlet weak var veryOverstableDiscImageView: UIImageView!
    @IBOutlet weak var stableDiscImageView: UIImageView!
    @IBOutlet weak var understableDiscImageView: UIImageView!
    @IBOutlet weak var veryUnderstableDiscImageView: UIImageView!
    
    
    override func awakeFromNib() {
           super.awakeFromNib()
        // setup disc images
        overstableDiscImageView.image = UIImage(named: "blankDisc")?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        veryOverstableDiscImageView.image = UIImage(named: "blankDisc")?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
        stableDiscImageView.image = UIImage(named: "blankDisc")?.withTintColor(.systemOrange, renderingMode: .alwaysOriginal)
        understableDiscImageView.image = UIImage(named: "blankDisc")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
        veryUnderstableDiscImageView.image = UIImage(named: "blankDisc")?.withTintColor(.systemTeal, renderingMode: .alwaysOriginal)
    }
}
