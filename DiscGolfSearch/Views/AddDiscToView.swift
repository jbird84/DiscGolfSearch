//
//  AddDiscToView.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 10/27/23.
//

import UIKit

protocol CancelTa

class AddDiscToView: UIView {

    
    @IBAction func addToCartTapped(_ sender: Any) {
        print("Added Disc To Cart!")
    }
    
    
    @IBAction func addToBagTapped(_ sender: Any) {
        print("Added Disc To Bag!")
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        print("Cancel Tapped")
    }
    
    
}
