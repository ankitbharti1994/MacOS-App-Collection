//
//  ViewController.swift
//  Slack001
//
//  Created by Ankit Kumar Bharti on 06/09/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

enum ModelType {
    case LoginModel
}

class MainViewController: NSViewController, ModelPresentation {

    @IBOutlet weak var profileStackView: NSStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.darkGreen.cgColor
    }

    @IBAction func presentModel(_ sender: Any) {
        present(.LoginModel, relativeTo: profileStackView)
    }
}

