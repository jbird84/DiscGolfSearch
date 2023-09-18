//
//  DiscViewController.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 9/16/23.
//

import UIKit

class DiscViewController: UIViewController {

    @IBOutlet weak var discNameLabel: UILabel!
    @IBOutlet weak var discImageView: UIImageView!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var glideLabel: UILabel!
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var fadeLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var discView: UIView!
    
    var disc: DiscGolfDisc?
    let flightDiscImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let disc = disc {
            discNameLabel.text = disc.name
            speedLabel.text = disc.speed
            glideLabel.text = disc.glide
            turnLabel.text = disc.turn
            fadeLabel.text = disc.fade
            startRotation()
            setupFlightDiscImageView()
            companyNameLabel.text = "By: \(disc.brand)"
        }
    }
    
    private func setupFlightDiscImageView() {
        flightDiscImageView.image = UIImage(named: "blankDisc")
        discImageView.frame = CGRect(x: 0, y: -150, width: 50, height: 50) // Set the initial frame
        view.addSubview(flightDiscImageView)
        
        // Create the flight path
               let path = UIBezierPath()
               path.move(to: CGPoint(x: 50, y: 200)) // Start point
               path.addQuadCurve(to: CGPoint(x: 300, y: 200), controlPoint: CGPoint(x: 175, y: 0)) // Quad curve
               
               // Create the animation
               let animation = CAKeyframeAnimation(keyPath: "position")
               animation.path = path.cgPath
               animation.duration = 30.0 // Duration of the animation
               animation.timingFunction = CAMediaTimingFunction(name: .linear)
               animation.fillMode = .forwards
               animation.isRemovedOnCompletion = false
               
               // Add rotation animation
               let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
               rotationAnimation.fromValue = 0
               rotationAnimation.toValue = 2.0 * .pi
               rotationAnimation.duration = 5.0
               rotationAnimation.repeatCount = .infinity
               
               // Apply animations to the disc image view's layer
               flightDiscImageView.layer.add(animation, forKey: "flightPathAnimation")
               flightDiscImageView.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }

    private func startRotation() {
           // Create a CABasicAnimation for continuous rotation
           let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
           
           // Set the animation properties
           rotationAnimation.fromValue = 0.0
           rotationAnimation.toValue = CGFloat.pi * 2.0 // Full circle (360 degrees)
           rotationAnimation.duration = 50.0 // Duration of one full rotation in seconds
           rotationAnimation.repeatCount = .infinity // Repeat indefinitely
           
           // Add the animation to the image view's layer
           discView.layer.add(rotationAnimation, forKey: "rotationAnimation")
       }
   }

