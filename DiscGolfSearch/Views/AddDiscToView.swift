//
//  AddDiscToView.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 10/27/23.
//

import UIKit

protocol CancelTappedDelegate {
    func dissmiss()
}

class AddDiscToView: UIView {

    var delegate: CancelTappedDelegate?
    
    @IBAction func addToCartTapped(_ sender: Any) {
       
        print("Added Disc To Cart!")
    }
    
    
    @IBAction func addToBagTapped(_ sender: Any) {
        print("Added Disc To Bag!")
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        print("Cancel Tapped")
        delegate?.dissmiss()
    }
    
}
