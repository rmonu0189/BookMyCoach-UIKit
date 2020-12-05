//
//  CustomCell+Helper.swift
//  BookMyCoach
//
//  Created by Bharat Lal on 12/5/20.
//

import UIKit

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableView {
    func cellWithType<T>(_: T.Type, indexPath: IndexPath, identifier: String? = nil) -> T {
        return dequeueReusableCell(withIdentifier: identifier ?? String(describing: T.self), for: indexPath) as! T
    }
    func reloadDataWith(_ animation: UITableView.RowAnimation) {
        beginUpdates()
        reloadSections(IndexSet(integersIn: 0..<numberOfSections), with: animation)
        endUpdates()
    }
}

extension UICollectionView {
    func cellWithType<T>(_: T.Type, for indexPath: IndexPath, identifier: String? = nil) -> T {
        return dequeueReusableCell(withReuseIdentifier: identifier ?? String(describing: T.self), for: indexPath) as! T
    }
}
