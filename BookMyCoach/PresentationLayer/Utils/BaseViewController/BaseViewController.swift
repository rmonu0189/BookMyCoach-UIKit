//
//  BaseViewController.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 03/12/20.
//

import UIKit

enum ViewMode {
    case normal
    case edit
}

class BaseViewController: UIViewController {

    @IBOutlet weak var bottomConstraint: NSLayoutConstraint?
    private var bottomSafeArea: CGFloat = 0
        
    override func viewDidLoad() {
        super.viewDidLoad()
        bottomSafeArea = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
        self.addKeyboardObserver()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

extension BaseViewController {
    
    private func addKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHeightWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardHeightWillChange(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.3) {
                self.bottomConstraint?.constant = keyboardSize.height - self.bottomSafeArea
                self.view.layoutIfNeeded()
            }
        }
    }
    
    // Keyboard will  show notifications
    @objc func keyboardWillHide(notification _: NSNotification) {
        UIView.animate(withDuration: 0.3) {
            self.bottomConstraint?.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
}

extension BaseViewController: UITextFieldDelegate {
    
    // MARK: - UITextFields return button functionality
    @discardableResult
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.returnKeyType == .next {
            nextTextField(textField: textField)
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    fileprivate func nextTextField(textField: UITextField) {
        let allSubviews = textField.superview?.subviews
        let textFields = allSubviews?.filter { $0 is UITextField && ($0 as? UITextField)?.isHidden == false }
        guard let allTextField = textFields?.sorted(by: {$0.tag < $1.tag}) else {
            textField.resignFirstResponder()
            return
        }
        
        if let index = allTextField.firstIndex(of: textField), index + 1 < allTextField.count {
            let nextTextField = allTextField[index + 1]
            nextTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
    }
}
