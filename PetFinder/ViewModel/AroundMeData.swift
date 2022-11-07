//
//  AroundMeData.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 21/09/2022.
//

import CloudKit
import CoreLocation
import os

class AroundMeData: NSObject, ObservableObject {
    @Published private(set) var petsAround: [PetLost] = []
    @Published var range: Radius = .r50km { didSet { Task { await loadData() } } }
    @Published var isDesplayingAlert: Bool = false
    @Published private(set) var alertMessage: String?
    @Published var authorizationStatus: CLAuthorizationStatus
    private let locationManager: CLLocationManager
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: AroundMeData.self))
    var location: CLLocationCoordinate2D = CLLocationCoordinate2D()

    override init() {
        self.locationManager = CLLocationManager()
        self.authorizationStatus = locationManager.authorizationStatus
        super.init()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    }

    func startUpdatingMyLocation() {
        if authorizationStatus == .authorizedWhenInUse {
            logger.info("Starting location request")
            locationManager.delegate = self
            locationManager.requestLocation()
        }
    }

    func loadData() async {
        logger.info("Starting loading data")
        let locationToFetch = CLLocation(latitude: location.latitude, longitude: location.longitude)
        let pets: [PetLost]
        do {
            pets = try await fetchMissingPetsAround(location: locationToFetch, radiusInMeters: range)
        } catch let error {
            return await displayError(message: error.localizedDescription)
        }
        await MainActor.run {
            logger.info("Finished loading data")
            petsAround = pets
        }
    }

    func requestLocationAuthorization() {
        logger.info("Starting location authorisation request")
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }

    func resetAlertMessage() {
        alertMessage = nil
    }
}

// MARK: - CloudKit methods
extension AroundMeData {
    @MainActor private func displayError(message: String) {
        alertMessage = message
        isDesplayingAlert = true
    }

    private func fetchMissingPetsAround(location: CLLocation, radiusInMeters: Radius) async throws -> [PetLost] {
        var pets: [PetLost] = []
        let predicate = NSPredicate(format: "distanceToLocation:fromLocation:(location, %@) < %f", location, radiusInMeters.value)
        let query = CKQuery(recordType: "Pets", predicate: predicate)
        let (values, _) = try await Model.database.records(
            matching: query,
            desiredKeys: ["user", "name", "gender", "type", "breed", "birthDay", "location", "dateLost"]
        )
        for value in values {
            if let record = try? value.1.get() {
                guard
                    let owner = record["user"] as? CKRecord.Reference,
                    let name = record["name"] as? String,
                    let gender = record["gender"] as? String,
                    let type = record["type"] as? String,
                    let breed = record["breed"] as? String,
                    let dateLost = record["dateLost"] as? Date,
                    let birthDay = record["birthDay"] as? Date,
                    let location = record["location"] as? CLLocation
                else { throw ModelError.typeCasting }
                let newPet = PetLost(
                    id: record.recordID.recordName,
                    owner: owner.recordID.recordName,
                    name: name,
                    gender: gender,
                    type: type,
                    breed: breed,
                    dateLost: dateLost,
                    birthDay: birthDay,
                    location: location
                )
                pets.append(newPet)
            }
        }
        return pets
    }
}

// MARK: - The Radius
extension AroundMeData {
    enum Radius: Int, CaseIterable, Identifiable {
        case r5km, r10km, r50km

        var id: Int { self.rawValue }

        var name: String {
            switch self {
            case .r5km: return "Radius 5 km"
            case .r10km: return "Radius 10 km"
            case .r50km: return "Radius 50 km"
            }
        }

        var value: CGFloat {
            switch self {
            case .r5km: return 5000
            case .r10km: return 10000
            case .r50km: return 50000
            }
        }
    }
}

// MARK: - Core Location Manager Delegate
extension AroundMeData: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        logger.error("\(error.localizedDescription) - locationManager(_, locations)")
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        logger.info("Finished location request")
        locationManager.stopUpdatingLocation()
        locationManager.delegate = nil
        guard let newLocation = locations.first else {
            // TODO: Logg this error
            return print("Error")
        }
        logger.info("Updating Location")
        location = newLocation.coordinate
        Task { await loadData() }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }

}
