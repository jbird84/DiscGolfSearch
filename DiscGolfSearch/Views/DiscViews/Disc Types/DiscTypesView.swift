//
//  DiscTypesView.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 9/22/23.
//

import UIKit
import SwiftUI

class DiscTypesView: UIView {

    @IBOutlet weak var overstableDiscImageView: UIImageView!
    @IBOutlet weak var veryOverstableDiscImageView: UIImageView!
    @IBOutlet weak var stableDiscImageView: UIImageView!
    @IBOutlet weak var understableDiscImageView: UIImageView!
    @IBOutlet weak var veryUnderstableDiscImageView: UIImageView!
    
    @IBOutlet weak var veryOverstableLabel: UILabel!
    @IBOutlet weak var overstableLabel: UILabel!
    @IBOutlet weak var stableLabel: UILabel!
    @IBOutlet weak var understableLabel: UILabel!
    @IBOutlet weak var veryUnderstableLabel: UILabel!
    
    weak var navigationController: UINavigationController?
    
    override func awakeFromNib() {
           super.awakeFromNib()
        // setup disc images
        overstableDiscImageView.image = UIImage(named: "blankDisc")?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        veryOverstableDiscImageView.image = UIImage(named: "blankDisc")?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
        stableDiscImageView.image = UIImage(named: "blankDisc")?.withTintColor(.systemOrange, renderingMode: .alwaysOriginal)
        understableDiscImageView.image = UIImage(named: "blankDisc")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
        veryUnderstableDiscImageView.image = UIImage(named: "blankDisc")?.withTintColor(.systemTeal, renderingMode: .alwaysOriginal)
    
        // Add tap gesture recognizers to labels
            addTapGesture(to: veryOverstableLabel)
            addTapGesture(to: overstableLabel)
            addTapGesture(to: stableLabel)
            addTapGesture(to: understableLabel)
            addTapGesture(to: veryUnderstableLabel)
        }
        
        private func addTapGesture(to label: UILabel) {
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped(_:)))
            label.isUserInteractionEnabled = true
            label.addGestureRecognizer(tapGesture)
        }
        
        @objc private func labelTapped(_ gesture: UITapGestureRecognizer) {
            guard let tappedLabel = gesture.view as? UILabel else { return }
            let stabilityStoryboard = UIStoryboard(name: "StabilityInfo", bundle: nil)
            
            if tappedLabel == overstableLabel || tappedLabel == veryOverstableLabel {
                if let vc = stabilityStoryboard.instantiateViewController(withIdentifier: "overstablePageViewController") as? OverstablePageViewController {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            } else if tappedLabel == stableLabel {
                let stableCarouselView = StableCarouselView() // Instantiate CarouselView
                self.navigationController?.pushViewController(UIHostingController(rootView: stableCarouselView), animated: true)
            } else if tappedLabel == understableLabel || tappedLabel == veryUnderstableLabel  {
                let understableCarouselView = UnderStableCarouselView() // Instantiate CarouselView
                self.navigationController?.pushViewController(UIHostingController(rootView: understableCarouselView), animated: true)
            }
            
            else {
                if let vc = stabilityStoryboard.instantiateViewController(withIdentifier: "overstablePageViewController") as? OverstablePageViewController {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
}
