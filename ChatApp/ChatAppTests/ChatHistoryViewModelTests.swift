//
//  ChatHistoryViewModelTests.swift
//  ChatApp
//
//  Created by James Klitzke on 5/20/17.
//  Copyright © 2017 James Klitzke. All rights reserved.
//

import XCTest
@testable import ChatApp
import AlamofireObjectMapper

class ChatHistoryViewModelTests: XCTestCase {
    
    var viewModel = ChatHistoryViewModel()
    
    override func setUp() {
        super.setUp()
        self.viewModel = ChatHistoryViewModel()
        self.viewModel.chatHistory = [ChatSummary.dummyChatSummary()]
    }
    
    func testNumberOFChats() {
        XCTAssertEqual(viewModel.numberOfChats, 1)
    }
    
    func testChatIdForChat() {
        XCTAssertEqual(viewModel.chatIdForChat(0), 100)
    }
    
    func testLastChatMessageTextForChat() {
        XCTAssertEqual(viewModel.lastChatMessageTextForChat(0),"Hi there!")
    }
    
    func testChatByTextForChat() {
        XCTAssertEqual(viewModel.chatByTextForChat(0),"Some Chat by John Doe")
    }

    func testChatByTextForChat_WithNoChatNameOrUserName() {
        let chatSummary = viewModel.chatHistory[0]
        chatSummary.name = nil
        chatSummary.last_chat_message?.user?.name = nil
        
        XCTAssertEqual(viewModel.chatByTextForChat(0),"Generic Chat by ")
    }
}

extension ChatSummary {
    static func dummyChatSummary() -> ChatSummary {
        let chat = ChatSummary()
        chat.chatId = 100
        chat.name = "Some Chat"
        chat.users = [User.dummyUser()]
        chat.last_chat_message = ChatMessage.dummyChatMessage()
        
        return chat
    }
}

extension User {
    static func dummyUser() -> User {
        let user = User()
        user.email = "test@gmail.com"
        user.name = "John Doe"
        user.userID = 1
        return user
    }
}

extension ChatMessage {
    static func dummyChatMessage() -> ChatMessage {
        let lastChatMessage = ChatMessage()
        lastChatMessage.chat_id = 1
        lastChatMessage.created_at = "2016-12-25T12:00:00+0000"
        lastChatMessage.id = 1
        lastChatMessage.message = "Hi there!"
        lastChatMessage.user = User.dummyUser()
        return lastChatMessage
    }
}
