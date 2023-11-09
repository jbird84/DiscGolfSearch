//
//  DiscSwiftDataModel.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 11/5/23.
//

import UIKit
import SwiftData


@Model
class DiscSwiftDataModel {
    
    @Attribute(.unique) var id: String
    var name: String
    var imageData: Data
    var stability: String
    var speed: String
    var glide: String
    var turn: String
    var fade: String
    var brand: String
    
    init(id: String, name: String, imageData: Data, stability: String, speed: String, glide: String, turn: String, fade: String, brand: String) {
        self.id = id
        self.name = name
        self.imageData = imageData
        self.stability = stability
        self.speed = speed
        self.glide = glide
        self.turn = turn
        self.fade = fade
        self.brand = brand
    }
}
