//
//  BagViewController.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 12/24/23.
//

import UIKit

class BagViewController: UIViewController {

    @IBOutlet weak var segControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var coreDataManager: CoreDataManager!
    var bag: BagDataModel?
    var discs: [DiscDataModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("AppDelegate not found")
        }
        coreDataManager = appDelegate.coreDataManager
    }
    
    private func getDiscs() {
        //fetch discs from coreData
        let discsFromCoreData = coreDataManager.fetch(DiscEntity.self)
        
        //convert DiscEntity to DiscDataModel
        discs = discsFromCoreData.map { DiscDataModel(id: $0.discGolfDisc_id, selectedColor: $0.discGolfDisc_color!, name: $0.discGolfDisc_name!, nameSlug: $0.discGolfDisc_name_slug!, category: $0.discGolfDisc_category!, link: $0.discGolfDisc_link!, pic: $0.discGolfDisc_pic!, plastic: $0.discGolfDisc_plastic ?? "NA", stability: $0.discGolfDisc_stability!, speed: $0.discGolfDisc_speed!, glide: $0.discGolfDisc_glide!, turn: $0.discGolfDisc_turn!, fade: $0.discGolfDisc_fade!, brand: $0.discGolfDisc_brand!, bagName: $0.discGolfDisc_bag_name!, usedFor: $0.discGolfDisc_usedFor!, weight: $0.discGolfDisc_weight ?? "NA") }
        
        tableView.reloadData()
    }


}

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
