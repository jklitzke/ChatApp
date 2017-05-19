//
//  AccountTableViewController.swift
//  ChatApp
//
//  Created by James Klitzke on 5/17/17.
//  Copyright © 2017 James Klitzke. All rights reserved.
//

import UIKit

class AccountTableViewController: UITableViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!

    lazy var createUserViewModel = CreateUserViewModel()
    lazy var loggedInUserViewModel = LoggedInUserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTextField.text = loggedInUserViewModel.name
        userEmailTextField.text = loggedInUserViewModel.email
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "Account"
        self.tabBarController?.navigationItem.rightBarButtonItem =
            UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        let request = CreateUserRequest(userName: userNameTextField.text ?? "", email: userEmailTextField.text ?? "",
                                        password: passwordTextField.text ?? "", confirmPassword: confirmPasswordTextField.text ?? "")
        
        guard createUserViewModel.isValidNameForUser(request) else {
            self.showAlertWithTitle("Invalid name entered!", message: "Please enter a valid name.")
            return
        }
        
        guard createUserViewModel.isValidEmailForUser(request) else {
            self.showAlertWithTitle("Invalid email entered!", message: "Please enter a valid email.")
            return
        }
        
        guard createUserViewModel.isValidPasswordForUser(request) else {
            self.showAlertWithTitle("Invalid password entered!", message: "Please enter a valid password.")
            return
        }
        
        guard createUserViewModel.passwordFieldsMatch(request) else {
            self.showAlertWithTitle("Passwords do not match!", message: "Password and repeat password fields do not match.")
            return
        }
        
        createUserViewModel.createUser(user: request, success: {
            self.showAlertWithTitle("Account Info Updated", message: "Account Info Was Updated Successfully!")
        }, failure: {
            self.showGenericErorrMessage()
        })
    }
}
