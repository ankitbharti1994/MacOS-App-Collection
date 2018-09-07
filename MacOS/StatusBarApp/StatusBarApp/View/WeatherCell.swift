//
//  WeatherCell.swift
//  StatusBarApp
//
//  Created by Ankit Kumar Bharti on 23/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class WeatherCell: NSCollectionViewItem {

    @IBOutlet weak var dayLabel: NSTextField!
    @IBOutlet weak var minimumTempLabel: NSTextField!
    @IBOutlet weak var maximumTempLabel: NSTextField!
    @IBOutlet weak var weatherTypeImageView: NSImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.gray.cgColor.copy(alpha: 0.5)
        view.layer?.cornerRadius = 10.0
    }
    
    func configure(weather: Weather) {
        dayLabel.stringValue = weather.day
        minimumTempLabel.stringValue = weather.minTemp
        maximumTempLabel.stringValue = weather.maxTemp
        weatherTypeImageView.image = WeatherDataHelper.image(weather.type)
    }
}
