//
//  LocationManager.swift
//  NPF-4
//
//  Created by Lowell Pence on 4/21/21.
//

import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject {
    
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    let objectWillChange = PassthroughSubject<Void,Never>()
    
    @Published var locationError: Bool? {
        willSet { objectWillChange.send() }
    }
    
    @Published var permissionError: Bool? {
        willSet { objectWillChange.send() }
    }
    
    @Published var status: CLAuthorizationStatus? {
        willSet { objectWillChange.send() }
    }
    
    @Published var location: CLLocation? {
        willSet { objectWillChange.send() }
    }
    
    @Published var placemark: CLPlacemark? {
        willSet { objectWillChange.send() }
    }
    
    override init() {
        super.init()
        
        /* configure the CLLocationManger */
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // request permission
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
        }
        
        locationManager.startUpdatingLocation()
    }
    
    
    private func geocode() {
        guard let location = location else { return }
        geocoder.reverseGeocodeLocation(location) { (places, error) in
            if error == nil {
                self.placemark = places?[0]
            } else {
                self.placemark = nil
            }
        }
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        status = CLLocationManager.authorizationStatus()
        switch status {
        case .restricted:
            self.permissionError = true
            return
        case .denied:
            self.permissionError = true
            return
        case .notDetermined:
            self.permissionError = true
            return
        case .authorizedWhenInUse:
            self.permissionError = false
            return
        case .authorizedAlways:
            self.permissionError = false
            return
        case .none:
            self.permissionError = true
            return
        @unknown default:
            break
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        
        self.location = location
        self.locationError = false
        self.geocode()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.locationError = true
    }
}
