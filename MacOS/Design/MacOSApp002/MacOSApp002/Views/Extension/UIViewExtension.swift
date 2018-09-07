//
//  UIViewExtension.swift
//  MacOSApp002
//
//  Created by Ankit Kumar Bharti on 29/08/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

extension NSView {
    
    func addRightDivider() {
        
        self.wantsLayer = true
        
        let dividerLayer = CAShapeLayer()
        
        let path = CGMutablePath()
        path.move(to: CGPoint(x: self.bounds.size.width, y: self.bounds.origin.y + 20))
        path.addLine(to: CGPoint(x: self.bounds.size.width, y: self.bounds.size.height - 20))
        
        dividerLayer.path = path
        dividerLayer.strokeColor = NSColor.white.cgColor
        dividerLayer.lineWidth = 1.0
        dividerLayer.fillColor = NSColor.clear.cgColor
        
        self.layer?.addSublayer(dividerLayer)
    }
    
    func roundedView() {
        self.wantsLayer = true
        layer?.cornerRadius = min(bounds.size.width, bounds.size.height) / 2.0
        layer?.masksToBounds = true
    }
}
