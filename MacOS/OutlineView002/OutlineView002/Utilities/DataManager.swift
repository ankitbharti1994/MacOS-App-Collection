//
//  DataManager.swift
//  OutlineView002
//
//  Created by Ankit Kumar Bharti on 26/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Foundation

struct DataManager {
    private static let semaphore = DispatchSemaphore(value: 1)
    static func data(queue: DispatchQueue = DispatchQueue.global(), _ completion: @escaping ([Branch]) -> ()) {
        queue.async {
            guard let fileURL = Bundle.main.url(forResource: "FriendsList", withExtension: "json") else { return }
            DataManager.semaphore.wait()
            do {
                let data = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                let branches = try decoder.decode([Branch].self, from: data)
                completion(branches)
            }catch {
                print(error.localizedDescription)
                completion([])
            }
            DataManager.semaphore.signal()
        }
    }
}
