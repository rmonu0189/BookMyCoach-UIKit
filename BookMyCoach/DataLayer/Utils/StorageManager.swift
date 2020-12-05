//
//  StorageManager.swift
//  BookMyCoach
//
//  Created by Bharat Lal on 12/1/20.
//

import Foundation
import FirebaseStorage
import Firebase

enum StorageFolder: String {
    case Profile
}

class StorageManager {
    
    class func initialize() {
        FirebaseApp.configure()
    }
    
    class func uploadImage(_ data: Data, folder: StorageFolder, handler: @escaping (_ url: URL?, _ error: Error?) -> ()) {
        let riversRef = Storage.storage().reference().child(folder.rawValue + "/" + uniqueFileName(".jpeg"))
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        _ = riversRef.putData(data, metadata: metadata) { (metadata, error) in
            riversRef.downloadURL { (url, error) in
                guard let downloadURL = url else { handler(nil, generateError("Image uploading failed. Please try again.")); return }
                handler(downloadURL, nil)
            }
        }
    }
    
    private class func uniqueFileName(_ type: String) -> String {
        let randomNum: UInt32 = arc4random_uniform(1000)
        let randomString: String = String(randomNum)
        return randomString + String(Int(Date().timeIntervalSince1970 * 1000)) + type
    }
    
    class func generateError(_ message: String) -> Error {
        return NSError(domain: "FIREBASE_UPLOAD_ERROR", code: 1010, userInfo: [NSLocalizedDescriptionKey: message])
    }
}
