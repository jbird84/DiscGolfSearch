//
//  AnimationHelper.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 1/26/24.
//

import Foundation


import Lottie
import UIKit

class AnimationHelper {
    
    static let shared = AnimationHelper()
    
    private let discURLs: [String: [String: String]] = [
        "Above Ground Level": [
            "baobab":"https://storage.googleapis.com/disc-animation/AboveGroundLevel/BAOBAB_ABOVE%20GROUND%20LEVEL.json",
            "beech":"https://storage.googleapis.com/disc-animation/AboveGroundLevel/BEECH_ABOVE%20GROUND%20LEVEL.json",
            "cedar":"https://storage.googleapis.com/disc-animation/AboveGroundLevel/CEDAR_ABOVE%20GROUND%20LEVEL.json",
           // "douglas-fir":"https://imagizer.imageshack.com/img923/2956/guYiNY.png",
            "locust":"https://storage.googleapis.com/disc-animation/AboveGroundLevel/LOCUST_ABOVE%20GROUND%20LEVEL.json",
            //"madrone":"https://imagizer.imageshack.com/img922/7901/Ss5mfO.png",
            "magnolia":"https://storage.googleapis.com/disc-animation/AboveGroundLevel/MAGNOLIA_ABOVE%20GROUND%20LEVEL.json",
            //"manzanita":"https://imagizer.imageshack.com/img923/4905/uZDr3H.png",
            //"ponderosa":"https://imagizer.imageshack.com/img924/1954/SxLVjp.png",
            "redwood":"https://storage.googleapis.com/disc-animation/AboveGroundLevel/REDWOOD_ABOVE%20GROUND%20LEVEL.json",
            "spruce":"https://storage.googleapis.com/disc-animation/AboveGroundLevel/SPRUCE_ABOVE%20GROUND%20LEVEL.json",
            "sycamore":"https://storage.googleapis.com/disc-animation/AboveGroundLevel/SPRUCE_ABOVE%20GROUND%20LEVEL.json"
        ],
        "Axiom Discs": [
            "alias": "https://storage.googleapis.com/disc-animation/Axiom/ALIAS_AXIOM%20DISCS.json",
            "clash": "https://storage.googleapis.com/disc-animation/Axiom/CLASH_AXIOM%20DISCS.json",
            "crave": "https://storage.googleapis.com/disc-animation/Axiom/CRAVE_AXIOM%20DISCS.json",
            "defy": "https://storage.googleapis.com/disc-animation/Axiom/AXIOM%20DISCS_DEFY.json",
            //"delirium": "https://imagizer.imageshack.com/img924/2766/QiBcWc.png",
            //"envy": "https://imagizer.imageshack.com/img922/1839/tgDBcT.png",
            "excite": "https://storage.googleapis.com/disc-animation/Axiom/AXIOM%20DISCS_EXCITE.json",
            "fireball": "https://storage.googleapis.com/disc-animation/Axiom/AXIOM%20DISCS_FireBall.json",
            "hex": "https://storage.googleapis.com/disc-animation/Axiom/HEX_AXIOM%20DISCS.json",
            "insanity": "https://storage.googleapis.com/disc-animation/Axiom/AXIOM%20DISCS_INSANITY.json",
            "inspire": "https://storage.googleapis.com/disc-animation/Axiom/INSPIRE_AXIOM%20DISCS.json",
            "mayhem": "https://storage.googleapis.com/disc-animation/Axiom/AXIOM%20DISCS_MAYHEM.json",
            "panic": "https://storage.googleapis.com/disc-animation/Axiom/AXIOM%20DISCS_PANIC.json",
            "paradox": "https://storage.googleapis.com/disc-animation/Axiom/PARADOX_AXIOM%20DISCS.json",
           // "proxy": "",
            "pyro": "https://storage.googleapis.com/disc-animation/Axiom/PYRO_AXIOM%20DISCS.json",
            "rhythm": "https://storage.googleapis.com/disc-animation/Axiom/RHYTHM_AXIOM%20DISCS.json",
            "tantrum": "https://storage.googleapis.com/disc-animation/Axiom/AXIOM%20DISCS_TANTRUM.json",
            "tenacity": "https://storage.googleapis.com/disc-animation/Axiom/AXIOM%20DISCS_TENACITY.json",
            "theory": "https://storage.googleapis.com/disc-animation/Axiom/THEORY_AXIOM%20DISCS.json",
            "thrill": "https://storage.googleapis.com/disc-animation/Axiom/AXIOM%20DISCS_THRILL.json",
            "time-lapse": "https://storage.googleapis.com/disc-animation/Axiom/AXIOM%20DISCS_TIME-LAPSE.json",
            "trance": "https://storage.googleapis.com/disc-animation/Axiom/TRANCE_AXIOM%20DISCS.json",
            "vanish": "https://storage.googleapis.com/disc-animation/Axiom/AXIOM%20DISCS_VANISH.json",
            "virus": "https://storage.googleapis.com/disc-animation/Axiom/AXIOM%20DISCS_VIRUS.json",
            "wrath": "https://storage.googleapis.com/disc-animation/Axiom/AXIOM%20DISCS_WRATH.json"
        ]
    ]
    
    private init() {}
        
        func setupFlightPathAnimationView(discCompanyName: String, discName: String, animationView: LottieAnimationView, defaultImage: UIImage? = nil) {
            // Check if the disc company and disc name exist in the dictionary
            guard let companyDiscs = discURLs[discCompanyName],
                  let url = companyDiscs[discName] else {
                // Handle the case when the combination of disc company and disc name is not found
                if let defaultImage = defaultImage {
                    // Show the default image if provided
                    let imageView = UIImageView(image: defaultImage)
                    imageView.frame = animationView.bounds
                    animationView.addSubview(imageView)
                }
                return
            }
            
            // Load and play the animation using the obtained URL
            guard let animationURL = URL(string: url) else { return }
            
            LottieAnimation.loadedFrom(url: animationURL, closure: { animation in
                animationView.animation = animation
                animationView.contentMode = .scaleAspectFit
                animationView.loopMode = .loop
                animationView.animationSpeed = 1.0
                animationView.play()
            }, animationCache: DefaultAnimationCache.sharedCache)
        }
    }
