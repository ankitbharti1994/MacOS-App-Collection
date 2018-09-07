//
//  Feed.swift
//  OutlineView001
//
//  Created by Ankit Kumar Bharti on 26/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

enum OulineError: Error {
    case FileNotFound
}

struct Feed: Decodable {
    let name: String
    var items: [FeedItem]
    
    static func feedList()throws -> [Feed] {
        
        guard let fileURL = Bundle.main.url(forResource: "Feeds", withExtension: "plist") else { throw OulineError.FileNotFound }
        let data = try Data(contentsOf: fileURL)
        
        let decoder = PropertyListDecoder()
        
        return try decoder.decode([Feed].self, from: data)
    }
}
