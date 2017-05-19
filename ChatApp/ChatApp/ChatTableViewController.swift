//
//  ChatTableViewController.swift
//  ChatApp
//
//  Created by James Klitzke on 5/17/17.
//  Copyright © 2017 James Klitzke. All rights reserved.
//

import UIKit

class ChatTableViewController: UITableViewController {

    let myChatMessageReuseID = "myChatMessageTableViewCell"
    let myFriendChatMessageReuseID = "myFriendChatMessageTableViewCell"
    
    var viewModel : ChatMessagesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getChatMessages(success: {
            self.tableView.reloadData()
        }, failure: {
            self.showGenericErorrMessage()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.navigationItem.title = "A Chat"
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseID = (indexPath.row % 2 == 0) ? myFriendChatMessageReuseID : myChatMessageReuseID
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath)

        return cell
    }
}

class MyChatMessageTableViewCell : UITableViewCell {
    
}

class MyFriendChatMessageTableViewCell : UITableViewCell {
    
}
 
