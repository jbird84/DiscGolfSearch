//
//  InfoViewController.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 4/23/24.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var windGuideView: UIView!
    @IBOutlet weak var overstableView: UIView!
    @IBOutlet weak var stableView: UIView!
    @IBOutlet weak var understableView: UIView!
    
    
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
    }
    
    @objc private func windGuideViewTapped() {
        let storyboard = UIStoryboard(name: "Info", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "windGuideVC")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func overstableViewTapped() {
        let storyboard = UIStoryboard(name: "Info", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "windGuideVC")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func stableViewTapped() {
        let storyboard = UIStoryboard(name: "Info", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "windGuideVC")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func understableViewTapped() {
        let storyboard = UIStoryboard(name: "Info", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "windGuideVC")
        navigationController?.pushViewController(vc, animated: true)
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

}
