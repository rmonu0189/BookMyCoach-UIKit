//
//  Image+Helper.swift
//  BookMyCoach
//
//  Created by Bharat Lal on 12/1/20.
//

import Foundation
import UIKit

extension String {
    
    func image(_ height: CGFloat = 100, isCircular: Bool = true) -> UIImage? {
        return UIImage.defaultImage(name: self, height: height, isCircular: isCircular)
    }
    
    func getInitials() -> String {
        let characters = self.components(separatedBy: " ").filter({$0.count > 0})
        var text = characters.compactMap({$0[$0.startIndex...$0.startIndex]}).joined(separator: "")
        if text.count > 2 {
            text = String(text[text.startIndex..<text.index(text.startIndex, offsetBy: 2)])
        }
        return text.uppercased()
    }
    
    func pickColor() -> UIColor {
        guard let alphabet = self.first else { return UIColor.black }
        let alphabetColors = [0x5A8770, 0xB2B7BB, 0x6FA9AB, 0xF5AF29, 0x0088B9, 0xF18636, 0xD93A37, 0xA6B12E, 0x5C9BBC, 0xF5888D, 0x9A89B5, 0x407887, 0x9A89B5, 0x5A8770, 0xD33F33, 0xA2B01F, 0xF0B126, 0x0087BF, 0xF18636, 0x0087BF, 0xB2B7BB, 0x72ACAE, 0x9C8AB4, 0x5A8770, 0xEEB424, 0x407887]
        let str = String(alphabet).unicodeScalars
        let unicode = Int(str[str.startIndex].value)
        if 65...90 ~= unicode {
            let hex = alphabetColors[unicode - 65]
            return UIColor(red: CGFloat(Double((hex >> 16) & 0xFF)) / 255.0, green: CGFloat(Double((hex >> 8) & 0xFF)) / 255.0, blue: CGFloat(Double((hex >> 0) & 0xFF)) / 255.0, alpha: 1.0)
        }
        return UIColor.black
    }
}

extension UIImage {
    
    class func defaultImage(name: String, height: CGFloat = 100, isCircular: Bool = true) -> UIImage? {
        let characters = name.components(separatedBy: " ").filter({$0.count > 0})
        let lblNameInitialize = UILabel()
        lblNameInitialize.frame.size = CGSize(width: height, height: height)
        var text = characters.compactMap({$0[$0.startIndex...$0.startIndex]}).joined(separator: "")
        if text.count > 2 {
            text = String(text[text.startIndex..<text.index(text.startIndex, offsetBy: 2)])
        }
        lblNameInitialize.text = text.uppercased()
        lblNameInitialize.textColor = UIColor.white
        lblNameInitialize.backgroundColor = UIColor.pickColor(text.uppercased().first)
        lblNameInitialize.textAlignment = NSTextAlignment.center
        lblNameInitialize.font = UIFont.boldSystemFont(ofSize: (height*40) / 100)
        if isCircular == true {
            lblNameInitialize.layer.cornerRadius = height/2
            lblNameInitialize.clipsToBounds = true
        }
        
        UIGraphicsBeginImageContext(lblNameInitialize.frame.size)
        lblNameInitialize.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}

extension UIColor {
    
    class func pickColor(_ nameCharacter: Character?) -> UIColor {
        guard let alphabet = nameCharacter else { return UIColor.black }
        let alphabetColors = [0x5A8770, 0xB2B7BB, 0x6FA9AB, 0xF5AF29, 0x0088B9, 0xF18636, 0xD93A37, 0xA6B12E, 0x5C9BBC, 0xF5888D, 0x9A89B5, 0x407887, 0x9A89B5, 0x5A8770, 0xD33F33, 0xA2B01F, 0xF0B126, 0x0087BF, 0xF18636, 0x0087BF, 0xB2B7BB, 0x72ACAE, 0x9C8AB4, 0x5A8770, 0xEEB424, 0x407887]
        let str = String(alphabet).unicodeScalars
        let unicode = Int(str[str.startIndex].value)
        if 65...90 ~= unicode {
            let hex = alphabetColors[unicode - 65]
            return UIColor(red: CGFloat(Double((hex >> 16) & 0xFF)) / 255.0, green: CGFloat(Double((hex >> 8) & 0xFF)) / 255.0, blue: CGFloat(Double((hex >> 0) & 0xFF)) / 255.0, alpha: 1.0)
        }
        return UIColor.black
    }
    
}
