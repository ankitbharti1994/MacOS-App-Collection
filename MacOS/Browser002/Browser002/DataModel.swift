//
//  DataModel.swift
//  Browser002
//
//  Created by Ankit Kumar Bharti on 09/08/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Foundation

class Node: NSObject {
    var name: String
    var imageName: String
    var friends: [Node]
    
    override init() {
        self.name = ""
        self.imageName = "1"
        self.friends = []
        super.init()
    }
    
    init(name: String, imageName: String = "0", friends: [Node] = []) {
        self.name = name
        self.friends = friends
        self.imageName = imageName
    }
}
