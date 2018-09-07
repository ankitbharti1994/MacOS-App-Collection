//
//  ChannelViewController.swift
//  Slack001
//
//  Created by Ankit Kumar Bharti on 06/09/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class ChannelViewController: NSViewController {

    @IBOutlet weak var addButton: NSButton!
    @IBOutlet weak var horizontalSeperatorLine: NSBox!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.darkPurple.cgColor
        addButton.button(with: "Add +", textColor: .white)
        
        horizontalSeperatorLine.borderColor = .white
        
    }
}
