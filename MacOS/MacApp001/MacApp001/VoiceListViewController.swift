//
//  VoiceListViewController.swift
//  MacApp001
//
//  Created by Ankit Kumar Bharti on 26/06/18.
//  Copyright © 2018 Ankit Kumar Bharti. All rights reserved.
//

import Cocoa

class VoiceListViewController: NSViewController {
    
    lazy var voiceNames: [String] = {
       return Utility.systemVoiceNames()
    }()
    
    var preselectedVoice = 0
    
    @IBOutlet private weak var tableView: NSTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        preselectedVoice = voiceNames.count - 2
        let index = IndexSet(integer: preselectedVoice)
        tableView.selectColumnIndexes(index, byExtendingSelection: false)
        tableView.scrollRowToVisible(preselectedVoice)
    }
    
}

extension VoiceListViewController: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return voiceNames.count
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        let voice = voiceNames[row]
        return voice
    }
}

extension VoiceListViewController: NSTableViewDelegate {
    func tableViewSelectionDidChange(_ notification: Notification) {
        performSegue(withIdentifier: NSStoryboardSegue.Identifier.init(rawValue: "binding"), sender: nil)
    }
}
