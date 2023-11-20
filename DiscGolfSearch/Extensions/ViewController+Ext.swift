//
//  ViewController+Ext.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 11/15/23.
//

import UIKit


extension UIViewController {
    
    func createDisclousureIndicatorView() -> UIImageView {
        var config = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 14))
        config = config.applying(UIImage.SymbolConfiguration(weight: .semibold))
        config = config.applying(UIImage.SymbolConfiguration(paletteColors: [.systemGray2]))
        let image = UIImage(systemName: "chevron.right", withConfiguration: config)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleToFill
        return imageView
    }
    
    func createCircleColorView(with color: UIColor) -> UIImageView {
        var config = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 14))
        config = config.applying(UIImage.SymbolConfiguration(weight: .semibold))
        //config = config.applying(UIImage.SymbolConfiguration(paletteColors: [.systemGray2]))
        let image = UIImage(systemName: "circle.fill", withConfiguration: config)?.withTintColor(color, renderingMode: .alwaysOriginal)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleToFill
        return imageView
    }
    
}
