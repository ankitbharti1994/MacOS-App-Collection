//
//  EditUserViewController.swift
//  CoreData001
//
//  Created by Ankit Kumar Bharti on 19/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class EditUserViewController: NSViewController {

    // MARK:- Properties
    @IBOutlet weak var nameTextfield: NSTextField!
    @IBOutlet weak var mobileTextField: NSTextField!
    @IBOutlet weak var addressTextfield: NSTextField!
    @IBOutlet weak var imageView: DraggableImageView!
    lazy var databaseHelper = DatabaseHelper()
    lazy var pasteboardManager = PasteboardManager()
    
    typealias SaveUserCompletionBlock = (TempUser?) -> Void
    var saveUser: SaveUserCompletionBlock? = nil
    
    typealias UpdateUserCompletionBlock = (TempUser?) -> Void
    var updateUser: UpdateUserCompletionBlock? = nil
    
    var user: User?
    
    // MARK:- Controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.processImage = {[unowned self] in
            self.imageView.image = $0
        }
        if let userToUpdate = user {
            if let data = userToUpdate.image {
                imageView.image = NSImage(data: data as Data)
            }
            nameTextfield.stringValue = user?.name ?? ""
            mobileTextField.stringValue = user?.mobile ?? ""
            addressTextfield.stringValue = user?.address ?? ""
        }
    }
    
    // MARK:- Paste the copied image
    @IBAction func pasteImage(_ sender: Any) {
        imageView.image = pasteboardManager.pasteImage()
    }
    
    // MARK:- Pick profile picture from computer
    @IBAction func pickProfilePicture(_ sender: Any) {
        let openPanel = NSOpenPanel()
        openPanel.allowedFileTypes = ["png","jpg"]
        let modalResponse = openPanel.runModal()
        if modalResponse == .OK {
            guard let imageURL = openPanel.url else { return }
            self.imageView.image = NSImage(contentsOf: imageURL)
        }
    }
    
    // MARK:- Save user
    @IBAction func saveUser(_ sender: Any) {
        guard !nameTextfield.stringValue.isEmpty, !mobileTextField.stringValue.isEmpty, !addressTextfield.stringValue.isEmpty else {
            presentAlert(messageText: "Please fill the required Info", informativeText: "please check if you have missed to fill name, mobile or address.")
            return
        }
        if let userToUpdate = user {
            updateUser?(TempUser(id: userToUpdate.id, name: nameTextfield.stringValue, mobile: mobileTextField.stringValue, address: addressTextfield.stringValue, image: imageView.image?.tiffRepresentation))
        }else {
            saveUser?(TempUser(name: nameTextfield.stringValue, mobile: mobileTextField.stringValue, address: addressTextfield.stringValue, image: imageView.image?.tiffRepresentation))
        }
        self.dismissViewController(self)
    }
    
    @IBAction func cancelEditing(_ sender: Any) {
        self.dismissViewController(self)
    }
    
    // MARK:- Validate paste menu item in menu bar
    override func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
        switch menuItem.action {
        case #selector(pasteImage(_:)):
            return pasteboardManager.canReadImage()
        default:
            return false
        }
    }
}
