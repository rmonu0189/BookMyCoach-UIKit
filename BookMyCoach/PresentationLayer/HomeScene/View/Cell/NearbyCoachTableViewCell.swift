//
//  NearbyCoachTableViewCell.swift
//  BookMyCoach
//
//  Created by Bharat Lal on 12/5/20.
//

import UIKit

class NearbyCoachTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avtarImageView: UIImageView?
    @IBOutlet weak var coachNameLabel: UILabel?
    @IBOutlet weak var sportNameLabel: UILabel?
    @IBOutlet weak var sportImageView: UIImageView?
    @IBOutlet weak var ratingLabel: UILabel?
    @IBOutlet weak var priceLabel: UILabel?
    @IBOutlet weak var bookNowButon: UIButton?

    var bookNowAction: ((Int) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fill(with viewModel: NearbyCoachViewModelProtocol) {
        coachNameLabel?.text = viewModel.coachName
        sportNameLabel?.text = viewModel.sportName
        sportImageView?.image = UIImage(named: viewModel.sportIconName)
        ratingLabel?.text = viewModel.rating
        priceLabel?.text = viewModel.price
        avtarImageView?.kf.setImage(with: URL(string: viewModel.avtarImageURL), placeholder: viewModel.coachName.image(200, isCircular: false))
        bookNowButon?.tag = viewModel.coachId
    }
    
    @IBAction func bookNowTapped(_ sender: UIButton) {
        bookNowAction?(sender.tag)
    }

}
