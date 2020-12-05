//
//  UIViewController+Helper.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 03/12/20.
//

import UIKit

enum StoryboardName: String {
    case Authentication
    case Home
    case Chat
    case Member
    case Profile
}

protocol ViewModel {
    var error: Observable<Error>? {get set}
}

protocol UIViewModel: ViewModel {
    var showLoader: Observable<Bool>? {get set}
}

extension UIViewController {
    
    static func controller<T: UIViewController>(_ type: T.Type, name: StoryboardName) -> T {
        let storyboard = UIStoryboard(name: name.rawValue, bundle: nil)
        if let controller = storyboard.instantiateViewController(identifier: String(describing: T.self)) as? T {
            return controller
        }
        fatalError(String(describing: T.self) + " not found.")
    }
    
    func show(_ controller: UIViewController?, animation: Bool = true) {
        if controller?.navigationController == nil {
            controller?.present(self, animated: animation, completion: nil)
        } else {
            controller?.navigationController?.pushViewController(self, animated: animation)
        }
    }
    
    func showAsRoot(_ controller: UIViewController?, animation: Bool = false) {
        controller?.navigationController?.pushViewController(self, animated: animation)
        controller?.navigationController?.viewControllers = [self]
    }
    
    func popViewController(animation: Bool = true) {
        if self.navigationController == nil {
            self.dismiss(animated: animation, completion: nil)
        } else {
            self.navigationController?.popViewController(animation: true)
        }
    }
}
