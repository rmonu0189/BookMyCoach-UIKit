//
//  ProfileInfoTableViewCell.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 06/12/20.
//

import UIKit

class ProfileInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var subTitleLabel: UILabel?
    @IBOutlet weak var iconImageView: UIImageView?
        
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func fill(with info: ProfileInfoCellViewModel) {
        titleLabel?.text = info.title
        subTitleLabel?.text = info.subTitle
        iconImageView?.image = UIImage(named: info.icon)
    }

}
