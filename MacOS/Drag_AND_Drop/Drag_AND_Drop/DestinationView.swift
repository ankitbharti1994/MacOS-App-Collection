//
//  DestinationView.swift
//  Drag_AND_Drop
//
//  Created by Ankit Kumar Bharti on 16/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

@IBDesignable
class DestinationView: NSView {
    
    typealias ProcessImageCallback = (NSImage?) -> ()
    
    var processImage: ProcessImageCallback? = nil
    
    // MARK:- define the dragable types
    private var dragableTypes: [NSPasteboard.PasteboardType] {
        return [.URL,.tiff]
    }
    
    // MARK:- View life cycle
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        rounded()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // register the draggable types
        registerForDraggedTypes(dragableTypes)
    }
    
    
    // MARK:- update the display
    var isReceivingDrag = false {
        didSet {
            needsDisplay = true
        }
    }
    
    // MARK:- check whether read the draggable item or not
    
    /// check for can read image
    ///
    /// - Parameter draggingInfo: NSDraggingInfo instance
    /// - Returns: return the bool value
    func canReadImage(_ draggingInfo: NSDraggingInfo) -> Bool {
        return draggingInfo.draggingPasteboard().canReadObject(forClasses: [NSURL.self,NSImage.self], options: [.urlReadingContentsConformToTypes: NSImage.imageTypes])
    }
    
    // MARK:- methods when mouse entered into dragable view
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        let allow = canReadImage(sender)
        isReceivingDrag = allow
        return allow ? .copy : NSDragOperation()
    }
    
    // MARK:- methods when mouse exited from dragable view
    override func draggingEnded(_ sender: NSDraggingInfo) {
        isReceivingDrag = false
    }
    
    // MARK:- prepare for drag operation, it's the last chance to accept or reject the dragging item
    override func prepareForDragOperation(_ sender: NSDraggingInfo) -> Bool {
        return canReadImage(sender)
    }
    
    // MARK:- perform the drag operation
    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        let allow = canReadImage(sender)
        isReceivingDrag = false
        let pasteboard = sender.draggingPasteboard()
        guard let urls = pasteboard.readObjects(forClasses: [NSURL.self,NSImage.self], options: [.urlReadingContentsConformToTypes: NSImage.imageTypes]) as? [URL], let url = urls.first else {
            if let image = NSImage(pasteboard: pasteboard) {
                processImage?(image)
                return allow
            }
            return false
        }
        processImage?(NSImage(contentsOf: url))
        return allow
    }
}



extension NSView {
    func rounded() {
        layer?.cornerRadius = 10.0
        layer?.borderWidth = 2.0
        layer?.borderColor = NSColor.gray.cgColor
        layer?.masksToBounds = true
    }
}
