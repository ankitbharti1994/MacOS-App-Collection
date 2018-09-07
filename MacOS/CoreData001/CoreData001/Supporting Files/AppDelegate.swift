//
//  AppDelegate.swift
//  CoreData001
//
//  Created by Ankit Kumar Bharti on 19/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
       var databaseHelper = DatabaseHelper()
        databaseHelper.save()
    }
}

