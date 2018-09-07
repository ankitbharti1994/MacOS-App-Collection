//
//  NodeCell.swift
//  Browser002
//
//  Created by Ankit Kumar Bharti on 09/08/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class NodeCell: NSBrowserCell {
    
    override init(imageCell image: NSImage?) {
        super.init(imageCell: image)
    }
    
    override init(textCell string: String) {
        super.init(textCell: string)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}
