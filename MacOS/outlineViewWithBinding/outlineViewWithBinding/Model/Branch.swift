//
//  Branch.swift
//  outlineViewWithBinding
//
//  Created by Ankit Kumar Bharti on 26/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Foundation

class Branch: NSObject, Decodable {
    @objc dynamic let title: String
    @objc dynamic let students: [Student]
    
    init(title: String, students: [Student]) {
        self.title = title
        self.students = students
    }
}

class Student: NSObject, Decodable {
    @objc dynamic let name: String
    @objc dynamic let hobbies: [String]
    
    init(name: String, hobbies: [String]) {
        self.name = name
        self.hobbies = hobbies
    }
}
