//
//  ViewController.swift
//  Pasteboard01
//
//  Created by Ankit Kumar Bharti on 16/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @objc dynamic var message: String? = "Welcome To Pasteboard"
    private var pasteboardManager = PasteboardManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

// MARK: Pasteboard
extension ViewController {
    
    @IBAction func copyText(_ sender: Any) {
        guard let text = message else { return }
        pasteboardManager.copy(text: text)
    }
    
    @IBAction func pasteText(_ sender: Any) {
        if let text = pasteboardManager.pasteText() {
            message = text
        }
    }
    
    @IBAction func cutText(_ sender: Any) {
        guard let text = message else { return }
        if pasteboardManager.copy(text: text) {
            message = nil
        }
    }
}

// MARK:- Validate Menu Item

extension ViewController {
    override func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
        switch menuItem.action {
        case #selector(copyText(_:)), #selector(cutText(_:)):
            return message != nil
        case #selector(pasteText(_:)):
            return pasteboardManager.canReadText()
        default:
            return false
        }
    }
}
