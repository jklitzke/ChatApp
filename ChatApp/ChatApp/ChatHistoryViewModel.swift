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
    
    var chatHistory = [ChatSummary]()
    lazy var oraChatApi = OraChatAPI.sharedInstance

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
        let date = chatSummary.last_chat_message?.created_at ?? ""
        let name = chatSummary.last_chat_message?.user?.name ?? ""
        return "\(name) - \(date)"
    }
    func dataTextForChat(_ section : Int) -> String {
        return String(describing: chatHistory[section].last_chat_message?.created_at)
    }
}
