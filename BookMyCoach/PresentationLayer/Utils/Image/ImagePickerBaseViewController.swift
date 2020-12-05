//
//  ImagePickerBaseViewController.swift
//
//  Created by Monu Rathor on 28/08/19.
//  Copyright © 2019 DianApps. All rights reserved.
//

import UIKit
import MobileCoreServices

typealias ImagePickerHandler = (UIImage?, URL?) -> ()

class ImagePickerBaseViewController: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePickerHandler: ImagePickerHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func openSelectPhoto(_ sender: UIButton, allowEditing: Bool = true, isVideo: Bool = true, isImage: Bool = true) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                self.openCamera(allowEditing, isVideo: isVideo, isImage: isImage)
            }))
        }
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { _ in
                self.openGallary(allowEditing, isVideo: isVideo, isImage: isImage)
            }))
        }
        
        alert.popoverPresentationController?.sourceView = sender.superview
        alert.popoverPresentationController?.sourceRect = sender.frame
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func openCamera(_ allowEditing: Bool = true, isVideo: Bool = true, isImage: Bool = true) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) == true {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = .camera
            imagePickerController.allowsEditing = allowEditing
            var media = [String]()
            if isVideo { media.append(kUTTypeMovie as String) }
            if isImage { media.append(kUTTypeImage as String) }
            if media.count > 0 { imagePickerController.mediaTypes = media }
            self.present(imagePickerController, animated: true, completion: nil)
        } else {
            ToastView.showErrorMessage("Camera not supported on your device.")
        }
    }
    
    func openGallary(_ allowEditing: Bool = true, isVideo: Bool = true, isImage: Bool = true) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) == true {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.allowsEditing = allowEditing
            var media = [String]()
            if isVideo { media.append(kUTTypeMovie as String) }
            if isImage { media.append(kUTTypeImage as String) }
            if media.count > 0 { imagePickerController.mediaTypes = media }
            present(imagePickerController, animated: true, completion: nil)
        } else {
            ToastView.showErrorMessage("Photo gallery not supported on your device.")
        }
    }
    
    func imageFromPicker(_ info: [UIImagePickerController.InfoKey : Any]) -> UIImage? {
        if let image = info[.editedImage] as? UIImage {
            return image
        } else if let image = info[.originalImage] as? UIImage {
            return image
        }
        return nil
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if info[UIImagePickerController.InfoKey.mediaType] as? String == kUTTypeMovie as String {
            guard let videoUrl = info[UIImagePickerController.InfoKey.mediaURL] as? URL else { return }
            self.imagePickerHandler?(nil, videoUrl)
        } else if let image = imageFromPicker(info) {
            self.imagePickerHandler?(image, nil)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
}
