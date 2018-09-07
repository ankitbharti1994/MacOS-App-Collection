//
//  ListViewController.swift
//  ViewControllerTypes
//
//  Created by Ankit Kumar Bharti on 20/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

protocol ListViewControllerDelegate: AnyObject {
    func didSelect(website: Website)
}

class ListViewController: NSViewController {

    @objc dynamic var websites: [Website] {
        return [Website(name: "Google", url: "https://www.google.co.in"),
                Website(name: "Raywenderlich", url: "https://www.raywenderlich.com"),
                Website(name: "Exilant Mail", url: "https://mail.exilant.com/"),
                Website(name: "Exis App", url: "https://exis.exilant.com/"),
                Website(name: "Apple Developer", url: "https://developer.apple.com")
        ]
    }
    
    weak var delegate: ListViewControllerDelegate?
    
    @IBOutlet weak var arrayController: NSArrayController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func selectWebsite(_ sender: Any) {
        guard let website = arrayController.selectedObjects.first as? Website else { return }
        delegate?.didSelect(website: website)
    }
}

