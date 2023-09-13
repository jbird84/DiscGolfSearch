//
//  ViewController.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 9/10/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var allDisc: [DiscGolfDisc] = []
    var brands: Set<String> = Set()
    var brandSlugs: Set<String> = Set()
    var selectedIndices: Set<Int> = [] // Keep track of selected indice
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        APIManager.shared.fetchDiscGolfData(param: "disc") { discs, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
            } else if let discs = discs {
                self.allDisc = discs
                for disc in discs {
                    self.brands.insert(disc.brand)
                    self.brandSlugs.insert(disc.brandSlug)
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
        
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
    
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        print(brandSlugs)
    }
    
    @objc func selectAllTapped() {
        // Toggle the selection state for all brand names
        if selectedIndices.count == brands.count {
            selectedIndices.removeAll() // Deselect all if all are currently selected
            brandSlugs.removeAll()
        } else {
            // Select all items by adding all indices to 'selectedIndices'
            selectedIndices = Set(0..<brands.count)
            brandSlugs = Set(brands)
        }
        print(brandSlugs)
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
            cell.backgroundColor = .orange // Change to the selected color you want
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
            let brandSlug = sortedBrands[indexPath.item]
            brandSlugs.remove(brandSlug)
        } else {
            selectedIndices.insert(indexPath.item)
            let sortedBrands = brands.sorted()
            let brandSlug = sortedBrands[indexPath.item]
            brandSlugs.insert(brandSlug)
        }
        
        collectionView.reloadItems(at: [indexPath])
    }
}

