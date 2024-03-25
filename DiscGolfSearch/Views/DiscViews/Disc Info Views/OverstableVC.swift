//
//  StabilityViewController.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 10/1/23.
//

import UIKit

class OverstableVC: UIViewController {

    
    @IBOutlet weak var discView: UIView!
    @IBOutlet weak var discImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
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

extension OverstableVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        
        // Define the threshold where you want to change the appearance
        let threshold: CGFloat = 50
        
        if offset > threshold {
            // Set navigation bar background color to orange
            navigationController?.navigationBar.barTintColor = .systemGreen
            // Show navigation bar title
            navigationItem.title = "OVERSTABLE"
        } else {
            // Revert navigation bar to its original appearance
            navigationController?.navigationBar.barTintColor = .clear
            // Hide navigation bar title
            navigationItem.title = nil
        }
    }
}
