//
//  InfoViewController.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 4/23/24.
//

import UIKit
import SwiftUI

class InfoViewController: UIViewController {

    @IBOutlet weak var windGuideView: UIView!
    @IBOutlet weak var overstableView: UIView!
    @IBOutlet weak var stableView: UIView!
    @IBOutlet weak var understableView: UIView!
    @IBOutlet weak var speedView: UIView!
    @IBOutlet weak var glideView: UIView!
    @IBOutlet weak var turnView: UIView!
    @IBOutlet weak var fadeView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
setupView()
        // Do any additional setup after loading the view.
    }
    
    private func setupView() {
        
        //Setup wind-guide view and its tap gesture:
        let windGuideTapGesture = UITapGestureRecognizer(target: self, action: #selector(windGuideViewTapped))
        setup(view: windGuideView, with: windGuideTapGesture)
        
        //Setup overstable view and its tap gesture:
        let overstableTapGesture = UITapGestureRecognizer(target: self, action: #selector(overstableViewTapped))
        setup(view: overstableView, with: overstableTapGesture)
        
        //Setup stable view and its tap gesture:
        let stableTapGesture = UITapGestureRecognizer(target: self, action: #selector(stableViewTapped))
        setup(view: stableView, with: stableTapGesture)
        
        //Setup understable view and its tap gesture:
        let understableTapGesture = UITapGestureRecognizer(target: self, action: #selector(understableViewTapped))
        setup(view: understableView, with: understableTapGesture)
        
        //Setup speed view and its tap gesture:
        let speedTapGesture = UITapGestureRecognizer(target: self, action: #selector(speedViewTapped))
        setup(view: speedView, with: speedTapGesture)
        
        //Setup glide view and its tap gesture:
        let glideTapGesture = UITapGestureRecognizer(target: self, action: #selector(glideViewTapped))
        setup(view: glideView, with: glideTapGesture)
        
        //Setup turn view and its tap gesture:
        let turnTapGesture = UITapGestureRecognizer(target: self, action: #selector(turnViewTapped))
        setup(view: turnView, with: turnTapGesture)
        
        //Setup fade view and its tap gesture:
        let fadeTapGesture = UITapGestureRecognizer(target: self, action: #selector(fadeViewTapped))
        setup(view: fadeView, with: fadeTapGesture)
        
        title = "Disc Reference Guide"
        // Set the navigation title attributes
        let navigationTitleAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 35)]

        // Set the attributes for the navigation bar title
        self.navigationController?.navigationBar.titleTextAttributes = navigationTitleAttributes
    }
    
    @objc private func windGuideViewTapped() {
        let storyboard = UIStoryboard(name: "Info", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "windGuideVC")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func overstableViewTapped() {
        let stabilityStoryboard = UIStoryboard(name: "StabilityInfo", bundle: nil)
        if let vc = stabilityStoryboard.instantiateViewController(withIdentifier: "overstablePageViewController") as? OverstablePageViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc private func stableViewTapped() {
        let stableCarouselView = StableCarouselView() // Instantiate CarouselView
        self.navigationController?.pushViewController(UIHostingController(rootView: stableCarouselView), animated: true)
    }
    
    @objc private func understableViewTapped() {
        let understableCarouselView = UnderStableCarouselView() // Instantiate CarouselView
        self.navigationController?.pushViewController(UIHostingController(rootView: understableCarouselView), animated: true)
    }
    
    @objc private func speedViewTapped() {
        navigateToFlightNumberViewController(with: 1)
    }
    
    @objc private func glideViewTapped() {
        navigateToFlightNumberViewController(with: 2)
    }
    
    @objc private func turnViewTapped() {
        navigateToFlightNumberViewController(with: 3)
    }
    
    @objc private func fadeViewTapped() {
        navigateToFlightNumberViewController(with: 4)
    }
   
    private func setup(view: UIView, with tapGesture: UITapGestureRecognizer) {
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.white.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.layer.masksToBounds = false
        view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: view.layer.cornerRadius).cgPath
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1
        view.addGestureRecognizer(tapGesture)
    }
    
    private func navigateToFlightNumberViewController(with flightDigit: Int) {
        let storyboard = UIStoryboard(name: "FlightNumber", bundle: nil)
        if let flightNumberVC = storyboard.instantiateViewController(withIdentifier: "flight") as? FlightNumbersViewController {
            flightNumberVC.flightDigit = flightDigit
            navigationController?.pushViewController(flightNumberVC, animated: true)
        }
    }
}
    
