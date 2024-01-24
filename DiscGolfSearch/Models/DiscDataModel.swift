//
//  DiscDataModel.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 12/25/23.
//

import UIKit


struct DiscDataModel: Identifiable {
    let id: Int64
    let selectedColor: String
    let name: String
    let nameSlug: String
    let category: String
    let link: String
    let pic: String
    let plastic: String?
    let stability: String
    let speed: String
    let glide: String
    let turn: String
    let fade: String
    let brand: String
    let bagName: String
    let usedFor: String
    let weight: String?
    
    init(id: Int64, selectedColor: String, name: String, nameSlug: String, category: String, link: String, pic: String, plastic: String?, stability: String, speed: String, glide: String, turn: String, fade: String, brand: String, bagName: String, usedFor: String, weight: String?) {
        self.id = id
        self.selectedColor = selectedColor
        self.name = name
        self.nameSlug = nameSlug
        self.category = category
        self.link = link
        self.pic = pic
        self.plastic = plastic
        self.stability = stability
        self.speed = speed
        self.glide = glide
        self.turn = turn
        self.fade = fade
        self.brand = brand
        self.bagName = bagName
        self.usedFor = usedFor
        self.weight = weight
    }
}
