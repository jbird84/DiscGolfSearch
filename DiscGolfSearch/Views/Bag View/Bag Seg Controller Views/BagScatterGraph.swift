//
//  BagScatterGraph.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 1/21/24.
//

import SwiftUI
import Charts
import Foundation

struct BagScatterGraph: View {
    var discs: [DiscDataModel] = []
  
    init(discs: [DiscDataModel]) {
            self.discs = discs
        }
    
    var body: some View {
        Chart(discs) { savingModel in
            PointMark(x: .value("Fade + Glide", savingModel.turn + savingModel.fade), y: .value("Speed", savingModel.speed))
                .foregroundStyle(Color(hex: savingModel.selectedColor))
                
        }
        .chartXAxisLabel(position: .top, alignment: .trailing) {
            Text("Stability Fade + Glide")
        }
        .chartYAxisLabel(position: .leading, alignment: .center) {
            Text("Speed")
                .rotationEffect(Angle(degrees: -360), anchor: .leading) // Rotate around the leading edge
                    .padding(.leading, 10) // Add some padding to prevent truncation
        }
    }
}
