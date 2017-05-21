//
//  ChatHistoryViewModel.swift
//  ChatApp
//
//  Created by James Klitzke on 5/18/17.
//  Copyright © 2017 James Klitzke. All rights reserved.
//

import Foundation

class ChatHistoryViewModel {
    typealias GetChatHistorySuccess = () -> Void
    typealias GetChatHistoryFailure = () -> Void
    typealias CreateChatSuccess = () -> Void
    typealias CreateChatFailure = () -> Void

    var chatHistory = [ChatSummary]()
    lazy var oraChatApi = OraChatAPI.sharedInstance
    let friendlyDateFormatter = DateFormatter.userFrinedlyDateFormatter()

    func getChatHistory(success : @escaping GetChatHistorySuccess, failure: @escaping GetChatHistoryFailure ) {
        oraChatApi.getChatHistory(success: {
            chatHistory in
            self.chatHistory = chatHistory
            success()
        }, failure: {
            error in
            failure()
        })
    }
    
    func createChat(name: String, message : String, success : @escaping CreateChatSuccess, failure: @escaping CreateChatFailure ) {
        oraChatApi.createChat(name: name, message: message, success: {
            chatHistory in
            self.chatHistory.append(chatHistory)
            success()
        }, failure: {
            error in
            failure()
        })
    }
    
    var numberOfChats : Int {
        return chatHistory.count
    }
 
    func chatIdForChat(_ section : Int) -> Int? {
        return chatHistory[section].chatId
    }
    
    func lastChatMessageTextForChat(_ section : Int) -> String {
        return chatHistory[section].last_chat_message?.message ?? ""
    }
    
    func chatByTextForChat(_ section : Int) -> String {
        let chatSummary = chatHistory[section]
        let chatName = chatSummary.name ?? "Generic Chat"
        let person = chatSummary.last_chat_message?.user?.name ?? ""
        return "\(chatName) by \(person)"
    }
    
    func lastChatSummaryTextForChat(_ section : Int) -> String {
        let chatSummary = chatHistory[section]
        let formattedDate = getFriendlyDateForDate(chatSummary.last_chat_message?.createdAtDate)
        
        let name = chatSummary.last_chat_message?.user?.name ?? ""
        return "\(name) - \(formattedDate)"
    }
    
    func dataTextForChat(_ section : Int) -> String {
        return getFriendlyDateForDate(chatHistory[section].last_chat_message?.createdAtDate)
    }
    
    func getFriendlyDateForDate(_ date : Date?) -> String {
        guard let date = date else {
            return ""
        }
        
        return friendlyDateFormatter.string(from: date)
    }
}
