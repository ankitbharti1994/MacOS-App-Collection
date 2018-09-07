//
//  PreviewController.swift
//  Browser002
//
//  Created by Ankit Kumar Bharti on 09/08/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class PreviewController: NSViewController {

    var node:  Node!
    @IBOutlet private weak var imageView: NSImageView!
    @IBOutlet private weak var nameLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let image = NSImage(named: NSImage.Name(node.imageName))
        image?.size = imageView.frame.size
        imageView.image = image
        nameLabel.stringValue = node.name
        
        let clickGesture = NSClickGestureRecognizer(target: self, action: #selector(openImageInPreview))
        clickGesture.numberOfClicksRequired = 2
        imageView.addGestureRecognizer(clickGesture)
    }
    
    @objc func openImageInPreview() {
        
        let fileURL = FileManager.default.temporaryDirectory
        let tempImgFile = fileURL.appendingPathComponent("tempImg001.png")
        let data = imageView.image?.tiffRepresentation
        try? data?.write(to: tempImgFile)
        NSWorkspace.shared.openFile(tempImgFile.path, withApplication: "Preview")
    }
}
