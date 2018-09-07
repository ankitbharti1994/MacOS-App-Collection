//
//  AppDelegate.swift
//  Sheets
//
//  Created by Ankit Kumar Bharti on 17/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    private var configurationController: ConfigurationWindowController?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @IBAction func showPreferences(_ sender: Any) {
        let windowController = ConfigurationWindowController(windowNibName: NSNib.Name(rawValue: String(describing: ConfigurationWindowController.self)))
        windowController.color = NSColor.gray
        NSApplication.shared.mainWindow?.beginSheet(windowController.window!, completionHandler: { modalResponse in
            switch modalResponse {
            case NSApplication.ModalResponse.OK:
                print("OK Clicked")
            default:
                print("Nothing Happened")
            }
            self.configurationController = nil
        })
        configurationController = windowController
    }
}

