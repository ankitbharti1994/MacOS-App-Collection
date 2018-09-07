//
//  FriendView.swift
//  MacOSApp002
//
//  Created by Ankit Kumar Bharti on 29/08/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class RoundedImageView: NSImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.roundedView()
    }
}
