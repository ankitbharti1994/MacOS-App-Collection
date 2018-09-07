//
//  ViewController.swift
//  ArrayController001
//
//  Created by Ankit Kumar Bharti on 27/06/18.
//  Copyright © 2018 Ankit Kumar Bharti. All rights reserved.
//

import Cocoa

enum ValidationError: Error {
    case Invalid
}

class ViewController: NSViewController {
    
    @objc dynamic var employees: [Employee] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

