//
//  DateFormatter+Extensions.swift
//  ChatApp
//
//  Created by James Klitzke on 5/20/17.
//  Copyright © 2017 James Klitzke. All rights reserved.
//

import Foundation

extension DateFormatter {
    static func iso8601DateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        let enUSPosixLocale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.locale = enUSPosixLocale as Locale!
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return dateFormatter
    }
    
    static func userFrinedlyDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter
    }
}
