//
//  CartViewController.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 11/5/23.
//

import UIKit

class CartViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var discs: [DiscSwiftDataModel] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       getDiscs()
        setupTableView()
    }
    
    private func setupTableView()  {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func getDiscs() {
        DatabaseService.shared.fetchDiscCartList { [weak self] discs, error in
            if let data = discs, error == nil {
                self?.discs = data
                self?.tableView.reloadData()
            } else if let error = error {
                print("There was a problem getting your discs. ERROR: \(error)")
            }
        }
    }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return discs.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartTableViewCell
        let image = UIImage(data: discs[indexPath.row].imageData)
        cell.companyNameLabel.text = discs[indexPath.row].brand
        cell.discNameLabel.text = discs[indexPath.row].name
        cell.discStabilityLabel.text = discs[indexPath.row].stability
        cell.discSpeedLabel.text = discs[indexPath.row].speed
        cell.discTurnLabel.text = discs[indexPath.row].turn
        cell.discGlideLabel.text = discs[indexPath.row].glide
        cell.discFadeLabel.text = discs[indexPath.row].fade
        cell.discImageView.image = image 
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110.0 // Adjust this value to set the desired cell height
    }
    
    // Implement swipe-to-delete functionality:
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                // Handle the delete action here.

                K.showAlertWithDeleteAction(title: "Disc will be deleted", message: "Are you sure you want to delete the selected disc?", presentingViewController: self) { [weak self] _ in
                    guard let self else { return }
                    DatabaseService.shared.deleteDiscFromCartView(disc: self.discs[indexPath.row])
                    self.discs.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                }
            }
        }
    
}
