//
//  EventMonitoring.swift
//  MacApp002
//
//  Created by Ankit Kumar Bharti on 01/08/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class EventMonitor {
    
    private var monitor: Any?
    private var mask: NSEvent.EventTypeMask
    private var handler: (NSEvent?) -> ()
    
    init(mask: NSEvent.EventTypeMask, _ handler: @escaping (NSEvent?) -> Void) {
        self.mask = mask
        self.handler = handler
    }
    
    deinit {
        stop()
    }
    
    func start() {
        monitor = NSEvent.addGlobalMonitorForEvents(matching: mask, handler: handler)
    }
    
    func stop() {
        guard let localMonitor = monitor else { return }
        NSEvent.removeMonitor(localMonitor)
        monitor = nil
    }
    
}
