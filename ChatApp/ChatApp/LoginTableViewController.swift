//
//  LoginTableViewController.swift
//  ChatApp
//
//  Created by James Klitzke on 5/17/17.
//  Copyright © 2017 James Klitzke. All rights reserved.
//

import UIKit

class LoginTableViewController : UITableViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let chatStoryBoard = UIStoryboard(name: "ChatStoryboard", bundle: nil)
    lazy var viewModel = LoggedInUserViewModel()
    var activityIndicator : UIActivityIndicatorView!
    
    override func viewDidLoad() {
        activityIndicator = UIActivityIndicatorView.standardActivityIndicatorForView(self.view)
        super.viewDidLoad()
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text, viewModel.isValidEmail(email) else {
            emailTextInvalidAlert()
            return
        }
        
        guard let password = passwordTextField.text, viewModel.isValidPassword(password) else {
            passwordTextInvalidAlert()
            return
        }
        
        activityIndicator.startAnimating()
        viewModel.fetchUserWith(email: email, password: password, successClosure: {
            self.activityIndicator.stopAnimating()
            guard let initialViewControler = self.chatStoryBoard.instantiateInitialViewController() else {
                return
            }
            
            self.navigationController?.present(initialViewControler, animated: true)
        }, failureClosure: {
            self.activityIndicator.stopAnimating()
            print("failure!")
            self.loginServiceFailedAlert()
        })
    }
    
    func emailTextInvalidAlert() {
        self.showAlertWithTitle("Invalid email", message: "Please enter a valid email")
    }
    
    func passwordTextInvalidAlert() {
        self.showAlertWithTitle("Invalid password", message: "Please enter a valid password")
    }
    
    func loginServiceFailedAlert() {
        self.showAlertWithTitle("Could Not Login", message: "Invalid user name and/or password")
    }    
}
