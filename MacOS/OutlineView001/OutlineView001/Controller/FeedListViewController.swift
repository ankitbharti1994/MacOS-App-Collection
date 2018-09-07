//
//  FeedListViewController.swift
//  OutlineView001
//
//  Created by Ankit Kumar Bharti on 26/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class FeedListViewController: NSViewController {

    @IBOutlet weak var outlineView: NSOutlineView!
    private var feeds: [Feed] = []
    var dateFormatter : DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    var didSelectedItem: ((String) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            feeds = try Feed.feedList()
            outlineView.reloadData()
        }catch {
            print(error)
        }
    }
}


extension FeedListViewController: NSOutlineViewDataSource {
    
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        if let feed = item as? Feed {
            return feed.items.count
        }
        return feeds.count
    }
    
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        if let feed = item as? Feed {
            return feed.items[index]
        }
        return feeds[index]
    }
    
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        if let feed = item as? Feed {
            return feed.items.count > 0
        }
        return false
    }
}


extension FeedListViewController: NSOutlineViewDelegate {
    
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        var view: NSTableCellView?
        
        if let feed = item as? Feed {
            if tableColumn?.identifier == NSUserInterfaceItemIdentifier(rawValue: "DateColumn") {
                view = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "DateCell"), owner: self) as? NSTableCellView
                if let textField = view?.textField {
                    textField.stringValue = ""
                    textField.sizeToFit()
                }
            }else {
                view = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "FeedCell"), owner: self) as? NSTableCellView
                if let textField = view?.textField {
                    textField.stringValue = feed.name
                    textField.sizeToFit()
                }
            }
        }else if let feedItem = item as? FeedItem {
            if (tableColumn?.identifier)!.rawValue == "DateColumn" {
                view = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "DateCell"), owner: self) as? NSTableCellView
                if let textField = view?.textField {
                    textField.stringValue = dateFormatter.string(from: feedItem.date)
                    textField.sizeToFit()
                }
            }else {
                view = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "FeedCell"), owner: self) as? NSTableCellView
                if let textField = view?.textField {
                    textField.stringValue = feedItem.title
                    textField.sizeToFit()
                }
            }
        }
        
        return view
    }
    
    func outlineViewSelectionDidChange(_ notification: Notification) {
        guard let outlineView = notification.object as? NSOutlineView else { return }
        let selectedIndex = outlineView.selectedRow
        if let feedItem = outlineView.item(atRow: selectedIndex) as? FeedItem {
            didSelectedItem?(feedItem.url)
        }
    }
}
