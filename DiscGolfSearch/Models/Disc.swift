//
//  Disc.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 9/10/23.
//

import Foundation


struct DiscGolfDisc: Codable {
    let id: String
    let name: String
    let brand: String
    let category: String
    var speed: String
    var glide: String
    var turn: String
    var fade: String
    let stability: String
    let link: String
    let pic: String
    let nameSlug: String
    let brandSlug: String
    let color: String
    let backgroundColor: String
    var usedFor: String? = "Backhand"
    var plasticType: String? = "N/A"
    var discWeight: String? = "0.0"
    var discColor: String? = "#FF0000"
    
    
    var displayedBrand: String {
        let brandMapping: [String: String] = [
            "Above Ground Level": "AGL",
            "Daredevil Discs": "Daredevil",
            "Disc Golf UK": "DG UK",
            "Dynamic Discs": "Dynamic",
            "Elevation Disc Golf": "Elevation",
            "Hooligan Discs": "Hooligan",
            "Infinite Discs": "Infinite",
            "Lone Star Discs": "Lone Star",
            "Loft Discs": "Loft",
            "Mint Discs": "Mint",
            "Westside Discs": "Westside",
            "Thought Space Athletics": "TSA",
            "Wild Discs": "Wild"
        ]
        
        return brandMapping[brand] ?? brand
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case brand
        case category
        case speed
        case glide
        case turn
        case fade
        case stability
        case link
        case pic
        case nameSlug = "name_slug"
        case brandSlug = "brand_slug"
        case color
        case backgroundColor = "background_color"
        case usedFor
        case plasticType
        case discWeight
        case discColor
    }
}
