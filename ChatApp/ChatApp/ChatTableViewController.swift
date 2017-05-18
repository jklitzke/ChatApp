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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
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
 
