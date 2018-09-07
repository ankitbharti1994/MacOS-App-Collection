//
//  ViewController.swift
//  Locallization
//
//  Created by Ankit Kumar Bharti on 18/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @objc dynamic var message = "message".localized()
    @IBOutlet weak var messageLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let format = NSLocalizedString("NEED", comment: "%@ needs a %@")
        let string = String(format: format, "i", "scooter")
        print(string)
        
        let format1 = NSLocalizedString("NEEDS", comment: "A %2$@ what %1$@ needs")
        let string1 = String(format: format1, "ankit", "scooter")
        print(string1)
        
        
        // Archiving
        
        let user = User(name: "ankit", age: 24)
        
        guard let docURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = docURL.appendingPathComponent("User.txt")
        
        let isArchived = NSKeyedArchiver.archiveRootObject(user, toFile: fileURL.path)
        print("archived : \(isArchived)")
        guard let user1 = NSKeyedUnarchiver.unarchiveObject(withFile: fileURL.path) as? User else { return }
        print(user1.name)
    }
    
    @IBAction func changeMessage(_ sender: NSButton) {
        switch sender.tag {
        case 0:
            message = "message".localized()
        case 1:
            message = "message".localized(by: .russian)
        case 2:
            message = "message".localized(by: .french)
        default:
            fatalError()
        }
    }
}

