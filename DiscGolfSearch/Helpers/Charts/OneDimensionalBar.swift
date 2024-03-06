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

    @State var data = DataUsageData.example

    @State private var showLegend = true
    
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
                        }
                        chart
                    }
                }

                customisation
            }
        }
    }

    private var chart: some View {
        Chart(data, id: \.stability) { disc in
            Plot {
                BarMark(
                    x: .value("Data Size", disc.numberOfDiscs)
                )
                .foregroundStyle(by: .value("Data Category", disc.stability))
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
                .background(Color(.systemFill))
                #endif
                .cornerRadius(8)
        }
        .accessibilityChartDescriptor(self)
        .chartXAxis(.hidden)
        .chartXScale(domain: 0...totalSize)
        .chartYScale(range: .plotDimension(endPadding: -8))
        .chartLegend(position: .bottom, spacing: 8)
        .chartLegend(showLegend ? .visible : .hidden)
        .frame(height: 50)
    }
    
    private var customisation: some View {
        Section {
            Toggle("Show Chart Legend", isOn: $showLegend)
        }
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
}

// MARK: - Preview

struct OneDimensionalBar_Previews: PreviewProvider {
    static var previews: some View {
        OneDimensionalBar(isOverview: true)
        OneDimensionalBar(isOverview: false)
    }
}
