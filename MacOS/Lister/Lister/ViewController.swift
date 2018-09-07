//
//  ViewController.swift
//  Lister
//
//  Created by Ankit Kumar Bharti on 27/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("iiii oiii ooii oooi oooo".canRearrange)
    }
}

extension String {
    var canRearrange: Bool {
        
        let originalTextCollection = self.components(separatedBy: " ")
        guard originalTextCollection.count > 1 else { return false } // TODO:- Remove this line
        guard originalTextCollection.count == 2 else {
            
            // TODO:- Write code to check if more than 2
            
            for index0 in 0..<originalTextCollection.count {
                for index1 in (index0 + 1)..<originalTextCollection.count {
                    if originalTextCollection[index0].characterSet == originalTextCollection[index1].characterSet {
                        return true
                    }
                }
            }
            
            return false
        }
        return originalTextCollection.first!.characterSet == originalTextCollection.last!.characterSet
    }
    
    var characterSet: [String] {
        var cha = [String]()
        for character in self {
            cha.append("\(character)")
        }
        return cha
    }
}

//"abcde fghij".canRearrange
//"abcde xyz ecdab".canRearrange
