//
//  Utility.swift
//  Learning01
//
//  Created by Ankit Kumar Bharti on 25/06/18.
//  Copyright © 2018 Ankit Kumar Bharti. All rights reserved.
//

import Cocoa

struct User: Codable {
    var name: String
    var age: Int
    var address: String?
}

extension User: CustomStringConvertible {
    var description: String {
        return "name: \(name) age: \(age)"
    }
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
        self.address = nil
    }
}

extension FileManager {
    static var docURL : URL? {
        guard let documnetURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documnetURL
    }
}


struct Utility {
    
    private lazy var documentURL: URL? = {
        guard var docURL = userDocumentURL else { return nil }
        print(docURL)
        return docURL.appendingPathComponent("User").appendingPathExtension("xml")
    }()
    
    private lazy var userDocumentURL: URL? = {
        guard var userDocURL = FileManager.docURL else { return nil }
        return userDocURL.appendingPathComponent("User", isDirectory: true)
    }()
    
    mutating func createDirectory() {
        if let url = self.userDocumentURL {
            try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
    }
    
    static func systemVoiceNames() -> [String] {
        let voices = NSSpeechSynthesizer.availableVoices
        
        let voiceName = voices.map {
            NSSpeechSynthesizer.attributes(forVoice: $0)[NSSpeechSynthesizer.VoiceAttributeKey.name] as! String
        }
        return voiceName
    }
    
    @discardableResult
    mutating func save(user: User) -> Data? {
        let encoder = PropertyListEncoder()
        do {
            encoder.outputFormat = .xml
            let data = try encoder.encode(user)
            if let url = self.documentURL {
                if FileManager.default.createFile(atPath: url.absoluteString, contents: data, attributes: nil) {
                    print("User saved at : \(url.absoluteString)")
                }
                return data
            }
        }catch {
            fatalError(error.localizedDescription)
        }
        return nil
    }
    
    @discardableResult
    mutating func fetchUser(data: Data?) -> User? {
        
        let decoder = PropertyListDecoder()
        guard let data = data else {
            do {
                if let url = self.documentURL {
                    guard let data = FileManager.default.contents(atPath: url.absoluteString) else { return nil }
                    let user = try decoder.decode(User.self, from: data)
                    return user
                }
                return nil
            }catch{
                fatalError(error.localizedDescription)
            }
        }
        
        do {
                let user = try decoder.decode(User.self, from: data)
                return user
        }catch{
            fatalError(error.localizedDescription)
        }
        return nil
    }

}


extension Int {
    postfix static func ++(value: inout Int) {
        value = value + 1
    }
    
    static postfix func --(value: inout Int) {
        value = value - 1
    }
}
