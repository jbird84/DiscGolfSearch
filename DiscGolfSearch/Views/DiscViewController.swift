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
        
        if let disc = disc {
            
            //Get current disc speed, glide turn and fade:
            guard let selectedSpeed = Double(disc.speed),
                  let selectedGlide = Double(disc.glide),
                  let selectedTurn = Double(disc.turn),
                  let selectedFade = Double(disc.fade) else {
                return
            }
            getImageFromLink(imageView: discImageView, disc: disc, cell: nil)
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
                        return abs(speed - selectedSpeed) <= 1 &&
                        abs(glide - selectedGlide) <= 1 &&
                        abs(turn - selectedTurn) <= 1 &&
                        abs(fade - selectedFade) <= 1
                    }
                    
                    // Now, you have a list of similar discs in the 'similarDiscs' array
                    // You can use this array to display the similar discs in your UI
                    print("SIMMMM \(similarDiscs.count)")
                }
            }
            
            discNameLabel.text = disc.name
            speedLabel.text = disc.speed
            glideLabel.text = disc.glide
            turnLabel.text = disc.turn
            fadeLabel.text = disc.fade
            
            startRotation()
            setupFlightDiscImageView()
            companyNameLabel.text = "By: \(disc.brand)"
        }
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
    
    private func getImageFromLink(imageView: UIImageView, disc: DiscGolfDisc, cell: DiscCell?) {
        if let webLink = DiscImageNames.webLink(for: disc.brand, disc: disc.nameSlug) {
            if let imageURL = URL(string: webLink) {
                APIManager.shared.downloadImage(from: imageURL) { imageData in
                    
                    DispatchQueue.main.async {
                        
                        if let imageData = imageData {
                            if let image = UIImage(data: imageData) {
                                imageView.image = image
                                cell?.companyNameLabel.text = ""
                                cell?.discNameLabel.text = ""
                                cell?.speedlabel.text = ""
                                cell?.glideLabel.text = ""
                                cell?.turnLabel.text = ""
                                cell?.fadeLabel.text = ""
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
        
        // Clear the image first
        cell.discImageView.image = UIImage(named: "blankDisc")
        cell.companyNameLabel.text = disc.displayedBrand
        cell.discNameLabel.text = disc.name
        cell.speedlabel.text = disc.speed
        cell.glideLabel.text = disc.glide
        cell.turnLabel.text = disc.turn
        cell.fadeLabel.text = disc.fade
        
        getImageFromLink(imageView: cell.discImageView, disc: disc, cell: cell)
            return cell
        
    }
}
