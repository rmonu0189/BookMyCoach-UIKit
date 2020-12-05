//
//  SportRepository.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 05/12/20.
//

import Foundation

class SportRepository: SportListRepositoryProtocol, UpdateSportRepositoryProtocol {
    
    func fetchSportList(handler: @escaping ([Sport]?, Error?) -> ()) {
        handler(localDBSports, nil)
    }
    
    func updateSport(sportId: Int, isPrimary: Bool, handler: @escaping (User?, Error?) -> ()) {
        let sport = UpdateSportRequest.Sport(sportId: sportId, isPrimary: isPrimary)
        let request = UpdateSportRequest(sports: [sport])
        let service = APIService.updateSports(request: request)
        service.fetch(User.self) { (user, error, _) in
            handler(user, error)
        }
    }
    
}
