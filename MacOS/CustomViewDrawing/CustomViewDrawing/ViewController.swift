//
//  ViewController.swift
//  CustomViewDrawing
//
//  Created by Ankit Kumar Bharti on 29/06/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet private weak var diceView: DiceView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func savePDF(_ sender: Any) {
        let panel = NSSavePanel()
        panel.allowedFileTypes = ["jpeg"]
        panel.beginSheetModal(for: self.view.window!) {[unowned self] (modelResponse) in
            if modelResponse == NSApplication.ModalResponse.OK {
                //guard let data = "ankit bharti".data(using: .utf8) else { return }
                let data = panel.dataWithPDF(inside: self.view.bounds)
                guard  let fileURL = panel.url else { return }
                print(fileURL)
                try? data.write(to: fileURL, options: Data.WritingOptions.atomic)
            }
        }
    }
}

