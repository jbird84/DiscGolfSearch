//
//  DiscInBagInfoViewController.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 2/22/24.
//

import UIKit

class DiscInBagInfoViewController: UIViewController {
    
    @IBOutlet weak var stackView1: UIStackView!
    @IBOutlet weak var stackView2: UIStackView!
    @IBOutlet weak var stackView3: UIStackView!
    @IBOutlet weak var speedProgressBar: ProgressBar!
    @IBOutlet weak var glideProgressBar: ProgressBar!
    @IBOutlet weak var turnProgressBar: ProgressBar!
    @IBOutlet weak var fadeProgressBar: ProgressBar!
    
    var disc: DiscDataModel?
    var progressTimers: [ProgressBar: CGFloat] = [:]
    let timerInterval: TimeInterval = 0.1
    
    //Setup Views
    let discCompanyNameView = ImageHeaderSubheaderView()
    let discNameView = ImageHeaderSubheaderView()
    let discPlasticView = ImageHeaderSubheaderView()
    let discWeightView = ImageHeaderSubheaderView()
    let discTypeView = ImageHeaderSubheaderView()
    let usedForView = ImageHeaderSubheaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Disc Info"
        if let disc = disc {
            setupViewsForDisc(disc: disc)
            speedProgressBar.progressText = disc.speed
            glideProgressBar.progressText = disc.glide
            fadeProgressBar.progressText = disc.fade
            turnProgressBar.progressText = disc.turn
        }
        
        startProgressTimer(for: speedProgressBar)
        startProgressTimer(for: glideProgressBar)
        startProgressTimer(for: turnProgressBar)
        startProgressTimer(for: fadeProgressBar)
    }
    
    private func setupViewsForDisc(disc: DiscDataModel) {
   
        discCompanyNameView.configure(image: UIImage(systemName: "house.lodge.fill"), headerText: "Company", subheaderText: disc.brand)
        discNameView.configure(image: UIImage(systemName: "circle.fill"), headerText: "Name", subheaderText: disc.name)
        discPlasticView.configure(image: UIImage(systemName: "creditcard.fill"), headerText: "Plastic", subheaderText: disc.plastic ?? "No plastic specified.")
        discWeightView.configure(image: UIImage(systemName: "scalemass.fill"), headerText: "Weight", subheaderText: disc.weight ?? "No weight specified.")
        discTypeView.configure(image: UIImage(systemName: "scale.3d"), headerText: "Stability", subheaderText: disc.stability)
        
        usedForView.configure(image: UIImage(systemName: "signpost.right.and.left.fill"), headerText: "Primary Use", subheaderText: disc.usedFor)
        
        stackView1.addArrangedSubview(discCompanyNameView)
        stackView1.addArrangedSubview(discNameView)
        stackView2.addArrangedSubview(discPlasticView)
        stackView2.addArrangedSubview(discWeightView)
        stackView3.addArrangedSubview(discTypeView)
        stackView3.addArrangedSubview(usedForView)
    }
    
    func startProgressTimer(for progressBar: ProgressBar) {
        let timer = Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: true) { [weak self] timer in
            guard let self = self else {
                timer.invalidate()
                return
            }
            if let count = self.progressTimers[progressBar] {
                self.progressTimers[progressBar] = count + 1
                DispatchQueue.main.async {
                    progressBar.progress = min(0.03 * count, 1)
                    if progressBar.progress == 1 {
                        timer.invalidate()
                    }
                }
            }
        }
        progressTimers[progressBar] = 0
        timer.fire()
    }
}
