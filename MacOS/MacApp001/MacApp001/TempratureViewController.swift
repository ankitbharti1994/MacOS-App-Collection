//
//  TempratureViewController.swift
//  MacApp001
//
//  Created by Ankit Kumar Bharti on 26/06/18.
//  Copyright © 2018 Ankit Kumar Bharti. All rights reserved.
//

import Cocoa

class TempratureViewController: NSViewController {
    
    @objc dynamic var temprature = 50
    @objc dynamic var isOn = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func raiseTemp(_ sender: Any) {
       temprature++
    }
    
    @IBAction func decreaseTemp(_ sender: Any) {
        temprature--
    }
    
}
