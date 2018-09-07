//
//  ViewController.swift
//  Chart
//
//  Created by Ankit Kumar Bharti on 06/08/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    lazy var data: [ChartDataModel] = {
        return Database.chartData
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ViewController: PieChartViewDataSource {
    func numberOfSection(_ pieChartView: PieChartView) -> Int {
        return data.count
    }
    
    func color(_ pieChartView: PieChartView, at section: Int) -> NSColor? {
        return data[section].color
    }
    
    func data(pieChartView: PieChartView, at section: Int) -> Double {
        return data[section].value
    }
}

extension ViewController: PieChartViewDelegate {
    func didSelect(section: Int, _ pieChartView: PieChartView) {
        print("section \(section) selected with title: \(data[section].title)")
    }
    
    func sectionTitle(_ pieChartView: PieChartView, for section: Int) -> String? {
        return data[section].title
    }
}
