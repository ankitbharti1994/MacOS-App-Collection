//
//  Utility.swift
//  CoreData001
//
//  Created by Ankit Kumar Bharti on 19/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

/// Present the alert with some message text and informative text
///
/// - Parameters:
///   - messageText: pass the message text which will show as title on alert window
///   - informativeText: pass the informative text message, it can be of multiline
func presentAlert(messageText: String?, informativeText: String?) {
    let alert = NSAlert()
    if messageText != nil {
        alert.messageText = messageText!
    }
    if informativeText != nil {
        alert.informativeText = informativeText!
    }
    alert.showsSuppressionButton = true
    alert.runModal()
}
