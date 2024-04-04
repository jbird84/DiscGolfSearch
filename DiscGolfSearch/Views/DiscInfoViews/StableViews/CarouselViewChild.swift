//
//  CarouselViewChild.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 4/3/24.
//

import SwiftUI

struct CarouselViewChild: View, Identifiable {
    var id: Int
    @ViewBuilder var content: any View
    var body: some View {
        ZStack {
            AnyView(content)
        }
    }
}

