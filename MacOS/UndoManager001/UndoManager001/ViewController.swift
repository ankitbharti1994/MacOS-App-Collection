//
//  ViewController.swift
//  UndoManager001
//
//  Created by Ankit Kumar Bharti on 23/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var colorWell: NSColorWell!
    @IBOutlet weak var countLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK:- Changes
    
    /**
         Creating an undo action requires three steps.
         1. Performing a change
         2. Registering an “undo operation” which can reverse the change.
         3. Responding to a request to undo the change.
     */
    func change(color: NSColor) {
    
        let oldColor = colorWell.color
        undoManager?.registerUndo(withTarget: self, handler: { targetSelf in
            targetSelf.change(color: oldColor)
        })
        colorWell.color = color
    }
    
    func change(text: String) {
        let oldValue = countLabel.stringValue
        undoManager?.registerUndo(withTarget: self, handler: { targetSelf in
            targetSelf.change(text: oldValue)
        })
        countLabel.stringValue = text
    }
    
    // MARK:- Undo & Redo action
    
    @IBAction func actionUndo(_ sender: Any) {
       undoManager?.undo()
    }
    
    @IBAction func actionRedo(_ sender: Any) {
        undoManager?.redo()
    }
   
    // MARK: Button Action
    
    @IBAction func didChangeColor(_ sender: NSButton) {
        switch sender.tag {
        case 0:
            change(color: .black)
        case 1:
            change(color: .red)
        case 2:
            change(color: .green)
        case 3:
            change(color: .yellow)
        default:
            change(color: .white)
        }
    }
    
    @IBAction func increaseValue(_ sender: Any) {
        var oldValue = Int(countLabel.stringValue)!
        oldValue++
        change(text: "\(oldValue)")
    }
    
    // MARK: - Validate Undo & Redo MenuItem
    override func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
        switch menuItem.action {
        case #selector(actionUndo(_:)):
            return undoManager?.canUndo ?? false
        case #selector(actionRedo(_:)):
            return undoManager?.canRedo ?? false
        default:
            return false
        }
    }
}
