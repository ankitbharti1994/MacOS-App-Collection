//
//  Database.swift
//  PieChartKit
//
//  Created by Ankit Kumar Bharti on 03/08/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Foundation

struct Database {
    static var chartData : [ChartDataModel] {
        return [ChartDataModel(color: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), title: "Blue", value: 1000.0),
                ChartDataModel(color: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), title: "Sky Blue", value: 150.0),
                ChartDataModel(color: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), title: "Red", value: 800.0),
                ChartDataModel(color: #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1), title: "Green", value: 240.0)
                ]
    }
}
