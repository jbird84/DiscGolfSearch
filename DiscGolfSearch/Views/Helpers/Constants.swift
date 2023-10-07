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
    
}
