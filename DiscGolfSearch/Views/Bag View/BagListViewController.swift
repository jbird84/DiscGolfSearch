//
//  BagListViewController.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 11/12/23.
//

import UIKit
import DZNEmptyDataSet
import CoreData

class BagListViewController: UIViewController {
    
    @IBOutlet weak var navBarItem: UINavigationItem!
    @IBOutlet weak var tableView: UITableView!
    
    var bagItems: [BagDataModel] = []
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getBags()
    }
    
    
    private func setupView() {
        let addNewBagButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addNewBag))
        navBarItem.rightBarButtonItem = addNewBagButton
        title = "My Bags"
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        
    }
    
    @objc func addNewBag() {
        let vc = UIStoryboard(name: "AddBag", bundle: nil).instantiateViewController(identifier: "addBag") as! AddBagViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func getBags() {
        // Fetch entities
        let entities = appDelegate.coreDataManager.fetch(BagEntity.self)
        
        // Convert BagEntity instances to BagDataModel instances
        if !entities.isEmpty {
            self.bagItems = entities.map { entity in
                return BagDataModel(id: entity.bag_disc, bagHexColor: entity.bag_hex_color!, bagTitle: entity.bag_title!, bagType: entity.bag_type!)
            }
            self.tableView.reloadData()
        }
    }
}

//MARK: - TableView Delegate Methods
extension BagListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bagItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bagList", for: indexPath) as! BagListTableViewCell
        cell.bagImageView.setImageColor(color: UIColor(hex: bagItems[indexPath.row].bagHexColor))
        cell.bagNameLabel.text = bagItems[indexPath.row].bagTitle
        cell.bagUseLabel.text = bagItems[indexPath.row].bagType
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            K.showAlertWithDeleteAction(title: "Selected Bag Will Be Deleted", message: "Are you sure you want to delete this bag?", presentingViewController: self) { [weak self] _ in
                guard let self = self else { return }

                // Get the BagDataModel to be deleted
                let bagDataModelToDelete = self.bagItems[indexPath.row]

                // Convert BagDataModel to NSManagedObject
                if let bagEntityToDelete = appDelegate.coreDataManager.fetch(BagEntity.self, predicate: NSPredicate(format: "id == %@", bagDataModelToDelete.id as NSNumber)).first {
                    
                    // Delete the object from Core Data
                    appDelegate.coreDataManager.delete(bagEntityToDelete)

                    // Update the data source and table view
                    self.bagItems.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                }
            }
        }
    }
    
}

//MARK: - Empty Dataset Delegates
extension BagListViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return UIImage(named: "noBackPack")
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "No Bags Found"
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
        let str = "Tap the + button above to create your first bag."
        let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
}
