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
    let getChatMessagesSegue = "getChatMessages"

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
            self.showGenericErorrMessage()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.navigationItem.title = "OraChat"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfChats
    }
        
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.dataTextForChat(section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatHistoryTableView.dequeueReusableCell(withIdentifier: reuseID)!
        
        if let chatCell = cell as? ChatHistoryTableViewCell {

            chatCell.configureFor(viewModel: viewModel, indexPath: indexPath)
        }
        
        return cell
    }
    
    @IBAction func createChatTapped(_ sender: Any) {
        //Need to get message info first!
        viewModel.createChat(success: {
            self.chatHistoryTableView.reloadData()
        }, failure: {
            self.showGenericErorrMessage()
        })
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == getChatMessagesSegue {
            if let viewController = segue.destination as? ChatTableViewController,
               let indexPath = self.chatHistoryTableView.indexPathForSelectedRow {
                let selectedChatId = self.viewModel.chatIdForChat(indexPath.section)
                viewController.viewModel = ChatMessagesViewModel(id : selectedChatId)
            }
        }
    }
}


class ChatHistoryTableViewCell : UITableViewCell {
    @IBOutlet weak var chatByLabel: UILabel!
    @IBOutlet weak var lastChatSummaryLabel: UILabel!
    @IBOutlet weak var lastChatMessageLabel: UILabel!
    
    func configureFor(viewModel : ChatHistoryViewModel, indexPath: IndexPath) {
        chatByLabel.text = viewModel.chatByTextForChat(indexPath.section)
        lastChatSummaryLabel.text = viewModel.lastChatSummaryTextForChat(indexPath.section)
        lastChatMessageLabel.text = viewModel.lastChatMessageTextForChat(indexPath.section)
    }
}
