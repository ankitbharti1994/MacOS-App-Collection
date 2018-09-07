//
//  CGRectExtension.swift
//  PieChartKit
//
//  Created by Ankit Kumar Bharti on 02/08/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import QuartzCore
import Cocoa

extension CGRect {
    var center: CGPoint {
        return CGPoint(x: midX, y: midY)
    }
}

extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}
