//
//  APIService+RequestBody.swift
//   BookMyCoach
//
//  Created by Monu Rathor on 21/11/20.
//

import Foundation

extension APIService {
    
    func requestBody() -> DPRequestBody {
        switch self {
        case let .login(user):
            return DPRequestBody(model: user)
        case let .register(user):
            return DPRequestBody(model: user)
        case let .updateUser(request):
            return DPRequestBody(model: request)
        case let .getNearbyCoaches(request):
            return DPRequestBody(model: request)
        case let .changePassword(request):
            return DPRequestBody(model: request)
        case let .updateSports(request):
            return DPRequestBody(model: request)
        case let .bookCoach(request):
            return DPRequestBody(model: request)
        case let .acceptBookingRequest(request):
            return DPRequestBody(model: request)
        default:
            return DPRequestBody()
        }
    }
    
}
