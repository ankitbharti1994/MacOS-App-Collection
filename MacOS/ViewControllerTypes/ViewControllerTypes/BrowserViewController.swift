//
//  BrowserViewController.swift
//  ViewControllerTypes
//
//  Created by Ankit Kumar Bharti on 20/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa
import WebKit

class BrowserViewController: NSViewController {
    
    @IBOutlet private weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func load(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
