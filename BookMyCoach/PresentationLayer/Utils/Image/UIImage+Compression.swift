//
//  UIImage+Additions.swift
//  BookMyCoach
//
//  Created by Bharat Lal on 12/1/20.
//

import UIKit

enum CompressLevel {
    case veryVeryLow
    case veryLow
    case low
    case medium
    case mediumHigh
    case high
    case veryHigh
    
    var size: CGSize {
        switch self {
        case .veryVeryLow:
            return CGSize(width: 50, height: 50)
        case .veryLow:
            return CGSize(width: 128, height: 128)
        case .low:
            return CGSize(width: 256, height: 256)
        case .medium:
            return CGSize(width: 512, height: 512)
        case .mediumHigh:
            return CGSize(width: 768, height: 768)
        case .high:
            return CGSize(width: 1024, height: 1024)
        case .veryHigh:
            return CGSize(width: 2048, height: 2048)
        }
    }
}

extension UIImage {
    
    func compressImageAspectRatio(_ compressLevel: CompressLevel = CompressLevel.medium) -> UIImage? {
        if let data = self.compressData(compressLevel.size.height, width: compressLevel.size.width) {
            return UIImage(data: data)
        }
        return nil
    }
    
    func compressImageDataAspectRatio(_ compressLevel: CompressLevel = CompressLevel.medium) -> Data? {
        return self.compressData(compressLevel.size.height, width: compressLevel.size.width)
    }
    
    private func compressData(_ height: CGFloat = 500.0, width: CGFloat = 500.0) -> Data? {
        var actualHeight: CGFloat = size.height
        var actualWidth: CGFloat = size.width
        let maxHeight: CGFloat = height
        let maxWidth: CGFloat = width
        var imgRatio: CGFloat = actualWidth / actualHeight
        let maxRatio: CGFloat = maxWidth / maxHeight
        var compressionQuality: CGFloat = 0.5

        if actualHeight > maxHeight || actualWidth > maxWidth {
            if imgRatio < maxRatio {
                // adjust width according to maxHeight
                imgRatio = maxHeight / actualHeight
                actualWidth = imgRatio * actualWidth
                actualHeight = maxHeight
            } else if imgRatio > maxRatio {
                // adjust height according to maxWidth
                imgRatio = maxWidth / actualWidth
                actualHeight = imgRatio * actualHeight
                actualWidth = maxWidth
            } else {
                actualHeight = maxHeight
                actualWidth = maxWidth
                compressionQuality = 1
            }
        }

        let rect = CGRect(x: 0.0, y: 0.0, width: actualWidth, height: actualHeight)
        UIGraphicsBeginImageContext(rect.size)
        draw(in: rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        let imageData = img?.jpegData(compressionQuality: compressionQuality)
        UIGraphicsEndImageContext()
        return imageData
    }
    
}
