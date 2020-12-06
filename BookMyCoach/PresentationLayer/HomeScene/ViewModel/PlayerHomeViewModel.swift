//
//  PlayerHomeViewModel.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 05/12/20.
//

import Foundation
import CoreLocation

protocol PlayerHomeViewModelInput {
    
    var totalBookings: Int { get }
    var totalSports: Int { get }
    var totalCoaches: Int { get }
    
    func viewWillAppear()
    func bookNowAction(coachId: Int)
    func booking(at index: Int) -> CurrentBookingViewModelProtocol
    func sport(at index: Int) -> Sport
    func coach(at index: Int) -> NearbyCoachViewModelProtocol
}

protocol PlayerHomeViewModelOutput {
    var sports: Observable<[Sport]> { get set }
    var coaches: Observable<[User]> { get set }
    var bookings: Observable<[Booking]> { get set }
    var placemark: Observable<String> { get set }
    var error: Observable<Error> { get set }
    var showLoader: Observable<Bool> { get set }
    var showBookingSuccess: Observable<Bool> { get set }
}

protocol PlayerHomeViewModelProtocol: PlayerHomeViewModelInput, PlayerHomeViewModelOutput { }

class PlayerHomeViewModel: PlayerHomeViewModelProtocol {

    
    private let myBookingUseCase: MyBookingUseCaseProtocol
    private let nearbyCoachUseCase: NearbyCoachUseCaseProtocol
    private let sportListUseCase: SportListUseCaseProtocol
    private let bookCoachUseCase: BookCoachUseCaseProtocol
    private let locationManager: LocationManager
    private var currentLocation: CLLocation?
    
    var sports: Observable<[Sport]> = Observable([])
    var coaches: Observable<[User]> = Observable([])
    var bookings: Observable<[Booking]> = Observable([])
    var placemark: Observable<String> = Observable(nil)
    var error: Observable<Error> = Observable(nil)
    var showLoader: Observable<Bool> = Observable(nil)
    var showBookingSuccess: Observable<Bool> = Observable(nil)
    
    init(myBookingUseCase: MyBookingUseCaseProtocol, nearbyCoachUseCase: NearbyCoachUseCaseProtocol, sportListUseCase: SportListUseCaseProtocol, bookCoachUseCase: BookCoachUseCaseProtocol, locationManager: LocationManager) {
        self.myBookingUseCase = myBookingUseCase
        self.nearbyCoachUseCase = nearbyCoachUseCase
        self.sportListUseCase = sportListUseCase
        self.bookCoachUseCase = bookCoachUseCase
        self.locationManager = locationManager
        self.fetchCurrentLocation()
    }
    
    private func fetchSports() {
        showLoader.value = true
        sportListUseCase.fetchSportList { [weak self] (sports, error) in
            self?.showLoader.value = false
            if error == nil {
                self?.sports.value = sports ?? []
            } else {
                self?.error.value = error
            }
        }
    }
    
    private func fetchCurrentLocation() {
        self.showLoader.value = true
        locationManager.fetchCurrentLocation { [weak self] (location, placemark, error) in
            self?.showLoader.value = false
            if error == nil {
                self?.placemark.value = placemark?.locality
                self?.currentLocation = location
                self?.fetchNearbyCoaches()
            } else {
                self?.error.value = error
            }
        }
    }
    
    private func fetchMyBookings() {
        self.showLoader.value = true
        myBookingUseCase.fetchMyBookings { [weak self] (bookings, error) in
            self?.showLoader.value = false
            if error == nil {
                self?.bookings.value = bookings
            } else {
                self?.error.value = error
            }
        }
    }
    
    private func fetchNearbyCoaches() {
        let latitude = currentLocation?.coordinate.latitude ?? 0
        let longitude = currentLocation?.coordinate.longitude ?? 0
        self.showLoader.value = true
        nearbyCoachUseCase.nearbyCoach(latitude: latitude, longitude: longitude) { [weak self] (coaches, error) in
            self?.showLoader.value = false
            if error == nil {
                self?.coaches.value = coaches?.filter({ $0.bookingStatus == .none })
            } else {
                self?.error.value = error
            }
        }
    }
    
    
}

extension PlayerHomeViewModel {
    
    func viewWillAppear() {
        fetchMyBookings()
        fetchSports()
    }
    
    var totalBookings: Int {
        return bookings.value?.count ?? 0
    }
    
    var totalSports: Int {
        return sports.value?.count ?? 0
    }
    
    var totalCoaches: Int {
        return coaches.value?.count ?? 0
    }
    
    func booking(at index: Int) -> CurrentBookingViewModelProtocol {
        if let item = bookings.value?[index] {
            return CurrentBookingViewModel(item)
        }
        fatalError("Booking not found at index \(index)")
    }
    
    func sport(at index: Int) -> Sport {
        if let item = sports.value?[index] {
            return item
        }
        fatalError("Sport not found at index \(index)")
    }
    
    func coach(at index: Int) -> NearbyCoachViewModelProtocol {
        if let item = coaches.value?[index] {
            return NearbyCoachViewModel(item)
        }
        fatalError("Sport not found at index \(index)")
    }
    
    func bookNowAction(coachId: Int) {
        self.showLoader.value = true
        bookCoachUseCase.bookCoach(coachId: coachId) { [weak self] (bookings, error) in
            self?.showLoader.value = false
            if error == nil {
                self?.showBookingSuccess.value = true
                self?.fetchMyBookings()
                self?.fetchNearbyCoaches()
            } else {
                self?.error.value = error
            }
        }
    }
    
}
