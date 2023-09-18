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
    
    var selectedButton: UIButton? // To keep track of the selected button
    var selectedCompanyDiscs: [DiscGolfDisc] = []
    var filteredDiscs: [DiscGolfDisc] = []
    var selectedSpeed: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        self.title = "Select Your Disc Speed"
        oneToThreeSpeedButton.tag = 1
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
    
    @objc func buttonTapped(_ sender: UITapGestureRecognizer) {
        if let tappedButton = sender.view as? UIButton {
            
            // Reset the background color of the previously selected button
            selectedButton?.backgroundColor = .gray
            
            // Change the background color of the tapped button
            tappedButton.backgroundColor = .blue
            
            // Update the selected button reference
            selectedButton = tappedButton
            
            // Print the number corresponding to the tapped button's tag
            let speed = "\(tappedButton.tag)"
            filterDiscsBySpeed(speed)
            printPrettyResponse(discs: filteredDiscs)
        }
    }
    
    func filterDiscsBySpeed(_ speed: String) {
        selectedSpeed = speed
        
         filteredDiscs = selectedCompanyDiscs.filter({ disc in
            return disc.speed == speed
        })
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
        
        cell.companyNameLabel.text = disc.brand
        cell.discNameLabel.text = disc.name
        
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
}
