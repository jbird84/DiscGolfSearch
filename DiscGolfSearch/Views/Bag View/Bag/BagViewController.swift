//
//  BagViewController.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 12/24/23.
//

import UIKit
import DZNEmptyDataSet

class BagViewController: UIViewController {

    @IBOutlet weak var segControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var coreDataManager: CoreDataManager!
    var bag: BagDataModel?
    var discs: [DiscDataModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getDiscs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDiscs()
    }
    
    private func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("AppDelegate not found")
        }
        coreDataManager = appDelegate.coreDataManager
    }
    
    private func getDiscs() {
        // Fetch discs from coreData
        let result = coreDataManager.fetch(DiscEntity.self)
        
        switch result {
        case .success(let discsFromCoreData):
            // Convert DiscEntity instances to DiscDataModel instances
            discs = discsFromCoreData.map { DiscDataModel(id: $0.discGolfDisc_id, selectedColor: $0.discGolfDisc_color!, name: $0.discGolfDisc_name!, nameSlug: $0.discGolfDisc_name_slug!, category: $0.discGolfDisc_category!, link: $0.discGolfDisc_link!, pic: $0.discGolfDisc_pic!, plastic: $0.discGolfDisc_plastic ?? "NA", stability: $0.discGolfDisc_stability!, speed: $0.discGolfDisc_speed!, glide: $0.discGolfDisc_glide!, turn: $0.discGolfDisc_turn!, fade: $0.discGolfDisc_fade!, brand: $0.discGolfDisc_brand!, bagName: $0.discGolfDisc_bag_name!, usedFor: $0.discGolfDisc_usedFor!, weight: $0.discGolfDisc_weight ?? "NA") }
            
            tableView.reloadData()
        case .failure(let error):
            // Handle the error appropriately, e.g., show an alert or log the error
            print("Error fetching discs: \(error.localizedDescription)")
            K.showAlert(title: "Error", message: "Failed to fetch discs. Please try again later.", presentingViewController: self)
        }
    }


}

//MARK: TableView Delegates
extension BagViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        discs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "discInBagCell", for: indexPath) as! DiscInBagCell
        
        cell.discImageColorImageView.tintColor = UIColor(hex: discs[indexPath.row].selectedColor)
        cell.discNameLabel.text = discs[indexPath.row].name
        cell.usedForLabel.text = discs[indexPath.row].usedFor
        
        return cell
    }
}

//MARK: Empty Data Source Delegates
extension BagViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return UIImage(named: "noDiscGolfDisc")
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "No Discs Found"
        let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func imageTintColor(forEmptyDataSet scrollView: UIScrollView) -> UIColor? {
        let userInterfaceStyle = scrollView.traitCollection.userInterfaceStyle
        if userInterfaceStyle != .dark {
            return UIColor.label
        } else {
            return UIColor.secondaryLabel
        }
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "Tap the \"Disc\" tab, find & select a disc, tap the + at the top right and choose \"Add Disc To Bag\". "
        let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
}
