//
//  ViewController.swift
//  TableView002
//
//  Created by Ankit Kumar Bharti on 18/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

fileprivate struct User {
    let name: String
    let age: Int
    let address: String
}

class ViewController: NSViewController {

    private let users = [User(name: "ankit bharti", age: 24, address: "bangalore")]
    @IBOutlet weak var tableView: NSTableView!
    
    enum CellIdentifier {
        static let nameCell = "NameCell"
        static let ageCell = "AgeCell"
        static let addressCell = "AddressCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK:- NSTableView DataSource

extension ViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return users.count
    }
}


// MARK:- NSTableViewDelegate

extension ViewController: NSTableViewDelegate {
    func tableViewSelectionDidChange(_ notification: Notification) {
        let user = users[tableView.selectedRow]
        print(user)
    }
    
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        var cellIdentifier = ""
        var txt = ""
        
        switch tableColumn {
        case tableView.tableColumns[0]:
            txt = users[row].name
            cellIdentifier = CellIdentifier.nameCell
        case tableView.tableColumns[1]:
            txt = "\(users[row].age)"
            cellIdentifier = CellIdentifier.ageCell
        case tableView.tableColumns[2]:
            txt = users[row].address
            cellIdentifier = CellIdentifier.addressCell
        default:
            return nil
        }
        
        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = txt
            return cell
        }
        
        return nil
    }
}


