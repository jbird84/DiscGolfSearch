//
//  OverstableVC2.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 3/30/24.
//

import UIKit

class OverstableVC2: UIViewController {
    
    @IBOutlet weak var textLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        textLabel.layer.cornerRadius = 10
        textLabel.layer.masksToBounds = true
    }
}
