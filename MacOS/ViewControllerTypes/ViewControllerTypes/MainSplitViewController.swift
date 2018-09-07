//
//  MainSplitViewController.swift
//  ViewControllerTypes
//
//  Created by Ankit Kumar Bharti on 20/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class MainSplitViewController: NSSplitViewController {

    private var listViewController: ListViewController {
        return self.splitViewItems.first?.viewController as! ListViewController
    }
    
    private var browserViewController: BrowserViewController {
        return self.splitViewItems.last?.viewController as! BrowserViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listViewController.delegate = self
        loadDefaultPage()
    }
    
    func loadDefaultPage() {
        let google = Website(name: "Google", url: "https://google.co.in")
        self.view.window?.title = google.name
        browserViewController.load(urlString: google.url)
    }
}

extension MainSplitViewController: ListViewControllerDelegate {
    func didSelect(website: Website) {
        browserViewController.load(urlString: website.url)
        self.view.window?.title = website.name
    }
}
