//
//  OraChatAPI.swift
//  ChatApp
//
//  Created by James Klitzke on 5/17/17.
//  Copyright © 2017 James Klitzke. All rights reserved.
//

import Foundation
import Alamofire

class OraChatAPI {
    
    static let sharedInstance = OraChatAPI()
    let baseURL = "https://private-93240c-oracodechallenge.apiary-mock.com/"
    let loginOp = "auth/login"
    let createUserOp = "users"
    let chatsOp = "chats"
    var currentLoggedInUser : User?
    
    typealias LoginUserSuccess = (_ user : User) -> Void
    typealias LoginUserFailure = (_ error : Error) -> Void
    
    func login(email : String, password : String, success : @escaping LoginUserSuccess, failure : @escaping LoginUserFailure) {
        let url = baseURL + loginOp
        
        let paramaters : Parameters = [
            "email": email,
            "password": password
        ]
        
        Alamofire.request(url, method: .post, parameters: paramaters, encoding: JSONEncoding.default, headers: nil)
            .validate()
            .responseJSON {
                response in
                switch response.result {
                case .success:
                    print("Validation Successful")
                case .failure(let error):
                    print(error)
                    failure(error)
                }
                
                let loginResponse = response.flatMap { json in
                    LoginResponse(json: json)
                }
                
                print("resp=\(loginResponse)")
                if let user = loginResponse.result.value?.data {
                    self.currentLoggedInUser = user
                    success(user)
                }
                else {
                    failure(NSError(domain: "Could Not Create User Object", code: -1, userInfo: nil))
                }
            }
    }
    
    func createUser(_ user : User) {
        let url = baseURL + createUserOp
        
        let paramaters : Parameters = [
            "name": user.name ?? "",
            "email": user.email ?? "",
            "password" : "something",
            "password_confirmation" : "something"
        ]
        Alamofire.request(url, method: .post, parameters: paramaters, encoding: JSONEncoding.default, headers: nil)
            .validate()
            .responseJSON {
                response in
                switch response.result {
                case .success:
                    print("Validation Successful")
                case .failure(let error):
                    print(error)
                }
                
                let loginResponse = response.flatMap { json in
                    LoginResponse(json: json)
                }
                
                print("resp=\(loginResponse)")
        }
    }
}
