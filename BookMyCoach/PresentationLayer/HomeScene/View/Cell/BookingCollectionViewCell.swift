//
//  BookingCollectionViewCell.swift
//  BookMyCoach
//
//  Created by Bharat Lal on 12/5/20.
//

import UIKit
import Kingfisher

class BookingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var avtarImageView: UIImageView?
    @IBOutlet weak var coachNameLabel: UILabel?
    @IBOutlet weak var sportNameLabel: UILabel?
    @IBOutlet weak var ratingLabel: UILabel?
    @IBOutlet weak var bookingStatusLabel: PaddedLabel?
    @IBOutlet weak var bookingDateLabel: UILabel?
    @IBOutlet weak var sessionTimeLabel: UILabel?
    
    func fill(with viewModel: CurrentBookingViewModelProtocol) {
        coachNameLabel?.text = viewModel.coachName
        sportNameLabel?.text = viewModel.sportName
        ratingLabel?.text = viewModel.rating
        bookingStatusLabel?.text = viewModel.bookingStatus
        bookingStatusLabel?.backgroundColor = viewModel.bookingStatus == Booking.BookingStatus.active.rawValue.capitalized ? UIColor.green.withAlphaComponent(0.5) : UIColor.yellow.withAlphaComponent(0.5)
        bookingDateLabel?.text = viewModel.bookingDate
        sessionTimeLabel?.text = viewModel.sessionTime
        avtarImageView?.kf.setImage(with: URL(string: viewModel.avtarImageURL), placeholder: viewModel.coachName.image())
    }
}
