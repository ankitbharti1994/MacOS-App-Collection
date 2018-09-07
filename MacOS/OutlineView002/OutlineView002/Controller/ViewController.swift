//
//  ViewController.swift
//  OutlineView002
//
//  Created by Ankit Kumar Bharti on 26/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var outlineView: NSOutlineView!

    private var branchList: [Branch] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let higherPriorityQueue = DispatchQueue.global(qos: .utility)
        
        DataManager.data(queue: higherPriorityQueue) {
            print("-------------------heigher priority data------------------------")
            print($0)
            print("-------------------heigher priority data End------------------------")
        }
        
        DataManager.data {[unowned self] in
            self.branchList = $0
            print("--------------lower priority data-------------------")
            print($0)
            print("--------------lower priority data End-------------------")
            DispatchQueue.main.async {
                self.outlineView.reloadData()
            }
        }
    }
}


extension ViewController: NSOutlineViewDataSource {
    
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        if let branch = item as? Branch {
            return branch.students.count
        }else if let students = item as? Student {
            return students.hobbies.count
        }
        return branchList.count
    }
    
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        if let branch = item as? Branch {
            return branch.students[index]
        }else if let students = item as? Student {
            return students.hobbies[index]
        }
        return branchList[index]
    }
    
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        if let branch = item as? Branch {
            return branch.students.count > 0
        }else if let students = item as? Student {
            return students.hobbies.count > 0
        }
        return false
    }
}


extension ViewController: NSOutlineViewDelegate {
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        let view = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "Cell"), owner: self) as? NSTableCellView
        
        if let branch = item as? Branch {
            view?.textField?.stringValue = branch.title
        }else if let students = item as? Student {
            view?.textField?.stringValue = students.name
        }else if let hobbies = item as? String {
            view?.textField?.stringValue = hobbies
        }
        
        return view
    }
}
