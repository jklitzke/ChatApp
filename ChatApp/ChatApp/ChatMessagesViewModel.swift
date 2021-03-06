//
//  ChatMessagesViewModel.swift
//  ChatApp
//
//  Created by James Klitzke on 5/18/17.
//  Copyright © 2017 James Klitzke. All rights reserved.
//

import Foundation

class ChatMessagesViewModel {
    typealias GetChatMessagesSuccess = () -> Void
    typealias GetChatMessagesFailure = () -> Void

    typealias CreateChatMessagesSuccess = () -> Void
    typealias CreateChatMessagesFailure = () -> Void

    var chatMessages = [ChatMessage]()
    var chatId : Int?
    lazy var oraChatApi = OraChatAPI.sharedInstance
    var currentLoggedInUser : User?
    let friendlyDateFormatter = DateFormatter.userFrinedlyDateFormatter()

    init(id : Int? ) {
        chatId = id
        currentLoggedInUser = oraChatApi.currentLoggedInUser
    }
    
    func createChatMessage(_ message : String, success : @escaping CreateChatMessagesSuccess, failure: @escaping CreateChatMessagesFailure) {
        guard let chatId = chatId else {
            failure()
            return
        }
        oraChatApi.createChatMessage(id: chatId, message: message, success: {
            chatMessage in
            self.chatMessages.append(chatMessage)
            success()
            
        }, failure: {
            error in
            failure()
        })
        
    }
    
    func getChatMessages(success : @escaping GetChatMessagesSuccess, failure: @escaping GetChatMessagesFailure) {
        guard let chatId = chatId else {
            failure()
            return
        }
        oraChatApi.getChatMessages(id: chatId, success: {
            chatMessages in
            self.chatMessages = chatMessages
            success()
        }, failure: {
            error in
            failure()
        })
    }
    
    var numberOfChatMessages : Int {
        return chatMessages.count
    }
    
    func isLoggedInUsersMessage(_ index : Int) -> Bool {
        let message = chatMessages[index]
        
        return message.user_id == currentLoggedInUser?.userID
    }
    
    func textForMessage(_ index : Int) -> String {
        return chatMessages[index].message ?? ""
    }
    
    func detailTextForMessage(_ index : Int) -> String {
        let userFriendlyDate : String
        
        if let date = chatMessages[index].createdAtDate {
            userFriendlyDate =  friendlyDateFormatter.string(from: date)
        }
        else {
            userFriendlyDate = ""
        }
        return "\(chatMessages[index].user?.name ?? "") - \(userFriendlyDate) "
    }
}
