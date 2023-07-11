//
//  NetworkManager.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 11/07/2023.
//

import Foundation
import CloudKit
import CoreData

class NetworkManager: ObservableObject {
    static let CloudContainer = CKContainer(identifier: "iCloud.fr.hludovic.container2")
    static let CloudDatabase = CloudContainer.publicCloudDatabase

    static var CKUserRecordID: CKRecord.ID {
        get async throws { try await CloudContainer.userRecordID() }
    }

    static func CKAccountStatus() async -> (Bool, String) {
        let accountStatus: CKAccountStatus
        do {
            accountStatus = try await CloudContainer.accountStatus()
        } catch let error {
            print(error.localizedDescription)
            return (false, "")
        }
        switch accountStatus {
        case .couldNotDetermine:
            return (false, "")
        case .available:
            return (true, "")
        case .restricted:
            return (false, "")
        case .noAccount:
            return (false, "")
        case .temporarilyUnavailable:
            return (false, "")
        @unknown default:
            return (false, "")
        }
    }

    func fetchMissingPetsAround(location: CLLocation, radiusInMeters: Radius) async throws -> [PetLost] {
        var pets: [PetLost] = []
        let predicate = NSPredicate(format: "distanceToLocation:fromLocation:(location, %@) < %f", location, radiusInMeters.value)
        let query = CKQuery(recordType: "Pets", predicate: predicate)
        let (values, _) = try await Self.CloudDatabase.records(
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
                else { throw NetworkError.typeCasting }
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
