//
//  scatterPlot.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 3/12/24.
//

import SwiftUI

struct ScatterPlot: View {
  var discName: String
  var discSelectedColor: String
    var body: some View {
        VStack {
            Circle()
                .foregroundColor(Color(hex: discSelectedColor))
                .frame(width: 10, height: 10)
            Text(discName)
                .font(.caption2)
        }
    }
}
