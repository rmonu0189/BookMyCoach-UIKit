//
//  NearbyCoachViewModel.swift
//  BookMyCoach
//
//  Created by Bharat Lal on 12/5/20.
//

import Foundation

protocol NearbyCoachViewModelInput { }

protocol NearbyCoachViewModelOutput {
    var coachId: Int { get set }
    var avtarImageURL: String { get set }
    var coachName: String { get set }
    var sportName: String { get set }
    var rating: String { get set }
    var price: String { get set }
    var sportIconName: String { get set }
}

protocol NearbyCoachViewModelProtocol: NearbyCoachViewModelOutput, NearbyCoachViewModelInput { }

class NearbyCoachViewModel: NearbyCoachViewModelProtocol {
    var coachId: Int = 0
    var avtarImageURL = ""
    var coachName = ""
    var sportName = ""
    var rating = ""
    var price = ""
    var sportIconName = ""
    
    init(_ coach: User) {
        self.coachId = coach.id
        self.avtarImageURL = coach.profilePhoto ?? ""
        self.coachName = coach.fullName ?? ""
        self.price = coach.price?.description ?? ""
        self.sportName = coach.userSports?.first?.sport?.name ?? ""
        self.sportIconName = coach.userSports?.first?.sport?.icon ?? ""
        self.rating = coach.rating?.description ?? "5.0"
    }
    
}
