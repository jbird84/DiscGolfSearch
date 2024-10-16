//
//  Bag.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 11/12/23.
//

import UIKit

struct BagDataModel {
    let id: Int64
    let bagHexColor: String
    let bagTitle: String
    let bagType: String
    
    init(id: Int64, bagHexColor: String, bagTitle: String, bagType: String) {
        self.id = id
        self.bagHexColor = bagHexColor
        self.bagTitle = bagTitle
        self.bagType = bagType
    }
}
