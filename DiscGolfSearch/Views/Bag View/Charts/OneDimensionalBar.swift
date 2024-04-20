//
//  OneDimensionalBar.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 3/5/24.
//

import SwiftUI
import Charts

struct OneDimensionalBar: View {
    var isOverview: Bool
    var currentBagDiscs: [DiscDataModel]
    
    private var data: [DataUsageData.Series] {
        let customOrder: [String: Int] = [
            "Very Overstable": 0,
            "Overstable": 1,
            "Stable": 2,
            "Understable": 3,
            "Very Understable": 4
        ]
        
        let sortedDiscs = currentBagDiscs.sorted { disc1, disc2 in
            let order1 = customOrder[disc1.stability] ?? Int.max
            let order2 = customOrder[disc2.stability] ?? Int.max
            return order1 < order2
        }
        
        return sortedDiscs.map { disc in
            DataUsageData.Series(stability: disc.stability, numberOfDiscs: Double(currentBagDiscs.count))
        }
    }
    
    private var totalSize: Double {
        data
            .reduce(0) { $0 + $1.numberOfDiscs }
    }
    
    var body: some View {
        if isOverview {
            VStack {
                HStack {
                    Text("Total Bag Stability")
                    Spacer()
                }
                chart
            }
        } else {
            List {
                Section {
                    VStack {
                        HStack {
                            Text("Total Bag Stability")
                            Spacer()
                            Text("\(currentBagDiscs.count) discs in bag")
                                .foregroundColor(.secondary)
                        }
                        chart
                    }
                }
            }
        }
    }
    
    private var chart: some View {
        Chart(data, id: \.stability) { disc in
            Plot {
                BarMark(
                    x: .value("Data Size", disc.numberOfDiscs)
                )
                .foregroundStyle(by: .value("Data Category", changeStabilityName(stability: disc.stability)))
            }
            .accessibilityLabel(disc.stability)
            .accessibilityValue("\(disc.numberOfDiscs, specifier: "%.1f") GB")
            .accessibilityHidden(isOverview)
        }
        .chartPlotStyle { plotArea in
            plotArea
#if os(macOS)
                .background(Color.gray.opacity(0.2))
#else
                .background(Color(.black))
#endif
                .cornerRadius(8)
        }
        .accessibilityChartDescriptor(self)
        .chartXAxis(.hidden)
        .chartXScale(domain: 0...totalSize)
        .chartYScale(range: .plotDimension(endPadding: -8))
        .frame(height: 50)
    }
}

// MARK: - Accessibility

extension OneDimensionalBar: AXChartDescriptorRepresentable {
    func makeChartDescriptor() -> AXChartDescriptor {
        let min = data.map(\.numberOfDiscs).min() ?? 0
        let max = data.map(\.numberOfDiscs).max() ?? 0
        
        let xAxis = AXCategoricalDataAxisDescriptor(
            title: "Stability",
            categoryOrder: data.map { $0.stability }
        )
        
        let yAxis = AXNumericDataAxisDescriptor(
            title: "Number Of Discs",
            range: Double(min)...Double(max),
            gridlinePositions: []
        ) { value in "\(String(format:"%.2f", value)) GB" }
        
        let series = AXDataSeriesDescriptor(
            name: "Data Usage Example",
            isContinuous: false,
            dataPoints: data.map {
                .init(x: $0.stability, y: $0.numberOfDiscs)
            }
        )
        
        return AXChartDescriptor(
            title: "Data Usage by category",
            summary: nil,
            xAxis: xAxis,
            yAxis: yAxis,
            additionalAxes: [],
            series: [series]
        )
    }
    
    func changeStabilityName(stability: String) -> String {
        switch stability {
        case "Very Overstable":
            return "VO-Stable"
        case "Overstable":
            return "O-Stable"
        case "Stable":
            return "Stable"
        case "Understable":
            return "U-Stable"
        case "Very Understable":
            return "VU-Stable"
        default:
            return "O-Stable"
        }
    }
}
