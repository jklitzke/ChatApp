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
    let newMessageTableViewCellReuseID = "newMessageTableViewCell"
    
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
        return viewModel.numberOfChatMessages + 1
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row < viewModel.numberOfChatMessages else {
            let cell = tableView.dequeueReusableCell(withIdentifier: newMessageTableViewCellReuseID, for: indexPath)
            
            if let createMessageCell = cell as? NewMessageTableViewCell {
                createMessageCell.parentViewController = self
            }
            
            return cell
        }
        
        let reuseID = viewModel.isLoggedInUsersMessage(indexPath.row) ? myFriendChatMessageReuseID : myChatMessageReuseID
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath)

        if let messageCell = cell as? MessageTableViewCell {
            messageCell.configure(viewModel: viewModel, index: indexPath.row)
        }
        
        return cell
    }
    
    func createNewChat(message : String) {
        viewModel.createChatMessage("Test chat", success: {
            self.tableView.reloadData()
        }, failure: {
            self.showGenericErorrMessage()
        })
    }
}

class NewMessageTableViewCell : UITableViewCell {
    weak var parentViewController : ChatTableViewController!
    @IBAction func newMessageTapped(_ sender: Any) {
        self.parentViewController.createNewChat(message: "message")
    }
}

class MessageTableViewCell : UITableViewCell {
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messageDetailLabel: UILabel!
    
    func configure(viewModel : ChatMessagesViewModel, index : Int) {
        messageLabel.text = viewModel.textForMessage(index)
        messageDetailLabel.text = viewModel.detailTextForMessage(index)
    }
}
