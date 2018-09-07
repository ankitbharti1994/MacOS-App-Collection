//
//  CustomView.swift
//  CustomViewDrawing
//
//  Created by Ankit Kumar Bharti on 29/06/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

@IBDesignable
class DiceView: NSView {

    @IBInspectable var numbers: Int = 6 {
        didSet {
            shuffleNumber()
            needsDisplay = true
        }
    }
    
    private var margin: CGFloat = 20.0
    
    // Dice Properties
    private var diceOriginX: CGFloat = 0.0
    private var diceOriginY: CGFloat = 0.0
    private var diceCenter: CGPoint = .zero
    private var diceWidth: CGFloat = 0.0
    private var diceHeight: CGFloat = 0.0
    private var dicePath: NSBezierPath?
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        // make dice background
        diceHeight = dirtyRect.height - margin * 2
        diceWidth = diceHeight
        let midX = dirtyRect.width / 2.0
        diceOriginX = midX - diceHeight / 2.0
        diceOriginY = dirtyRect.origin.y + margin
        diceCenter = CGPoint(x: diceOriginX + diceWidth / 2.0, y: diceOriginY + diceHeight / 2.0)
        
        NSGraphicsContext.saveGraphicsState()
        
        // shadow
        
        let shadow = NSShadow()
        shadow.shadowColor = NSColor.lightGray
        shadow.shadowBlurRadius = 5
        shadow.shadowOffset = NSSize(width: 0, height: -1)
        shadow.set()
        
        NSColor.white.set()
        let diceRect = NSRect(x: diceOriginX, y: diceOriginY, width: diceWidth, height: diceHeight)
        dicePath = NSBezierPath(roundedRect: diceRect, xRadius: 20.0, yRadius: 20.0)
        dicePath?.fill()
        
        // Shuffle Dice
        shuffleNumber()
        
        NSGraphicsContext.restoreGraphicsState()
    }
    
    
    private func shuffleNumber() {
        switch numbers {
        case 1:
            designDice(position: .center)
        case 2:
            designDice(position: .topLeftCorner)
            designDice(position: .bottomRightCorner)
        case 3:
            designDice(position: .topLeftCorner)
            designDice(position: .center)
            designDice(position: .bottomRightCorner)
        case 4:
            designDice(position: .topLeftCorner)
            designDice(position: .bottomLeftCorner)
            designDice(position: .topRightCorner)
            designDice(position: .bottomRightCorner)
        case 5:
            designDice(position: .topLeftCorner)
            designDice(position: .bottomLeftCorner)
            designDice(position: .center)
            designDice(position: .topRightCorner)
            designDice(position: .bottomRightCorner)
        case 6:
            designDice(position: .topLeftCorner)
            designDice(position: .bottomLeftCorner)
            designDice(position: .leftCenter)
            designDice(position: .topRightCorner)
            designDice(position: .bottomRightCorner)
            designDice(position: .rightCeneter)
        default:
            designDice(position: .center)
        }
    }
    
    
    // MARK:- Design Dice Numbers
    
    private func designDice(position: DicePosition) {
        var origin: CGPoint = .zero
        NSColor.darkGray.set()
        
        switch position {
        case .center:
            origin = CGPoint(x: diceCenter.x - margin, y: diceHeight / 2.0)
        case .leftCenter:
            origin = CGPoint(x: diceOriginX + margin, y: diceHeight / 2.0)
        case .rightCeneter:
            origin = CGPoint(x: diceOriginX + diceWidth - margin * 3, y: diceHeight / 2.0)
        case .topCenter:
            origin = CGPoint(x: diceCenter.x - margin, y: diceOriginY + diceHeight - margin * 3)
        case .bottomCenter:
            origin = CGPoint(x: diceCenter.x - margin, y: diceOriginY + margin)
        case .topLeftCorner:
            origin = CGPoint(x: diceOriginX + margin, y: diceOriginY + diceHeight - margin * 3)
        case .bottomLeftCorner:
            origin = CGPoint(x: diceOriginX + margin, y: diceOriginY + margin)
        case .topRightCorner:
            origin = CGPoint(x: diceOriginX + diceWidth - margin * 3, y: diceOriginY + diceHeight - margin * 3)
        case .bottomRightCorner:
            origin = CGPoint(x: diceOriginX + diceWidth - margin * 3, y: diceOriginY + margin)
        }
        
        let size = CGSize(width: 40.0, height: 40.0)
        let dicePath = NSBezierPath(ovalIn: NSRect(origin: origin, size: size))
        dicePath.fill()
    }
}


// MARK:- Mouse Events

extension DiceView {
    @IBAction func rollDice(_ sender: NSClickGestureRecognizer) {
        if let path = dicePath, path.contains(sender.location(in: self)) {
            numbers = Int(arc4random_uniform(6)) + 1
            print(numbers)
        }
    }
}
