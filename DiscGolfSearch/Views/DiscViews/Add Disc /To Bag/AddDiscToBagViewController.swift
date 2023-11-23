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
    
    @IBOutlet weak var pickerView: UIPickerView!
    
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
            self.delegate = destVC
        }
    }
    
    private func setupView() {
        // Add a "SAVE" button to the navigation bar
        let saveButton = UIBarButtonItem(title: "SAVE", style: .plain, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = saveButton
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        BagDatabaseService.shared.fetchDiscBagList { bags, error in
            if error == nil, bags == [] || bags == nil  {
                K.showAlertWithAction(title: "No Bags Created", message: "You need to add a bag before you can add a disc to your bags. Click the bag tab and tap the + to add your first bag.", presentingViewController: self, actionTitle: "Go Back") { [weak self] _ in
                    self?.navigationController?.popViewController(animated: true)
                }
            } else {
                if let theBags = bags {
                    self.bags = theBags
                }
            }
        }
    }
    
    @objc private func saveButtonTapped() {
        delegate?.saveDisc()
    }
}


//MARK: PickerView Delegates
extension AddDiscToBagViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return bags.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return bags[row].bagTitle
    }
    
    
}
