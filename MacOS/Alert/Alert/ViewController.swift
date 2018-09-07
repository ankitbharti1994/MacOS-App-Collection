//
//  ViewController.swift
//  Alert
//
//  Created by Ankit Kumar Bharti on 29/06/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @objc dynamic var message: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func showAlert(_ sender: NSButton) {
        let alert = NSAlert()
        alert.messageText = "Welcome message"
        alert.informativeText = "Welcome to cocoa programming world,it's interesting"
        alert.alertStyle = .warning
        alert.addButton(withTitle: "Done")
        alert.addButton(withTitle: "Visit website")
        
        // show as a seprate window
        /*
        let result = alert.runModal()
        switch result {
        case .alertFirstButtonReturn:
            message = "Done Button Clicked"
        case .alertSecondButtonReturn:
            message = "visit website button clicked"
        default:
            print("Nothing happened")
        }
        */
        
        // show as a sheet
        guard let window = sender.window else { return }
        alert.beginSheetModal(for: window) {[unowned self] (response) in
            switch response {
            case .alertFirstButtonReturn:
                self.message = "Done Button Clicked"
            case .alertSecondButtonReturn:
                self.message = "visit website button clicked"
            default:
                break
            }
        }
        
    }
}
