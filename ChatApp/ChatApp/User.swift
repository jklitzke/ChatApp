//
//  User.swift
//  ChatApp
//
//  Created by James Klitzke on 5/17/17.
//  Copyright © 2017 James Klitzke. All rights reserved.
//

import Foundation

/*
 {
 "data": {
 "id": 1,
 "name": "Alex Patoka",
 "email": "alex@orainteractive.com"
 },
 "meta": {}
 }
 */

class JSONModel : NSObject {
    
    init(json: Any?) {
        super.init()
        if let jsonDictionary = json as? [String : Any] {
            setValuesForKeys(jsonDictionary)
        }
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print("WARNING: Tried to set value for undfined key =\(key)")
    }
}

class LoginResponse : JSONModel {
    var data : User?
    var meta : Any?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "data" {
            data = User(json: value)
        }
        else {
            super.setValue(value, forKey: key)
        }
    }
}

class User : JSONModel {
    var id : String?
    var name : String?
    var email : String?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "id" {
                id = String(describing: value ?? "")
        }
        else {
            super.setValue(value, forKey: key)
        }
    }
}

