//
//  Person.swift
//  MacOSApp002
//
//  Created by Ankit Kumar Bharti on 29/08/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class Person: NSObject {
    @objc dynamic var name: String
    @objc dynamic var profileImage: NSImage
    @objc dynamic var subTitle: String
    @objc dynamic var time: String
    
    init(name: String, image: String, subTitle: String, time: String) {
        self.name = name
        self.profileImage = NSImage(named: NSImage.Name(image))!
        self.subTitle = subTitle
        self.time = time
        super.init()
    }
}
