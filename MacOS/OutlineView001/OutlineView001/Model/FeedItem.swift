//
//  FeedItem.swift
//  OutlineView001
//
//  Created by Ankit Kumar Bharti on 26/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

struct FeedItem: Decodable {
    let url: String
    let title: String
    let date: Date
}
