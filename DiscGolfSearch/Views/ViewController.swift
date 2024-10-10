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
    
    let userDefaultsManager = UserDefaultsManager()
    var allDiscs: [DiscGolfDisc] = []
    var brands: Set<String> = Set()
    var brandSlugs: Set<String> = []
    var selectedIndices: Set<Int> = [] // Keep track of selected indice
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        // Add a "Select All" button to the navigation bar
        let selectAllButton = UIBarButtonItem(title: "Select All", style: .plain, target: self, action: #selector(selectAllTapped))
        navigationItem.rightBarButtonItem = selectAllButton
        
        // Add a "Refresh Disc" button to the navigation bar
        let refreshDiscs = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise.square.fill"), style: .plain, target: self, action: #selector(refreshDiscList))
       
        // Set both buttons to the rightBarButtonItems
        navigationItem.rightBarButtonItems = [refreshDiscs, selectAllButton]
        
        let contactSupport = UIBarButtonItem(title: "Get Help", style: .plain, target: self, action: #selector(getHelpTapped))
        navigationItem.leftBarButtonItem = contactSupport
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadDiscData()
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(BrandCell.self, forCellWithReuseIdentifier: "BrandCell")
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let padding: CGFloat = 2.0
        
        // Calculate the item width based on 1/2 of the screen width minus the padding
        let itemWidth = (self.view.frame.width / 2) - (3 * padding)
        let itemHeight: CGFloat = 30.0
        
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        flowLayout.minimumInteritemSpacing = padding
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        
        collectionView.collectionViewLayout = flowLayout
    }
    
       
       private func saveAllDiscsToUserDefaults(_ discs: [DiscGolfDisc]) {
           userDefaultsManager.saveData(discs, for: .allDiscs)
       }
    
//    private func showAlert() {
//        let popup = UIAlertController(title: "Site is down ☹️", message: "It looks like the site where the disc data comes from is currently down. Please close app and check back in later.", preferredStyle: .alert)
//        
//        let retry = UIAlertAction(title: "Try Refreshing", style: .default) { _ in
//            self.loadDiscData()
//        }
//        
//        let help = UIAlertAction(title: "Contact Support", style: .default) { _ in
//            let storyboard = UIStoryboard(name: "HelpView", bundle: nil)
//            if let vc = storyboard.instantiateViewController(withIdentifier: "helpVC") as? HelpViewController {
//                vc.overrideUserInterfaceStyle = .dark
//                self.navigationController?.pushViewController(vc, animated: true)
//            }
//        }
//        
//        popup.addAction(retry)
//        popup.addAction(help)
//        present(popup, animated: true, completion: nil)
//    }
    
    private func loadDiscData() {
            SwiftSpinner.show("Loading A Disc Golf Company List...", animated: true)
            
        if let loadedDiscs: [DiscGolfDisc] = userDefaultsManager.loadData(for: .allDiscs) {
                    allDiscs = loadedDiscs
                    brands = Set(allDiscs.map { $0.brand })
                    DispatchQueue.main.async {
                        SwiftSpinner.hide()
                        self.collectionView.reloadData()
                    }
                } else {
                    fetchDiscsFromAPI()
                }
        }
    
    private func fetchDiscsFromAPI() {
            APIManager.shared.fetchDiscGolfData(param: "disc") { [weak self] discs, error in
                guard let self = self else { return }
                if let error = error {
                    DispatchQueue.main.async {
                        self.showAlert()
                       // 111 AlertUtils.showSiteDownAlert(on: self) { self.loadDiscData() }
                    }
                    print("Error fetching data: \(error.localizedDescription)")
                } else if let discs = discs {
                    self.allDiscs = discs
                    self.saveAllDiscsToUserDefaults(discs)
                    for disc in discs {
                        self.brands.insert(disc.brand)
                    }
                    
                    DispatchQueue.main.async {
                        SwiftSpinner.hide()
                        self.collectionView.reloadData()
                    }
                }
            }
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
    
    @objc func getHelpTapped() {
            presentContactSupportAlert()
        // 111 AlertUtils.showSupportAlert(on: self)
        }

        private func presentContactSupportAlert() {
            let alertController = UIAlertController(title: "Support", message: "Would you like to contact support?", preferredStyle: .alert)
            
            let helpAction = UIAlertAction(title: "Contact Support", style: .default) { _ in
                self.navigateToHelpViewController()
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alertController.addAction(helpAction)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: nil)
        }

        private func navigateToHelpViewController() {
            let storyboard = UIStoryboard(name: "HelpView", bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: "helpVC") as? HelpViewController {
                vc.hidesBottomBarWhenPushed = true // Optional, if you want to hide the bottom bar
                navigationController?.pushViewController(vc, animated: true)
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
    
    @objc func refreshDiscList() {
        SwiftSpinner.show("Loading A Disc Golf Company List...", animated: true)
        fetchDiscsFromAPI()
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

