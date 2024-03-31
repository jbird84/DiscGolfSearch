//
//  UnderstableVC.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 3/24/24.
//

import UIKit

class UnderstableVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
    }
}

    extension UnderstableVC: UIScrollViewDelegate {
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offset = scrollView.contentOffset.y
            
            // Define the threshold where you want to change the appearance
            let threshold: CGFloat = 50
            
            if offset > threshold {
                // Set navigation bar background color to orange
                navigationController?.navigationBar.barTintColor = .systemRed
                // Show navigation bar title
                navigationItem.title = "UNDERSTABLE"
            } else {
                // Revert navigation bar to its original appearance
                navigationController?.navigationBar.barTintColor = .clear
                // Hide navigation bar title
                navigationItem.title = nil
            }
        }
    }

