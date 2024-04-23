//
//  InfoViewController.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 4/23/24.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var windGuideView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
setupView()
        // Do any additional setup after loading the view.
    }
    
    private func setupView() {
        //Setup wind-guide view
        windGuideView.layer.cornerRadius = 10
        windGuideView.layer.shadowColor = UIColor.white.cgColor
        windGuideView.layer.shadowOpacity = 0.5
        windGuideView.layer.shadowOffset = CGSize(width: 0, height: 2) 
        windGuideView.layer.shadowRadius = 4
        windGuideView.layer.masksToBounds = false
        windGuideView.layer.shadowPath = UIBezierPath(roundedRect: windGuideView.bounds, cornerRadius: windGuideView.layer.cornerRadius).cgPath
        windGuideView.layer.borderColor = UIColor.gray.cgColor
        windGuideView.layer.borderWidth = 1
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(windGuideViewTapped))
        windGuideView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func windGuideViewTapped() {
        let storyboard = UIStoryboard(name: "Info", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "windGuideVC")
        navigationController?.present(vc, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
