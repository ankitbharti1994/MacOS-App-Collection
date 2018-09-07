//
//  ConfigurationWindowController.swift
//  Sheets
//
//  Created by Ankit Kumar Bharti on 17/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class ConfigurationWindowController: NSWindowController {

    @objc dynamic var color: NSColor = .white
    
    override func windowDidLoad() {
        super.windowDidLoad()
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    @IBAction func cancelWindow(_ sender: Any) {
        window?.endEditing(for: nil)
        dismiss(with: .OK)
    }
    
    private func dismiss(with modalResponse: NSApplication.ModalResponse) {
        window?.sheetParent?.endSheet(window!, returnCode: modalResponse)
    }
}
