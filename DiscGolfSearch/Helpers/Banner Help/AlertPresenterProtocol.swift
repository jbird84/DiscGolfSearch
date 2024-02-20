//
//  AlertPresenterProtocol.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 2/19/24.
//

import Foundation


protocol AlertPresenterProtocol {
    
    func showAlert(title: String, body: String, handler: (() -> Void)?)
    
}
