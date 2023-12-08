//
//  AddBagViewController.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 11/13/23.
//

import UIKit
import Eureka
import CoreData

class AddBagViewController: FormViewController {
    
    
    private enum CellTags: String {
        case bagName
        case bagType
        case bagColor
    }
    
    var coreDataManager: CoreDataManager!
    
    private var bagName: String?
    private var bagType: String?
    private var selectedColor: String = "#808080" // Default color
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    // Add a slider and an image view
    private let colorPickerButton = UIButton()
    
    private let colorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Access the shared instance of CoreDataManager from AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("AppDelegate not found")
        }
        coreDataManager = appDelegate.coreDataManager
        createForm()
        setupView()
    }
    
    
    private func setupView() {
        let addNewBagButton = UIBarButtonItem(title: "SAVE", style: .plain, target: self, action: #selector(saveBag))
        navigationItem.rightBarButtonItem = addNewBagButton
        
        //setup bag imageView
        
        // Set the plus sign image to the image view
        imageView.image = UIImage(named: "bag")
        imageView.setImageColor(color: UIColor.systemGray2)
        
        // Calculate the center of the screen
        let centerX = view.bounds.midX
        let centerY = view.bounds.midY
        
        // Set the center of the image view to the center of the screen
        imageView.center = CGPoint(x: centerX, y: centerY)
        
        // Add the image view to the view hierarchy
        view.addSubview(imageView)
    }
    
    private func createForm() {
        form
        +++ Section(header: "Create a Bag", footer: "The color of the bag image below is your bags color.")
        
        <<< NameRow(CellTags.bagName.rawValue) {
            $0.title =  "Bag Name"
        }.onChange({ [weak self] row in
            self?.bagName = row.value
        })
        
        <<< NameRow(CellTags.bagType.rawValue) {
            $0.title =  "Bag Used For"
        }.onChange({ [weak self] row in
            self?.bagType = row.value
        })
        
        
        <<< LabelRow(CellTags.bagColor.rawValue) {
            $0.title = "Tap to change your bags color"
        }.cellUpdate({ [weak self] cell, row in
            cell.accessoryView = self?.createDisclousureIndicatorView()
        }).onCellSelection({ [weak self] cell, row in
            
            let gridColorPickerVC = GridColorPickerViewController()
            gridColorPickerVC.delegate = self
            self?.present(gridColorPickerVC, animated: true, completion: nil)
        })
        
        
    }
    
    @objc private func saveBag() {
        
        print("Bag Saved")
        if bagName == nil {
            K.showAlert(title: "Bag Name Empty", message: "Please add a name for this bag.", presentingViewController: self)
            return
        }
        if bagType == nil {
            K.showAlert(title: "Bag Type Empty", message: "Please add what this bag is used for.", presentingViewController: self)
            return
        }
        
        // Generate a random id
        let randomId = Int64(arc4random_uniform(UInt32.max))
        
        if let bagName = bagName, let bagType = bagType {
            // Create a new entity
            if let newEntity = NSEntityDescription.insertNewObject(forEntityName: "BagEntity", into: coreDataManager.managedContext) as? BagEntity {
                newEntity.setValue(randomId, forKey: "bag_disc")
                newEntity.setValue(selectedColor, forKey: "bag_hex_color")
                newEntity.setValue(bagName, forKey: "bag_title")
                newEntity.setValue(bagType, forKey: "bag_type")
                coreDataManager.saveContext()
            }
            navigationController?.popViewController(animated: true)
        }
    }
}

//Grid Color Picker Delegates
extension AddBagViewController: GridColorPickerDelegate {
    func colorWasSelected(selectedColor: UIColor) {
        let color = selectedColor
        self.selectedColor = color.toHexString()
        imageView.setImageColor(color: color)
    }
    
    
    
}





