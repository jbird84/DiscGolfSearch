//
//  ImageHeaderSubheaderView.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 3/3/24.
//

import UIKit


class ImageHeaderSubheaderView: UIView {
    
    // MARK: - Properties
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.tintColor = .white
        return imageView
    }()
    
    private let headerLabel: UILabel = {
        let headerLabel = UILabel()
        headerLabel.font = UIFont.boldSystemFont(ofSize: 16)
        headerLabel.textColor = .white
        return headerLabel
    }()
    
    private let subheaderLabel: UILabel = {
        let subheaderLabel = UILabel()
        subheaderLabel.font = UIFont.systemFont(ofSize: 14)
        subheaderLabel.textColor = .white
        return subheaderLabel
    }()
    
    // MARK: - Initialization
    
    //initWithFrame to init view from code
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    //initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        
    }
    
    //common func to init our view
    private func setupView() {
        //add the three subviews
        addSubview(imageView)
        addSubview(headerLabel)
        addSubview(subheaderLabel)
        
        // Set background color and corner radius
        backgroundColor = UIColor(hex: "#1a1b1d")
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Calculate sizes and positions
        let imageSize = CGSize(width: bounds.height * 0.8, height: bounds.height * 0.8)
        let labelWidth = bounds.width - imageSize.width - 20 // Adjust the 20 as per your preference
        
        imageView.frame = CGRect(origin: CGPoint(x: 10, y: (bounds.height - imageSize.height) / 2),
                                 size: imageSize)
        
        headerLabel.frame = CGRect(x: imageView.frame.maxX + 10,
                                   y: imageView.frame.minY + 10,
                                   width: labelWidth,
                                   height: 18)
        
        subheaderLabel.frame = CGRect(x: headerLabel.frame.origin.x,
                                      y: headerLabel.frame.maxY + 3,
                                      width: labelWidth,
                                      height: 15)
    }
    
    // MARK: - Public methods
    
    func configure(image: UIImage?, headerText: String, subheaderText: String) {
        imageView.image = image
        headerLabel.text = headerText
        subheaderLabel.text = subheaderText
    }
}
