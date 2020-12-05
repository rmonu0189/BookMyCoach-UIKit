//
//  NotificationView.swift
//
//  Created by Monu Rathor on 13/11/18.
//  Copyright © 2020 Digimoplus. All rights reserved.
//

import UIKit

enum NotificationType {
    case success
    case error

    var color: UIColor {
        switch self {
        case .success:
            return UIColor(red: 56.0 / 255.0, green: 142.0 / 255.0, blue: 60.0 / 255.0, alpha: 1.0)
        case .error:
            return UIColor(red: 176.0 / 255.0, green: 0, blue: 32.0 / 255.0, alpha: 1.0)
        }
    }
}

class ToastView: UIView {

    // MARK: - Properties

    fileprivate let displayTime = 5.0 // Seconds

    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var safeAreaConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer(target: self, action: #selector(hide))
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(hide))
        swipe.direction = .up
        self.addGestureRecognizer(tap)
        self.addGestureRecognizer(swipe)
    }
    private class func instanceFromNib() -> ToastView {
        return UINib(nibName: String(describing: self), bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! ToastView
    }

    /// Dissmiss notification view.
    ///
    /// - Parameter sender: UIButton
    @IBAction func dissmissButtonTapped(_: UIButton) {
        hide()
    }
}

extension ToastView {

    // MARK: - Public methods

    /// Show message in notification form.
    ///
    /// - Parameter error: Error occure and you want to show in notification.
    class func showError(_ error: Error?) {
        guard let message = error?.localizedDescription else { return }
        if let err = error as NSError?, err.code == -999 { return }
        ToastView.showMessage(message, type: .error)
    }

    /// Show message in notification form.
    ///
    /// - Parameters:
    ///   - successMessage: Notification message.
    class func showSuccess(_ successMessage: String?) {
        guard let message = successMessage else { return }
        ToastView.showMessage(message, type: .success)
    }
    class func showUnderDevelopment() {
        ToastView.showMessage("Coming soon!!", type: .success)
    }
    class func showErrorMessage(_ errorMessage: String?) {
        guard let message = errorMessage else { return }
        ToastView.showMessage(message, type: .error)
    }

    /// Show message in notification form.
    ///
    /// - Parameters:
    ///   - successMessage: Notification message.
    ///   - type: Notification type like as success, error, info etc.
    class func showMessageWithType(_ successMessage: String?, type: NotificationType) {
        guard let message = successMessage else { return }
        ToastView.showMessage(message, type: type)
    }
    
}

extension ToastView {

    // MARK: - Private methods

    fileprivate class func showMessage(_ message: String, type: NotificationType) {
        if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
            if Thread.isMainThread {
                let alertView = ToastView.instanceFromNib()
                alertView.messageLabel.text = message
                alertView.backgroundColor = type.color
                alertView.addAlertOnWindow(window, message: message)
            } else {
                DispatchQueue.main.async {
                    let alertView = ToastView.instanceFromNib()
                    alertView.messageLabel.text = message
                    alertView.backgroundColor = type.color
                    alertView.addAlertOnWindow(window, message: message)
                }
            }
        }
    }

    @objc func hide() {
        UIView.animate(withDuration: 0.3, animations: {
            self.frame.origin.y = (-1.0 * self.frame.height)
        }) { _ in
            self.removeFromSuperview()
        }
    }

    private func addAlertOnWindow(_ window: UIWindow, message: String) {
        let topSafeArea = (UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0)
        let height = message.textHeight(UIScreen.main.bounds.width - 32, font: messageLabel.font) + 24 + topSafeArea // 20 alert text height
        safeAreaConstraint.constant = topSafeArea
        frame = CGRect(x: 0, y: -1.0 * height, width: UIScreen.main.bounds.width, height: height)
        // Show alert view
        window.addSubview(self)
        UIView.animate(withDuration: 0.3, animations: {
            self.frame.origin.y = 0
        }) { _ in
            // Hide view
            self.perform(#selector(self.hide), with: nil, afterDelay: self.displayTime)
        }
    }
}

extension String {

    // MARK: - String Extension

    /// Get string height with corrosponding the with.
    ///
    /// - Parameters:
    ///   - width: CGFloat Fixed width.
    ///   - font: UIFont of label or textFields.
    /// - Returns: Height of the content size.
    func textHeight(_ width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.height
    }
}
