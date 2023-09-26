//
//  DiscListViewController.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 9/14/23.
//

import UIKit

class DiscListViewController: UIViewController {
    
    @IBOutlet weak var oneToThreeSpeedButton: UIButton!
    @IBOutlet weak var fourSpeedButton: UIButton!
    @IBOutlet weak var fiveSpeedButton: UIButton!
    @IBOutlet weak var sixSpeedButton: UIButton!
    @IBOutlet weak var sevenSpeedButton: UIButton!
    @IBOutlet weak var eightSpeedButton: UIButton!
    @IBOutlet weak var nineSpeedButton: UIButton!
    @IBOutlet weak var tenSpeedButton: UIButton!
    @IBOutlet weak var elevenSpeedButton: UIButton!
    @IBOutlet weak var twelveSpeedButton: UIButton!
    @IBOutlet weak var thirteenSpeedButton: UIButton!
    @IBOutlet weak var fourteenSpeedButton: UIButton!
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var discTypesView: UIView?
    var selectedButton: UIButton? // To keep track of the selected button
    var selectedCompanyDiscs: [DiscGolfDisc] = []
    var filteredDiscs: [DiscGolfDisc] = []
    var selectedSpeed: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupCollectionView()
        oneToThreeSpeedButton.tag = 3
        fourSpeedButton.tag = 4
        fiveSpeedButton.tag = 5
        sixSpeedButton.tag = 6
        sevenSpeedButton.tag = 7
        eightSpeedButton.tag = 8
        nineSpeedButton.tag = 9
        tenSpeedButton.tag = 10
        elevenSpeedButton.tag = 11
        twelveSpeedButton.tag = 12
        thirteenSpeedButton.tag = 13
        fourteenSpeedButton.tag = 14
        
        let buttons = [
            oneToThreeSpeedButton,
            fourSpeedButton,
            fiveSpeedButton,
            sixSpeedButton,
            sevenSpeedButton,
            eightSpeedButton,
            nineSpeedButton,
            tenSpeedButton,
            elevenSpeedButton,
            twelveSpeedButton,
            thirteenSpeedButton,
            fourteenSpeedButton
        ]
        
