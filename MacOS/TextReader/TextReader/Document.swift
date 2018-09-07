//
//  Document.swift
//  TextReader
//
//  Created by Ankit Kumar Bharti on 23/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class Document: NSDocument {

    var attributedString: NSAttributedString? = nil
    
    override init() {
        super.init()
        // Add your subclass-specific initialization here.
    }

    override class var autosavesInPlace: Bool {
        return true
    }

    override func makeWindowControllers() {
        // Returns the Storyboard that contains your Document window.
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        let windowController = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("Document Window Controller")) as! NSWindowController
        self.addWindowController(windowController)
    }

    override func read(from url: URL, ofType typeName: String) throws {
        let data = try Data(contentsOf: url)
        
        attributedString = try NSAttributedString(data: data, options: [:], documentAttributes: nil)
    }
    
    override func write(to url: URL, ofType typeName: String) throws {
        guard let controller = windowControllers.first?.contentViewController as? ViewController, let textStorage = controller.textView.textStorage, let data = textStorage.rtf(from: NSRange(location: 0, length: textStorage.length), documentAttributes: [:]) else { return }
        try data.write(to: url)
    }
}

