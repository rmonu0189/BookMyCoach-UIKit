//
//  ProfileViewController.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 05/12/20.
//

import UIKit
import Kingfisher

class ProfileViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profilePhotoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    var viewModel: ProfileViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
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
        
        viewModel.logoutSuccess.bind { (success) in
            if success == true {
                AppDICoordinator.setRootControllerAfterLoggedOutUser()
            }
        }
        
        viewModel.profileIcon.bind { [weak self] (icon) in
            self?.profilePhotoImageView.kf.setImage(with: URL(string: icon ?? ""), placeholder: self?.viewModel.userName.value?.image(300, isCircular: false))
        }
        
        viewModel.userName.bind { [weak self] (name) in
            self?.nameLabel.text = name
        }
        
        viewModel.userEmail.bind { [weak self] (email) in
            self?.emailLabel.text = email
        }
        
        viewModel.refreshTable.bind { [weak self] (refresh) in
            if refresh == true {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.showUpdateProfile.bind { [weak self] (status) in
            if status == true {
                AppDICoordinator.updateProfileViewController(viewMode: .edit).show(self)
            }
        }
        
        viewModel.showUpdateSport.bind { [weak self] (status) in
            if status == true {
                AppDICoordinator.sportListViewController(viewMode: .edit).show(self)
            }
        }
        
        viewModel.showChangePassword.bind { [weak self] (status) in
            if status == true {
                AppDICoordinator.changePasswordViewController().show(self)
            }
        }
    }

    @IBAction func logoutPressed(_ sender: Any) {
        self.showConfirmAlert(title: Constant.logout.uppercased(), message: Constant.logoutConfirmation) { [weak self] (action) in
            if action == true {
                self?.viewModel.logoutUser()
            }
        }
    }
    
}

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return Constant.aboutMe
        } else if section == 2 {
            return Constant.preference
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.sportInfo.count
        } else if section == 1 {
            return viewModel.aboutInfo.count
        }
        return viewModel.menues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            // Sport Section
            let cell = tableView.cellWithType(ProfileInfoTableViewCell.self, indexPath: indexPath)
            cell.fill(with: viewModel.sportInfo[indexPath.item])
            return cell
        } else if indexPath.section == 1 {
            // About Me Section
            let cell = tableView.cellWithType(ProfileMenuTableViewCell.self, indexPath: indexPath)
            cell.fill(with: viewModel.aboutInfo[indexPath.item])
            cell.accessoryType = .none
            return cell
        } else {
            let cell = tableView.cellWithType(ProfileMenuTableViewCell.self, indexPath: indexPath)
            cell.fill(with: viewModel.menues[indexPath.item])
            cell.accessoryType = .disclosureIndicator
            return cell
        }
        
    }
    
}

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            viewModel.didSelectMenu(at: indexPath.item)
        }
    }
    
}
