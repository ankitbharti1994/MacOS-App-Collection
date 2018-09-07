//
//  WeatherDataHelper.swift
//  StatusBarApp
//
//  Created by Ankit Kumar Bharti on 23/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

struct WeatherDataHelper {
    
    static func data() -> [Weather] {
        return [Weather(day: "Today", type: .clear, minTemp: "22 °", maxTemp: "30 °"),
                Weather(day: "Tomorrow", type: .clouds, minTemp: "20 °", maxTemp: "30 °"),
                Weather(day: "25 July", type: .partially_cloudy, minTemp: "24 °", maxTemp: "33 °"),
                Weather(day: "26 July", type: .rain, minTemp: "22 °", maxTemp: "34 °"),
                Weather(day: "27 July", type: .clear, minTemp: "26 °", maxTemp: "34 °"),
                Weather(day: "28 July", type: .snow, minTemp: "24 °", maxTemp: "32 °"),
                Weather(day: "29 July", type: .thunderstorm, minTemp: "18 °", maxTemp: "30 °")]
    }
    
    static func image(_ type: WeatherType) -> NSImage {
        switch type {
        case .clear:
            return #imageLiteral(resourceName: "Clear")
        case .clouds:
            return #imageLiteral(resourceName: "Clouds")
        case .partially_cloudy:
            return #imageLiteral(resourceName: "Partially Cloudy")
        case .rain:
            return #imageLiteral(resourceName: "Rain")
        case .snow:
            return #imageLiteral(resourceName: "Snow")
        case .thunderstorm:
            return #imageLiteral(resourceName: "Thunderstorm")
        }
    }
}
