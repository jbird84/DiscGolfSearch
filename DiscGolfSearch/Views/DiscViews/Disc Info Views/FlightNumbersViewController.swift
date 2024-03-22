//
//  FlightNumbersViewController.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 10/4/23.
//

import UIKit

class FlightNumbersViewController: UIViewController {
    
    
    @IBOutlet weak var flightNumberCategoryLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var flightDigit = 1
    
    // Combine the attributed strings with your descriptions
    private let speedDescription = """
    Speed is like the blazing velocity of a superhero in flight. 
    
    -Picture Speed 1 as a leisurely hero, strolling through the skies, while Speed 14 is the supersonic savior, streaking like lightning.
    
    -Speedy discs slice effortlessly through headwinds, but mastering their might requires finesse. On the other hand, gentler, slower discs don't mind a breeze; they're your steadfast allies in precision, especially when the wind has your back.
    
    -Novices, you'd be wise to wield the slower discs, for the swifter ones demand Herculean prowess.
    
    -So, choosing a disc is a bit like picking the right superhero for the job. Fast ones for long shots. It's all about having the perfect hero for each adventure on the disc golf course!
    """

    private let glideDescription = """
    Glide is akin to a disc's skyward stamina, reminiscent of an airborne behemoth. 
    
    -Certain discs are soaring champions, keeping lofty aspirations alive (Glide 7), while others surrender to gravity's embrace with haste (Glide 1).
    
    -Fresh-faced adventurers adore high-glide discs; they deliver impressive distances with minimal exertion. Yet when tempests rage, low-glide discs stand their ground like unwavering titans.
    
    -So, choosing a disc is a bit like picking the right superhero for the job. Choose high glide for big distances. It's all about having the perfect hero for each adventure on the disc golf course!
    """

    private let turnDescription = """
    Turn dictates the disc's mid-air dance, deciding whether it leans left or right during its flight. 
    
    -A disc donning a +1 rating boasts a straight-laced demeanor, refusing to waver from its path. Contrastingly, a -5 rating is a siren call to the rightward skies (for right-handed flyers), coaxing daring discs to dance on the ground.
    
    -Discs with -3 to -5 ratings are the acrobatic daredevils, tumbling and twirling.
    
    -Seeking precision amidst gusty winds? Opt for discs with conservative turns. But for the neophytes, discs with more turn are like a breeze to hurl.
    
    -So, choosing a disc is a bit like picking the right superhero for the job. Turn for curvy flights. It's all about having the perfect hero for each adventure on the disc golf course!
    """

    private let fadeDescription = """
    Fade mirrors a disc's show-stopping finale, akin to a superhero's grand exit. 
    
    -A disc bearing a 0 rating executes a dignified, straight-backed finale, akin to a triumphant mission accomplished.
    
    -In contrast, a disc crowned with a 5 rating stages a spectacular, dramatic leftward curtain call (for right-handed performers).
    
    -High-fade discs are the virtuosos, saving their flair for dazzling feats and tricky maneuvers. These are your go-to heroes when the shot needs that extra pizzazz.
    
    -So, choosing a disc is a bit like picking the right superhero for the job. Fade for epic finishes. It's all about having the perfect hero for each adventure on the disc golf course!
    """
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Update descriptionLabel based on flightDigit
        switch flightDigit {
        case 1:
            descriptionLabel.text = speedDescription
            flightNumberCategoryLabel.text = "SPEED (1 TO 14)"
        case 2:
            flightNumberCategoryLabel.text = "GLIDE (1 TO 7)"
            descriptionLabel.text = glideDescription
        case 3:
            flightNumberCategoryLabel.text = "TURN (+1 TO -5)"
            descriptionLabel.text = turnDescription
        case 4:
            flightNumberCategoryLabel.text = "FADE (0 TO 5)"
            descriptionLabel.text = fadeDescription
        default:
            // Handle other cases or provide a default description if needed
            descriptionLabel.text = "Invalid flightDigit"
            flightNumberCategoryLabel.text = ""
        }
    }
}
