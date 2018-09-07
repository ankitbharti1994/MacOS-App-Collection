//
//  ViewController.swift
//  CocoaBinding001
//
//  Created by Ankit Kumar Bharti on 27/06/18.
//  Copyright © 2018 Ankit Kumar Bharti. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @objc dynamic private var redColor = 0 {
        didSet {
            prepareColor()
        }
    }
    @objc dynamic private var greenColor = 0 {
        didSet {
            prepareColor()
        }
    }
    @objc dynamic private var blueColor = 0 {
        didSet {
            prepareColor()
        }
    }
    
    @objc dynamic var rgbColor = NSColor(calibratedRed: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func prepareColor() {
        rgbColor = NSColor(calibratedRed: CGFloat(Double(redColor) / 255.0), green: CGFloat(Double(greenColor) / 255.0), blue: CGFloat(Double(blueColor) / 255.0), alpha: 1.0)
    }
}

