//
//  BookMyCoach+Helper.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 21/11/20.
//

import Foundation

extension DPRequestProtocol {
    
    func submit(completionHandler: @escaping (DPResponse) -> Void) {
        BookMyCoach.shared.performService(self, completionHandler: completionHandler)
    }
    
    func fetch<T: Codable>(_ type: T.Type, completion: @escaping (T?, Error?, String?) -> Void) {
        BookMyCoach.shared.performService(self) { (response) in
            if response.isSuccess {
                completion(response.decodeResponseToModel(self, type: T.self), response.error, response.message)
            } else {
                completion(nil, response.error, response.message)
            }
        }
    }
    
    func fetchList<T: Codable>(_ type: T.Type, completion: @escaping ([T]?, Error?, String?) -> Void) {
        BookMyCoach.shared.performService(self) { (response) in
            if response.isSuccess {
                completion(response.decodeResponseToModelList(self, type: T.self), response.error, response.message)
            } else {
                completion(nil, response.error, response.message)
            }
        }
    }
    
}
