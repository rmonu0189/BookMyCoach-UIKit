//
//  Error+Helper.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 05/12/20.
//

import Foundation

struct AppError {
    
    static func withMessage(message: String) -> Error {
        return NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: message])
    }
    
}
