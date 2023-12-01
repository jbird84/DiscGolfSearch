//
//  AddDiscToBagViewController.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 11/18/23.
//

import UIKit
import Eureka

class AddDiscToBagViewController: FormViewController {
    
    enum CellTags: String {
        case discName
        case discBrand
        case usedFor
        case discPlastic
        case discWeight
        case selectColor
        case selectBag
    }
    
    var disc: DiscGolfDisc?
    var bags: [BagSwiftDataModel] = []
    var selectedColor: String = "#FF0000" // Default color
    var selectedBag: BagSwiftDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getBags()
        createForm()
        // Do any additional setup after loading the view.
    }
    
    private func setupView() {
        // Add a "SAVE" button to the navigation bar
        let saveButton = UIBarButtonItem(title: "SAVE", style: .plain, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    private func getBags() {
        BagDatabaseService.shared.fetchDiscBagList { [weak self] bags, error in
            if let data = bags, error == nil {
                self?.bags = data
                self?.tableView.reloadData()
            } else if let error = error {
                print("There was a problem getting your bags. Error: \(error)")
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
            
            +++ Section("Select Bag")
                    
                    <<< PickerInlineRow<String>(CellTags.selectBag.rawValue) {
                        $0.title = "Bag"
                        $0.options = bags.map { $0.bagTitle }
                        $0.value = bags.first?.bagTitle // Set default value if available
                        $0.displayValueFor = { value in
                            return value
                        }
                    }.onChange { [weak self] row in
                        if let selectedBagTitle = row.value,
                            let selectedBag = self?.bags.first(where: { $0.bagTitle == selectedBagTitle }) {
                            self?.selectedBag = selectedBag
                        }
                    }
    
            +++ Section("Speed, Glide, Turn, Fade")
            <<< SegmentedRow<String>(){
                $0.options = [disc?.speed ?? "NA", disc?.glide ?? "NA", disc?.turn ?? "NA", disc?.fade ?? "NA"]
                $0.value = "Three"
                }
        }
    
    @objc private func saveButtonTapped() {
        
    }
}

//MARK: Grid Color Picker Delegates
extension AddDiscToBagViewController: GridColorPickerDelegate {
    func colorWasSelected(selectedColor: UIColor) {
        let color = selectedColor
        self.selectedColor = color.toHexString()
        self.disc?.discColor = color.toHexString()

        if let labelRow = form.rowBy(tag: CellTags.selectColor.rawValue) as? LabelRow {
            labelRow.updateCell()
        }
     }
}


