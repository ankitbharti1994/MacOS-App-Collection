//
//  ViewController.swift
//  TextReader
//
//  Created by Ankit Kumar Bharti on 23/07/18.
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
        if let document = view.window?.windowController?.document as? Document, let text = document.attributedString {
            textView.textStorage?.append(text)
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

