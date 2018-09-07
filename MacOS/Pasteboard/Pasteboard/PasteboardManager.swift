//
//  PasteboardManager.swift
//  Pasteboard
//
//  Created by Ankit Kumar Bharti on 13/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

struct PasteboardManager {
    
    private var pasteboard = NSPasteboard.general
    
    mutating func canReadImage() -> Bool {
        return pasteboard.canReadObject(forClasses: [NSImage.self], options: nil)
    }
    
    @discardableResult
    mutating func write(image: NSImage) -> Bool {
        pasteboard.clearContents()
        return pasteboard.writeObjects([image])
    }
    
    mutating func readImage() -> NSImage? {
        guard canReadImage() else {
            print("couldn't read image")
            return nil
        }
        guard let images = pasteboard.readObjects(forClasses: [NSImage.self], options: nil) as? [NSImage], let image = images.first else {
            print("couldn't find any image")
            return nil
        }
        return image
    }
}

