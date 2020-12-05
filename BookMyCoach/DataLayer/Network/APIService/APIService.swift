//
//  APIService.swift
//   BookMyCoach
//
//  Created by Monu Rathor on 21/11/20.
//

import Foundation

enum APIService: DPRequestProtocol {
    
    case login(user: UserLoginRequest)
    case register(user: UserRegisterRequest)
    case updateUser(request: UserUpdateRequest)
    case getUserProfile
    case getNearbyCoaches(request: NearbyCoachRequest)
    case logout
    case changePassword(request: UpdatePasswordRequest)
    case updateSports(request: UpdateSportRequest)
    case bookCoach(request: BookCoachRequest)
    case pendingRequestForCoach
    case pendingRequestByPlayer
    case acceptBookingRequest(request: RespondBookingRequest)
    case getMyBookings
    
    func baseUrl() -> String? {
        return "http://52.66.24.50:5000/api/v1"
    }
    
    func commonHeaders() -> [String: String] {
        var headers: [String: String] = ["apikey": "ISSMLLSHJNDKJKKJN7LKKKJKBJKJNL8UKJB8978676868JHBJBKJBK"]
        if UserManager.shared.isLoggedInUser(), let token = UserManager.shared.accessToken {
            headers["token"] = token
        }
        return headers
    }
    
    func responseKey() -> String? {
        return "data"
    }
    
    func dateEncodingStrategy() -> JSONEncoder.DateEncodingStrategy? {
        let formatter = DateFormatter()
        formatter.dateFormat = Date.Format.serverFormat
        return .formatted(formatter)
    }
    
    func dateDecodingStrategy() -> JSONDecoder.DateDecodingStrategy? {
        let formatter = DateFormatter()
        formatter.dateFormat = Date.Format.serverFormat
        return .formatted(formatter)
    }
}
