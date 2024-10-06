//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by Mukthar Amiyan on 28/09/24.
//

import Foundation

extension  Date {
    
    func convertToMonthYear() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
    
}
