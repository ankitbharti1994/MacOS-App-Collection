//
//  ViewController.swift
//  Dummy
//
//  Created by Ankit Kumar Bharti on 02/08/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    let adventInput = [4, 10, 4, 1, 8, 4, 9, 14, 5, 1, 14, 15, 0, 15, 3, 5]
    
    let sampleInput0 = [0, 2, 7, 0]
    let sampleInput1 = [2, 5, 0, 3]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        processMemoryBank(sampleInput1) { (memoryBlocks, repeatedBlock, steps) in
            print(memoryBlocks)
            print("------------------------------\n")
            print(repeatedBlock)
            print("-------------------------------\n")
            print(steps)
        }
        
        find(\Person.friends)
    }
    
    func find<T>(_ keyPath: WritableKeyPath<Person, T>) {
        let person = Person()
        print(person[keyPath: keyPath])
    }
}

class Person {
    var name: String = "Unknown"
    var friends: [Person] = []
}
