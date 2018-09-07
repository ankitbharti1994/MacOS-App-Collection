//
//  NSButtonExtension.swift
//  Slack001
//
//  Created by Ankit Kumar Bharti on 07/09/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

extension NSButton {
    
    func button(with title: String, textColor: NSColor) {
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        
        let attributes: [NSAttributedStringKey: Any] = [NSAttributedStringKey.paragraphStyle: paragraph, .font: NSFont.systemFont(ofSize: 14.0), .foregroundColor: textColor]
        
        let attributedString = NSAttributedString(string: title, attributes: attributes)
        self.attributedTitle = attributedString
    }
}
