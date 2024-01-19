//
//  BagScatterGraphView.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 1/18/24.
//

import UIKit
import DGCharts

class ScatterChart: UIView {
    
    var chartView: ScatterChartView!
    var discs: [DiscDataModel] = [] {
            didSet {
                updateChartData()
            }
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func updateChartData() {
        // Create entries for each disc
        var entries: [ChartDataEntry] = []
        
        for (index, disc) in discs.enumerated() {
            let entry = ChartDataEntry(x: (Double(disc.turn) ?? 0) + (Double(disc.fade) ?? 0), y: Double(disc.speed) ?? 0)
            entries.append(entry)
        }
        
        // Create a ScatterChartDataSet
        let dataSet = ScatterChartDataSet(entries: entries, label: "Discs")
        dataSet.setScatterShape(.circle)
        dataSet.scatterShapeSize = 12
        dataSet.colors = discs.map { UIColor(hex: $0.selectedColor) }
        dataSet.valueTextColor = .systemPink
        
        // Create a ScatterChartData
        let data = ScatterChartData(dataSet: dataSet)
        
        // Apply the data to the chart
        chartView.data = data
        
//        for set in chartView.data! {
//            set.drawValuesEnabled = !set.drawValuesEnabled
//        }
        
    }
    
    private func setupView() {
        // Initialize ScatterChartView once
        chartView = ScatterChartView(frame: bounds)
        addSubview(chartView)
        
        // Add constraints to fill the parent view
        chartView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chartView.topAnchor.constraint(equalTo: topAnchor),
            chartView.leadingAnchor.constraint(equalTo: leadingAnchor),
            chartView.trailingAnchor.constraint(equalTo: trailingAnchor),
            chartView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        // Configure the Y-axis for Speed (ranging from 1 to 16)
        let yAxis = chartView.leftAxis
        yAxis.axisMinimum = 0
        yAxis.axisMaximum = 16
        yAxis.labelCount = 16
        yAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
        yAxis.drawGridLinesEnabled = true
        // Set Y-axis title
        addAxisTitle(labelText: "Speed", isXAxis: false)
        chartView.rightAxis.enabled = false
        
        // Configure the X-axis for Stability (ranging from -5 to 5)
        let xAxis = chartView.xAxis
        xAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
        xAxis.axisMinimum = -5.0
        xAxis.axisMaximum = 5.0
        xAxis.labelCount = 10
        xAxis.drawGridLinesEnabled = true
        // Set X-axis title
        addAxisTitle(labelText: "Stability (Turn + Fade)", isXAxis: true)
        
        updateChartData()
        
        chartView.chartDescription.text = "Disc Golf Discs Chart"
        chartView.legend.enabled = false
    }
    
    private func addAxisTitle(labelText: String, isXAxis: Bool) {
        let label = UILabel()
        label.text = labelText
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.sizeToFit()
        
        if isXAxis {
            label.center = CGPoint(x: frame.size.width / 2, y: frame.size.height - label.frame.size.height / 2)
        } else {
            label.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
            label.frame.origin.y = (frame.size.height) / 3
            label.frame.origin.x = -6
        }
        
        addSubview(label)
    }
}
