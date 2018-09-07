//
//  FriendsVC.swift
//  outlineViewWithBinding
//
//  Created by Ankit Kumar Bharti on 26/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class FriendsVC: NSViewController {

    @objc dynamic var branches: [Branch] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            branches = try DataManager.data()
        }catch {
            print(error)
        }
    }
}
