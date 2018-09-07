//
//  MenuItem.swift
//  MacOSApp002
//
//  Created by Ankit Kumar Bharti on 29/08/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class MenuItem: NSObject {
    
    @objc dynamic var title: String
    @objc dynamic var image: NSImage
    
    init(title: String, image: String) {
        self.title = title
        self.image = NSImage(named: NSImage.Name(rawValue: image))!
        super.init()
    }
}
