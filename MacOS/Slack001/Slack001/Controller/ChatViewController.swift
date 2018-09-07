//
//  ChatViewController.swift
//  Slack001
//
//  Created by Ankit Kumar Bharti on 06/09/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class ChatViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.white.cgColor
    }
    
}
