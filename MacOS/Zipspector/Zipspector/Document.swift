//
//  Document.swift
//  Zipspector
//
//  Created by Ankit Kumar Bharti on 23/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class Document: NSDocument {
    
    var fileNames: [String] = []
    
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

    override func data(ofType typeName: String) throws -> Data {
        // Insert code here to write your document to data of the specified type. If outError != nil, ensure that you create and set an appropriate error when returning nil.
        // You can also choose to override fileWrapperOfType:error:, writeToURL:ofType:error:, or writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
        throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
    }

    override func read(from url: URL, ofType typeName: String) throws {
        
        let filePath = url.path
        
        // prepare task
        let process = Process()
        process.launchPath = "/usr/bin/zipinfo"
        process.arguments = ["-1", filePath]
        
        // create the pipe to read from
        
        let outPipe = Pipe()
        process.standardOutput = outPipe
        
        // start the process
        process.launch()
        
        // Read the output
        let fileHandle = outPipe.fileHandleForReading
        let data = fileHandle.readDataToEndOfFile()
        
        // make sure task terminate normally
        process.waitUntilExit()
        let _ = process.terminationStatus
        
        // convert data to string
        
        let string = String(data: data, encoding: .utf8)!
        fileNames = string.components(separatedBy: "\n")
    }
}

