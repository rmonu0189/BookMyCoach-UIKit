//
//  UpdateProfileViewController.swift
//  BookMyCoach
//
//  Created by Bharat Lal on 05/12/20.
//

import UIKit
import Kingfisher

class UpdateProfileViewController: ImagePickerBaseViewController {

    @IBOutlet weak var fullNameTextField: AppTextField!
    @IBOutlet weak var hourlyRateTextField: AppTextField!
    @IBOutlet weak var aboutYouTextField: AppTextField!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var aboutYouConstraint: NSLayoutConstraint!
    
    var viewModel: UpdateProfileViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        addImageHandler()
        setupUI()
    }
    
    private func setupUI() {
        if viewModel.userType == UserType.player {
            hourlyRateTextField.isHidden = true
            aboutYouConstraint.constant = 20
        }
        aboutYouTextField.setLeftIcon(.aboutYou)
        hourlyRateTextField.setLeftIcon(.price)
    }
    
    private func bind() {
        
        viewModel.viewTitle.bind { [weak self] (title) in
            self?.title = title
        }
        
        viewModel.fullName.bind { [weak self] (fullName) in
            self?.fullNameTextField.text = fullName
        }
        
        viewModel.price.bind { [weak self] (price) in
            self?.hourlyRateTextField.text = price
        }
        
        viewModel.bio.bind { [weak self] (bio) in
            self?.aboutYouTextField.text = bio
        }
        
        viewModel.profilePhoto.bind { [weak self] (profilePhoto) in
            let url = URL(string: profilePhoto ?? "")
            self?.profileImageView.kf.setImage(with: url)
        }
        
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
        
        viewModel.updateSuccess.bind { [weak self] (success) in
            if success == true {
                if self?.viewModel.viewMode == ViewMode.normal {
                    if self?.viewModel.userType == UserType.player {
                        AppDICoordinator.setRootControllerForLoggedInUser()
                    } else {
                        AppDICoordinator.sportListViewController().showAsRoot(self)
                    }
                } else {
                    self?.popViewController()
                }
            }
        }
    }

    @IBAction func nextButtonPressed(_ sender: Any) {
        let imageData = profileImageView.image?.compressImageDataAspectRatio()
        viewModel.prepareInput(fullName: fullNameTextField.trimText,
                               hourlyPrice: hourlyRateTextField.trimText,
                               bio: aboutYouTextField.trimText,
                               imageData: imageData)
        viewModel.updateUser()
    }
    
    @IBAction func changeProfilePicPressed(_ sender: UIButton) {
        openSelectPhoto(sender, allowEditing: false, isVideo: false, isImage: true)
    }
    
    private func addImageHandler() {
        imagePickerHandler = { [weak self] (image, url) in
            self?.profileImageView.image = image
        }
    }
    
}
