//
//  AlertPresenter.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 2/19/24.
//

import UIKit
import SwiftMessages


final class AlertPresenter: @preconcurrency AlertPresenterProtocol {
    
    static public let instance: AlertPresenter = AlertPresenter()
    
    private init() {}
    
    @MainActor func showAlert(title: String, body: String, iconImage: UIImage, bannerColor: UIColor, handler: (() -> Void)?) {
        let view = MessageView.viewFromNib(layout: .messageView)
        view.configureTheme(.success)
        view.configureDropShadow()
        view.configureContent(title: title, body: body, iconImage: iconImage)
        view.button?.isHidden = true
        view.backgroundColor = bannerColor
        view.layoutMarginAdditions = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        var config = SwiftMessages.defaultConfig
            config.duration = .seconds(seconds: 6)
                
        SwiftMessages.show(config: config, view: view)
    }
}
