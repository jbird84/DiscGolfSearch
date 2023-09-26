//
//  SimilarDiscCell.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 9/24/23.
//

import Foundation
import UIKit


class SimilarDiscCell: UICollectionViewCell {
    static let reuseIdentifier = "BrandCell"
    
    // UILabel to display the brand name
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .systemPink
        return label
    }()
    
    override var isSelected: Bool {
         didSet {
             // Update the cell's background color based on the selection state
             if isSelected {
                 backgroundColor = .systemBlue // Change to the selected color you want
             } else {
                 backgroundColor = .clear // Change to the default/unselected color you want
             }
         }
     }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Add the titleLabel as a subview
        addSubview(titleLabel)
        
        // Configure constraints for the titleLabel
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        // Configure cell appearance
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
    }
    
    @objc func cellTapped() {
            // Toggle the selection state when the cell is tapped
            isSelected.toggle()
        }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
