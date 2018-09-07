//
//  ViewController.swift
//  MacOSApp002
//
//  Created by Ankit Kumar Bharti on 29/08/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class DetailsViewController: NSViewController {

    @IBOutlet weak var topContainerView: NSView!
    @IBOutlet weak var messageButton: NSButton!
    @IBOutlet weak var profileImageView: NSImageView!
    @IBOutlet weak var friendsButton: NSButton!
    
    @IBOutlet weak var customView0: NSView!
    @IBOutlet weak var customView1: NSView!
    @IBOutlet weak var customView2: NSView!
    
    @IBOutlet weak var recentlyPlayedButton: NSButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeView()
    }
    
    // MARK: - Customize View
    fileprivate func customizeView() {
        topContainerView.wantsLayer = true
        topContainerView.layer?.backgroundColor = NSColor.blue.cgColor
        
        messageButton.wantsLayer = true
        messageButton.layer?.backgroundColor = NSColor.gray.cgColor
        messageButton.roundedView()
        
        friendsButton.wantsLayer = true
        friendsButton.layer?.backgroundColor = NSColor.red.cgColor
        friendsButton.roundedView()
        
        customView0.addRightDivider()
        customView1.addRightDivider()
        customView2.addRightDivider()
        
        recentlyPlayedButton.wantsLayer = true
        recentlyPlayedButton.layer?.backgroundColor = NSColor.green.cgColor
    }
}

