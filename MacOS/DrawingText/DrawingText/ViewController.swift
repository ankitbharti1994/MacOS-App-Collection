//
//  ViewController.swift
//  DrawingText
//
//  Created by Ankit Kumar Bharti on 03/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var button: NSButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let attributedString = NSMutableAttributedString(string: "Press Here")
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        
        let dic: [NSAttributedStringKey: Any] = [.font: NSFont.boldSystemFont(ofSize: 20), .foregroundColor: NSColor.red, .paragraphStyle : paragraph]
        attributedString.addAttributes(dic, range: NSRange(0...4))
        
        button.attributedTitle = attributedString
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func saveFile(_ sender: Any) {
        let savePanel = NSSavePanel()
        savePanel.allowedFileTypes = ["txt"]
        savePanel.showsTagField = false
        
        savePanel.beginSheetModal(for: view.window!) { (applicationModelResponse) in
            let message = """
                                Hi here is ankit bharti,
                                😀
                                DOB: 09/04/1994
                                Address: Bangalore
                        """
            guard let data = message.data(using: .utf8) else { return }
            guard let url = savePanel.url else { return }
            try? data.write(to: url)
        }
    }

    @IBAction func openFile(_ sender: Any) {
        let openPanel = NSOpenPanel()
        openPanel.allowedFileTypes = ["pdf","txt","jpg","png"]
        openPanel.beginSheetModal(for: view.window!) { (applicationModelResponse) in
            print(String(describing: openPanel.url))
        }
    }
}

