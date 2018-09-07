//
//  ViewController.swift
//  Browser001
//
//  Created by Ankit Kumar Bharti on 26/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    @objc dynamic var nodes = [Node]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ankitHobbies1 = Node(title: "Palying Cricket", children: [])
        let ankithobbies2 = Node(title: "Listening Songs", children: [])
        
        let ankit = Node(title: "Ankit Bharti", children: [ankitHobbies1, ankithobbies2])
        let rohit = Node(title: "Rohit Shrivastva", children: [])
        let rootNode = Node(title: "Computer Science", children: [ankit, rohit])
        nodes.append(rootNode)
    }
}
