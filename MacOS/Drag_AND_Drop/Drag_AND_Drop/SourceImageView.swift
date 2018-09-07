//
//  SourceImageView.swift
//  Drag_AND_Drop
//
//  Created by Ankit Kumar Bharti on 16/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

@IBDesignable
class SourceImageView: NSImageView, NSDraggingSource {
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        rounded()
    }
    
    func draggingSession(_ session: NSDraggingSession, sourceOperationMaskFor context: NSDraggingContext) -> NSDragOperation {
        return .generic
    }
}

extension SourceImageView: NSPasteboardItemDataProvider {
    func pasteboard(_ pasteboard: NSPasteboard?, item: NSPasteboardItem, provideDataForType type: NSPasteboard.PasteboardType) {
        if let pasteboard = pasteboard , type == .tiff, let image = self.image {
            let tiffData = image.tiffRepresentation
            pasteboard.setData(tiffData, forType: .tiff)
        }
    }
    
    override func mouseDragged(with event: NSEvent) {
        super.mouseDragged(with: event)
        let pasteboardItem = NSPasteboardItem()
        pasteboardItem.setDataProvider(self, forTypes: [.tiff])
        
        let draggingItem = NSDraggingItem(pasteboardWriter: pasteboardItem)
        draggingItem.setDraggingFrame(self.bounds, contents: nil)
        
        beginDraggingSession(with: [draggingItem], event: event, source: self)
    }
}
