//
//  RegisterTableViewController.swift
//  ChatApp
//
//  Created by James Klitzke on 5/17/17.
//  Copyright © 2017 James Klitzke. All rights reserved.
//

import UIKit

class RegisterTableViewController: UITableViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    let chatStoryBoard = UIStoryboard(name: "ChatStoryboard", bundle: nil)

    lazy var viewModel = CreateUserViewModel()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginButtonTapped(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        let request = CreateUserRequest(userName: userNameTextField.text ?? "", email: userEmailTextField.text ?? "",
                                        password: passwordTextField.text ?? "", confirmPassword: confirmPasswordTextField.text ?? "")
        
        guard viewModel.isValidNameForUser(request) else {
            self.showAlertWithTitle("Invalid name entered!", message: "Please enter a valid name.")
            return
        }
        
        guard viewModel.isValidEmailForUser(request) else {
            self.showAlertWithTitle("Invalid email entered!", message: "Please enter a valid email.")
            return
        }
        
        guard viewModel.isValidPasswordForUser(request) else {
            self.showAlertWithTitle("Invalid password entered!", message: "Please enter a valid password.")
            return
        }
        
        guard viewModel.passwordFieldsMatch(request) else {
            self.showAlertWithTitle("Passwords do not match!", message: "Password and repeat password fields do not match.")
            return
        }
        
        viewModel.createUser(user: request, success: {
            guard let initialViewControler = self.chatStoryBoard.instantiateInitialViewController() else {
                return
            }
            
            self.navigationController?.present(initialViewControler, animated: true)
        }, failure: {
            self.showGenericErorrMessage()
        })
    }
}
