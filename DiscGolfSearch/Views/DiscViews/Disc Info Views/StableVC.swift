//
//  StableVC.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 3/21/24.
//

import UIKit

class StableVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.delegate = self
    }
}

extension StableVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        
        // Define the threshold where you want to change the appearance
        let threshold: CGFloat = 50
        
        if offset > threshold {
            // Set navigation bar background color to orange
            navigationController?.navigationBar.barTintColor = .systemOrange
            // Show navigation bar title
            navigationItem.title = "STABLE"
        } else {
            // Revert navigation bar to its original appearance
            navigationController?.navigationBar.barTintColor = .clear
            // Hide navigation bar title
            navigationItem.title = nil
        }
    }
}


//This goes in storyboard for stable then delete here:
/*
 Stable Discs:

 Straight Shot: Stable discs are ideal for throwing straight shots, where you release the disc flat, and it maintains a relatively straight path throughout its flight.

 Tunnel Shot: Stable discs are great for navigating tight tunnel-like fairways, where you need precision and control to stay on the desired path. These shots require accuracy and minimal lateral movement.
 */
