//
//  Constants.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 10/3/23.
//

import Foundation
import UIKit

struct K {
    
    enum FlightNumbers {
        static let speed = ["1", "1.5", "2", "2.5", "3", "3.5", "4", "4.5", "5", "5.5", "6", "6.5", "7", "7.5", "8", "8.5", "9", "9.5", "10", "10.5", "11", "11.5", "12", "12.5", "13", "13.5", "14"]
        static let glide = ["1", "1.5", "2", "2.5", "3", "3.5", "4", "4.5", "5", "5.5", "6", "6.5", "7"]
        static let turn = ["-5", "-4.5", "-4", "-3.5", "-3", "-2.5", "-2", "-1.5", "-1", "-0.5", "0", "0.5", "1"]
        static let fade = ["0", "1", "1.5", "2", "2.5", "3", "3.5", "4", "4.5", "5"]
    }
    
    enum HexColor {
        static let gold = "#FFD700"
        static let limeGreen = "#32CD32"
        static let blueViolet = "#8A2BE2"
        static let tomato = "#FF6347"
        static let mediumSpringGreen = "#00FA9A"
        static let royalBlue = "#4169E1"
        static let orangeRed = "#FF4500"
        static let saddleBrown = "#8B4513"
        static let seaGreen = "#2E8B57"
        static let darkOrchid = "#9932CC"
        static let darkOrange = "#FF8C00"
        static let grayishBlue = "#7393B3"
    }
                                            

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

