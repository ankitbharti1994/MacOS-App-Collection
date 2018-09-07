//
//  Extension.swift
//  UndoManager001
//
//  Created by Ankit Kumar Bharti on 23/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Foundation


// MARK: - Int extension
extension Int {
    postfix static func ++(value: inout Int) {
        value = value + 1
    }
}
