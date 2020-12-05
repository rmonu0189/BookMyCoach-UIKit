//
//  AppLoaderView.swift
//
//  Created by Monu on 09/01/18.
//  Copyright © 2020 Digimoplus. All rights reserved.
//

import UIKit

extension LoaderView {
    
    class func show() {
        if Thread.isMainThread {
            LoaderView.shared.showLoader()
        } else {
            DispatchQueue.main.async {
                LoaderView.shared.showLoader()
            }
        }
    }
    
    class func hide() {
        if Thread.isMainThread {
            LoaderView.shared.hideLoader()
        } else {
            DispatchQueue.main.async {
                LoaderView.shared.hideLoader()
            }
        }
    }
    
}

final class LoaderView: UIView {
    
    @IBOutlet var indicator: UIActivityIndicatorView!

    private class func instanceFromNib() -> LoaderView {
        return UINib(nibName: String(describing: self), bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! LoaderView
    }

    // MARK: - Singleton Instance
    private class var shared: LoaderView {
        struct Singleton {
            static let instance = LoaderView.instanceFromNib()
        }
        Singleton.instance.shadowOnView()
        return Singleton.instance
    }

    private func shadowOnView() {
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 5.0
        layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
        layer.shadowOpacity = 2.5
    }

    private func showLoader() {
        if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
            let loader = LoaderView.shared
            loader.indicator.startAnimating()
            loader.center = window.center
            if loader.superview == nil {
                window.addSubview(loader)
            }
        }
    }

    private func hideLoader() {
        let loader = LoaderView.shared
        loader.indicator.stopAnimating()
        loader.removeFromSuperview()
    }
    
}
