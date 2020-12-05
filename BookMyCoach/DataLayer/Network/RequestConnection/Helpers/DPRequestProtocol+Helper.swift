//
//  URLRequest+Helper.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 21/11/20.
//

import Foundation

extension DPRequestProtocol {
    
    fileprivate func getURL(_ requestPath: DPRequestPath, baseURL: String?) -> URL {
        if let url = requestPath.url {
            return url
        } else if let baseURL = baseURL, let endPoint = requestPath.endPoint, let url = URL(string: baseURL + endPoint) {
            return url
        }
        fatalError("URL can not be nil.")
    }
    
    func prepareRequest() -> URLRequest {
        let requestPath = self.requestPath()
        let baseURL = self.baseUrl()
        var request: URLRequest = URLRequest(url: getURL(requestPath, baseURL: baseURL))
        request.timeoutInterval = BookMyCoachConfiguration.shared.timeoutInterval
        request.httpMethod = requestPath.method.rawValue
        request.prepareHeaders(self.commonHeaders())
        request.prepareBody(self.requestBody(), service: self)
        return request
    }
    
}
