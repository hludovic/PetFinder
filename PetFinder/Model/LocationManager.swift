//
//  LocationManager.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 01/10/2022.
//

import Foundation
import CoreLocation
import os

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    @Published var location: CLLocationCoordinate2D?
    @Published var authorizationStatus: CLAuthorizationStatus
    private static let locationManager: CLLocationManager = CLLocationManager()
    private static let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: LocationManager.self))
    
    override init() {
        authorizationStatus = Self.locationManager.authorizationStatus
        super.init()
        Self.locationManager.delegate = self
        Self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        Self.logger.trace("Start requesting locations")
        Self.locationManager.startUpdatingLocation()
    }
    
    func requestAuthorization() {
        Self.logger.trace("Start requesting \"When in use\" authorization")
        Self.locationManager.requestWhenInUseAuthorization()
    }
    
    // MARK: - Core Location Manager Delegate
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        Self.logger.warning("\(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        Self.logger.trace("Location requesting is finished")
        location = locations.first?.coordinate
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }
}

