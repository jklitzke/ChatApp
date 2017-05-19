//
//  ChatSummaryModels.swift
//  ChatApp
//
//  Created by James Klitzke on 5/18/17.
//  Copyright © 2017 James Klitzke. All rights reserved.
//

import Foundation
import ObjectMapper


class LoginResponse : Mappable {
    var data : User?
    var meta : Any?
    
    required init?(map : Map) {
        
    }
    
    func mapping(map: Map) {
        data <- map["data"]
        meta <- map["meta"]
    }
    
}

class ChatHistoryResponse : Mappable {
    var data : [ChatSummary]?
    var meta : Any?
    
    required init?(map : Map) {
        
    }
    
    func mapping(map: Map) {
        data <- map["data"]
        meta <- map["meta"]
    }
}

class ChatSummary : Mappable {
    var chatId : Int?
    var name : String?
    var users : [User]?
    var last_chat_message : LastChatMessage?
    
    required init?(map : Map) {
        
    }
    
    func mapping(map: Map) {
        chatId <- map["id"]
        name <- map["name"]
        users <- map["users"]
        last_chat_message <- map["last_chat_message"]
    }
}

class User : Mappable {

    var userID : Int?
    var email : String?
    var name : String?
    
    required init?(map : Map) {
        
    }
    
    func mapping(map: Map) {
        userID <- map["id"]
        name <- map["name"]
        email <- map["email"]
    }

}

class LastChatMessage : Mappable {
    var id : Int?
    var chat_id : String?
    var message : String?
    var created_at : String?
    var user : User?
    
    required init?(map : Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        chat_id <- map["chat_id"]
        message <- map["message"]
        created_at <- map["created_at"]
        user <- map["user"]

    }
}