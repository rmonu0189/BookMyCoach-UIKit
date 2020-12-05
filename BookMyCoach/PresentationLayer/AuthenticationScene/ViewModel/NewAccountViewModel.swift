//
//  NewAccountViewModel.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 05/12/20.
//

import Foundation

protocol NewAccountViewModelInput {
    var userType: UserType { get set }
    var email: String { get set }
    var password: String { get set }
    var confirmPassword: String { get set }
    
    func selectUserType(_ type: UserType)
    func prepareInput(email: String, password: String, confirmPassword: String)
    func register()
}

protocol NewAccountViewModelOutput {
    var didChangeUserType: Observable<UserType> { get set }
    var error: Observable<Error> { get set }
    var showLoader: Observable<Bool> { get set }
    var registerSuccess: Observable<Bool> { get set }
}

protocol NewAccountViewModelProtocol: NewAccountViewModelInput, NewAccountViewModelOutput { }

class NewAccountViewModel: NewAccountViewModelProtocol {
    
    var userType: UserType = .player
    var email: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    
    var didChangeUserType: Observable<UserType> = Observable(UserType.player)
    var error: Observable<Error> = Observable(nil)
    var showLoader: Observable<Bool> = Observable(false)
    var registerSuccess: Observable<Bool> = Observable(nil)
    
    private let useCase: RegisterUseCaseProtocol!
    
    init(userCase: RegisterUseCaseProtocol) {
        self.useCase = userCase
    }
    
    // MARK: - PRIVATE
    private func validate() -> Bool {
        do {
            try email.requiredValidation(message: Constant.enterEmail)
            try email.emailValidation(message: Constant.incorrectEmail)
            try password.requiredValidation(message: Constant.enterPassword)
            try confirmPassword.requiredValidation(message: Constant.confirmYourPassword)
            try confirmPassword.matchValidation(with: password, message: Constant.passwordNotMatch)
            return true
        } catch {
            self.error.value = error
            return false
        }
    }
    
    func register() {
        guard validate() == true else { return }
        showLoader.value = true
        useCase.perform(email: email, password: password, userType: userType) { [weak self] (user, error) in
            self?.showLoader.value = false
            if error == nil {
                self?.registerSuccess.value = true
            } else {
                self?.error.value = error
            }
        }
    }
    
}

// MARK: - INPUT. View input methods
extension NewAccountViewModel {
    
    func prepareInput(email: String, password: String, confirmPassword: String) {
        self.email = email
        self.password = password
        self.confirmPassword = confirmPassword
    }
    
    func selectUserType(_ type: UserType) {
        self.userType = type
        self.didChangeUserType.value = type
    }
    
}
