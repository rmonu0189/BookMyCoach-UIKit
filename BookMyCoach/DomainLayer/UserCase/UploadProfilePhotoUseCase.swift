//
//  UploadProfilePhotoUseCase.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 05/12/20.
//

import Foundation

protocol UploadProfilePhotoUseCaseProtocol {
    func upload(imageData: Data, handler: @escaping (URL?, Error?) -> ())
}

class UploadProfilePhotoUseCase: UploadProfilePhotoUseCaseProtocol {
    
    private let repository: UploadProfilePhotoRepositoryProtocol
    
    init(repository: UploadProfilePhotoRepositoryProtocol) {
        self.repository = repository
    }
    
    func upload(imageData: Data, handler: @escaping (URL?, Error?) -> ()) {
        repository.uploadProfilePhoto(imageData, handler: handler)
    }
    
}
