//
//  Constants.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 10/3/23.
//

import Foundation
import UIKit

struct K {
    
    static func setDiscColorBasedOnStability(stability: Stability) -> UIColor {
        switch stability {
        case .veryOverstable:
            return UIColor.systemBlue
        case .overstable:
            return UIColor.systemGreen
        case .stable:
            return UIColor.systemOrange
        case .understable:
            return UIColor.systemRed
        case .veryUnderstable:
            return UIColor.systemTeal
        case .theDefault:
            return UIColor.white
        }
    }
    
    enum Stability: String {
        case veryOverstable = "Very Overstable"
        case overstable = "Overstable"
        case stable = "Stable"
        case understable = "Understable"
        case veryUnderstable = "Very Understable"
        case theDefault = ""
    }
    
    static func showAlertWithRetryOption(title: String, message: String, presentingViewController: UIViewController, retryFunction: @escaping (UIAlertAction) -> Void) {
        let popup = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let retry = UIAlertAction(title: "Try Again", style: .default, handler: retryFunction)
        popup.addAction(retry)
        presentingViewController.present(popup, animated: true, completion: nil)
    }
    
    static func showAlertWithDeleteAction(title: String, message: String, presentingViewController: UIViewController, deleteAction: @escaping (UIAlertAction) -> Void) {
        let popup = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            popup.dismiss(animated: true, completion: nil)
        })
        popup.addAction(cancel)
        let delete = UIAlertAction(title: "Delete", style: .destructive, handler: deleteAction)
        popup.addAction(delete)
        presentingViewController.present(popup, animated: true, completion: nil)
    }
    
    static func showAlertWithAction(title: String, message: String, presentingViewController: UIViewController, actionTitle: String, action: @escaping (UIAlertAction) -> Void) {
        let popup = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default, handler: action)
        popup.addAction(action)
        presentingViewController.present(popup, animated: true, completion: nil)
    }
    
    static func showAlert(title: String, message: String, presentingViewController: UIViewController) {
        let popup = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        popup.addAction(ok)
        presentingViewController.present(popup, animated: true, completion: nil)
    }
    
}

