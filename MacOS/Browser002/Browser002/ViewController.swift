//
//  ViewController.swift
//  Browser002
//
//  Created by Ankit Kumar Bharti on 09/08/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var browser: NSBrowser!
    
    @objc dynamic var rootNode: Node {
        let ankit = Node(name: "ankit bharti", imageName: "1")
        let rohit = Node(name: "rohit shrivastva", imageName: "4")
        let garima = Node(name: "Garima Sharma", imageName: "3")
        let kailash = Node(name: "Kailash Kumar", imageName: "2")
        
        garima.friends = [kailash]
        rohit.friends = [garima, kailash]
        ankit.friends = [rohit, garima, kailash]
        
        let sumit = Node(name: "Users", friends: [ankit, rohit, garima, kailash])
        let node = Node(name: "Node", imageName: "1", friends: [sumit])
        return node
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForDrag()
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "EEEE, MM/dd/YYYY"
        let day = dateformatter.string(from: Date())
        print(day)
    }
}

// MARK: NSBrowser Delegate

extension ViewController: NSBrowserDelegate {
    
    func rootItem(for browser: NSBrowser) -> Any? {
        browser.setCellClass(NodeCell.self)
        return rootNode
    }
    
    func browser(_ browser: NSBrowser, numberOfChildrenOfItem item: Any?) -> Int {
        guard let node = item as? Node else { return 0 }
        return node.friends.count
    }
    
    func browser(_ browser: NSBrowser, child index: Int, ofItem item: Any?) -> Any {
        guard let node = item as? Node else { return Node() }
        return node.friends[index]
    }
    
    func browser(_ browser: NSBrowser, isLeafItem item: Any?) -> Bool {
        guard let node = item as? Node else { return true }
        return node.friends.count == 0
    }
    
    func browser(_ browser: NSBrowser, objectValueForItem item: Any?) -> Any? {
        guard let node = item as? Node else { return nil }
        return node.name
    }
    
    func browser(_ sender: NSBrowser, willDisplayCell cell: Any, atRow row: Int, column: Int) {
        guard let node = sender.item(atRow: row, inColumn: column) as? Node, let nodeCell = cell as? NodeCell else {
            return
        }
        let image = NSImage(named: NSImage.Name(node.imageName))
        image?.size = NSSize(width: 16.0, height: 16.0)
        nodeCell.image = image
        nodeCell.isLeaf = true
    }
    
    func browser(_ browser: NSBrowser, previewViewControllerForLeafItem item: Any) -> NSViewController? {
        guard let node = item as? Node, let previewController = storyboard?.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("\(PreviewController.self)")) as? PreviewController else { return nil }
        previewController.node = node
        return previewController
    }
}


// MARK: - Drag

extension ViewController {
    
    private func registerForDrag() {
        browser.registerForDraggedTypes([.string])
    }
    
    func browser(_ browser: NSBrowser, writeRowsWith rowIndexes: IndexSet, inColumn column: Int, to pasteboard: NSPasteboard) -> Bool {
        pasteboard.clearContents()
        let pasteboardItem = NSPasteboardItem()
        guard let node = browser.item(atRow: rowIndexes.first!, inColumn: column) as? Node else { return false }
        print(node.name)
        pasteboardItem.setString(node.name, forType: .string)
        return pasteboard.writeObjects([pasteboardItem])
    }
}
