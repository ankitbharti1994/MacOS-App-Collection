//
//  CustomView.swift
//  CoreData001
//
//  Created by Ankit Kumar Bharti on 24/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

@IBDesignable
class CustomView: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        // allow layer-backed
        wantsLayer = true
        
        // Create Text Layer
        let textLayer = CATextLayer()
        textLayer.frame = NSRect(origin: .zero, size: CGSize(width: dirtyRect.size.width, height: 20.0))
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        
        let attributes: [NSAttributedStringKey: Any] = [.font: NSFont.systemFont(ofSize: 14.0), .foregroundColor: NSColor.black, .paragraphStyle: paragraph]
        let attrubutesString = NSAttributedString(string: "Hello User", attributes: attributes)
        
        textLayer.string = attrubutesString
        layer?.addSublayer(textLayer)
        
        // Create image layer
        let imageLayer = CALayer()
        imageLayer.contents = NSImage(named: NSImage.Name(rawValue: "user"))
        imageLayer.frame = NSRect(x: 0.0, y: 20.0, width: dirtyRect.size.width, height: dirtyRect.size.height - 20.0)
        layer?.addSublayer(imageLayer)
        
        
    }
}
