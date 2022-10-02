//
//  AroundMeData.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 21/09/2022.
//

import SwiftUI
import CloudKit

class AroundMeData: ObservableObject {
    @Published var petsAround: [Pet] = []
    @Published var range: Range = .r50km
    
    func fetchMissingPetsAround(location: CLLocationCoordinate2D?) async {
        guard let location else { return print("ERROR") }
        let locationToFetch = CLLocation(latitude: location.latitude, longitude: location.longitude)
        
        let pets: [Pet]
        do {
            pets = try await fetchMissingPetsAround(location: locationToFetch, radiusInMeters: range)
        } catch let error { return print(error.localizedDescription) }
        await MainActor.run{
            petsAround = pets
        }
    }
}

// MARK: - Private methods
extension AroundMeData {
    private func fetchMissingPetsAround(location: CLLocation, radiusInMeters: Range) async throws -> [Pet] {
        var pets: [Pet] = []
        let predicate = NSPredicate(format: "distanceToLocation:fromLocation:(location, %@) < %f", location, radiusInMeters.rawValue)
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
    
    enum Range: CGFloat, CaseIterable, Identifiable {
        var id: CGFloat { self.rawValue }
        case r1km = 1000
        case r5km = 5000
        case r10km = 10000
        case r50km = 50000
    }
}

