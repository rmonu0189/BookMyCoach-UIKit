//
//  SportListCell.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 05/12/20.
//

import UIKit

class SportListCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var selectSportImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func fill(with viewModel: SportListCellViewModelProtocol) {
        nameLabel.text = viewModel.sportName
        iconImageView.image = UIImage(named: viewModel.sportIcon)
        selectSportImageView.image = viewModel.isSelected ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "circle")
    }

}
