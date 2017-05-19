//
//  CreateUserViewModel.swift
//  ChatApp
//
//  Created by James Klitzke on 5/19/17.
//  Copyright © 2017 James Klitzke. All rights reserved.
//

import Foundation

class CreateUserViewModel {
    
    typealias CreateUserSuccess = () -> Void
    typealias CreateUserFailure = () -> Void

    lazy var oraChatApi = OraChatAPI.sharedInstance
    var registeredUser : User?

    func createUser(user : CreateUserRequest, success : @escaping CreateUserSuccess, failure: @escaping CreateUserFailure ) {
        oraChatApi.createUser(user, success: {
            user in
            self.registeredUser = user
            success()
        }, failure: {
            error in
            failure()
        })
    }
    
    func isValidEmailForUser(_ user : CreateUserRequest) -> Bool {
        return user.email.characters.count > 0
    }

    func isValidNameForUser(_ user : CreateUserRequest) -> Bool {
        return user.userName.characters.count > 0
    }
    func isValidPasswordForUser(_ user : CreateUserRequest) -> Bool {
        return user.password.characters.count > 0
    }
    
    func passwordFieldsMatch(_ user : CreateUserRequest) -> Bool {
        return user.password == user.confirmPassword
    }
}
