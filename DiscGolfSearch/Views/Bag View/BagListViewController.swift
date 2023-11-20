//
//  BagListViewController.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 11/12/23.
//

import UIKit
import DZNEmptyDataSet

class BagListViewController: UIViewController {

    @IBOutlet weak var navBarItem: UINavigationItem!
    
    @IBOutlet weak var tableView: UITableView!
    
    var bagItems: [BagSwiftDataModel] = []
 
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
        BagDatabaseService.shared.fetchDiscBagList { [weak self] bags, error in
            if let data = bags, error == nil {
                self?.bagItems = data
                self?.tableView.reloadData()
            } else if let error = error {
                print("There was a problem getting your bags. Error: \(error)")
            }
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
                guard let self else { return }
                BagDatabaseService.shared.deleteBagFromBagView(bag: self.bagItems[indexPath.row])
                self.bagItems.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
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
