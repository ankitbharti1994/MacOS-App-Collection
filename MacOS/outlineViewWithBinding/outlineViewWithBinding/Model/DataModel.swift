//
//  Branch.swift
//  OutlineView002
//
//  Created by Ankit Kumar Bharti on 26/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Foundation

class Node: NSObject {
    @objc dynamic let title: String
    @objc dynamic let children: [Node]
    
    init(title: String, children: [Node]) {
        self.title = title
        self.children = children
    }
}
