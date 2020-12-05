//
//  Date+Helper.swift
//  BookMyCoach
//
//  Created by Bharat Lal on 12/5/20.
//

import Foundation
extension Date {
    
    func formatted(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    struct Format {
        static let serverFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        static let yyyyMMddhhmma = "yyyy-MM-dd hh:mm a"
        static let hhmma = "hh:mm a"
    }
    
}
