//
//  SectionTileView.swift
//  PieChartKit
//
//  Created by Ankit Kumar Bharti on 03/08/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

@IBDesignable
class SectionTileView: NSView {
    
    @IBInspectable private var title: String?
    @IBInspectable private var color: NSColor?
    
    required init(coder: NSCoder) {
        fatalError("can't initilize with coder")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(title: String, color: NSColor?) {
        self.init(frame: .zero)
        self.title = title
        self.color = color
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        prepeareContent()
    }
    
    private func prepeareContent() {
        let tileView = NSView()
        tileView.wantsLayer = true
        tileView.layer?.backgroundColor = color?.cgColor
        addSubview(tileView)
        
        tileView.translatesAutoresizingMaskIntoConstraints = false
        let centerVerticalConstraint = tileView.centerYAnchor.constraint(equalTo: centerYAnchor)
        let leadingConstraint = tileView.leadingAnchor.constraint(equalTo: leadingAnchor)
        let widthConstraint = tileView.widthAnchor.constraint(equalToConstant: 10.0)
        let heightConstraint = tileView.heightAnchor.constraint(equalToConstant: 10.0)
        
        NSLayoutConstraint.activate([centerVerticalConstraint, leadingConstraint, widthConstraint, heightConstraint])
        
        
        let titleLabel = NSTextField()
        titleLabel.isBordered = false
        titleLabel.isEditable = false
        titleLabel.isSelectable = false
        titleLabel.stringValue = title ?? ""
        titleLabel.font = NSFont.systemFont(ofSize: 10.0)
        titleLabel.lineBreakMode = .byTruncatingTail
        addSubview(titleLabel)
        
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let labelLeadingConstraint = titleLabel.leadingAnchor.constraint(equalTo: tileView.trailingAnchor, constant: 4.0)
        let labelTrailingConstraint = titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0.0)
        //let labelHeightConstraint = titleLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1.0)
        let labelCenterYConstaint = titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        
        NSLayoutConstraint.activate([labelCenterYConstaint, labelLeadingConstraint, labelTrailingConstraint])
        needsLayout = true
    }
}
