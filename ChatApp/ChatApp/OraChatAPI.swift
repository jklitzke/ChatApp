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
    
    func createUser(_ user : User) {
        let loginURL = baseURL + createUserOp
        
        let paramaters : Parameters = [
            "name": user.name ?? "",
            "email": user.email ?? "",
            "password" : "something",
            "password_confirmation" : "something"
        ]
        Alamofire.request(loginURL, method: .post, parameters: paramaters, encoding: JSONEncoding.default, headers: nil)
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
    
    func login(email : String, password : String) {
        let loginURL = baseURL + loginOp
        
        let paramaters : Parameters = [
            "email": email,
            "password": password
        ]
        
        Alamofire.request(loginURL, method: .post, parameters: paramaters, encoding: JSONEncoding.default, headers: nil)
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
