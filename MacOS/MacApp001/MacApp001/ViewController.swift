//
//  ViewController.swift
//  MacApp001
//
//  Created by Ankit Kumar Bharti on 25/06/18.
//  Copyright © 2018 Ankit Kumar Bharti. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    var data: Data?
    lazy private var utility = Utility()
    @IBOutlet private weak var messageLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        utility.createDirectory()
        performKVC()
    }
    
    private func performKVC() {
        let student = Student()
        student[keyPath: \Student.name] = "XYZ"
        student[keyPath: \Student.age] = 24
        
        print(student.name)
        print(student.age)
        
        print(student.value(forKeyPath: #keyPath(Student.name)) as? String ?? "N/A")
        print(student.value(forKeyPath: #keyPath(Student.age)) as? Int ?? 0)
        
        print(student[keyPath: \Student.name])
        print(student[keyPath: \Student.age])
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func saveData(_ sender: Any) {
        data = utility.save(user: User(name: "XYZ", age: 24))
    }
    
    @IBAction func readData(_ sender: Any) {
        messageLabel.stringValue = utility.fetchUser(data: data)?.description ?? "N/A"
    }
}

