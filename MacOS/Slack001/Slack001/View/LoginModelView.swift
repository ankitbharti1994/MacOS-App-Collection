//
//  LoginModelView.swift
//  Slack001
//
//  Created by Ankit Kumar Bharti on 07/09/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class LoginModelView: NSView {

    @IBOutlet weak var view: NSView!
    var didClose: (() -> ())?
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        Bundle.main.loadNibNamed(NSNib.Name("\(LoginModelView.self)"), owner: self, topLevelObjects: nil)
        addSubview(self.view)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        setupView()
    }
    
    private func setupView() {
        self.view.frame = NSRect(x: 0, y: 0, width: 475, height: 300)
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = CGColor.white
        self.view.layer?.cornerRadius = 10.0
    }
    
    @IBAction func closeModel(_ sender: Any) {
        didClose?()
    }
}
