//
//  Extension.swift
//  Lister
//
//  Created by Ankit Kumar Bharti on 27/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Foundation

extension String {
    var isValidPassphrase: Bool {
        let originalTextCollection = self.components(separatedBy: " ")
        guard originalTextCollection.count > 1 else {
            return false
        }
        let uniqueTextCollection = Set(originalTextCollection)
        return originalTextCollection.count == uniqueTextCollection.count
    }
}
