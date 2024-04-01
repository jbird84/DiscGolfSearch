//
//  OverstableVC1.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 3/30/24.
//

import UIKit

class OverstableVC1: UIViewController {
    
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var spinningDiscImageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        infoLabel.layer.cornerRadius = 10
        infoLabel.layer.masksToBounds = true
        startRotation()
    }
    
    private func startRotation() {
        // Create a CABasicAnimation for continuous rotation
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        
        // Set the animation properties
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = CGFloat.pi * 2.0 // Full circle (360 degrees)
        rotationAnimation.duration = 1.0 // Duration of one full rotation in seconds
        rotationAnimation.repeatCount = .infinity // Repeat indefinitely
        
        // Add the animation to the image view's layer
        spinningDiscImageView.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
}
