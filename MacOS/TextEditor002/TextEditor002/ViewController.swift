//
//  ViewController.swift
//  TextEditor002
//
//  Created by Ankit Kumar Bharti on 24/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var textView: NSTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        guard let document = self.view.window?.windowController?.document as? Document else {
            return
        }
        textView.textStorage?.append(document.attributedString)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

