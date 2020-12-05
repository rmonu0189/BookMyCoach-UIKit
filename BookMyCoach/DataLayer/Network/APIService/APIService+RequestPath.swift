//
//  APIService+RequestPath.swift
//   BookMyCoach
//
//  Created by Monu Rathor on 21/11/20.
//

import Foundation

extension APIService {
    
    func requestPath() -> DPRequestPath {
        switch self {
        case .login:
            return DPRequestPath(method: .POST, endPoint: "/user/login")
        case .register:
            return DPRequestPath(method: .POST, endPoint: "/user")
        case .updateUser:
            return DPRequestPath(method: .PUT, endPoint: "/user")
        case .getUserProfile:
            return DPRequestPath(method: .GET, endPoint: "/user")
        case .getNearbyCoaches:
            return DPRequestPath(method: .GET, endPoint: "/coach/nearby")
        case .logout:
            return DPRequestPath(method: .DELETE, endPoint: "/user/logout")
        case .changePassword:
            return DPRequestPath(method: .PATCH, endPoint: "/user/changePassword")
        case .updateSports:
            return DPRequestPath(method: .PUT, endPoint: "/user/sports")
        case .bookCoach:
            return DPRequestPath(method: .POST, endPoint: "/booking/request")
        case .pendingRequestForCoach:
            return DPRequestPath(method: .GET, endPoint: "/coach/booking/pending")
        case .pendingRequestByPlayer:
            return DPRequestPath(method: .GET, endPoint: "/user/booking/pending")
        case .acceptBookingRequest:
            return DPRequestPath(method: .PATCH, endPoint: "/coach/booking/accept")
        case .getMyBookings:
            return DPRequestPath(method: .GET, endPoint: "/booking")
        }
    }
    
}
