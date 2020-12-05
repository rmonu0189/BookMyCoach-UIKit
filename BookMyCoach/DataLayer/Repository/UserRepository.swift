//
//  UserRepository.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 05/12/20.
//

import Foundation

protocol UserRepositoryProtocol: LoginRepositoryProtocol,
                                 RegisterRepositoryProtocol,
                                 UpdateUserRepositoryProtocol { }

class UserRepository: UserRepositoryProtocol {
    
    func login(email: String, password: String, handler: @escaping (User?, Error?) -> ()) {
        let service = APIService.login(user: UserLoginRequest(email: email, password: password))
        service.fetch(User.self) { (user, error, _) in
            handler(user, error)
        }
    }
    
    func register(email: String, password: String, userType: UserType, handler: @escaping (User?, Error?) -> ()) {
        let service = APIService.register(user: UserRegisterRequest(email: email, password: password, userType: userType))
        service.fetch(User.self) { (user, error, _) in
            handler(user, error)
        }
    }
    
    func updateUser(request: UserUpdateRequest, handler: @escaping (User?, Error?) -> ()) {
        let service = APIService.updateUser(request: request)
        service.fetch(User.self) { (user, error, _) in
            handler(user, error)
        }
    }
    
    func changePassword(_ oldPassword: String, _ newPassword: String, _ handler: @escaping (Bool, Error?)-> ()) {
        let service = APIService.changePassword(request: UpdatePasswordRequest(oldPassword: oldPassword, newPassword: newPassword))
        service.submit { response in
            handler(response.isSuccess, response.error)
        }
    }
    
    func logout(_ handler: @escaping (Bool, Error?)-> ()) {
        let service = APIService.logout
        service.submit { response in
            if response.isSuccess {
                UserManager.shared.deleteActiveUser()
                UserManager.shared.accessToken = nil
            }
            handler(response.isSuccess, response.error)
        }
    }
    
}
