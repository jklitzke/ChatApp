//
//  UIActivityIndicatorView+Extensions.swift
//  ChatApp
//
//  Created by James Klitzke on 5/20/17.
//  Copyright © 2017 James Klitzke. All rights reserved.
//

import Foundation
import UIKit

extension UIActivityIndicatorView {
    static func standardActivityIndicatorForView(_ view : UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.activityIndicatorViewStyle  = .gray;
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        return activityIndicator
    }
}
