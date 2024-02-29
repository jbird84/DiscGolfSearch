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
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var typeLabel: UILabel!
    
    var disc: DiscDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let disc = disc {
            companyLabel.text = disc.brand
            discLabel.text = disc.name
            plasticLabel.text = disc.plastic ?? "NA"
            weightLabel.text = disc.weight ?? "NA"
            typeLabel.text = disc.stability
            
            // Create bars for speed, glide, turn, and fade
            addBar(title: "Speed", value: disc.speed)
            addBar(title: "Glide", value: disc.glide)
            addBar(title: "Turn", value: disc.turn)
            addBar(title: "Fade", value: disc.fade)
        }
    }
    
    private func addBar(title: String, value: String) {
        let barView = UIView()
        let barHeight: CGFloat = 20 // Adjust this as needed
        let barWidth = CGFloat((value as NSString).floatValue) * 20 // You can adjust the multiplier to control the bar length
        barView.backgroundColor = UIColor.blue // Change color as needed
        barView.translatesAutoresizingMaskIntoConstraints = false
        barView.heightAnchor.constraint(equalToConstant: barHeight).isActive = true
        barView.widthAnchor.constraint(equalToConstant: barWidth).isActive = true
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.textAlignment = .center
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let stack = UIStackView(arrangedSubviews: [barView, valueLabel, titleLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 5 // Adjust spacing between components
        
        stackView.addArrangedSubview(stack)
    }
    
}
