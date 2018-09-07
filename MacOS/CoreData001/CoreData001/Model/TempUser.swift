//
//  TempUser.swift
//  CoreData001
//
//  Created by Ankit Kumar Bharti on 19/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Foundation

/// Temporary user for store and update to the database
struct TempUser {
    let id: Int32?
    let name: String?
    let mobile: String?
    let address: String?
    let image: Data?
    
    init(id: Int32? = nil, name: String?, mobile: String?, address: String?, image: Data?) {
        self.id = id
        self.name = name
        self.mobile = mobile
        self.address = address
        self.image = image
    }
}
