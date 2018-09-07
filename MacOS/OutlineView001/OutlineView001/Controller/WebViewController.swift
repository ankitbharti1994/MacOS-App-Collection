//
//  WebViewController.swift
//  OutlineView001
//
//  Created by Ankit Kumar Bharti on 26/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa
import WebKit

class WebViewController: NSViewController {
    
    @IBOutlet private weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func load(url: URL) {
        webView.load(URLRequest(url: url))
    }
}
