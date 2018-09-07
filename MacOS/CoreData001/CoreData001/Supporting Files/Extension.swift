//
//  Extension.swift
//  CoreData001
//
//  Created by Ankit Kumar Bharti on 19/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Foundation

extension Int32 {
    
    /// Create Random Int32 number
    ///
    /// - Parameter upperBound: pass the upper bound
    /// - Returns: it'll return the random Int32 value
    static func random(_ upperBound: Int32) -> Int32 {
        return Int32(arc4random_uniform(UInt32(upperBound)))
    }
}
