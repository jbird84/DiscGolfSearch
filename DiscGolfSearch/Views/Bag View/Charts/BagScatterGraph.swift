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
    @State var areNamesShowing: Bool = true
    init(discs: [DiscDataModel], areNamesShowing: Bool) {
        self.discs = discs
        self.areNamesShowing = areNamesShowing
    }
    let xValues = stride(from: -5, to: 7, by: 1).map { $0 }
    let yValues = stride(from: 0, to: 15, by: 1).map { $0 }
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                HStack {
                    Text("Show Names")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding(.leading, 20)
                    Toggle("", isOn: $areNamesShowing)
                        .frame(width: 70, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Spacer()
                }
                Chart(discs) { savingModel in
                    PointMark(x: .value("Turn + Fade", (Double(savingModel.turn) ?? 0) + (Double(savingModel.fade) ?? 0)), y: .value("Speed", Double(savingModel.speed) ?? 0))
                        .foregroundStyle(Color(hex: savingModel.selectedColor))
                        .symbolSize(150)
                        .annotation {
                            if areNamesShowing {
                                Text("\(savingModel.name)")
                                    .font(.caption2)
                                    .foregroundStyle(Color(hex: savingModel.selectedColor))
                            }
                        }
                }
                .chartXAxis { AxisMarks(position: .bottom, values: xValues) }
                .foregroundStyle(Color.white)
                .chartYAxis{ AxisMarks(position: .leading, values: yValues) }
                .chartXAxisLabel(position: .top, alignment: .trailing) {
                    Text("Stability Fade + Glide")
                        .foregroundStyle(.white)
                        .padding(.trailing, 15)
                }
                .chartYAxisLabel(position: .leading, alignment: .bottom) { Text("Speed").foregroundStyle(.white) }
            }
        }
    }
}
