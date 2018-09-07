//
//  PresentationBackgroundView.swift
//  Slack001
//
//  Created by Ankit Kumar Bharti on 07/09/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class PresentationBackgroundView: NSView {
    
    var didMouseClicked: (() -> ())?
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        wantsLayer = true
        layer?.backgroundColor = NSColor.black.withAlphaComponent(0.6).cgColor
        
        addGestureRecognizer(NSClickGestureRecognizer(target: self, action: #selector(didClicked)))
    }
    
    @objc fileprivate func didClicked() {
        didMouseClicked?()
    }
}
