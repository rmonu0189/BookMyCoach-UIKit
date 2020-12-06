//
//  ChangePasswordViewModel.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 06/12/20.
//

import Foundation

protocol ChangePasswordViewModelInput {
    func prepareInput(existingPassword: String, newPassword: String, confirmPassword: String)
    func changePassword()
}

protocol ChangePasswordViewModelOutput {
    var error: Observable<Error> { get }
    var showLoader: Observable<Bool> { get }
    var changePasswordSuccess: Observable<Bool> { get }
}

class ChangePasswordViewModel: ChangePasswordViewModelInput, ChangePasswordViewModelOutput {
    
    private var existingPassword: String?
    private var newPassword: String?
    private var confirmPassword: String?
    
    // MARK: - OUTPUT
    var error: Observable<Error> = Observable(nil)
    var showLoader: Observable<Bool> = Observable(nil)
    var changePasswordSuccess: Observable<Bool> = Observable(nil)
    
    private let changePasswordUseCase: ChangePasswordUseCaseProtocol
    
    init(changePasswordUseCase: ChangePasswordUseCaseProtocol) {
        self.changePasswordUseCase = changePasswordUseCase
    }
    
    // MARK: - PRIVATE
    private func validate() -> Bool {
        do {
            try existingPassword?.requiredValidation(message: Constant.enterExistingPassword)
            try newPassword?.requiredValidation(message: Constant.enterNewPassword)
            try newPassword?.passwordValidation(message: Constant.incorrectPassword)
            try confirmPassword?.requiredValidation(message: Constant.enterConfirmNewPassword)
            try confirmPassword?.matchValidation(with: newPassword ?? "", message: Constant.passwordNotMatch)
            return true
        } catch {
            self.error.value = error
            return false
        }
    }
    
    func changePassword() {
        guard validate() == true else { return }
        self.showLoader.value = true
        changePasswordUseCase.changePassword(oldPassword: existingPassword ?? "", newPassword: newPassword ?? "") { [weak self] (success, error) in
            self?.showLoader.value = false
            if error == nil {
                self?.changePasswordSuccess.value = true
            } else {
                self?.error.value = error
            }
        }
    }
    
}

extension ChangePasswordViewModel {
    
    func prepareInput(existingPassword: String, newPassword: String, confirmPassword: String) {
        self.existingPassword = existingPassword
        self.newPassword = newPassword
        self.confirmPassword = confirmPassword
    }
    
}
