//
//  MenuListViewController.swift
//  MacOSApp002
//
//  Created by Ankit Kumar Bharti on 29/08/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class MenuListViewController: NSViewController {
    
    @IBOutlet weak var mainTableView: NSTableView!
    @IBOutlet weak var friendTableView: NSTableView!
    
    @objc dynamic var menuItems: [MenuItem] {
        return [MenuItem(title: "Now Playing", image: "3"),
                MenuItem(title: "Scrobbles", image: "3"),
                MenuItem(title: "Library", image: "3"),
                MenuItem(title: "Popular", image: "3"),
                MenuItem(title: "Events", image: "3")]
    }
    
    @objc dynamic var persons: [Person] {
        return [Person(name: "Sumit Sharma", image: "3", subTitle: "Chennai, india", time: "1 min"),
                Person(name: "Rohit Shrivastva", image: "3", subTitle: "Pune, India", time: "2 mins"),
                Person(name: "Kailash Kumar", image: "3", subTitle: "Jaipur, india", time: "10 mins")]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.headerView = nil
        friendTableView.headerView = nil
    }
}


extension MenuListViewController: NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return tableView.tag == 0 ? 30.0 : 50.0
    }
}
