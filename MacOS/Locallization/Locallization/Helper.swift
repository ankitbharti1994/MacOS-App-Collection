//
//  Helper.swift
//  Locallization
//
//  Created by Ankit Kumar Bharti on 18/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Foundation

enum LanguageName: String {
    case english = "en"
    case french  = "fr"
    case russian = "ru"
}

extension String {
    
    func localized(by languageCode: LanguageName = .english) -> String {
        guard let languagePath = Bundle.main.path(forResource: languageCode.rawValue, ofType: "lproj") else { return self }
        guard let bundle = Bundle(path: languagePath) else { return self }
        let valueString = bundle.localizedString(forKey: self, value: nil, table: nil)
        return valueString
    }
}

class User: NSObject,NSCoding {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: "name") as? String else { return nil }
        self.init(name: name, age: aDecoder.decodeInteger(forKey: "age"))
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(age, forKey: "age")
    }
}
