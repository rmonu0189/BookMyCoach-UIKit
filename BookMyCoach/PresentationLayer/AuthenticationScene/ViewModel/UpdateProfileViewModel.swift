//
//  UpdateProfileViewModel.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 05/12/20.
//

import Foundation

protocol UpdateProfileViewModelInput {
    func prepareInput(fullName: String, hourlyPrice: String, bio: String, imageData: Data?)
    func updateUser()
}

protocol UpdateProfileViewModelOutput {
    var viewTitle: Observable<String> { get set }
    var fullName: Observable<String> { get set }
    var bio: Observable<String> { get set }
    var price: Observable<String> { get set }
    var profilePhoto: Observable<String> { get set }
    var error: Observable<Error> { get set }
    var showLoader: Observable<Bool> { get set }
    var updateSuccess: Observable<Bool> { get set }
}

protocol UpdateProfileViewModelProtocol: UpdateProfileViewModelInput, UpdateProfileViewModelOutput { }

class UpdateProfileViewModel: UpdateProfileViewModelProtocol {
    
    private let updateUserUseCase: UpdateUserUseCaseProtocol
    private let uploadImageUserCase: UploadProfilePhotoUseCaseProtocol
    private var imageData: Data?
    
    let userType: UserType?
    var viewTitle: Observable<String> = Observable(nil)
    var fullName: Observable<String> = Observable(nil)
    var bio: Observable<String> = Observable(nil)
    var price: Observable<String> = Observable(nil)
    var profilePhoto: Observable<String> = Observable(nil)
    var error: Observable<Error> = Observable(nil)
    var showLoader: Observable<Bool> = Observable(false)
    var updateSuccess: Observable<Bool> = Observable(nil)
    var locationManager = LocationManager()
    
    private(set) var viewMode: ViewMode
    
    init(user: User?, updateUserUseCase: UpdateUserUseCaseProtocol, uploadImageUserCase: UploadProfilePhotoUseCaseProtocol, viewMode: ViewMode = .normal) {
        self.userType = user?.userType
        self.fullName.value = user?.fullName ?? ""
        self.bio.value = user?.bio
        self.price.value = user?.price?.description
        self.profilePhoto.value = user?.profilePhoto
        self.updateUserUseCase = updateUserUseCase
        self.uploadImageUserCase = uploadImageUserCase
        self.viewMode = viewMode
        self.viewTitle.value = viewMode == ViewMode.normal ? Constant.tellUSMore : Constant.updateProfile
    }
    
    private func validate() -> Bool {
        do {
            try fullName.value?.requiredValidation(message: Constant.enterFullName)
            return true
        } catch {
            self.error.value = error
            return false
        }
    }
    
    private func uploadImage(imageData: Data, handler: @escaping (String?) -> ()) {
        uploadImageUserCase.upload(imageData: imageData) { (url, _) in
            handler(url?.absoluteString)
        }
    }
    
    private func updateUserProfile() {
        locationManager.fetchCurrentLocation { [weak self] (location, _, error) in
            if error != nil {
                self?.error.value = error
                return
            }
            
            let fullName = self?.fullName.value ?? ""
            let price = Double(self?.price.value ?? "")
            let request = UserUpdateRequest(fullName: fullName, bio: self?.bio.value, price: price, latitude: location?.latitude ?? 0, longitude: location?.longitude ?? 0, profilePhoto: self?.profilePhoto.value)
            self?.updateUserUseCase.perform(request: request) { [weak self] (user, error) in
                self?.showLoader.value = false
                if error == nil {
                    self?.updateSuccess.value = true
                } else {
                    self?.error.value = error
                }
            }
        }
    }
    
}

// MARK: - INPUT. View input methods
extension UpdateProfileViewModel {
        
    func prepareInput(fullName: String, hourlyPrice: String, bio: String, imageData: Data?) {
        self.fullName.value = fullName
        self.price.value = hourlyPrice
        self.bio.value = bio
        self.imageData = imageData
    }
    
    func updateUser() {
        showLoader.value = true
        if let data = imageData {
            uploadImage(imageData: data) { [weak self] (profilePhoto) in
                self?.profilePhoto.value = profilePhoto
                self?.updateUserProfile()
            }
        } else {
            updateUserProfile()
        }
    }
    
}
