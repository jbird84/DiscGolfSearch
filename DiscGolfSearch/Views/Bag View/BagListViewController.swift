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
    
    var bagItems: [Bag] = []
    override func viewDidLoad() {
        super.viewDidLoad()

setupView()
    }
    

    private func setupView() {
        let addNewBagButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addNewBag))
        navBarItem.rightBarButtonItem = addNewBagButton
        title = "My Bags"
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        
        bagItems = [
            Bag(bagHexColor: "#FF5733", bagTitle: "For the woods", bagType: "Woods"),
            Bag(bagHexColor: "#3498db", bagTitle: "Main Bag", bagType: "Take and win anywhere"),
            Bag(bagHexColor: "#27ae60", bagTitle: "Open Fields Galore", bagType: "For open courses"),
            Bag(bagHexColor: "#e74c3c", bagTitle: "Putt & Tricks", bagType: "Close range courses"),
            Bag(bagHexColor: "#8e44ad", bagTitle: "Backup Bag", bagType: "When I want to mix it up.")
        ]






    }
    
    @objc func addNewBag() {
        let vc = UIStoryboard(name: "AddBag", bundle: nil).instantiateViewController(identifier: "addBag") as! AddBagViewController
        navigationController?.pushViewController(vc, animated: true)
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
}

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
