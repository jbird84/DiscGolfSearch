//
//  ChartData.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 3/5/24.
//

import UIKit


struct DataUsageData {
    /// A data series for the bars.
    struct Series: Identifiable {
        /// Data Group.
        let stability: String

        /// Size of data in gigabytes?
        let numberOfDiscs: Double

        /// The identifier for the series.
        var id: String { stability }
    }

    static let example: [Series] = [
        .init(stability: "Overstable", numberOfDiscs: 7),
        .init(stability: "Very Overstable", numberOfDiscs: 3),
        .init(stability: "Stable", numberOfDiscs: 2),
        .init(stability: "Understable", numberOfDiscs: 3),
        .init(stability: "Very Understable", numberOfDiscs: 0)
    ]
}
