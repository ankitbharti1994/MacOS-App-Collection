//
//  Website.swift
//  ViewControllerTypes
//
//  Created by Ankit Kumar Bharti on 20/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class Website: NSObject {
    @objc dynamic var name: String = ""
    @objc dynamic var url: String = ""
    
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}
