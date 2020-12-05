//
//  LoginViewModel.swift
//  BookMyCoach
//
//  Created by Bharat Lal on 03/12/20.
//

import Foundation

protocol LoginViewModelInput {
    var email: String { get set }
    var password: String { get set }
    func setCredential(email: String, password: String)
    func login()
}

protocol LoginViewModelOutput {
    var error: Observable<Error> { get set }
    var showLoader: Observable<Bool> { get set }
    var loginSuccess: Observable<Bool> { get set }
}

protocol LoginViewModelProtocol: LoginViewModelInput, LoginViewModelOutput { }


class LoginViewModel: LoginViewModelProtocol {
    
    private let useCase: LoginUseCaseProtocol
    
    var email: String = ""
    var password: String = ""
    
    // MARK: - OUTPUT
    var error: Observable<Error> = Observable(nil)
    var showLoader: Observable<Bool> = Observable(nil)
    var loginSuccess: Observable<Bool> = Observable(nil)
    
    init(userCase: LoginUseCaseProtocol) {
        self.useCase = userCase
    }
    
    // MARK: - PRIVATE
    private func validate() -> Bool {
        do {
            try email.requiredValidation(message: Constant.enterEmail)
            try email.emailValidation(message: Constant.incorrectEmail)
            try password.requiredValidation(message: Constant.enterPassword)
            try password.passwordValidation(message: Constant.incorrectPassword)
            return true
        } catch {
            self.error.value = error
            return false
        }
    }
    
    private func loginWithCredential() {
        if validate() == false { return }
        showLoader.value = true
        useCase.perform(email: email, password: password) { [weak self] (user, error) in
            self?.showLoader.value = false
            if error == nil {
                self?.loginSuccess.value = true
            } else {
                self?.error.value = error
            }
        }
    }
}

// MARK: - INPUT. View input methods
extension LoginViewModel {
    
    func setCredential(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    func login() {
        self.loginWithCredential()
    }
    
}
