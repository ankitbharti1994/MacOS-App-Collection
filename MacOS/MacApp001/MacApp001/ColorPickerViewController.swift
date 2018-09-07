//
//  ColorPickerViewController.swift
//  MacApp001
//
//  Created by Ankit Kumar Bharti on 26/06/18.
//  Copyright © 2018 Ankit Kumar Bharti. All rights reserved.
//

import Cocoa

class ColorPickerViewController: NSViewController {

    @IBOutlet weak var redSlider: NSSlider!
    @IBOutlet weak var greenSlider: NSSlider!
    @IBOutlet weak var blueSlider: NSSlider!
    @IBOutlet weak var colorWellView: NSColorWell!
    
    
    private var red = 0.0 {
        didSet {
            updateColorWell()
        }
    }
    
    private var green = 0.0 {
        didSet {
            updateColorWell()
        }
    }
    
    private var blue = 0.0 {
        didSet {
            updateColorWell()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateColorWell()
    }
    
    private func updateColorWell() {
        let color = NSColor(calibratedRed: CGFloat(red/255.0), green: CGFloat(green/255.0), blue: CGFloat(blue/255.0), alpha: 1.0)
        colorWellView.color = color
    }
    
    @IBAction func selectColor(_ sender: NSSlider) {
        let colorValue = Double(sender.integerValue)
        switch sender.tag {
        case 100:
            red = colorValue
        case 101:
            green = colorValue
        case 102:
            blue = colorValue
        default:
            red = 0.0; green = 0.0; blue = 0.0;
        }
    }
}
