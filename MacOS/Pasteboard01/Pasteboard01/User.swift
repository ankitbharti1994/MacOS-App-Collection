//
//  User.swift
//  Pasteboard01
//
//  Created by Ankit Kumar Bharti on 16/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class User: NSObject, Codable {
    var name: String?
    var address: String?
    
    init(name: String?, address: String?) {
        self.name = name
        self.address = address
    }
    
    required convenience init?(pasteboardPropertyList propertyList: Any, ofType type: NSPasteboard.PasteboardType) {
        self.init(name: nil, address: nil)
        guard let jsonString = propertyList as? String, let data = jsonString.data(using: .utf8) else {
            return nil
        }
        let decoder = JSONDecoder()
        do {
            let _ = try decoder.decode(User.self, from: data)
        }catch {
            return nil
        }
    }
}

extension User: NSPasteboardWriting {
    
    func writableTypes(for pasteboard: NSPasteboard) -> [NSPasteboard.PasteboardType] {
        return [NSPasteboard.PasteboardType(rawValue: "com.exilant.pasteboard01.data")]
    }
    
    func pasteboardPropertyList(forType type: NSPasteboard.PasteboardType) -> Any? {
        return jsonData()
    }
}

extension User: NSPasteboardReading {
    
    static func readableTypes(for pasteboard: NSPasteboard) -> [NSPasteboard.PasteboardType] {
        return [NSPasteboard.PasteboardType(rawValue: "com.exilant.pasteboard01.data")]
    }
}

extension User {
    private func jsonData()-> String? {
        
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self)
            return String(data: data, encoding: .utf8)
        }catch {
            return nil
        }
    }
}
