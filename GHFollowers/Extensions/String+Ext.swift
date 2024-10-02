//
//  String+Ext.swift
//  GHFollowers
//
//  Created by Mukthar Amiyan on 28/09/24.
//

import Foundation

extension String {
    
    func convertToDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = .current
        return formatter.date(from: self)
    }
    
    func convertToDisplayFormatted() -> String {
        guard let date = convertToDate() else { return "N/A" }
        return date.convertToMonthYear()
    }
}
