//
//  DiscInBagInfoViewController.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 2/22/24.
//

import UIKit

class DiscInBagInfoViewController: UIViewController {

    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var discLabel: UILabel!
    @IBOutlet weak var plasticLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var glideLabel: UILabel!
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var fadeLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    var disc: DiscDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let disc = disc {
            companyLabel.text = disc.brand
            discLabel.text = disc.name
            plasticLabel.text = disc.plastic ?? "NA"
            weightLabel.text = disc.weight ?? "NA"
            speedLabel.text = disc.speed
            glideLabel.text = disc.glide
            turnLabel.text = disc.turn
            fadeLabel.text = disc.fade
            typeLabel.text = disc.stability 
        }
    }
}
