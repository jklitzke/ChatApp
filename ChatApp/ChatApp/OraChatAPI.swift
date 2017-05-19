//
//  OraChatAPI.swift
//  ChatApp
//
//  Created by James Klitzke on 5/17/17.
//  Copyright © 2017 James Klitzke. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class OraChatAPI {
    
    static let sharedInstance = OraChatAPI()
    let baseURL = "https://private-93240c-oracodechallenge.apiary-mock.com/"
    let loginOp = "auth/login"
    let createUserOp = "users"
    let chatsOp = "chats"
    var currentLoggedInUser : User?
    
    typealias LoginUserSuccess = (_ user : User) -> Void
    typealias CreateUserSuccess = (_ user : User) -> Void
    typealias ChatHistorySuccess = (_ chatSummaries : [ChatSummary]) -> Void
    typealias ChatMessagesSuccess = (_ chatMessages : [ChatMessage]) -> Void
    typealias ApiFailure = (_ error : Error) -> Void
    
    
    func login(email : String, password : String, success : @escaping LoginUserSuccess, failure : @escaping ApiFailure) {
        let url = baseURL + loginOp
        
        let paramaters : Parameters = [
            "email": email,
            "password": password
        ]
        
        Alamofire.request(url, method: .post, parameters: paramaters, encoding: JSONEncoding.default, headers: nil)
            .validate()
            .responseObject {
                (response : DataResponse<LoginResponse>) in
                
                switch response.result {
                case .success:
                    let loginResponse = response.result.value!.data!
                    self.currentLoggedInUser = loginResponse
                    success(loginResponse)
                case .failure(let error):
                    failure(error)
                }
            }
    }
    
    func createUser(_ user : CreateUserRequest, success : @escaping CreateUserSuccess, failure : @escaping ApiFailure) {
        let url = baseURL + createUserOp
        
        let paramaters : Parameters = [
            "name": user.userName,
            "email": user.email,
            "password" : user.password,
            "password_confirmation" : user.confirmPassword
        ]
        
        Alamofire.request(url, method: .post, parameters: paramaters, encoding: JSONEncoding.default, headers: nil)
            .validate()
            .responseObject {
                (response : DataResponse<LoginResponse>) in
                switch response.result {
                case .success:
                    let loginResponse = response.result.value!.data!
                    self.currentLoggedInUser = loginResponse
                    success(loginResponse)
                case .failure(let error):
                    failure(error)
                }
        }
    }
    
    func getChatHistory(success: @escaping ChatHistorySuccess, failure : @escaping ApiFailure) {
        let url = baseURL + chatsOp + "?page=1&limit=50"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .validate()
            .responseObject {
                (response : DataResponse<ChatHistoryResponse>) in
        
                switch response.result {
                case .success:
                    let chatHistoryResponse = response.result.value!.data!
                    success(chatHistoryResponse)
                case .failure(let error):
                    print(error)
                    failure(error)
                }
        }
    }
    
    func getChatMessages(id : Int, success : @escaping ChatMessagesSuccess, failure : @escaping ApiFailure) {
        let url = baseURL + chatsOp + "/\(id)/chat_messages"
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .validate()
            .responseObject {
                (response : DataResponse<ChatMessagesResponse>) in
                
                switch response.result {
                case .success:
                    let chatMessages = response.result.value!.data!
                    success(chatMessages)
                case .failure(let error):
                    print(error)
                    failure(error)
                }
        }
    }
}
