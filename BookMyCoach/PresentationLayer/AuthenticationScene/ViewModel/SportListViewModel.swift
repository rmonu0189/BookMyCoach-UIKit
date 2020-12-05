//
//  SportListViewModel.swift
//  BookMyCoach
//
//  Created by Bharat Lal on 05/12/20.
//

import Foundation

protocol SportListViewModelInput {
    func sportDidSelect(sport: Sport)
    func updateSport()
}

protocol SportListViewModelOutput {
    var viewTitle: Observable<String> { get set }
    var selectedSport: Observable<Sport> { get set }
    var error: Observable<Error> { get set }
    var showLoader: Observable<Bool> { get set }
    var sportUpdatedSuccess: Observable<Bool> { get set }
    var refreshData: Observable<Bool> { get set }
}

protocol SportListViewModelProtocol: SportListViewModelInput, SportListViewModelOutput { }

class SportListViewModel: SportListViewModelProtocol {
    
    var viewTitle: Observable<String> = Observable(nil)
    var selectedSport: Observable<Sport> = Observable(nil)
    var error: Observable<Error> = Observable(nil)
    var showLoader: Observable<Bool> = Observable(nil)
    var sportUpdatedSuccess: Observable<Bool> = Observable(nil)
    var refreshData: Observable<Bool> = Observable(true)
    
    private(set) var sports: [Sport] = []
    private(set) var viewMode: ViewMode
    
    private let sportListUseCase: SportListUseCaseProtocol
    private let updateSportUserCase: UpdateSportUseCaseProtocol
    
    init(selectedSport: Sport?, sportListUseCase: SportListUseCaseProtocol, updateSportUserCase: UpdateSportUseCaseProtocol, viewMode: ViewMode = .normal) {
        self.sportListUseCase = sportListUseCase
        self.updateSportUserCase = updateSportUserCase
        self.selectedSport.value = selectedSport
        self.viewMode = viewMode
        self.viewTitle.value = viewMode == ViewMode.normal ? Constant.chooseSports : Constant.updateSport
        self.fetchSports()
    }
    
    private func fetchSports() {
        showLoader.value = true
        sportListUseCase.fetchSportList { [weak self] (sports, error) in
            self?.showLoader.value = false
            if error == nil {
                self?.sports = sports ?? []
                self?.refreshData.value = true
            } else {
                self?.error.value = error
            }
        }
    }
    
    func updateSport() {
        if let sportId = selectedSport.value?.id {
            showLoader.value = true
            updateSportUserCase.updateSport(sportId: sportId, isPrimary: true) { [weak self] (_, error) in
                self?.showLoader.value = false
                if error == nil {
                    self?.sportUpdatedSuccess.value = true
                } else {
                    self?.error.value = error
                }
            }
        } else {
            self.error.value = AppError.withMessage(message: Constant.chooseSportToProceed)
        }
    }
    
    func cellViewModel(at index: Int) -> SportListCellViewModelProtocol {
        let sport = self.sports[index]
        return SportListCellViewModel(sport: sport, selectedSport: selectedSport.value)
    }
    
}

extension SportListViewModel {
    
    func sportDidSelect(sport: Sport) {
        selectedSport.value = sport
    }
    
}
