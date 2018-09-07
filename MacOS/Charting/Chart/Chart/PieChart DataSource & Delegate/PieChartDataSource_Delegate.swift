//
//  PieChartDataSource.swift
//  PieChartKit
//
//  Created by Ankit Kumar Bharti on 02/08/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

/// PieChartViewDataSource
@objc
protocol PieChartViewDataSource: class {
    @objc func numberOfSection(_ pieChartView: PieChartView) -> Int
    @objc func color(_ pieChartView: PieChartView, at section: Int) -> NSColor?
    @objc func data(pieChartView: PieChartView, at section: Int) -> Double
}

/// PieChartViewDelegate
@objc
protocol PieChartViewDelegate: class {
    @objc optional func sectionTitle(_ pieChartView: PieChartView, for section: Int) -> String?
    @objc optional func didSelect(section: Int, _ pieChartView: PieChartView)
}
