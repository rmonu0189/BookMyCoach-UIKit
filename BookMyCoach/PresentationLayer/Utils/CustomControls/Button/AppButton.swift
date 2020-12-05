//
//  AppButton.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 03/12/20.
//

import UIKit

class AppButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tintColor = .white
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        self.layer.cornerRadius = frame.height / 2
        self.backgroundColor = UIColor(red: 30.0 / 255.0, green: 30.0 / 255.0, blue: 30.0 / 255.0, alpha: 1.0)
        self.dropShadow()
    }
    
    func dropShadow() {
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.6
        layer.masksToBounds = false
    }

}

class AppRadioButton: AppButton {
    
    override var isSelected: Bool {
        didSet {
            setupSelectedButton()
        }
    }
    
    fileprivate func setupSelectedButton() {
        if isSelected == true {
            self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            self.backgroundColor = UIColor(red: 30.0 / 255.0, green: 30.0 / 255.0, blue: 30.0 / 255.0, alpha: 1.0)
        } else {
            self.titleLabel?.font = UIFont.systemFont(ofSize: 20)
            self.backgroundColor = UIColor.clear
        }
    }    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        self.setImage(UIImage(systemName: "circle"), for: .normal)
        self.setImage(UIImage(systemName: "circle.fill"), for: .selected)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        self.setupSelectedButton()
    }
    
}
