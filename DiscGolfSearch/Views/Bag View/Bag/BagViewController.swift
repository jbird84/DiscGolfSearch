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
            discs = discsFromCoreData.map { DiscDataModel(id: $0.disc_id, selectedColor: $0.disc_color!, name: $0.disc_name!, nameSlug: $0.name_slug!, category: $0.category!, link: $0.link!, pic: $0.pic!, plastic: $0.plastic ?? "NA", stability: $0.stability!, speed: $0.speed!, glide: $0.glide!, turn: $0.turn!, fade: $0.fade!, brand: $0.brand!, bagName: $0.bag_name!, usedFor: $0.usedFor!, weight: $0.disc_weight ?? "NA") }
            
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
