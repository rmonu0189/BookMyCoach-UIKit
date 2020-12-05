//
//  BookMyCoach.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 20/11/20.
//

import Foundation

final class BookMyCoach {
        
    fileprivate var urlSession: URLSession
    
    // MARK: - Singleton Instance
    class var shared: BookMyCoach {
        struct Singleton {
            static let instance = BookMyCoach()
        }
        return Singleton.instance
    }
    
    private init() {
        urlSession = URLSession(configuration: BookMyCoachConfiguration.shared.configuration)
    }
        
    /**
     Perform request to fetch data
     - parameter request:           request
     - parameter userInfo:          userinfo
     - parameter completionHandler: handler
     */
    func performService(_ service: DPRequestProtocol, completionHandler: @escaping (_ response: DPResponse) -> Void) {
        let request = service.prepareRequest()
        urlSession.dataTask(with: request) { (data, response, error) in
            let dataResponse = DPResponse(data: data, response: response, error: error, service: service)
            if let accessToken = dataResponse.headers?["token"] as? String {
                UserManager.shared.accessToken = accessToken
            }
            DispatchQueue.main.async {
                completionHandler(dataResponse)
            }
        }.resume()
    }
    
}
