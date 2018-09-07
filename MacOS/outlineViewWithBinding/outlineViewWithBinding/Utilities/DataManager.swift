//
//  DataManager.swift
//  OutlineView002
//
//  Created by Ankit Kumar Bharti on 26/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Foundation

enum OutlineProjError: Error {
    case FileNotFound
}

struct DataManager {
    
    static func data() throws -> [Branch] {
        
        guard let fileURL = Bundle.main.url(forResource: "FriendsList", withExtension: "json") else { throw OutlineProjError.FileNotFound }
        
        let data = try Data(contentsOf: fileURL)
        
        let decoder = JSONDecoder()
        
        return try decoder.decode([Branch].self, from: data)
    }
}
