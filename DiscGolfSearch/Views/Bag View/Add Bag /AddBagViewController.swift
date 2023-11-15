//
//  AddBagViewController.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 11/13/23.
//

import UIKit
import Eureka

class AddBagViewController: FormViewController {

    
    private enum CellTags: String {
        case bagName
        case bagType
        case bagColor
    }
    
    private var selectedColor: String = "#808080" // Default color
    
    // Add a slider and an image view
    private let colorPickerButton = UIButton()
    
    private let colorImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createForm()
        setupView()
    }
    
    
    private func setupView() {
        let addNewBagButton = UIBarButtonItem(title: "SAVE", style: .plain, target: self, action: #selector(saveBag))
        navigationItem.rightBarButtonItem = addNewBagButton
        }
    
    private func createForm() {
        form
        +++ Section("Create a Bag")
        
        <<< NameRow(CellTags.bagName.rawValue) {
            $0.title =  "Bag Name"
        }
        
        <<< NameRow(CellTags.bagType.rawValue) {
            $0.title =  "Bag used for what?"
        }
        
        <<< PushRow() {
            $0.title = "PushRow"
            $0.options = [💁🏻, 🍐, 👦🏼, 🐗, 🐼, 🐻]
            $0.value = 👦🏼
            $0.selectorTitle = "Choose an Emoji!"
            }.onPresent { from, to in
                to.dismissOnSelection = false
                to.dismissOnChange = false
        }
    }
    
    @objc private func saveBag() {
        print("Bag Saved")
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func didTapSelectColor() {
        
    }
 

}



