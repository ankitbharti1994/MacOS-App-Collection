//
//  SecondaryViewController.swift
//  Sheets
//
//  Created by Ankit Kumar Bharti on 17/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class SecondaryViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func dismissVC(_ sender: Any) {
        self.dismissViewController(self)
    }
}
