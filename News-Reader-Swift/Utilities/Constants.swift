//
//  Constants.swift
//  News-Reader-Swift
//
//  Created by Dhanraj Kawade on 05/12/23.
//

import Foundation

/// Constants
class Constants {
    static let staticSearchString = "feed"
    static let dateFormatterToParse = "yyyy-MM-dd'T'HH:mm:SSZ"
    static let dateFormatterToSet = "dd-MM-yyyy"
    static let error = "Error"
    static let ok = "Ok"
    
    static func convertServerDateToCurrentDate(serverDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateFormatterToParse
        
        if let date = dateFormatter.date(from: serverDate) {
            dateFormatter.dateFormat = Constants.dateFormatterToSet
            return dateFormatter.string(from: date)
        }
        return ""
    }
}
