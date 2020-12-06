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
    @IBOutlet weak var acceptButton: UIButton?
    @IBOutlet weak var rejectButton: UIButton?
    
    var bookingResponseAction: ((Int, Bool) -> ())?
    
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
        acceptButton?.tag = viewModel.bookingId
        rejectButton?.tag = viewModel.bookingId
    }
    
    //MARK: - IBActions
    @IBAction func acceptBookingTapped(_ sender: UIButton) {
        bookingResponseAction?(sender.tag, true)
    }
    
    @IBAction func rejectBookingTapped(_ sender: UIButton) {
        bookingResponseAction?(sender.tag, false)
    }
}
