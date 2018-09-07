//
//  FriendsListVC.swift
//  CoreData001
//
//  Created by Ankit Kumar Bharti on 19/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class FriendsListVC: NSViewController {

    // MARK:- Properties
    @IBOutlet weak var tableView: NSTableView!
    lazy var databaseHelper = DatabaseHelper()
    private var fetchedResultController: NSFetchedResultsController<User>?
    private var canDeleteUser: Bool {
        guard let objects = fetchedResultController?.fetchedObjects, objects.count > 0, (0..<objects.count).contains(tableView.selectedRow) else { return false }
        return true
    }
    @objc dynamic var canRemoveUser = false
    
    // MARK:- Cell Identifiers
    enum CellIdentifier {
        static let name     = "NameCell"
        static let mobile   = "MobileCell"
        static let address  = "AddressCell"
    }
    
    // MARK:- Controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupFetchedResultController()
        //storeDummyFriends()
    }
    
    private func storeDummyFriends() {
        
        DispatchQueue.global(qos: .background).async {
            let _ = self.duummyFriends().map { user in
                DispatchQueue.main.async {
                    self.databaseHelper.storeUser(name: user.name, mobile: user.mobile, address: user.address, image: user.image)
                }
            }
        }
    }
    
    fileprivate func duummyFriends() -> [TempUser] {
        var users: [TempUser] = []
        for _ in 0...100 {
            let user = TempUser(name: "xyz", mobile: "93673673677", address: "sdfgsdkjgskd", image: NSImage(named: NSImage.Name(rawValue: "user"))?.tiffRepresentation)
            users.append(user)
        }
        return users
    }
    
    // MARK:- Setup Tableview for Double Click Action
    private func setupTableView() {
        tableView.doubleAction = #selector(updateFriendInfo)
    }
    
    // MARK:- Setup for fetched Result Controller
    private func setupFetchedResultController() {
        let fetchRequest = User.fetchRequest() as NSFetchRequest<User>
        let sortByID = NSSortDescriptor(key: #keyPath(User.id), ascending: true)
        fetchRequest.sortDescriptors = [sortByID]
        fetchedResultController = NSFetchedResultsController<User>(fetchRequest: fetchRequest, managedObjectContext: databaseHelper.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController?.delegate = self
        do {
            try fetchedResultController?.performFetch()
        }catch {
            fatalError(error.localizedDescription)
        }
    }
    
    // MARK:- Remove selected friends
    @IBAction func removeFriends(_ sender: Any) {
        databaseHelper.delete(userID: (fetchedResultController?.fetchedObjects?[tableView.selectedRow].id)!)
    }
    
    // MARK:- Update Friend Info
    @objc private func updateFriendInfo() {
        guard let user = fetchedResultController?.object(at: IndexPath(item: tableView.selectedRow, section: 0)) else { return }
        performSegue(withIdentifier: NSStoryboardSegue.Identifier(rawValue: "\(EditUserViewController.self)"), sender: user)
    }
    
    // MARK: - Print
    
    @IBAction func printFriendsList(_ sender: Any) {
        NSPrintOperation(view: tableView).run()
    }
}

// MARK:- NSTableViewDataSource
extension FriendsListVC: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return fetchedResultController?.fetchedObjects?.count ?? 0
    }
}

// MARK:- NSTableViewDelegate
extension FriendsListVC: NSTableViewDelegate {
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        canRemoveUser = canDeleteUser
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        guard let user = fetchedResultController?.fetchedObjects?[row] else { return nil }
        
        var cellIdentifier = ""
        var image: NSImage? = nil
        var text: String?
        
        switch tableColumn {
        case tableView.tableColumns[0]:
            if let data = user.image as Data? {
                image = NSImage(data: data)
            }
            text = user.name
            cellIdentifier = CellIdentifier.name
        case tableView.tableColumns[1]:
            text = user.mobile
            cellIdentifier = CellIdentifier.mobile
        case tableView.tableColumns[2]:
            text = user.address
            cellIdentifier = CellIdentifier.address
        default:
            fatalError()
        }
        
        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: self) as? NSTableCellView {
            cell.imageView?.image = image
            cell.textField?.stringValue = text ?? ""
            return cell
        }
        
        return nil
        
    }
}

// MARK:- NSFetchedResultsControllerDelegate
extension FriendsListVC: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: IndexSet(integer: indexPath.item), withAnimation: .effectFade)
            }
        case .update:
            if let indexPath = indexPath {
                tableView.reloadData(forRowIndexes: IndexSet(integer: indexPath.item), columnIndexes: IndexSet(integersIn: 0...tableView.tableColumns.count - 1))
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.removeRows(at: IndexSet(integer: indexPath.item), withAnimation: .effectFade)
            }
        case .move:
            return
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}

// MARK:- Navigation
extension FriendsListVC {
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        guard segue.identifier!.rawValue == "\(EditUserViewController.self)", let controller = segue.destinationController as? EditUserViewController else { return }
        controller.user = sender as? User
        controller.saveUser = {[weak self] in
            self?.databaseHelper.storeUser(name: $0?.name, mobile: $0?.mobile, address: $0?.address, image: $0?.image)
        }
        
        controller.updateUser = {[weak self] in
            self?.databaseHelper.update(userID: $0!.id!, name: $0?.name, mobile: $0?.mobile, address: $0?.address, image: $0?.image as NSData?)
        }
    }
}
