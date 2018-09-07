//
//  FeedSplitViewController.swift
//  OutlineView001
//
//  Created by Ankit Kumar Bharti on 26/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class FeedSplitViewController: NSSplitViewController {

    var feedListViewController: FeedListViewController {
        return self.childViewControllers.first as! FeedListViewController
    }
    
    var webViewController: WebViewController {
        return self.childViewControllers.last as! WebViewController
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedListViewController.didSelectedItem = {[unowned self] in
            let url = URL(string: $0)!
            self.webViewController.load(url: url)
        }
    }
}
