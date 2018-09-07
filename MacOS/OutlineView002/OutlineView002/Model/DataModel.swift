//
//  Branch.swift
//  OutlineView002
//
//  Created by Ankit Kumar Bharti on 26/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Foundation

struct Branch: Decodable {
    let title: String
    let students: [Student]
}

struct Student: Decodable {
    let name: String
    let hobbies: [String]
}
