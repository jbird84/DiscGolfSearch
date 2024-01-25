//
//  DiscViewController.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 9/16/23.
//

import UIKit
import Lottie

class DiscViewController: UIViewController {
    
    @IBOutlet weak var discNameLabel: UILabel!
    @IBOutlet weak var discImageView: UIImageView!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var glideLabel: UILabel!
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var fadeLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var discView: UIView!
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var flightRatingsSpeedLabel: UILabel!
    @IBOutlet weak var flightRatingsGlideLabel: UILabel!
    @IBOutlet weak var flightRatingsTurnLabel: UILabel!
    @IBOutlet weak var flightRatingsFadeLabel: UILabel!
    
    @IBOutlet weak var simularDiscsCollectionView: UICollectionView!
    
    //LottieView:
    @IBOutlet weak var discAnimationView: UIView!
    
    private lazy var animationView: LottieAnimationView = {
        let view = LottieAnimationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var dropDownView: AddDiscToView!
    
    var disc: DiscGolfDisc?
    var similarDiscs: [DiscGolfDisc] = []
    let flightDiscImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupFlightRatingsTapGestures()
        //setupFlightPathAnimationView()
        setupAnimationView()
        setupAddDiscToView()
        createSimilarDiscsCollection(disc: disc)
        // Add a "Select All" button to the navigation bar
        let selectAllButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addDiscTapped))
        navigationItem.rightBarButtonItem = selectAllButton
        navigationController?.navigationBar.backgroundColor = .clear
    }
    
    private func setupAddDiscToView() {
        dropDownView = Bundle.main.loadNibNamed("AddDiscToView", owner: nil, options: nil)!.first as? AddDiscToView
        
        dropDownView.delegate = self
        dropDownView.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(dropDownView)
        dropDownView.isHidden = true
        
        dropDownView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        dropDownView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 25).isActive = true
        dropDownView.widthAnchor.constraint(equalToConstant: 249).isActive = true
        dropDownView.heightAnchor.constraint(equalToConstant: 115).isActive = true
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
            discNameLabel.textColor = K.setDiscColorBasedOnStability(stability: K.Stability(rawValue: selectedDisc.stability) ?? .theDefault)
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
    
    private func setupFlightPathAnimationView() {
        
        guard let url = URL(string: "https://storage.googleapis.com/disc-animation/vibram-vice.json") else { return }
        
        LottieAnimation.loadedFrom(url: url, closure: { animation in
            self.animationView.animation = animation
            self.animationView.contentMode = .scaleAspectFit
            self.animationView.loopMode = .loop
            self.animationView.animationSpeed = 1.0
            self.animationView.play()
        }, animationCache: DefaultAnimationCache.sharedCache)
    }
    
    private func setupAnimationView() {
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.leadingAnchor.constraint(equalTo: discAnimationView.leadingAnchor, constant: 0),
            animationView.trailingAnchor.constraint(equalTo: discAnimationView.trailingAnchor, constant: 0),
            animationView.topAnchor.constraint(equalTo: discAnimationView.topAnchor, constant: 0),
            animationView.bottomAnchor.constraint(equalTo: discAnimationView.bottomAnchor, constant: 0)
        ])
    }
    
    private func setupFlightRatingsTapGestures() {
        let flightRatingsLabels = [flightRatingsSpeedLabel, flightRatingsGlideLabel, flightRatingsTurnLabel, flightRatingsFadeLabel]
        
        for (index, label) in flightRatingsLabels.enumerated() {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(flightRatingLabelTapped(_:)))
            label?.tag = index // Set a unique tag for each label
            label?.isUserInteractionEnabled = true
            label?.addGestureRecognizer(tapGesture)
        }
    }
    
    @objc private func addDiscTapped() {
        dropDownView.isHidden.toggle()
    }
    
    @objc private func flightRatingLabelTapped(_ sender: UITapGestureRecognizer) {
        guard let tappedLabel = sender.view as? UILabel else { return }
        
        switch tappedLabel.tag {
        case 0:
            // Speed label tapped
            navigateToFlightNumberViewController(with: 1)
        case 1:
            // Glide label tapped
            navigateToFlightNumberViewController(with: 2)
        case 2:
            // Turn label tapped
            navigateToFlightNumberViewController(with: 3)
        case 3:
            // Fade label tapped
            navigateToFlightNumberViewController(with: 4)
        default:
            break
        }
    }
    
    private func navigateToFlightNumberViewController(with flightDigit: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let flightNumberVC = storyboard.instantiateViewController(withIdentifier: "flight") as? FlightNumbersViewController {
            flightNumberVC.flightDigit = flightDigit
            navigationController?.pushViewController(flightNumberVC, animated: true)
        }
    }
    
    private func getImageFromLink(imageView: UIImageView, disc: DiscGolfDisc) {
        imageView.image = UIImage(named: "nowLoadingBlankDisc")
        if let webLink = DiscImageNames.webLink(for: disc.brand, disc: disc.nameSlug) {
            if let imageURL = URL(string: webLink) {
                APIManager.shared.downloadImage(from: imageURL) { imageData in
                    DispatchQueue.main.async {
                        if let imageData = imageData {
                            if let image = UIImage(data: imageData) {
                                imageView.image = image
                            } else {
                                print("Failed to create UIImage from image data")
                                imageView.image = UIImage(named: "noDisc")
                            }
                        } else {
                            print("Failed to download image")
                            imageView.image = UIImage(named: "noDisc")
                        }
                    }
                }
            } else {
                DispatchQueue.main.async {
                    print("Failed to create URL from web link")
                    imageView.image = UIImage(named: "nowLoadingBlankDisc")
                }
            }
        } else {
            DispatchQueue.main.async {
                imageView.image = UIImage(named: "noDisc")
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
        
        cell.similarDiscNameBottomLabel.text =  disc.name
        
        getImageFromLink(imageView: cell.discImageView, disc: disc)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        disc = similarDiscs[indexPath.item]
        
        DispatchQueue.main.async {
            self.createSimilarDiscsCollection(disc: self.disc)
           // self.setupFlightPathAnimationView()
        }
    }
}

extension DiscViewController: AddDiscToViewDelegate {
    func saveDiscToBag() {
        let storyboard = UIStoryboard(name: "AddDiscToBag", bundle: nil)
        
        if let vc = storyboard.instantiateViewController(withIdentifier: "addDiscToBagVC") as? AddDiscToBagViewController, let disc = disc {
            vc.disc = disc
            vc.hidesBottomBarWhenPushed = true 
            vc.overrideUserInterfaceStyle = .dark  // Set the overrideUserInterfaceStyle to .dark
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func saveDiscToSwiftData() {
        
        guard let disc = disc else {
            K.showAlertWithRetryOption(title: "Issues Getting Disc Data", message: "We ran into a problem attempting to get the disc's data.", presentingViewController: self) { [weak self] _ in
                guard let self else { return }
                self.saveDiscToSwiftData()
            }
            return
        }
        
        if let image = discImageView.image {
            if let imageData = image.pngData() {
                DiscDatabaseService.shared.saveDisc(discName: disc.name, discImageData: imageData, discStability: disc.stability, discSpeed: disc.speed, discGlide: disc.glide, discTurn: disc.turn, discFade: disc.fade, discBrand: disc.brand, viewController: self)
            }
        } else {
            K.showAlert(title: "Issues Saving Disc", message: "We ran into a problem attempting to save the disc.", presentingViewController: self)
        }
    }
    
    
    func dissmiss() {
        dropDownView.isHidden = true
    }
}
