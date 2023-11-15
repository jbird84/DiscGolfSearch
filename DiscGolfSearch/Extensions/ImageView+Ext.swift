//
//  ImageView+Ext.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 11/12/23.
//

import UIKit

extension UIImageView {
  func setImageColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
}
