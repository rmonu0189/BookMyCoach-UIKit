//
//  ChangePasswordViewController.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 06/12/20.
//

import UIKit

class ChangePasswordViewController: BaseViewController {

    @IBOutlet weak var existingPasswordTextField: AppTextField!
    @IBOutlet weak var newPasswordTextField: AppTextField!
    @IBOutlet weak var confirmPasswordTextField: AppTextField!
    
    var viewModel: ChangePasswordViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        // Bind Error
        viewModel.error.bind({ (error) in
            ToastView.showError(error)
        })
        
        // Bind loader
        viewModel.showLoader.bind({ (loader) in
            if loader == true {
                LoaderView.show()
            } else {
                LoaderView.hide()
            }
        })
        
        viewModel.changePasswordSuccess.bind { [weak self] (success) in
            if success == true {
                ToastView.showSuccess(Constant.passwordChangeSuccess)
                self?.popController()
            }
        }
    }

    @IBAction func doneButtonPressed(_ sender: Any) {
        viewModel.prepareInput(existingPassword: existingPasswordTextField.trimText,
                               newPassword: newPasswordTextField.trimText,
                               confirmPassword: confirmPasswordTextField.trimText)
        viewModel.changePassword()
    }
    
}
