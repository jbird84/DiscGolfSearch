//
//  DiscInBagInfoViewController.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 2/22/24.
//

import UIKit

class DiscInBagInfoViewController: UIViewController {
    
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var discLabel: UILabel!
    @IBOutlet weak var plasticLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var speedProgressBar: ProgressBar!
    @IBOutlet weak var glideProgressBar: ProgressBar!
    @IBOutlet weak var turnProgressBar: ProgressBar!
    @IBOutlet weak var fadeProgressBar: ProgressBar!
    
    var disc: DiscDataModel?
    var progressTimers: [ProgressBar: CGFloat] = [:]
    let timerInterval: TimeInterval = 0.1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let disc = disc {
            companyLabel.text = disc.brand
            discLabel.text = disc.name
            plasticLabel.text = disc.plastic ?? "NA"
            weightLabel.text = disc.weight ?? "NA"
            typeLabel.text = disc.stability
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
