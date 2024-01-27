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
               .padding(.trailing, 15)
        }

        .chartYAxisLabel(position: .leading, alignment: .trailing) {
            Text("Speed")
        }
    }
}
