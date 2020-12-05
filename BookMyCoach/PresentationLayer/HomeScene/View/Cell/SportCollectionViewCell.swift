//
//  SportCollectionViewCell.swift
//  BookMyCoach
//
//  Created by Bharat Lal on 12/5/20.
//

import UIKit

class SportCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var sportImageView: UIImageView?
    @IBOutlet weak var sportNameLabel: UILabel?
    
    func fill(with name: String, icon: String) {
        sportNameLabel?.text = name
        sportImageView?.image = UIImage(named: icon)
    }
}
