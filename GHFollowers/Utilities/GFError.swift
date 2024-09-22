//
//  ErrorMessage.swift
//  GHFollowers
//
//  Created by Mukthar Amiyan on 21/09/24.
//

import Foundation


enum GFError: String, Error {
    case invalidUsername    = "This username created an invalid request. Please try again."
    case unableToComplete   = "Unable to complete request. Please check your internet connection"
    case invalidResponse    = "Invalid response from the server. Please try again."
    case invalidData        = "The data received from server was invalid. Please try again."
    
    
}
