//
//  LoggedInUserViewModel.swift
//  ChatApp
//
//  Created by James Klitzke on 5/18/17.
//  Copyright © 2017 James Klitzke. All rights reserved.
//

import Foundation

class LoggedInUserViewModel {
    
    typealias LoginUserSuccess = () -> Void
    typealias LoginUserFailure = () -> Void
    
    var loggedInUser : User?
    lazy var oraChatApi = OraChatAPI.sharedInstance
    
    var email : String {
        return loggedInUser?.email ?? ""
    }

    var name : String {
        return loggedInUser?.name ?? ""
    }
    
    init() {
        loggedInUser = oraChatApi.currentLoggedInUser
    }
    
    func fetchUserWith(email: String, password: String, successClosure : @escaping LoginUserSuccess, failureClosure: @escaping LoginUserFailure ) {
        oraChatApi.login(email: email, password: password, success: {
            user in
            self.loggedInUser = user
            successClosure()
        }, failure: {
            error in
            failureClosure()
        })
    }
    
    func isValidEmail(_ email : String) -> Bool {
        return !email.isEmpty
    }
    
    func isValidPassword(_ password : String) -> Bool {
        return !password.isEmpty
    }
}
