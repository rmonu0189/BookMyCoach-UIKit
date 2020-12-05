//
//  PendingBookingTableViewCell.swift
//  BookMyCoach
//
//  Created by Bharat Lal on 06/12/20.
//

import Foundation
import UIKit
import Kingfisher

class PendingBookingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avtarImageView: UIImageView?
    @IBOutlet weak var userNameLabel: UILabel?
    @IBOutlet weak var timeLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func fill(with viewModel: PendingBookingCellViewModelProtocol) {
        avtarImageView?.kf.setImage(with: URL(string: viewModel.profileIcon), placeholder: viewModel.userName.image())
        userNameLabel?.text = viewModel.userName
        timeLabel?.text = viewModel.sessionDateTime
    }
    
}
