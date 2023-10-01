//
//  DiscViewController.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 9/16/23.
//

import UIKit

class DiscViewController: UIViewController {
    
    @IBOutlet weak var discNameLabel: UILabel!
    @IBOutlet weak var discImageView: UIImageView!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var glideLabel: UILabel!
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var fadeLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var discView: UIView!
        
    @IBOutlet weak var simularDiscsCollectionView: UICollectionView!
    
    var disc: DiscGolfDisc?
    var similarDiscs: [DiscGolfDisc] = []
    let flightDiscImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createSimilarDiscsCollection(disc: disc)
    }

    
    private func setupCollectionView() {
        simularDiscsCollectionView.dataSource = self
        simularDiscsCollectionView.delegate = self
        
        let flowLayout = UICollectionViewFlowLayout()
        
        // Set the scroll direction to horizontal
        flowLayout.scrollDirection = .horizontal
        
        // Calculate the item width based on your desired width
        let itemWidth: CGFloat = 200.0 // Adjust this value to your preferred width
        
        flowLayout.itemSize = CGSize(width: itemWidth, height: simularDiscsCollectionView.frame.height)
        flowLayout.minimumInteritemSpacing = 10.0 // Adjust spacing between items
        
        simularDiscsCollectionView.collectionViewLayout = flowLayout
    }
    
    private func setupFlightDiscImageView() {
        flightDiscImageView.image = UIImage(named: "blankDisc")
        discImageView.frame = CGRect(x: 0, y: -150, width: 50, height: 50) // Set the initial frame
        view.addSubview(flightDiscImageView)
        
        // Create the flight path
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 50, y: 200)) // Start point
        path.addQuadCurve(to: CGPoint(x: 300, y: 200), controlPoint: CGPoint(x: 175, y: 0)) // Quad curve
        
        // Create the animation
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = path.cgPath
        animation.duration = 30.0 // Duration of the animation
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        
        // Add rotation animation
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = 0
        rotationAnimation.toValue = 2.0 * .pi
        rotationAnimation.duration = 5.0
        rotationAnimation.repeatCount = .infinity
        
        // Apply animations to the disc image view's layer
        flightDiscImageView.layer.add(animation, forKey: "flightPathAnimation")
        flightDiscImageView.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
    
    private func createSimilarDiscsCollection(disc: DiscGolfDisc?) {
        if let selectedDisc = disc {
            
            //Get current disc speed, glide turn and fade:
            guard let selectedSpeed = Double(selectedDisc.speed),
                  let selectedGlide = Double(selectedDisc.glide),
                  let selectedTurn = Double(selectedDisc.turn),
                  let selectedFade = Double(selectedDisc.fade) else {
                return
            }
            getImageFromLink(imageView: discImageView, disc: selectedDisc)
            // Load the stored discs from UserDefaults
            if let savedDiscsData = UserDefaults.standard.data(forKey: "allDiscs") {
                if let allDiscs = try? JSONDecoder().decode([DiscGolfDisc].self, from: savedDiscsData) {
                    // Filter the discs based on the selected disc's values (+1 or -1)
                    similarDiscs = allDiscs.filter { disc in
                        
                        guard let speed = Double(disc.speed),
                              let glide = Double(disc.glide),
                              let turn = Double(disc.turn),
                              let fade = Double(disc.fade) else {
                            return false
                        }
                        
                        // Check if the values are within +/- 1 of the selected disc
                        let isSimilarFlight =
                        abs(speed - selectedSpeed) <= 1 &&
                        abs(glide - selectedGlide) <= 1 &&
                        abs(turn - selectedTurn) <= 1 &&
                        abs(fade - selectedFade) <= 1
                        
                        //Chck to make sure discs have same stability
                        let isSameStability = disc.stability == selectedDisc.stability
                        
                        //Check to make sure current disc does not appear in the simular discs collection.
                        let isSelectedDiscName = disc.name == selectedDisc.name
                        
                        //return the simular discs collection
                        return isSimilarFlight && isSameStability && !isSelectedDiscName
                    }
                    
                    // Now, you have a list of similar discs in the 'similarDiscs' array
                    // You can use this array to display the similar discs in your UI
                    print("SIMMMM \(similarDiscs.count)")
                }
            }
            
            discNameLabel.text = selectedDisc.name
            speedLabel.text = selectedDisc.speed
            glideLabel.text = selectedDisc.glide
            turnLabel.text = selectedDisc.turn
            fadeLabel.text = selectedDisc.fade
            
            startRotation()
            setupFlightDiscImageView()
            companyNameLabel.text = "By: \(selectedDisc.brand)"
        }
  
            self.simularDiscsCollectionView.reloadData()
        
        // Scroll to the first item
           if similarDiscs.count > 0 {
               let indexPath = IndexPath(item: 0, section: 0)
               simularDiscsCollectionView.scrollToItem(at: indexPath, at: .left, animated: false)
           }
    }
    
    private func getImageFromLink(imageView: UIImageView, disc: DiscGolfDisc) {
        if let webLink = DiscImageNames.webLink(for: disc.brand, disc: disc.nameSlug) {
            if let imageURL = URL(string: webLink) {
                APIManager.shared.downloadImage(from: imageURL) { imageData in
                    
                    DispatchQueue.main.async {
                        
                        if let imageData = imageData {
                            if let image = UIImage(data: imageData) {
                                imageView.image = image
                                
                                
                            } else {
                                print("Failed to create UIImage from image data")
                                
                            }
                            
                        } else {
                            print("Failed to download image")
                        }
                    }
                }
                
            } else {
                imageView.image = UIImage(named: "blankDisc")
                
            }
            
        } else {
            imageView.image = UIImage(named: "nowLoadingBlankDisc")
            
        }
       
    }
    
    private func startRotation() {
        // Create a CABasicAnimation for continuous rotation
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        
        // Set the animation properties
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = CGFloat.pi * 2.0 // Full circle (360 degrees)
        rotationAnimation.duration = 50.0 // Duration of one full rotation in seconds
        rotationAnimation.repeatCount = .infinity // Repeat indefinitely
        
        // Add the animation to the image view's layer
        discView.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
}


extension DiscViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return similarDiscs.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "discCell", for: indexPath) as! DiscCell
        
        let disc = similarDiscs[indexPath.item]
        
        cell.similarDiscNameBottomLabel.text =  disc.name
        
        getImageFromLink(imageView: cell.discImageView, disc: disc)
            return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let disc = similarDiscs[indexPath.item]
        
        DispatchQueue.main.async {
            self.createSimilarDiscsCollection(disc: disc)
        }
    }
}
