//
//  CartViewController.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 11/5/23.
//

import UIKit

class CartViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DatabaseService.shared.fetchTasks { discs, error in
            if let data = discs, error == nil {
                print(data)
            } else if let error = error {
                print("There was a problem getting your discs. ERROR: \(error)")
            }
        }
    }
}
