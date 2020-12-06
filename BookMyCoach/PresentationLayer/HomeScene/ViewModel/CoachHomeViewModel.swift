//
//  CoachHomeViewModel.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 05/12/20.
//

import Foundation
import CoreLocation

protocol CoachHomeViewModelInput {
    var totalBookings: Int { get }
    var totalPendingBookings: Int { get }
    func viewWillAppear()
    func booking(at index: Int) -> CurrentBookingViewModelProtocol
    func pendingBooking(at index: Int) -> PendingBookingCellViewModelProtocol
    func bookingResponseAction(bookingId: Int, isAccept: Bool)
}

protocol CoachHomeViewModelOutput {
    var pendingBookings: Observable<[Booking]> { get }
    var bookings: Observable<[Booking]> { get }
    var placemark: Observable<String> { get }
    var error: Observable<Error> { get }
    var showLoader: Observable<Bool> { get }
}

protocol CoachHomeViewModelProtocol: CoachHomeViewModelInput, CoachHomeViewModelOutput { }

class CoachHomeViewModel: CoachHomeViewModelProtocol {
    
    private let pendingInvitationUseCase: CoachPendingInvitationUseCaseProtocol
    private let myBookingUseCase: MyBookingUseCaseProtocol
    private let responseToBookingUseCase: CoachResponseUseCaseProtocol
    private let locationManager: LocationManager
    
    var pendingBookings: Observable<[Booking]> = Observable([])
    var bookings: Observable<[Booking]> = Observable([])
    var placemark: Observable<String> = Observable(nil)
    var error: Observable<Error> = Observable(nil)
    var showLoader: Observable<Bool> = Observable(nil)
    var showSuccess: Observable<Bool> = Observable(nil)
    
    init(pendingInvitationUseCase: CoachPendingInvitationUseCaseProtocol, myBookingUseCase: MyBookingUseCaseProtocol, responseToBookingUseCase: CoachResponseUseCaseProtocol, locationManager: LocationManager) {
        self.pendingInvitationUseCase = pendingInvitationUseCase
        self.myBookingUseCase = myBookingUseCase
        self.responseToBookingUseCase = responseToBookingUseCase
        self.locationManager = locationManager
        self.fetchCurrentLocation()
    }
    
    private func fetchCurrentLocation() {
        locationManager.fetchCurrentLocation { [weak self] (location, placemark, error) in
            if error == nil {
                self?.placemark.value = placemark?.locality
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
    
    private func fetchPendingInvitations() {
        self.showLoader.value = true
        pendingInvitationUseCase.pendingInvitationForCoach { [weak self] (bookings, error) in
            self?.showLoader.value = false
            if error == nil {
                self?.pendingBookings.value = bookings
            } else {
                self?.error.value = error
            }
        }
    }
    
}

extension CoachHomeViewModel {
    
    var totalBookings: Int {
        return bookings.value?.count ?? 0
    }
    
    var totalPendingBookings: Int {
        return pendingBookings.value?.count ?? 0
    }
    
    func viewWillAppear() {
        fetchMyBookings()
        fetchPendingInvitations()
    }
    
    func booking(at index: Int) -> CurrentBookingViewModelProtocol {
        if let item = bookings.value?[index] {
            return CurrentBookingViewModel(item)
        }
        fatalError("Booking not found at index \(index)")
    }
    
    func pendingBooking(at index: Int) -> PendingBookingCellViewModelProtocol {
        if let item = pendingBookings.value?[index] {
            return PendingBookingCellViewModel(item)
        }
        fatalError("Booking not found at index \(index)")
    }
    
    func bookingResponseAction(bookingId: Int, isAccept: Bool) {
        self.showLoader.value = true
        responseToBookingUseCase.respondToBookingRequest(bookingId: bookingId, isAccept: isAccept) { [weak self] (success, error) in
            self?.showLoader.value = false
            if error == nil {
                self?.fetchPendingInvitations()
                self?.showSuccess.value = isAccept
            } else {
                self?.error.value = error
            }
        }
    }
}
