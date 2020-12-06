//
//  ProfileViewModel.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 06/12/20.
//

import Foundation

protocol ProfileViewModelInput {
    var error: Observable<Error> { get set }
    var showLoader: Observable<Bool> { get set }
    var logoutSuccess: Observable<Bool> { get set }
    var profileIcon: Observable<String> { get }
    var userName: Observable<String> { get }
    var userEmail: Observable<String> { get }
    var refreshTable: Observable<Bool> { get }
    var showUpdateProfile: Observable<Bool> { get }
    var showChangePassword: Observable<Bool> { get }
    var showUpdateSport: Observable<Bool> { get }
    func didSelectMenu(at index: Int)
    func logoutUser()
}

class ProfileViewModel: ProfileViewModelInput {
    
    var error: Observable<Error> = Observable(nil)
    var showLoader: Observable<Bool> = Observable(nil)
    var logoutSuccess: Observable<Bool> = Observable(nil)
    var profileIcon: Observable<String> = Observable(nil)
    var userName: Observable<String> = Observable(nil)
    var userEmail: Observable<String> = Observable(nil)
    var refreshTable: Observable<Bool> = Observable(nil)
    var showUpdateProfile: Observable<Bool> = Observable(nil)
    var showChangePassword: Observable<Bool> = Observable(nil)
    var showUpdateSport: Observable<Bool> = Observable(nil)
    
    var menues: [ProfileMenuCellViewModel] = []
    var aboutInfo: [ProfileMenuCellViewModel] = []
    var sportInfo: [ProfileInfoCellViewModel] = []
    
    private let logoutUserUseCase: LogoutUserUseCaseProtocol
    
    fileprivate func refreshUIData(_ user: User?) {
        menues.removeAll()
        aboutInfo.removeAll()
        sportInfo.removeAll()
        self.profileIcon.value = user?.profilePhoto
        self.userName.value = user?.fullName
        self.userEmail.value = user?.email
        self.setupProfileInfosAndMenu(user: user)
        self.refreshTable.value = true
    }
    
    init(user: User?, logoutUserUseCase: LogoutUserUseCaseProtocol) {
        self.logoutUserUseCase = logoutUserUseCase
        self.refreshUIData(user)
    }
    
    private func setupProfileInfosAndMenu(user: User?) {
        menues.append(ProfileMenuCellViewModel(title: Constant.updateProfile))
        menues.append(ProfileMenuCellViewModel(title: Constant.changePassword))
        if user?.userType == .coach {
            sportInfo.append(ProfileInfoCellViewModel(title: Constant.sport, subTitle: user?.userSports?.first?.sport?.name ?? "", icon: user?.userSports?.first?.sport?.icon ?? ""))
            menues.append(ProfileMenuCellViewModel(title: Constant.updateSport))
        }
        aboutInfo.append(ProfileMenuCellViewModel(title: user?.bio ?? ""))
        menues.append(ProfileMenuCellViewModel(title: Constant.termsOfService))
        menues.append(ProfileMenuCellViewModel(title: Constant.privacyPolicy))
    }
    
    
}

extension ProfileViewModel {
    
    func viewWillAppear() {
        self.refreshUIData(UserManager.shared.activeUser)
    }
    
    func didSelectMenu(at index: Int) {
        switch menues[index].title {
        case Constant.updateProfile:
            self.showUpdateProfile.value = true
        case Constant.changePassword:
            self.showChangePassword.value = true
        case Constant.updateSport:
            self.showUpdateSport.value = true
        default:
            self.error.value = AppError.withMessage(message: "Coming Soon!!!")
        }
    }
    
    func logoutUser() {
        self.showLoader.value = true
        logoutUserUseCase.logout { [weak self] (success, error) in
            self?.showLoader.value = false
            if success == true {
                self?.logoutSuccess.value = true
            } else {
                self?.error.value = error
            }
        }
    }
    
}
