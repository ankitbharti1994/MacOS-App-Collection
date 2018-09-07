//
//  AppDelegate.swift
//  MacApp002
//
//  Created by Ankit Kumar Bharti on 01/08/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    var eventMonitor: EventMonitor?
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusBarItem.image = NSImage(named: NSImage.Name("Clear"))
        statusBarItem.action = #selector(handleTap)
        menuItem()
        
        eventMonitor = EventMonitor(mask: [.leftMouseDown], { event in
            guard let event = event else { return }
            print(event.allTouches())
        })
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @objc func handleTap() {
        print("it's clear weather")
        eventMonitor?.start()
    }
    
    func menuItem() {
        let menu = NSMenu()
        
        menu.addItem(withTitle: "Open App", action: #selector(openApp), keyEquivalent: "O")
        menu.addItem(NSMenuItem.separator())
        menu.addItem(withTitle: "Quit App", action: #selector(quitapp), keyEquivalent: "q")
        
        statusBarItem.menu = menu
    }
    
    @objc func openApp() {
        NSWorkspace.shared.open(URL(string: "https://google.co.in")!)
    }
    
    @objc func quitapp() {
        NSApplication.shared.terminate(nil)
    }
}

