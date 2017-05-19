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
    
    
}
