//
//  ViewController.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 9/10/23.
//

import UIKit
import SwiftSpinner

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var allDiscs: [DiscGolfDisc] = []
    var brands: Set<String> = Set()
    var brandSlugs: Set<String> = []
    var selectedIndices: Set<Int> = [] // Keep track of selected indice
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        getDiscData()
        // Add a "Select All" button to the navigation bar
        let selectAllButton = UIBarButtonItem(title: "Select All", style: .plain, target: self, action: #selector(selectAllTapped))
        navigationItem.rightBarButtonItem = selectAllButton
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(BrandCell.self, forCellWithReuseIdentifier: "BrandCell")
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let padding: CGFloat = 2.0 // Adjust the padding as needed
        
        // Calculate the item width based on 1/2 of the screen width minus the padding
        let itemWidth = (self.view.frame.width / 2) - (3 * padding)
        let itemHeight: CGFloat = 30.0
        
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        flowLayout.minimumInteritemSpacing = padding // Set the minimum interitem spacing
        
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        
        collectionView.collectionViewLayout = flowLayout
    }
    
    private func getDiscData() {
        SwiftSpinner.show("Loading A Disc Golf Company List...", animated: true)
        APIManager.shared.fetchDiscGolfData(param: "disc") { [weak self] discs, error in
            guard let self = self else { return }
            if let error = error {
                DispatchQueue.main.async {
                    self.showAlert()
                }
                print("Error fetching data: \(error.localizedDescription)")
            } else if let discs = discs {
                self.allDiscs = discs
                self.saveAllDiscsToUserDefaults()
                for disc in discs {
                    self.brands.insert(disc.brand)
                }
            }
            
            DispatchQueue.main.async {
                SwiftSpinner.hide()
                self.collectionView.reloadData()
            }
        }
    }
    
    private func saveAllDiscsToUserDefaults() {
        do {
            let encoder = JSONEncoder()
            
            let data = try encoder.encode(allDiscs)
            
            UserDefaults.standard.setValue(data, forKey: "allDiscs")
            
        } catch {
            print("Unable to Encode all discs (\(error)")
        }
    }
    
    private func showAlert() {
        let popup = UIAlertController(title: "Site is down ☹️", message: "It looks like the site where the disc data comes from is currently down. Please close app and check back in later.", preferredStyle: .alert)
        
        let retry = UIAlertAction(title: "Try Refreshing", style: .default) { _ in
            self.getDiscData()
        }
        
        let help = UIAlertAction(title: "Contact Support", style: .default) { _ in
            let storyboard = UIStoryboard(name: "HelpView", bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: "helpVC") as? HelpViewController {
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        popup.addAction(retry)
        popup.addAction(help)
        present(popup, animated: true, completion: nil)
    }
    
    
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        let selectedCompanyDiscs: [DiscGolfDisc] = allDiscs.filter { disc in
            return brandSlugs.contains(disc.brandSlug)
        }
        
        for name in selectedCompanyDiscs {
            print(name.nameSlug)
        }
        
        // Check if there are any selected discs to display
        if selectedCompanyDiscs.isEmpty {
            // Handle the case where no discs match the selected brands
            AlertPresenter.instance.showAlert(title: "No Brand Selected", body: "Please select at least one brand and then tap the search button.", iconImage: UIImage(named: "noDiscForThisSpeed")!, bannerColor: .orange, handler: nil)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil) // Replace "Main" with your storyboard name
            if let vc = storyboard.instantiateViewController(withIdentifier: "discList") as? DiscListViewController {
                vc.selectedCompanyDiscs = selectedCompanyDiscs
                vc.filteredDiscs = selectedCompanyDiscs
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    
    @objc func selectAllTapped() {
        
        // Toggle the selection state for all brand names
        if selectedIndices.count == brands.count {
            selectedIndices.removeAll() // Deselect all if all are currently selected
            brandSlugs.removeAll()
        } else {
            // Select all items by adding all indices to 'selectedIndices'
            selectedIndices = Set(0..<brands.count)
            
            // Clear the brandSlugs set and then add all brand slugs
            brandSlugs.removeAll()
            brandSlugs = Set(brands.map { brand in
                return brand.lowercased().replacingOccurrences(of: " ", with: "-")
            })
        }
        collectionView.reloadData() // Reload the collection view to reflect the changes
    }
}


//MARK: - ColectionView Delegate Methods
extension ViewController:  UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return brands.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandCell", for: indexPath) as! BrandCell
        
        // Configure the cell with the brand name and selection state
        let sortedBrands = brands.sorted()
        let brand = sortedBrands[indexPath.item]
        cell.titleLabel.text = brand
        
        if selectedIndices.contains(indexPath.item) {
            cell.backgroundColor = .systemBlue // Change to the selected color you want
        } else {
            cell.backgroundColor = .clear // Change to the default/unselected color you want
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Toggle the selection state for the tapped cell's index
        if selectedIndices.contains(indexPath.item) {
            selectedIndices.remove(indexPath.item)
            
            let sortedBrands = brands.sorted()
            let brand = sortedBrands[indexPath.item]
            let brandSlug = brand.lowercased().replacingOccurrences(of: " ", with: "-")
            brandSlugs.remove(brandSlug)
        } else {
            selectedIndices.insert(indexPath.item)
            let sortedBrands = brands.sorted()
            let brand = sortedBrands[indexPath.item]
            let brandSlug = brand.lowercased().replacingOccurrences(of: " ", with: "-")
            brandSlugs.insert(brandSlug)
        }
        collectionView.reloadItems(at: [indexPath])
    }
}

