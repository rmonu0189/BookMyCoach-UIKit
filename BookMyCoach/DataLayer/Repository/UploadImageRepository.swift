//
//  UploadImageRepository.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 05/12/20.
//

import Foundation

class UploadImageRepository: UploadProfilePhotoRepositoryProtocol {
    
    func uploadProfilePhoto(_ imageData: Data, handler: @escaping (URL?, Error?) -> ()) {
        StorageManager.uploadImage(imageData, folder: .Profile, handler: handler)
    }
    
}
