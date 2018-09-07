//
//  AppDelegate.swift
//  StatusBarApp
//
//  Created by Ankit Kumar Bharti on 23/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusBarItem.button?.title = WeatherDataHelper.data().first?.minTemp ?? "--°"
        statusBarItem.button?.action = #selector(showPopOver)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    // MARK: - present Popover
    @objc private func showPopOver() {
        let storyboard = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil)
        guard let controller = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "\(ViewController.self)")) as? ViewController else { return }
        let popover = NSPopover()
        popover.contentViewController = controller
        popover.behavior = .transient
        popover.show(relativeTo: statusBarItem.button!.bounds, of: statusBarItem.button!, preferredEdge: .maxY)
    }
}

