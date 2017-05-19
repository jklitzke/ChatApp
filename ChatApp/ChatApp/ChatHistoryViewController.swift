//
//  ChatHistoryViewController.swift
//  ChatApp
//
//  Created by James Klitzke on 5/17/17.
//  Copyright © 2017 James Klitzke. All rights reserved.
//

import UIKit

class ChatHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var chatHistoryTableView: UITableView!
    
    let reuseID = "chatHistoryTableViewCell"

    lazy var viewModel = ChatHistoryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatHistoryTableView.dataSource = self
        chatHistoryTableView.delegate = self
        chatHistoryTableView.rowHeight = UITableViewAutomaticDimension
        chatHistoryTableView.estimatedRowHeight = 96.0
        
        viewModel.getChatHistory(success: {
            self.chatHistoryTableView.reloadData()
        }, failure: {
        
        })
//        
//        api.getChatHistory(success: {
//            chatHistory in
//            print("SUCCESS!")
//        }, failure: {
//            error in 
//            print("FAILURE!")
//        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.navigationItem.title = "OraChat"
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = chatHistoryTableView.dequeueReusableCell(withIdentifier: reuseID)!
        
        if let chatCell = cell as? ChatHistoryTableViewCell {
            chatCell.configure()
        }
        
        return cell
    }
}


class ChatHistoryTableViewCell : UITableViewCell {
    
    @IBOutlet weak var chatByLabel: UILabel!
    @IBOutlet weak var lastChatSummaryLabel: UILabel!
    @IBOutlet weak var lastChatMessageLabel: UILabel!
    
    func configure() {
        chatByLabel.text = "A Chat By James!"
        lastChatSummaryLabel.text = "James - 1 hour ago"
        lastChatMessageLabel.text = "Wassup!"
    }
}
