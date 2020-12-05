//
//  LocationManager.swift
//  BookMyCoach
//
//  Created by Bharat Lal on 12/2/20.
//

import Foundation
import CoreLocation

typealias LocationHandler = (CLLocation?, CLPlacemark?, Error?) -> Void

class LocationManager: NSObject {
    
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    private(set) var handler: LocationHandler?
    private(set) var location: CLLocation?
    private(set) var placemark: CLPlacemark?
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    //MARK: - private
    private func geocode() {
        guard let location = self.location else { return }
        geocoder.reverseGeocodeLocation(location, completionHandler: { (places, error) in
            if error == nil {
                self.placemark = places?.first
            } else {
                self.placemark = nil
            }
            self.handler?(location, self.placemark, nil)
        })
    }
    
    //MARK: - public
    func fetchCurrentLocation(handler: LocationHandler?) {
        self.handler = handler
        self.locationManager.startUpdatingLocation()
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == .authorizedAlways || status == .authorizedWhenInUse) == false {
            handler?(nil, nil, AppError.withMessage(message: Constant.locationRequired))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
        self.geocode()
        self.locationManager.stopUpdatingLocation()
    }
}

extension CLLocation {
    var latitude: Double {
        return self.coordinate.latitude
    }
    
    var longitude: Double {
        return self.coordinate.longitude
    }
}

