//
//  PasteboardManager.swift
//  Pasteboard01
//
//  Created by Ankit Kumar Bharti on 16/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

struct PasteboardManager {
    
    let pasteboard = NSPasteboard.general
    
    mutating func canReadText() -> Bool {
        return pasteboard.canReadObject(forClasses: [NSString.self], options: nil)
    }
    
    @discardableResult
    mutating func copy(text: String) -> Bool {
        pasteboard.clearContents()
        return pasteboard.writeObjects([text as NSString])
    }
    
    mutating func pasteText() -> String? {
        guard let data = pasteboard.readObjects(forClasses: [NSString.self], options: nil) as? [NSString], let firstText = data.first else { return nil }
        return firstText as String
    }
    
    mutating func canReadUser() -> Bool {
        return pasteboard.canReadObject(forClasses: [User.self], options: nil)
    }
    
    @discardableResult
    mutating func copy(user: User) -> Bool {
        pasteboard.clearContents()
        return pasteboard.writeObjects([user])
    }
    
    mutating func pasteUser() -> User? {
        guard let users = pasteboard.readObjects(forClasses: [User.self], options: nil) as? [User], let user = users.first else { return  nil }
        return user
    }
}
