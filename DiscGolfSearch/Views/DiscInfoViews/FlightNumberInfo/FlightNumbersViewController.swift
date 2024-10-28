//
//  FlightNumbersViewController.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 10/4/23.
//

import UIKit

struct FlightCharacteristic {
    let category: String
    let descriptions: [String]
}

class FlightNumbersViewController: UIViewController {
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    
    
    @IBOutlet weak var flightNumberCategoryLabel: UILabel!
    @IBOutlet var descriptionLabels: [UILabel]?
    var flightDigit = 1
    
    private let flightCharacteristics: [FlightCharacteristic] = [
        FlightCharacteristic(category: "SPEED (1 TO 14)", descriptions: [
            "Speed tells you how fast a disc can travel through the air when you throw it.",
            "Imagine throwing a ball. Some balls go really fast (like a baseball), while others go slower (like a soft, squishy ball). In disc golf, speed numbers usually range from 1 to 14. A disc with a speed of 5 is slower than one with a speed of 12.",
            "If you want your disc to fly far, you need one with a higher speed. It’s like choosing between a regular car and a race car: the race car goes much faster!"
        ]),
        FlightCharacteristic(category: "GLIDE (1 TO 7)", descriptions: [
            "Glide tells you how well a disc stays up in the air after you throw it.",
            "Think about how some objects float easily, like a feather, while others fall quickly, like a rock. Glide numbers range from 1 to 7. A disc with a glide of 6 will stay in the air longer than one with a glide of 2.",
            "If you want your disc to sail through the air smoothly and not drop quickly, you want a disc with good glide. It’s like a bird soaring on the wind—high glide helps the disc stay up longer!"
        ]),
        FlightCharacteristic(category: "TURN (+1 TO -5)", descriptions: [
            "Turn shows how much the disc will curve to the right right after you throw it (if you’re throwing with your right hand).",
            "Think of it like steering a bike. If you turn the handlebars, the bike goes in that direction. Turn numbers can be negative (like -3) or positive (like +1). A disc with a negative turn (like -2) will start turning to the right more than one with a 0 or positive turn.",
            "If you want your disc to fly straight, you’ll want a lower turn number. If you want it to curve to the right, you’d pick a disc with a higher negative turn. It helps you decide how to throw and where you want the disc to go!"
        ]),
        FlightCharacteristic(category: "FADE (0 TO 5)", descriptions: [
            "Fade tells you how much the disc will hook to the left at the end of its flight.",
            "Imagine if you threw a ball straight, but then it suddenly curved to the left before it landed. Fade numbers range from 0 to 5. A disc with a fade of 5 will hook left a lot, while one with a fade of 1 will hardly curve at all.",
            "If you want your disc to go straight and then gently curve left at the end, you’d choose one with a little fade. If you want a sharp turn left, you’d pick one with a strong fade."
        ])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateFlightCharacteristics()
    }
    
    private func updateFlightCharacteristics() {
        view1.layer.cornerRadius = 10 // Set the corner radius
        view1.layer.masksToBounds = true // Clip the content to the bounds of the view
        view2.layer.cornerRadius = 10 // Set the corner radius
        view2.layer.masksToBounds = true // Clip the content to the bounds of the view
        view3.layer.cornerRadius = 10 // Set the corner radius
        view3.layer.masksToBounds = true // Clip the content to the bounds of the view
        
        guard let descriptionLabels = descriptionLabels else {
            return
        }
        guard flightDigit >= 1 && flightDigit <= flightCharacteristics.count else {
            descriptionLabels.forEach { $0.text = "Invalid flightDigit" }
            flightNumberCategoryLabel.text = ""
            return
        }
        
        let characteristic = flightCharacteristics[flightDigit - 1]
        flightNumberCategoryLabel.text = characteristic.category
        for (index, description) in characteristic.descriptions.enumerated() {
            descriptionLabels[index].text = description
            descriptionLabels[index].layer.cornerRadius = 10
            descriptionLabels[index].layer.masksToBounds = true
        }
    }
}
