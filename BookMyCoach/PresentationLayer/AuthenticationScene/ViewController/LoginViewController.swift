//
//  LoginViewController.swift
//  BookMyCoach
//
//  Created by Bharat Lal on 03/12/20.
//

import UIKit

class LoginViewController: BaseViewController {

    @IBOutlet weak var emailTextField: AppTextField!
    @IBOutlet weak var passwordTextField: AppTextField!
        
    var loginViewModel: LoginViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.bind()
    }
    
    private func bind() {
        // Bind Error
        loginViewModel.error.bind({ (error) in
            ToastView.showError(error)
        })
        
        // Bind loader
        loginViewModel.showLoader.bind({ (loader) in
            if loader == true {
                LoaderView.show()
            } else {
                LoaderView.hide()
            }
        })
        
        // Bind login success
        loginViewModel.loginSuccess.bind({ [weak self] success in
            if success == true {
                let user = UserManager.shared.activeUser
                if user?.isProfileComplete == true {
                    AppDICoordinator.setRootControllerForLoggedInUser()
                } else {
                    AppDICoordinator.updateProfileViewController().show(self)
                }
            }
        })
    }
    
    @IBAction func loginButtonPressed(_ : Any) {
        loginViewModel.setCredential(email: emailTextField.trimText, password: passwordTextField.trimText)
        loginViewModel.login()
    }
    
    @IBAction func signupPressed(_ : Any) {
        AppDICoordinator.newAccountViewController().show(self)
    }
}
