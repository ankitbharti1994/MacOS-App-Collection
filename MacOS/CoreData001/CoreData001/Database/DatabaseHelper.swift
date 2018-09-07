//
//  DatabaseHelper.swift
//  CoreData001
//
//  Created by Ankit Kumar Bharti on 19/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import CoreData

struct DatabaseHelper {
    
    // MARK:- create and load the persistent container
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Database")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if error != nil {
                // TODO:- Handle error
            }
        })
        return container
    }()
    
    // MARK:- Save if any changes occured
    mutating func save() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            }catch {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    // MARK:- Perform the task to store, fetch & delete the user
    
    /// store the user to database
    ///
    /// - Parameters:
    ///   - name: name of the user
    ///   - mobile: mobile number of the user
    ///   - address: address of the user
    ///   - image: image of the user
    mutating func storeUser(name: String?, mobile: String?, address: String?, image: Data?) {
        let context = persistentContainer.viewContext
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "\(User.self)", in: context) else { return }
        if let newUser = NSManagedObject(entity: entityDescription, insertInto: context) as? User {
            save(user: newUser, id: Int32.random(Int32.max), name: name, mobile: mobile, address: address, image: image as NSData?)
        }
    }
    
    /// fetch the all avaialble users in database
    ///
    /// - Returns: return the list of users available in database
    mutating func fetchAllUsers() -> [User] {
        let fetchRequest = User.fetchRequest() as NSFetchRequest<User>
        let context = persistentContainer.viewContext
        do {
            let users = try context.fetch(fetchRequest) as [User]
            return users
        }catch {
            return []
        }
    }
    
    
    /// delete a specified user by their id
    ///
    /// - Parameter userID: id of the user
    mutating func delete(userID: Int32) {
        guard let user = findUserBy(id: userID) else { return }
        persistentContainer.viewContext.delete(user)
        save()
    }
    
    
    /// Update user by ID
    ///
    /// - Parameters:
    ///   - userID: user id
    ///   - name: name of the user
    ///   - mobile: mobile number of the user
    ///   - address: address of the user
    ///   - image: image of the user
    mutating func update(userID: Int32, name: String?, mobile: String?, address: String?, image: NSData?) {
        guard let user = findUserBy(id: userID) else { return }
        save(user: user,id: userID, name: name, mobile: mobile, address: address, image: image)
    }
    
    // MARK:- Private methods for find user by id and store new user or update existing user
    
    /// find user by user id
    ///
    /// - Parameter id: id of the user
    /// - Returns: return the user if found in the database
    mutating private func findUserBy(id: Int32) -> User? {
        let fetchRequest = User.fetchRequest() as NSFetchRequest<User>
        let context = persistentContainer.viewContext
        let predicate = NSPredicate(format: "%K = %d", argumentArray: [#keyPath(User.id), id])
        fetchRequest.predicate = predicate
        do {
            let users = try context.fetch(fetchRequest) as [User]
            guard let user = users.first else { return nil }
            return user
        }catch {
            return nil
        }
    }
    
    /// save the new user or update the existing one
    ///
    /// - Parameters:
    ///   - id: user id
    ///   - name: name of the user
    ///   - mobile: mobile number of the user
    ///   - address: address of the user
    ///   - image: image of the user
    mutating private func save(user: User, id: Int32, name: String?, mobile: String?, address: String?, image: NSData?) {
        user.id = id
        user.name = name
        user.mobile = mobile
        user.address = address
        user.image = image
        save()
    }
}
