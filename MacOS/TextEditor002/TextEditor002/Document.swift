//
//  Document.swift
//  TextEditor002
//
//  Created by Ankit Kumar Bharti on 24/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class Document: NSDocument {

    var attributedString = NSAttributedString(string: "")
    
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

    override func write(to url: URL, ofType typeName: String) throws {
        
        guard let controller = windowControllers.first?.contentViewController as? ViewController, let textStorage = controller.textView.textStorage, let data = textStorage.rtf(from: NSRange(location: 0, length: textStorage.length), documentAttributes: [:]) else { return }
        textStorage.enumerateAttribute(.attachment, in: NSRange(location: 0, length: textStorage.length), options: NSAttributedString.EnumerationOptions(rawValue: 0)) { (value, tange, stop) in
            let attachment = value as? NSTextAttachment
            let fileWrapper = attachment?.fileWrapper
            try? fileWrapper?.write(to: url, options: FileWrapper.WritingOptions.atomic, originalContentsURL: url)
        }
        try data.write(to: url)
    }
    
    override func read(from url: URL, ofType typeName: String) throws {
        let data = try Data(contentsOf: url)
        attributedString = try NSAttributedString(data: data, options: [:], documentAttributes: nil)
    }
}

