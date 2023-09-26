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
    let speed: String
    let glide: String
    let turn: String
    let fade: String
    let stability: String
    let link: String
    let pic: String
    let nameSlug: String
    let brandSlug: String
    let color: String
    let backgroundColor: String
    
    var displayedBrand: String {
        let brandMapping: [String: String] = [
            "Above Ground Level": "AGL",
            "Daredevil Discs": "Daredevil",
            "Disc Golf UK": "DG UK",
            "Dynamic Discs": "Dynamic",
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
    }
}
