//
//  StabilityViewController.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 10/1/23.
//

import UIKit

class StabilityViewController: UIViewController {

    
    @IBOutlet weak var discView: UIView!
    
    @IBOutlet weak var discImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        discImageView.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }

}
