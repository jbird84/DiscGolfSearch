//
//  Bag.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 11/12/23.
//

import UIKit
import SwiftData


@Model
class BagSwiftDataModel {
    @Attribute(.unique) var id: String
    var bagHexColor: String
    var bagTitle: String
    var bagType: String
    var discs: [DiscGolfDisc] = []
    
    init(id: String, bagHexColor: String, bagTitle: String, bagType: String) {
        self.id = id
        self.bagHexColor = bagHexColor
        self.bagTitle = bagTitle
        self.bagType = bagType
    }
}
