//
//  DraggableTextView.swift
//  TextEditor002
//
//  Created by Ankit Kumar Bharti on 24/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class DraggableTextView: NSTextView {
    
    private var allowedFileTypes: [NSPasteboard.PasteboardType] {
        return [.URL]
    }
    
    private var options: [NSPasteboard.ReadingOptionKey: [String]] {
        return [.urlReadingContentsConformToTypes: NSImage.imageTypes]
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerForDraggedTypes(allowedFileTypes)
    }
    
    var isDragging = false {
        didSet {
            needsDisplay = true
        }
    }
    
    func shouldAllow(_ draggingInfo: NSDraggingInfo) -> Bool {
        let pasteboard = draggingInfo.draggingPasteboard()
        return pasteboard.canReadObject(forClasses: [NSURL.self], options: options)
    }
    
    
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        let allow = shouldAllow(sender)
        isDragging = allow
        return allow ? .copy : NSDragOperation()
    }
    
    override func draggingExited(_ sender: NSDraggingInfo?) {
        isDragging = false
    }
    
    override func prepareForDragOperation(_ sender: NSDraggingInfo) -> Bool {
        return shouldAllow(sender)
    }
    
    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        guard shouldAllow(sender) else { return false }
        
        let pasteboard = sender.draggingPasteboard()
        guard let imageURLs = pasteboard.readObjects(forClasses: [NSURL.self], options: options) as? [URL], let imageURL = imageURLs.first, let image = NSImage(contentsOf: imageURL) else { return false }
        
        let attachmentCell = NSTextAttachmentCell(imageCell: image)
        let attachment = NSTextAttachment()
        attachment.attachmentCell = attachmentCell
        let attributedString = NSAttributedString(attachment: attachment)
        textStorage?.append(attributedString)
        
        return true
    }
}
