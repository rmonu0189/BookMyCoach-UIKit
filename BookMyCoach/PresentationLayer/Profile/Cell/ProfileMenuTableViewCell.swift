//
//  ProfileMenuTableViewCell.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 06/12/20.
//

import UIKit

class ProfileMenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func fill(with info: ProfileMenuCellViewModel) {
        titleLabel?.text = info.title
    }
}
