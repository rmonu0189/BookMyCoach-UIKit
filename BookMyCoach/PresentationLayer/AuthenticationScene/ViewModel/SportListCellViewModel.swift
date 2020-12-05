//
//  SportListCellViewModel.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 05/12/20.
//

import Foundation

protocol SportListCellViewModelProtocol {
    var sportName: String { get set }
    var sportIcon: String { get set }
    var isSelected: Bool { get set }
}

class SportListCellViewModel: SportListCellViewModelProtocol {
    
    var sportName: String
    var sportIcon: String
    var isSelected: Bool
    
    init(sport: Sport, selectedSport: Sport?) {
        sportName = sport.name
        sportIcon = sport.icon
        isSelected = sport.id == selectedSport?.id
    }
    
}
