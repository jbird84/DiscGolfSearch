//
//  AddDiscToBagFormViewController.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 11/18/23.
//

import UIKit
import Eureka

class AddDiscToBagFormViewController: FormViewController {
    
    enum CellTags: String {
        case discName
        case discBrand
        case usedFor
        case discPlastic
        case discWeight
        case selectBag
        case selectColor
    }
    
    var disc: DiscGolfDisc?
    var bags: [BagSwiftDataModel] = []
    var selectedColor: String = "#FF0000" // Default color
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        getBags()
        createForm()
    }
    
    private func getBags() {
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
    
    private func createForm() {
        form
        +++ Section("Disc Details")
        
        <<< LabelRow(CellTags.discName.rawValue) {
            $0.title =  "Disc Name"
            $0.value = disc?.name
        }
        
        <<< LabelRow(CellTags.discBrand.rawValue) {
            $0.title =  "Company"
            $0.value = disc?.brand
        }
        
        <<< AlertRow<String>(CellTags.usedFor.rawValue) {
            $0.title = "Used For"
            $0.selectorTitle = "Mainly Used For:"
            $0.cancelTitle = "Cancel"
            $0.options = ["General Use", "Roller", "Backhand", "Flick (Forehand)", "Hyzer","Anhyzer", "Tomahawk", "Thumber", "Approach",        "Putt", "Skip Shot", "Scoober", "Grenade", "Flex Shot", "Turnover", "Stall Shot", "Turbo Putt", "Power Grip", "Fan Grip",
                "Crane Shot", "Flex Forehand", "Sky Roller", "Wind Breaker", "Roller Putt", "Low Ceiling Shot", "Jump Putt"]
            $0.value = "Backhand"
        }.onChange { [weak self] row in
            self?.disc?.usedFor = row.value ?? "Backhand"
        }.cellUpdate({ [weak self] cell, row in
            cell.accessoryView = self?.createDisclousureIndicatorView()
        })
        
        
        <<< NameRow(CellTags.discPlastic.rawValue) {
            $0.title =  "Plastic Type"
            $0.placeholder = "N/A"
        }.onChange({ [weak self] row in
           self?.disc?.plasticType = row.value ?? "N/A"
        })
        
        <<< DecimalRow(CellTags.discWeight.rawValue) {
            $0.title =  "Disc Weight (g)"
            $0.placeholder = "0.0"
        }.onChange({ [weak self] row in
            self?.disc?.discWeight = String(row.value ?? 0.0)
        })
        
        <<< LabelRow(CellTags.selectColor.rawValue) {
            $0.title = "Tap to change color"
        }.cellUpdate({ [weak self] cell, row in
            cell.accessoryView = self?.createCircleColorView(with: UIColor(hex: self!.selectedColor ))
        }).onCellSelection({ [weak self] cell, row in
            
            let gridColorPickerVC = GridColorPickerViewController()
            gridColorPickerVC.delegate = self
            self?.present(gridColorPickerVC, animated: true, completion: nil)
        })
        
        <<< PushRow<String>(CellTags.selectBag.rawValue) { row in
                        row.title = "Select Bag"
                        row.selectorTitle = "Choose a Bag"
                        row.options = bags.map { $0.bagTitle }
                        row.value = bags.first?.bagTitle
                    }
        
        +++ Section("Speed, Glide, Turn, Fade")
        <<< SegmentedRow<String>(){
            $0.options = [disc?.speed ?? "NA", disc?.glide ?? "NA", disc?.turn ?? "NA", disc?.fade ?? "NA"]
            $0.value = "Three"
            }
    }
}

//MARK: Grid Color Picker Delegates
extension AddDiscToBagFormViewController: GridColorPickerDelegate {
    func colorWasSelected(selectedColor: UIColor) {
        let color = selectedColor
        self.selectedColor = color.toHexString()
        self.disc?.discColor = color.toHexString()
        
        if let labelRow = form.rowBy(tag: CellTags.selectColor.rawValue) as? LabelRow {
            labelRow.updateCell()
        }
    }
}

//MARK: Save Disc to Bag Delegates
extension AddDiscToBagFormViewController: SaveDisctoBagDelegate {
   
    func saveDisc() {
       // let addDisc
        print(disc!)
    }
}
