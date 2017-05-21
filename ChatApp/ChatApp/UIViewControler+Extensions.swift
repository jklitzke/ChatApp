//
//  UIViewControler+Extensions.swift
//  ChatApp
//
//  Created by James Klitzke on 5/18/17.
//  Copyright © 2017 James Klitzke. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlertWithTitle(_ title : String, message : String) {
        let alert = UIAlertController.genericAlert(title: title, message: message)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showGenericErorrMessage() {
        self.showAlertWithTitle("Service Error", message: "We're sorry something went wrong with this request. Please try again.")
    }
}
