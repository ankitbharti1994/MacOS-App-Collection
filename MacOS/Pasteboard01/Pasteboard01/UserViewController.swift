//
//  UserViewController.swift
//  Pasteboard01
//
//  Created by Ankit Kumar Bharti on 16/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class UserViewController: NSViewController {

    private var pasteboardManager = PasteboardManager()
    
    private var user = User(name: "ankit bharti", address: "bangalore")
    @objc dynamic var name: String? {
        get {
            return user.name
        }
        
        set {
            user.name = newValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
}

// MARK: Pasteboard
extension UserViewController {
    
    @IBAction func copyUser(_ sender: Any) {
        guard let _ = name else { return }
        pasteboardManager.copy(user: user)
    }
    
    @IBAction func pasteUser(_ sender: Any) {
        if let text = pasteboardManager.pasteText() {
            name = text
        }
    }
    
    @IBAction func cutUser(_ sender: Any) {
        guard let _ = name else { return }
        if pasteboardManager.copy(user: user) {
            name = nil
        }
    }
}

// MARK:- Validate Menu Item

extension UserViewController {
    override func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
        switch menuItem.action {
        case #selector(copyUser(_:)), #selector(cutUser(_:)):
            return name != nil
        case #selector(pasteUser(_:)):
            return pasteboardManager.canReadUser()
        default:
            return false
        }
    }
}
