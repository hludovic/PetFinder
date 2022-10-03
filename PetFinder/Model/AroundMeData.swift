//
//  AroundMeData.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 21/09/2022.
//

import SwiftUI
import CloudKit

class AroundMeData: ObservableObject {
    @Published private(set) var petsAround: [Pet] = []
    @Published var range: Radius = .r50km
    @Published var alert: Bool = false
    @Published private(set) var alertMessage: String?
    
    func loadData(from location: CLLocationCoordinate2D?) async {
        guard let location else {
            return await displayError(message: "No location", error: nil)
        }
        let locationToFetch = CLLocation(latitude: location.latitude, longitude: location.longitude)
        
        let pets: [Pet]
        do {
            pets = try await fetchMissingPetsAround(location: locationToFetch, radiusInMeters: range)
        } catch let error {
            return await displayError(message: error.localizedDescription, error: error)
        }
        await MainActor.run{
            petsAround = pets
        }
    }
    
    func resetAlertMessage() {
        alertMessage = nil
    }
}

// MARK: - Private methods
extension AroundMeData {
    @MainActor private func displayError(message: String, error: Error?) {
        alert = true
        alertMessage = message
        print(message)
    }
    
    private func fetchMissingPetsAround(location: CLLocation, radiusInMeters: Radius) async throws -> [Pet] {
        var pets: [Pet] = []
        let predicate = NSPredicate(format: "distanceToLocation:fromLocation:(location, %@) < %f", location, radiusInMeters.value)
        let query = CKQuery(recordType: "Pets", predicate: predicate)
        let (values, _) = try await Model.database.records(matching: query, desiredKeys: ["user", "name", "gender", "type", "race", "birthDay", "location", "dateLost"])
        for value in values {
            if let record = try? value.1.get() {
                guard
                    let owner = record["user"] as? CKRecord.Reference,
                    let name = record["name"] as? String,
                    let gender = record["gender"] as? String,
                    let type = record["type"] as? String,
                    let race = record["race"] as? String,
                    let dateLost = record["dateLost"] as? Date,
                    let birthDay = record["birthDay"] as? Date,
                    let location = record["location"] as? CLLocation
                else { throw ModelError.typeCasting }
                let newPet = Pet(
                    id: record.recordID.recordName,
                    owner: owner.recordID.recordName,
                    name: name,
                    gender: gender,
                    type: type,
                    race: race,
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
