//
//  AddDiscToView.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 10/27/23.
//

import UIKit

protocol AddDiscToViewDelegate {
    func dissmiss()
    func saveDiscToSwiftData()
    func saveDiscToBag()
}

class AddDiscToView: UIView {

    var delegate: AddDiscToViewDelegate?
    
    @IBAction func addToCartTapped(_ sender: Any) {
       
        //Send user to fillout form then pop to view
        delegate?.saveDiscToSwiftData()
        delegate?.dissmiss()
    }
    
    @IBAction func addToBagTapped(_ sender: Any) {
        //Send user to fillout form then pop to view
        delegate?.saveDiscToBag()
        delegate?.dissmiss()
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        delegate?.dissmiss()
    }
}
