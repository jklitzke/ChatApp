//
//  RegisterTableViewController.swift
//  ChatApp
//
//  Created by James Klitzke on 5/17/17.
//  Copyright © 2017 James Klitzke. All rights reserved.
//

import UIKit

class RegisterTableViewController: UITableViewController {

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginButtonTapped(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        //TODO: Add code to call register API
        navigationController?.popToRootViewController(animated: true)
    }
    
}
