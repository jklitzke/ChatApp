//
//  LoginTableViewController.swift
//  ChatApp
//
//  Created by James Klitzke on 5/17/17.
//  Copyright © 2017 James Klitzke. All rights reserved.
//

import UIKit

class LoginTableViewController : UITableViewController {
    
    let chatStoryBoard = UIStoryboard(name: "ChatStoryboard", bundle: nil)
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        guard let initialViewControler = chatStoryBoard.instantiateInitialViewController() else {
            return
        }
        
        navigationController?.present(initialViewControler, animated: true)
    }
}
