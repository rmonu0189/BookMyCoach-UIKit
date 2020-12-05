//
//  NewAccountViewController.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 03/12/20.
//

import UIKit

class NewAccountViewController: BaseViewController {

    @IBOutlet weak var emailTextField: AppTextField!
    @IBOutlet weak var passwordTextField: AppTextField!
    @IBOutlet weak var confirmTextField: AppTextField!
    @IBOutlet weak var playerButton: AppButton!
    @IBOutlet weak var coachButton: AppButton!
    
    var viewModel: NewAccountViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bind()
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
        
        viewModel.didChangeUserType.bind { [weak self] (userType) in
            switch userType ?? UserType.player {
            case .player:
                self?.playerButton.isSelected = true
                self?.coachButton.isSelected = false
            case .coach:
                self?.playerButton.isSelected = false
                self?.coachButton.isSelected = true
            }
        }
        
        // Bind register success
        viewModel.registerSuccess.bind({ [weak self] success in
            if success == true {
                AppDICoordinator.updateProfileViewController().showAsRoot(self)
            }
        })
    }
    
    @IBAction func signupPressed(_ sender: UIButton) {
        viewModel.prepareInput(email: emailTextField.trimText, password: passwordTextField.trimText, confirmPassword: confirmTextField.trimText)
        viewModel.register()
    }
    
    @IBAction func playerPressed(_ sender: UIButton) {
        viewModel.selectUserType(.player)
    }
    
    @IBAction func coachPressed(_ sender: UIButton) {
        viewModel.selectUserType(.coach)
    }

}
