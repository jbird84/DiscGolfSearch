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
    let xValues = stride(from: -5, to: 7, by: 1).map { $0 }
    let yValues = stride(from: 0, to: 15, by: 1).map { $0 }

    var body: some View {
        Chart(discs) { savingModel in
            PointMark(x: .value("Turn + Fade", (Double(savingModel.turn) ?? 0) + (Double(savingModel.fade) ?? 0)), y: .value("Speed", Double(savingModel.speed) ?? 0))
                .foregroundStyle(Color(hex: savingModel.selectedColor))
                .symbolSize(150)
                .annotation {
                    Text("\(savingModel.name)")
                        .font(.caption2)
                        .foregroundStyle(Color(hex: savingModel.selectedColor))
                                    }
        }
    
        .chartXAxis{
            AxisMarks(position: .bottom, values: xValues)
           }
        .chartYAxis{
               AxisMarks(position: .leading, values: yValues)
           }
        .chartXAxisLabel(position: .top, alignment: .trailing) {
            Text("Stability Fade + Glide")
               .padding(.trailing, 15)
        }

        .chartYAxisLabel(position: .leading, alignment: .bottom) {
            Text("Speed")
        }
    }
}
