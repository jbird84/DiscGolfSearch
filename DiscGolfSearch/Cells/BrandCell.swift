//
//  BrandCell.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 9/10/23.
//

import Foundation
import UIKit


class BrandCell: UICollectionViewCell {
    static let reuseIdentifier = "BrandCell"
    
    // UILabel to display the brand name
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    override var isSelected: Bool {
         didSet {
             // Update the cell's background color based on the selection state
             if isSelected {
                 backgroundColor = .systemBlue
             } else {
                 backgroundColor = .clear
             }
         }
     }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
    }
    
    @objc func cellTapped() {
            isSelected.toggle()
        }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