        for button in buttons {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(buttonTapped(_:)))
            button?.addGestureRecognizer(tapGesture)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    @objc func toggleDiscTypesView(_ sender: UIBarButtonItem) {
        if discTypesView == nil {
            // Load the DiscTypes.xib view if it's not already loaded
            if let loadedView = Bundle.main.loadNibNamed("DiscTypes", owner: self, options: nil)?.first as? UIView {
                discTypesView = loadedView
                
                // Calculate the width as the screen width minus 20
                let viewWidth = 139
                let viewHeight = 556
                
                let screenWidth = UIScreen.main.bounds.width
                
                // Calculate the y-coordinate to be 5 points below the navigation bar
                var y: CGFloat = 0.0
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                    let statusBarManager = windowScene.statusBarManager
                    y = (statusBarManager?.statusBarFrame.height ?? 0) + 40
                }
                
                // Set the frame for the discTypesView
                discTypesView?.frame = CGRect(
                    x: Int(screenWidth - 150), // Center horizontally
                    y: Int(y), // Center vertically
                    width: viewWidth,
                    height: viewHeight
                )
                discTypesView?.layer.cornerRadius = 20
                view.addSubview(discTypesView!)
            }
        } else {
            // Toggle the visibility of the DiscTypes.xib view
            discTypesView?.isHidden = !discTypesView!.isHidden
        }
    }
    
    @objc func buttonTapped(_ sender: UITapGestureRecognizer) {
            if let tappedButton = sender.view as? UIButton {
                if tappedButton != selectedButton {
                    // A different button is tapped, unselect the currently selected button
                    selectedButton?.isSelected = false
                }
                
                // Toggle the selection of the tapped button
                tappedButton.isSelected.toggle()
                
                // Update the selected button reference
                selectedButton = tappedButton
                
                if tappedButton.isSelected {
                    // Button is selected, filter discs based on speed
                    let speed = "\(tappedButton.tag)"
                    filterDiscsBySpeed(speed)
                } else {
                    // Button is unselected, show all discs
                    selectedSpeed = nil
                    filteredDiscs = selectedCompanyDiscs
                }
                
                collectionView.reloadData()
                printPrettyResponse(discs: filteredDiscs)
            }
        }
    
    func filterDiscsBySpeed(_ speed: String) {
        selectedSpeed = speed

        if speed == "3" {
            filteredDiscs = selectedCompanyDiscs.filter { disc in
                return disc.speed == "1" || disc.speed.hasPrefix("2") || disc.speed.hasPrefix("3")
            }
        } else {
            filteredDiscs = selectedCompanyDiscs.filter { disc in
                return disc.speed.hasPrefix(speed)
            }
        }

        collectionView.reloadData()
    }
    
    func printPrettyResponse(discs: [DiscGolfDisc]) {
        for disc in discs {
            print("Disc Name: \(disc.name)")
            print("Brand: \(disc.brand)")
            print("Category: \(disc.category)")
            print("Speed: \(disc.speed)")
            // Add more properties as needed
            print("------")
        }
    }
    
    private func resetButtons() {
        let buttons = [
            oneToThreeSpeedButton,
            fourSpeedButton,
            fiveSpeedButton,
            sixSpeedButton,
            sevenSpeedButton,
            eightSpeedButton,
            nineSpeedButton,
            tenSpeedButton,
            elevenSpeedButton,
            twelveSpeedButton,
            thirteenSpeedButton,
            fourteenSpeedButton
        ]
        
        for button in buttons {
            button?.isSelected = false
        }
    }
    
    private func setupNavBar() {
        let toggleButton = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .done, target: self, action: #selector(toggleDiscTypesView(_ :)))
        self.title = "Select Your Disc Speed"
        
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        }
        navigationItem.rightBarButtonItem = toggleButton
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let flowLayout = UICollectionViewFlowLayout()
        let padding: CGFloat = 5.0
        
        // Calculate the item width based on the screen width minus the padding
        let itemWidth = (view.frame.width - 3 * padding) / 2
        
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth) // Set the item size to create two columns
        flowLayout.minimumInteritemSpacing = padding
        flowLayout.minimumLineSpacing = padding
        flowLayout.sectionInset = UIEdgeInsets(top: 3, left: padding, bottom: 0, right: padding)
        
        collectionView.collectionViewLayout = flowLayout
    }
}

extension DiscListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredDiscs.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "discCell", for: indexPath) as! DiscCell
        
        let disc = filteredDiscs[indexPath.item]
        
        cell.companyNameLabel.text = disc.displayedBrand
        cell.discNameLabel.text = disc.name
        cell.speedlabel.text = disc.speed
        cell.glideLabel.text = disc.glide
        cell.turnLabel.text = disc.turn
        cell.fadeLabel.text = disc.fade
        
        if let stability = Stability(rawValue: disc.stability) {
            cell.discImageView.image = UIImage(named: "blankDisc")?.withTintColor(setDiscColorBasedOnStability(stability: stability), renderingMode: .alwaysOriginal)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let disc = filteredDiscs[indexPath.item]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "discVC") as? DiscViewController {
            vc.disc = disc
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func setDiscColorBasedOnStability(stability: Stability) -> UIColor {
        switch stability {
        case .veryOverstable:
            return UIColor.systemBlue
        case .overstable:
            return UIColor.systemGreen
        case .stable:
            return UIColor.systemOrange
        case .understable:
            return UIColor.systemRed
        case .veryUnderstable:
            return UIColor.systemTeal
        }
    }
    
    enum Stability: String {
        case veryOverstable = "Very Overstable"
        case overstable = "Overstable"
        case stable = "Stable"
        case understable = "Understable"
        case veryUnderstable = "Very Understable"
    }
}
