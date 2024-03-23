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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
