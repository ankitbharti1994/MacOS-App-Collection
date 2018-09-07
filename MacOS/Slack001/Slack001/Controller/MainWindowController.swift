//
//  MainWindowController.swift
//  Slack001
//
//  Created by Ankit Kumar Bharti on 06/09/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
        window?.titleVisibility = .hidden
        window?.backgroundColor = .clear
    }
}
