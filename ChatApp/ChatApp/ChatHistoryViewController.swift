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
    var activityIndicator : UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator = UIActivityIndicatorView.standardActivityIndicatorForView(self.view)

        chatHistoryTableView.dataSource = self
        chatHistoryTableView.delegate = self
        chatHistoryTableView.rowHeight = UITableViewAutomaticDimension
        chatHistoryTableView.estimatedRowHeight = 96.0
        
        activityIndicator.startAnimating()
        viewModel.getChatHistory(success: {
            self.activityIndicator.stopAnimating()
            self.chatHistoryTableView.reloadData()
        }, failure: {
            self.activityIndicator.stopAnimating()
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
        let alertController = UIAlertController(title: "New Chat", message: "What do you want to say?", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Send", style: .default) { (_) in
            self.activityIndicator.startAnimating()
            let name = alertController.textFields![0].text ?? ""
            let message = alertController.textFields![1].text ?? ""
            
            self.viewModel.createChat(name: name, message: message, success: {
                self.activityIndicator.stopAnimating()
                self.chatHistoryTableView.reloadData()
            }, failure: {
                self.activityIndicator.stopAnimating()
                self.showGenericErorrMessage()
            })
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        alertController.addTextField { textField in
            textField.placeholder = "Name"
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "Message"
        }

        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
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
