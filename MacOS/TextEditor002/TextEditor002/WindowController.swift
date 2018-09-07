//
//  WindowController.swift
//  TextEditor002
//
//  Created by Ankit Kumar Bharti on 01/08/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        shouldCascadeWindows = true
    }
}
