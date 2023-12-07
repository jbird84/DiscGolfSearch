//
//  Bag.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 11/12/23.
//

import UIKit
import SwiftData

struct BagDataModel {
    let id: Int64
    let bagHexColor: String
    let bagTitle: String
    let bagType: String
    let discs: [DiscGolfDisc]
    
    init(id: Int64, bagHexColor: String, bagTitle: String, bagType: String) {
        self.id = id
        self.bagHexColor = bagHexColor
        self.bagTitle = bagTitle
        self.bagType = bagType
        self.discs = []
    }
}
