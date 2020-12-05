//
//  UIView+LayerProperties.swift
//
//  Created by Monu Rathor on 13/11/18.
//  Copyright © 2018 Appster All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
extension UIView {

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = CGFloat(newValue)
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }

        set {
            layer.borderWidth = CGFloat(newValue)
        }
    }

    @IBInspectable var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }

    @IBInspectable var defaultShadow: Bool {
        get {
            return layer.masksToBounds
        }
        set {
            layer.shadowOffset = CGSize(width: 0, height: 0)
            layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
            layer.shadowRadius = 5
            layer.shadowOpacity = 0.6
            layer.masksToBounds = false
        }
    }

}
