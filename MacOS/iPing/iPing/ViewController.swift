//
//  ViewController.swift
//  iPing
//
//  Created by Ankit Kumar Bharti on 23/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var outputView: NSTextView!
    @IBOutlet weak var hostField: NSTextField!
    @IBOutlet weak var startButton: NSButton!
    var global_process: Process?
    var global_pipe: Pipe?
    var global_fileHandler: FileHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func togglePinging(_ sender: NSButton) {
        if let process = global_process {
            process.interrupt()
        }else {
            // create new process
            let process = Process()
            process.launchPath = "/sbin/ping"
            process.arguments = ["-c10", hostField.stringValue]
            
            // create a new pipe for standard output
            let pipe = Pipe()
            process.standardOutput = pipe
            
            // grab the file handle
            let fileHandle = pipe.fileHandleForReading
            
            global_process = process
            global_pipe = pipe
            global_fileHandler = fileHandle
            
            let notificationCenter = NotificationCenter.default
            notificationCenter.removeObserver(self)
            notificationCenter.addObserver(self, selector: #selector(receiveDataReadyNotification(_:)), name: FileHandle.readCompletionNotification, object: nil)
            notificationCenter.addObserver(self, selector: #selector(receiveProcessTerminationNotification(_:)), name: Process.didTerminateNotification, object: process)
            
            process.launch()
            outputView.string = ""
            fileHandle.readInBackgroundAndNotify()
        }
    }
    
    func appendData(_ data: Data) {
        let string = String(data: data, encoding: .utf8)
        let textStorage = outputView.textStorage
        let endRange = NSRange(location: (textStorage?.length)!, length: 0)
        textStorage?.replaceCharacters(in: endRange, with: string!)
    }
    
    @objc func receiveDataReadyNotification(_ notification: Notification) {
        let data = notification.userInfo![NSFileHandleNotificationDataItem] as! Data
        
        print("received data : \(data.count) bytes")
        if data.count > 0 {
            appendData(data)
        }
        
        if let fileHandle = global_fileHandler {
            fileHandle.readInBackgroundAndNotify()
        }
    }
    
    @objc func receiveProcessTerminationNotification(_ notification: Notification) {
        print("process terminated")
        global_process = nil
        global_pipe = nil
        global_fileHandler = nil
        startButton.state = NSControl.StateValue(rawValue: 0)
    }
}

