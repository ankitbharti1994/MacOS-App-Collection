//
//  PasteboardManager.swift
//  CoreData001
//
//  Created by Ankit Kumar Bharti on 19/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

struct PasteboardManager {
    
    /// general pasteboard initilization
    lazy var pasteboard = NSPasteboard.general
    
    
    /// options while paste the url, this will allow to get url which have image
    private var options: [NSPasteboard.ReadingOptionKey: [String]] {
        return [.urlReadingContentsConformToTypes : NSImage.imageTypes]
    }
    
    /// checking that pasteboard is readable or not for URL which must have Image included
    ///
    /// - Returns: return true if pasteboard is readable
    mutating func canReadImage() -> Bool {
        return pasteboard.canReadObject(forClasses: [NSURL.self], options: options)
    }
    
    /// read the URL and fetch the image from the URL
    ///
    /// - Returns: return image if it's possible
    mutating func pasteImage() -> NSImage? {
        guard let imageURLs = pasteboard.readObjects(forClasses: [NSURL.self], options: nil), let url = imageURLs.first as? URL  else { return nil }
        return NSImage(contentsOf: url)
    }
}
