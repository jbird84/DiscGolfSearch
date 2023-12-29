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
    
    var coreDataManager: CoreDataManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("AppDelegate not found")
        }
        coreDataManager = appDelegate.coreDataManager
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
        let result = coreDataManager.fetch(BagEntity.self)
        
        switch result {
        case .success(let entities):
            // Convert BagEntity instances to BagDataModel instances
            if !entities.isEmpty {
                self.bagItems = entities.map { entity in
                    return BagDataModel(id: entity.id, bagHexColor: entity.bag_hex_color!, bagTitle: entity.bag_title!, bagType: entity.bag_type!)
                }
                self.tableView.reloadData()
            }
        case .failure(let error):
            // Handle the error appropriately, e.g., show an alert or log the error
            print("Error fetching bags: \(error.localizedDescription)")
            K.showAlert(title: "Error", message: "Failed to fetch bags. Please try again later.", presentingViewController: self)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bag = bagItems[indexPath.item]
        
        let storyboard = UIStoryboard(name: "Bag", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "bagVC") as? BagViewController {
            vc.bag = bag
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            K.showAlertWithDeleteAction(title: "Selected Bag Will Be Deleted", message: "Are you sure you want to delete this bag?", presentingViewController: self) { [weak self] _ in
                guard let self = self else { return }

                // Get the BagDataModel to be deleted
                let bagDataModelToDelete = self.bagItems[indexPath.row]

                // Fetch BagEntity instances for deletion
                switch coreDataManager.fetch(BagEntity.self, predicate: NSPredicate(format: "id == %@", bagDataModelToDelete.id as NSNumber)) {
                case .success(let bagEntities):
                    if let bagEntityToDelete = bagEntities.first {
                        // Delete the object from Core Data
                        coreDataManager.delete(bagEntityToDelete)

                        // Update the data source and table view
                        self.bagItems.remove(at: indexPath.row)
                        tableView.deleteRows(at: [indexPath], with: .automatic)
                        tableView.reloadData()
                    }
                case .failure(let error):
                    // Handle the error appropriately, e.g., show an alert or log the error
                    print("Error fetching bag entities for deletion: \(error.localizedDescription)")
                    K.showAlert(title: "Error", message: "Failed to delete bag. Please try again later.", presentingViewController: self)
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
