//
//  ViewController.swift
//  StatusBarApp
//
//  Created by Ankit Kumar Bharti on 23/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    // MARK: - Properties
    @IBOutlet weak var dayLabel: NSTextField!
    @IBOutlet weak var tempLabel: NSTextField!
    @IBOutlet weak var weatherTypeImageView: NSImageView!
    @IBOutlet weak var weatherTypeLabel: NSTextField!
    
    lazy var weatherData: [Weather] = {
        return WeatherDataHelper.data()
    }()
    
    // MARK: - Controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer?.backgroundColor = CGColor(red: 0.27, green: 0.85, blue: 0.98, alpha: 1.0)
        guard let todayData = weatherData.first else { return }
        updateWeatherData(todayData)
    }
    
    // MARK: - Update Weather data
    fileprivate func updateWeatherData(_ weather: Weather) {
        dayLabel.stringValue = weather.day
        tempLabel.stringValue = weather.minTemp
        weatherTypeImageView.image = WeatherDataHelper.image(weather.type)
        weatherTypeLabel.stringValue = weather.type.rawValue
        guard let appDelegate = NSApplication.shared.delegate as? AppDelegate else { return }
        appDelegate.statusBarItem.button?.title = weather.minTemp
    }
    
    // MARK:- Quit app
    
    @IBAction func quitApplication(_ sender: Any) {
        NSApplication.shared.terminate(nil)
    }
}


// MARK: - NSCollectionViewDataSource
extension ViewController: NSCollectionViewDataSource {
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherData.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        guard let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "\(WeatherCell.self)"), for: indexPath) as? WeatherCell else { return NSCollectionViewItem() }
        item.configure(weather: weatherData[indexPath.item])
        return item
    }
}


// MARK: - NSCollectionViewDelegateFlowLayout
extension ViewController: NSCollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        return CGSize(width: 125.0, height: 125.0)
    }
}

// MARK: - NSCollectionViewDelegate
extension ViewController: NSCollectionViewDelegate {
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        guard let indexPath = indexPaths.first else { return }
        updateWeatherData(weatherData[indexPath.item])
    }
}
