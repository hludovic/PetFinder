//
//  LocationManager.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 01/10/2022.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    @Published var location: CLLocation?
    @Published var authorizationStatus: CLAuthorizationStatus
    
    private let locationManager: CLLocationManager
    
    override init() {
        locationManager = CLLocationManager()
        authorizationStatus = locationManager.authorizationStatus
        
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.startUpdatingLocation()
    }
    
//    func requestAuthorization() {
//        guard let authorized, !authorized else { return }
//        locationManager.requestWhenInUseAuthorization()
//    }
    
    // MARK: - Core Location Manager Delegate

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let newLocation = locations.first {
            location = newLocation
        }
    }

//    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        switch manager.authorizationStatus {
//        case .notDetermined:
//            authorized = false
//        case .restricted, .denied:
//            authorized = false
//        case .authorizedAlways, .authorizedWhenInUse:
//            authorized = true
//        @unknown default:
//            authorized = false
//        }
//    }

}

