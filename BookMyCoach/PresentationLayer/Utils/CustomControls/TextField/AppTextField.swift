//
//  AppTextField.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 03/12/20.
//

import UIKit

enum AppTextFieldLeftIcon {
    case aboutYou
    case price
}

class AppTextField: UITextField {

    private let padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 0)
    private let leftImageView = UIImageView()
    private let bottomLine = UIView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        self.textColor = .white
        self.borderStyle = .none
        self.tintColor = .white
        self.setupPlaceholder()
        self.setupLeftImage()
        self.setupBottomLine()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        leftImageView.frame = CGRect(x: 0, y: 0, width: 25, height: frame.height)
        bottomLine.frame = CGRect(x: 0, y: frame.height - 1, width: frame.width, height: 1)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    private func setupLeftImage() {
        leftImageView.frame = CGRect(x: 0, y: 0, width: 25, height: frame.height)
        leftImageView.contentMode = .scaleAspectFit
        leftImageView.tintColor = .white
        switch textContentType ?? UITextContentType.name {
        case .emailAddress:
            leftImageView.image = UIImage(systemName: "envelope")
        case .password:
            leftImageView.image = UIImage(systemName: "lock")
        default:
            break
        }
        self.addSubview(leftImageView)
    }
    
    private func setupBottomLine() {
        bottomLine.frame = CGRect(x: 0, y: frame.height - 1, width: frame.width, height: 1)
        bottomLine.backgroundColor = .white
        self.addSubview(bottomLine)
    }
    
    private func setupPlaceholder() {
        self.attributedPlaceholder = NSAttributedString(string: placeholder ?? "",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    func setLeftIcon(_ type: AppTextFieldLeftIcon) {
        switch type {
        case .aboutYou:
            leftImageView.image = UIImage(systemName: "text.below.photo")
        case .price:
            leftImageView.image = UIImage(systemName: "dollarsign.circle")
        }
    }
}
