//
//  AddDiscToBagViewController.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 11/18/23.
//

import UIKit
import Eureka
import CoreData
import OSLog

class AddDiscToBagViewController: FormViewController {
    
    enum CellTags: String {
        case discName
        case discBrand
        case usedFor
        case discPlastic
        case discWeight
        case selectColor
        case selectBag
        case discSpeed
        case discGlide
        case discTurn
        case discFade
    }
    
    var coreDataManager: CoreDataManager!
    var disc: DiscGolfDisc?
    var bags: [BagDataModel] = []
    var selectedColor: String = "#FF0000" // Default color
    var selectedBag: BagDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getBags()
        
        if let discData = disc {
            createForm(disc: discData)
        }
    }
    
    private func setupView() {
        // Add a "SAVE" button to the navigation bar
        let saveButton = UIBarButtonItem(title: "SAVE", style: .plain, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = saveButton
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("AppDelegate not found")
        }
        coreDataManager = appDelegate.coreDataManager
        
        disc?.usedFor = "Back Hand"
        disc?.plasticType = "Unknown"
        disc?.discWeight = "Unknown"
        
        self.title = "Add Disc To Bag"
        
        // Set the navigation bar title text color to white
            if let navigationBar = navigationController?.navigationBar {
                let appearance = UINavigationBarAppearance()
                appearance.configureWithOpaqueBackground()
                appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
                appearance.backgroundColor = navigationBar.backgroundColor // retain the existing background color
                navigationBar.standardAppearance = appearance
                navigationBar.scrollEdgeAppearance = appearance
            }
    }
    
    private func getBags() {
        // Fetch bags from core data
        let result = coreDataManager.fetch(BagEntity.self)
        
        switch result {
        case .success(let bagsFromCoreData):
            // Convert BagEntity objects to BagDataModel
            bags = bagsFromCoreData.map { BagDataModel(id: $0.id, bagHexColor: $0.bag_hex_color!, bagTitle: $0.bag_title!, bagType: $0.bag_type!)}
            
            if bags.isEmpty {
                self.navigationController?.popViewController(animated: true)
                AlertPresenter.instance.showAlert(title: "No Bags Found", body: "Please go to the bag tab and create your first bag.", iconImage: UIImage(systemName: "exclamationmark.circle.fill")!, bannerColor: .red) {
                }
            } else {
                selectedBag = bags.first
                tableView?.reloadData()
            }
        case .failure(let error):
            // Log the error for developers
             os_log("Error fetching bags: %@", log: OSLog.default, type: .error, error.localizedDescription)
            AlertPresenter.instance.showAlert(title: "Error", body: "Failed to fetch bags. Please try again later.", iconImage: UIImage(systemName: "exclamationmark.circle.fill")!, bannerColor: .red) {
            }
        }
    }
    
    private func createForm(disc: DiscGolfDisc) {
        form
        +++ Section("Disc Details")
        
        <<< LabelRow(CellTags.discName.rawValue) {
            $0.title =  "Disc Name"
            $0.value = disc.name
        }
        
        <<< LabelRow(CellTags.discBrand.rawValue) {
            $0.title =  "Company"
            $0.value = disc.brand
        }
        
        <<< AlertRow<String>(CellTags.usedFor.rawValue) {
            $0.title = "Used For"
            $0.selectorTitle = "Mainly Used For:"
            $0.cancelTitle = "Cancel"
            $0.options = ["General Use", "Roller", "Backhand", "Flick (Forehand)", "Hyzer","Anhyzer", "Tomahawk",
                          "Thumber", "Approach", "Putt", "Skip Shot", "Scoober", "Grenade", "Flex Shot",
                          "Turnover", "Stall Shot", "Turbo Putt", "Power Grip", "Fan Grip", "Crane Shot",
                          "Flex Forehand", "Sky Roller", "Wind Breaker", "Roller Putt", "Low Ceiling Shot", "Jump Putt"]
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
        <<< PushRow<String>(CellTags.selectBag.rawValue) {
            $0.title = "Bag"
            $0.options = bags.map { $0.bagTitle }
            $0.value = bags.first?.bagTitle 
            $0.selectorTitle = "Select a Bag"
        }.onChange { [weak self] row in
            if let selectedBagTitle = row.value,
               let selectedBag = self?.bags.first(where: { $0.bagTitle == selectedBagTitle }) {
                self?.selectedBag = selectedBag
            }
        }
        
        +++ Section("Flight Numbers [S, G, T, F]")
        <<< PushRow<String>(CellTags.discSpeed.rawValue) {
            $0.title = "Speed"
            $0.options = K.FlightNumbers.speed
            $0.value = disc.speed
            $0.displayValueFor = { value in
                guard let value = value else { return nil }
                return String(value)
            }
        }.onChange({ [weak self] row in
            self?.disc?.speed = row.value ?? "1"
        })
        <<< PushRow<String>(CellTags.discGlide.rawValue) {
            $0.title = "Glide"
            $0.options = K.FlightNumbers.glide
            $0.value = disc.glide
            $0.displayValueFor = { value in
                guard let value = value else { return nil }
                return String(value)
            }
        }.onChange({ [weak self] row in
            self?.disc?.glide = row.value ?? "1"
        })
        <<< PushRow<String>(CellTags.discTurn.rawValue) {
            $0.title = "Turn"
            $0.options = K.FlightNumbers.turn
            $0.value = disc.turn
            $0.displayValueFor = { value in
                guard let value = value else { return nil }
                return String(value)
            }
        }.onChange({ [weak self] row in
            self?.disc?.turn = row.value ?? "0"
        })
        <<< PushRow<String>(CellTags.discFade.rawValue) {
            $0.title = "Fade"
            $0.options = K.FlightNumbers.fade
            $0.value = disc.fade
            $0.displayValueFor = { value in
                guard let value = value else { return nil }
                return String(value)
            }
        }.onChange({ [weak self] row in
            self?.disc?.fade = row.value ?? "0"
        })
    }
    
    @objc private func saveButtonTapped() {
        
        if let currentDisc = disc, let selectedBag = selectedBag {
            // Create a new entity
            if let newEntity = NSEntityDescription.insertNewObject(forEntityName: "DiscEntity", into: coreDataManager.managedContext) as? DiscEntity {
                newEntity.disc_id = selectedBag.id
                newEntity.disc_color = selectedColor
                newEntity.disc_name = currentDisc.name
                newEntity.name_slug = currentDisc.nameSlug
                newEntity.category = currentDisc.category
                newEntity.link = currentDisc.link
                newEntity.pic = currentDisc.pic
                newEntity.plastic = currentDisc.plasticType
                newEntity.stability = currentDisc.stability
                newEntity.speed = currentDisc.speed
                newEntity.glide = currentDisc.glide
                newEntity.turn = currentDisc.turn
                newEntity.fade = currentDisc.fade
                newEntity.brand = currentDisc.brand
                newEntity.bag_name = selectedBag.bagTitle
                newEntity.usedFor = currentDisc.usedFor
                newEntity.disc_weight = currentDisc.discWeight
                coreDataManager.saveContext()
            }
            navigationController?.popViewController(animated: true)
            AlertPresenter.instance.showAlert(title: "Success", body: "Disc Added To Bag Successfully!", iconImage: UIImage(systemName: "checkmark.circle.fill")!, bannerColor: .green) {
            }
        }
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


final class NumericRow: Row<NumericCell>, RowType {
    required init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<NumericCell>(nibName: "NumericCell")
        value = 0
    }
}

final class NumericCell: Cell<Double>, CellType {
    @IBOutlet private weak var textField: UITextField!

    override func setup() {
        super.setup()
        textField.keyboardType = .numbersAndPunctuation
        textField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
    }

    override func update() {
        super.update()
        textField.text = row.displayValueFor?(row.value)
    }

    @objc private func editingChanged() {
        guard let text = textField.text, let value = Double(text) else { return }
        row.value = value
    }
}
