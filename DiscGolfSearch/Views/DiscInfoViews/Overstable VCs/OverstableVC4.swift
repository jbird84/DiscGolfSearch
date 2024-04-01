//
//  OverstableVC4.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 3/30/24.
//

import UIKit

class OverstableVC4: UIViewController {

    
    @IBOutlet weak var textLabel1: UILabel!
    @IBOutlet weak var textLabel2: UILabel!
    @IBOutlet weak var textLabel3: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textLabel1.layer.cornerRadius = 10
        textLabel2.layer.cornerRadius = 10
        textLabel3.layer.cornerRadius = 10
        textLabel1.layer.masksToBounds = true
        textLabel2.layer.masksToBounds = true
        textLabel3.layer.masksToBounds = true
    }
}
