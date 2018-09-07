//
//  Extension.swift
//  CoreData001
//
//  Created by Ankit Kumar Bharti on 19/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class DraggableImageView: NSImageView {
    
    // MARK:- Properties
    typealias ProcessImageCallback = (NSImage?) -> ()
    var processImage: ProcessImageCallback? = nil
    
    private var options: [NSPasteboard.ReadingOptionKey: [String]] {
        return [.urlReadingContentsConformToTypes: NSImage.imageTypes]
    }
    
    private var draggableTypes: [NSPasteboard.PasteboardType] {
        return [.URL]
    }
    
    private var isReceiving = false {
        didSet {
            needsDisplay = true
        }
    }
    
    // MARK:- View life cycle
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    // MARK:- register the draggable types
    func setup() {
        registerForDraggedTypes(draggableTypes)
    }
    
    // MARK:- Check for particular types that is this draggable
    func shouldAllow(draggingInfo: NSDraggingInfo) -> Bool {
        let pasteboard = draggingInfo.draggingPasteboard()
        return pasteboard.canReadObject(forClasses: [NSURL.self], options: options)
    }
    
    // MARK:- Track dragging action
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        let allow = shouldAllow(draggingInfo: sender)
        isReceiving = allow
        return allow ? .copy : NSDragOperation()
    }
    
    override func draggingExited(_ sender: NSDraggingInfo?) {
        isReceiving = false
    }
    
    // MARK:- NSDraggingDestination Protocol
    override func prepareForDragOperation(_ sender: NSDraggingInfo) -> Bool {
        return shouldAllow(draggingInfo: sender)
    }
    
    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        guard shouldAllow(draggingInfo: sender) else { return false }
        let pasteboard = sender.draggingPasteboard()
        
        guard let imageURLs = pasteboard.readObjects(forClasses: [NSURL.self], options: options), let url = imageURLs.first as? NSURL else { return false }
        let image = NSImage(contentsOf: url as URL)
        processImage?(image)
        return true
    }
}
