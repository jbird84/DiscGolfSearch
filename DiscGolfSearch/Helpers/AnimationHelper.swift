///Users/kinneykare/Downloads/CRAVE_AXIOM DISCS.json
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
            "sycamore":"https://storage.googleapis.com/disc-animation/AboveGroundLevel/SYCAMORE_ABOVE%20GROUND%20LEVEL.json"
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
        ],
        "Clash Discs": [
            "berry": "https://storage.googleapis.com/disc-animation/Clash%20Discs/Clash-Discs_BERRY.json",
            //"butter": "",
            //"candy": "",
            "cinnamon": "https://storage.googleapis.com/disc-animation/Clash%20Discs/Clash-Discs_CINNAMON.json",
            "cookie": "https://storage.googleapis.com/disc-animation/Clash%20Discs/Clash-Discs_COOKIE.json",
            //"fudge": "",
            "ginger": "https://storage.googleapis.com/disc-animation/Clash%20Discs/Clash-Discs_GINGER.json",
            "honey": "https://storage.googleapis.com/disc-animation/Clash%20Discs/Clash-Discs_HONEY.json",
            "lotus": "https://storage.googleapis.com/disc-animation/Clash%20Discs/Clash-Discs_LOTUS.json",
            "mango": "https://storage.googleapis.com/disc-animation/Clash%20Discs/Clash-Discs_MANGO.json",
            "mint": "https://storage.googleapis.com/disc-animation/Clash%20Discs/Clash-Discs_MINT.json",
            "peach": "https://storage.googleapis.com/disc-animation/Clash%20Discs/Clash-Discs_PEACH.json",
            "pepper": "https://storage.googleapis.com/disc-animation/Clash%20Discs/Clash-Discs_PEPPER.json",
            "peppermint": "https://storage.googleapis.com/disc-animation/Clash%20Discs/Clash-Discs_PEPPERMINT.json",
            //"popcorn": "",
            "salt": "https://storage.googleapis.com/disc-animation/Clash%20Discs/Clash-Discs_SALT.json",
            "soda": "https://storage.googleapis.com/disc-animation/Clash%20Discs/Clash-Discs_SODA.json",
            "spice": "https://storage.googleapis.com/disc-animation/Clash%20Discs/Clash-Discs_SPICE.json",
            "vanilla": "https://storage.googleapis.com/disc-animation/Clash%20Discs/Clash-Discs_VANILLA.json"
        ],
        "Daredevil Discs": [
            "albatross": "https://storage.googleapis.com/disc-animation/Daredevil%20Discs/Daredevil%20Discs_ALBATROSS.json",
            //"beaver": "",
            //"big-horn": "",
            "bigfoot": "https://storage.googleapis.com/disc-animation/Daredevil%20Discs/Daredevil%20Discs_BIGFOOT.json",
            "buffalo": "https://storage.googleapis.com/disc-animation/Daredevil%20Discs/Daredevil%20Discs_BUFFALO.json",
            "caribou": "https://storage.googleapis.com/disc-animation/Daredevil%20Discs/Daredevil%20Discs_CARIBOU.json",
            "grizzly": "https://storage.googleapis.com/disc-animation/Daredevil%20Discs/Daredevil%20Discs_GRIZZLY.json",
            "hellbender": "https://storage.googleapis.com/disc-animation/Daredevil%20Discs/Daredevil%20Discs_HELLBENDER.json",
            "hellbender-razorback": "https://storage.googleapis.com/disc-animation/Daredevil%20Discs/Daredevil%20Discs_HELLBENDER%20(RAZORBACK).json",
            "mammoth": "https://storage.googleapis.com/disc-animation/Daredevil%20Discs/Daredevil%20Discs_MAMMOTH.json",
            "merlin": "https://storage.googleapis.com/disc-animation/Daredevil%20Discs/Daredevil%20Discs_MERLIN.json",
            "moose": "https://storage.googleapis.com/disc-animation/Daredevil%20Discs/Daredevil%20Discs_MOOSE.json",
            "ogopogo": "https://storage.googleapis.com/disc-animation/Daredevil%20Discs/Daredevil%20Discs_OGOPOGO.json",
           // "owl": "",
           // "polar-bear": "",
            "sabertooth": "https://storage.googleapis.com/disc-animation/Daredevil%20Discs/Daredevil%20Discs_SABERTOOTH.json",
            "sasquatch": "https://storage.googleapis.com/disc-animation/Daredevil%20Discs/Daredevil%20Discs_SASQUATCH.json",
            "swift-fox": "https://storage.googleapis.com/disc-animation/Daredevil%20Discs/Daredevil%20Discs_SWIFT%20FOX.json",
            "timberwolf": "https://storage.googleapis.com/disc-animation/Daredevil%20Discs/Daredevil%20Discs_SWIFT%20FOX.json",
            "walrus": "https://storage.googleapis.com/disc-animation/Daredevil%20Discs/Daredevil%20Discs_TIMBERWOLF.json",
          //  "woodchuck": "",
            "wolverine": "https://storage.googleapis.com/disc-animation/Daredevil%20Discs/Daredevil%20Discs_WOLVERINE.json",
            "yeti": "https://storage.googleapis.com/disc-animation/Daredevil%20Discs/Daredevil%20Discs_YETI.json"
        ],
        "DGA": [
            "aftershock": "https://storage.googleapis.com/disc-animation/DGA/DGA_AFTERSHOCK.json",
            "avalanche": "https://storage.googleapis.com/disc-animation/DGA/DGA_AVALANCHE.json",
            "banzai": "https://storage.googleapis.com/disc-animation/DGA/DGA_BANZAI.json",
            //"blowfly": "",
            //"breaker": "",
            //"gumbputt": "",
            "hellfire": "https://storage.googleapis.com/disc-animation/DGA/DGA_HELLFIRE.json",
            "hurricane": "https://storage.googleapis.com/disc-animation/DGA/DGA_HURRICANE.json",
            "hypercane": "https://storage.googleapis.com/disc-animation/DGA/DGA_HYPERCANE.json",
            "pipeline": "https://storage.googleapis.com/disc-animation/DGA/DGA_PIPELINE.json",
            "quake": "https://storage.googleapis.com/disc-animation/DGA/DGA_QUAKE.json",
            //"reef": "",
            "rift": "https://storage.googleapis.com/disc-animation/DGA/DGA_RIFT.json",
            "riptide": "https://storage.googleapis.com/disc-animation/DGA/DGA_RIPTIDE.json",
            "rogue": "https://storage.googleapis.com/disc-animation/DGA/DGA_ROGUE.json",
            "sail": "https://storage.googleapis.com/disc-animation/DGA/DGA_SAIL.json",
            "shockwave": "https://storage.googleapis.com/disc-animation/DGA/DGA_SHOCKWAVE.json",
            "squall": "https://storage.googleapis.com/disc-animation/DGA/DGA_SQUALL.json",
          //  "steady": "",
          //  "steady-bl": "",
            "tempest": "https://storage.googleapis.com/disc-animation/DGA/DGA_TEMPEST.json",
    //        "titanic": "",
            "torrent": "https://storage.googleapis.com/disc-animation/DGA/DGA_TORRENT.json",
            "tremor": "https://storage.googleapis.com/disc-animation/DGA/DGA_TREMOR.json",
            "tsunami": "https://storage.googleapis.com/disc-animation/DGA/DGA_TSUNAMI.json",
            "undertow": "https://storage.googleapis.com/disc-animation/DGA/DGA_UNDERTOW.json",
            "vortex": "https://storage.googleapis.com/disc-animation/DGA/DGA_VORTEX.json"
        ]
    ]
    
    private init() {}
        
    func setupFlightPathAnimationView(currentDisc: DiscGolfDisc, discCompanyName: String, discName: String, animationView: LottieAnimationView) {
            // Check if the disc company and disc name exist in the dictionary
            guard let companyDiscs = discURLs[discCompanyName],
                  let url = companyDiscs[discName] else {
                // Handle the case when the combination of disc company and disc name is not found
                getFlightPathImageFromLink(disc: currentDisc) { image in
                    // Show the default image if provided
                    let imageView = UIImageView(image: image)
                    imageView.frame = animationView.bounds
                    animationView.addSubview(imageView)
                }
                return
            }
            
            // Load and play the animation using the obtained URL
            guard let animationURL = URL(string: url) else { return }
            DispatchQueue.main.async {
                LottieAnimation.loadedFrom(url: animationURL, closure: { animation in
                    animationView.animation = animation
                    animationView.contentMode = .scaleAspectFit
                    animationView.loopMode = .loop
                    animationView.animationSpeed = 1.5
                    animationView.play()
                }, animationCache: DefaultAnimationCache.sharedCache)
            }
        }
    
    //TODO: Replacce images wiht images relating to not getting a discPath back.
    private func getFlightPathImageFromLink(disc: DiscGolfDisc, completion: @escaping (UIImage?) -> Void) {
        let weblink = disc.pic
        if let imageURL = URL(string: weblink) {
            APIManager.shared.downloadImage(from: imageURL) { imageData in
                DispatchQueue.main.async {
                    if let imageData = imageData, let image = UIImage(data: imageData) {
                        completion(image)
                    } else {
                        print("Failed to create UIImage from image data")
                        completion(UIImage(named: "noDisc"))
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                print("Failed to create URL from web link")
                completion(UIImage(named: "nowLoadingBlankDisc"))
            }
        }
    }
    
    }
