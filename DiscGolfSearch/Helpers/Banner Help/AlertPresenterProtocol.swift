//
//  AlertPresenterProtocol.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 2/19/24.
//

import UIKit


protocol AlertPresenterProtocol {
    
    func showAlert(title: String, body: String, iconImage: UIImage, bannerColor: UIColor, handler: (() -> Void)?)
    
}
