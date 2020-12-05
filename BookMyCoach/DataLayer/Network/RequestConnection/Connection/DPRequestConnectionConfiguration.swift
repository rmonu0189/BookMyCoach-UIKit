//
//  BookMyCoachConfiguration.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 20/11/20.
//

import Foundation

final class BookMyCoachConfiguration {
    
    fileprivate init() { }
    
    // Public Configurations
    var configuration: URLSessionConfiguration = URLSessionConfiguration.default
    var authenticationTokenKeyInHeader: String?
    var isLogging: Bool = true
    var timeoutInterval: TimeInterval = 30
    
    // MARK: - Singleton Instance
    class var shared: BookMyCoachConfiguration {
        struct Singleton {
            static let instance = BookMyCoachConfiguration()
        }
        return Singleton.instance
    }
    
}
