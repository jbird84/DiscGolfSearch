//
//  AddDiscToBagViewController.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 11/18/23.
//

import UIKit
import Eureka

protocol SaveDisctoBagDelegate: AnyObject {
    func saveDisc()
}

class AddDiscToBagViewController: UIViewController {
    
    
    var disc: DiscGolfDisc?
    var bags: [BagSwiftDataModel] = []
    var delegate: SaveDisctoBagDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addBagToFormSegue", let disc = disc {
            let destVC = segue.destination as! AddDiscToBagFormViewController
            destVC.disc = disc
            destVC.bags = bags
            self.delegate = destVC
        }
    }
    
    private func setupView() {
        // Add a "SAVE" button to the navigation bar
        let saveButton = UIBarButtonItem(title: "SAVE", style: .plain, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc private func saveButtonTapped() {
        delegate?.saveDisc()
    }
}



