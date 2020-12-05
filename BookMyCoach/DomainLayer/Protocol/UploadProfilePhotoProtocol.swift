//
//  UploadProfilePhotoProtocol.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 05/12/20.
//

import Foundation

protocol UploadProfilePhotoRepositoryProtocol {
    func uploadProfilePhoto(_ imageData: Data, handler: @escaping (URL?, Error?) -> ())
}
