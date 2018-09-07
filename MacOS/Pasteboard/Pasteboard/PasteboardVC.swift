//
//  PasteboardVC.swift
//  Pasteboard
//
//  Created by Ankit Kumar Bharti on 13/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class PasteboardVC: NSViewController {

    @IBOutlet private weak var imageView: NSImageView!
    private var pasteboardManager = PasteboardManager()
    
    // MARK:- Copy Imageview
    
    @IBAction func copyImage(_ sender: Any) {
        guard let image = imageView.image else { return }
        pasteboardManager.write(image: image)
    }
    
    // MARK:- Paste Imageview
    
    @IBAction func pasteImage(_ sender: Any) {
        if let image = pasteboardManager.readImage() {
            imageView.image = image
        }
    }
    
    // MARK: Cut ImageView
    
    @IBAction func cutImage(_ sender: Any) {
        guard let image = imageView.image else { return }
        if pasteboardManager.write(image: image) {
            imageView.image = nil
        }
    }
    
    // MARK:- Validate MenuItem Visibility
    
    override func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
        switch menuItem.action {
        case #selector(copyImage(_:)):
            return imageView.image != nil
        case #selector(pasteImage(_:)):
            return pasteboardManager.canReadImage()
        case #selector(cutImage(_:)):
            return imageView.image != nil
        default:
            return false
        }
    }
}
