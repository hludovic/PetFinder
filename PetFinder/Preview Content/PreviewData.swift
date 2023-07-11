//
//  PreviewData.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 11/07/2023.
//

import Foundation
import CloudKit
import SwiftUI
import CoreLocation
import CoreData

struct PreviewData {

    static var myLocation: CLLocationCoordinate2D {
        let location = CLLocation(latitude: 16.255072, longitude: -61.653711)
        return location.coordinate
    }

    static func uploadMissingPets() async throws -> [CKRecord] {
        let container = CKContainer(identifier: "iCloud.fr.hludovic.container2")
        let database = container.publicCloudDatabase

        let record1 = CKRecord(recordType: "Pets")
        let record2 = CKRecord(recordType: "Pets")
        let record3 = CKRecord(recordType: "Pets")

        record1.setValuesForKeys([
            "birthDay": Date.dateCreator(year: 2020, month: 1, day: 4),
            "dateLost": Date.dateCreator(year: 2022, month: 3, day: 9),
            "gender": PetLost.Gender.male.rawValue,
            "location": CLLocation(latitude: 16.261587307523747, longitude: -61.62137873321357),
            "name": "Felix",
            "photo": CKAsset(fileURL: localeURL(forImageNamed: "Pet1")!),
            "breed": PetLost.DogBreed.englishSpringerSpaniel.name,
            "type": PetLost.PetType.cat.rawValue,
            "user": CKRecord.Reference(recordID: CKRecord.ID(recordName: "_6ca1cd867330130aadfa04d47746aff9"), action: .none)
        ])

        record2.setValuesForKeys([
            "birthDay": Date.dateCreator(year: 2021, month: 7, day: 12),
            "dateLost": Date.dateCreator(year: 2022, month: 2, day: 10),
            "gender": PetLost.Gender.female.rawValue,
            "location": CLLocation(latitude: 16.04076861022844, longitude: -61.60101545693777),
            "name": "Martin",
            "photo": CKAsset(fileURL: localeURL(forImageNamed: "Pet2")!),
            "breed": PetLost.DogBreed.borderCollie.name,
            "type": PetLost.PetType.dog.rawValue,
            "user": CKRecord.Reference(recordID: CKRecord.ID(recordName: "_6ca1cd867330130aadfa04d47746aff9"), action: .none)
        ])

        record3.setValuesForKeys([
            "birthDay": Date.dateCreator(year: 2022, month: 5, day: 23),
            "dateLost": Date.dateCreator(year: 2022, month: 1, day: 4),
            "gender": PetLost.Gender.male.rawValue,
            "location": CLLocation(latitude: 16.258563662672728, longitude: -61.272922369971425),
            "name": "Woofy",
            "photo": CKAsset(fileURL: localeURL(forImageNamed: "Pet3")!),
            "breed": PetLost.DogBreed.germanShorthairedPointer.name,
            "type": PetLost.PetType.dog.rawValue,
            "user": CKRecord.Reference(recordID: CKRecord.ID(recordName: "_6ca1cd867330130aadfa04d47746aff9"), action: .none)
        ])

        let accountStatus: CKAccountStatus = try await CKContainer.default().accountStatus()

        if accountStatus == .noAccount {
            throw NetworkError.noAccount
        } else {
            var savedRecords: [CKRecord] = []
            var savedRecord = try await database.save(record1)
            savedRecords.append(savedRecord)
            savedRecord = try await database.save(record2)
            savedRecords.append(savedRecord)
            savedRecord = try await database.save(record3)
            savedRecords.append(savedRecord)
            return savedRecords
        }
    }
}

private extension PreviewData {
    static func localeURL(forImageNamed name: String) -> URL? {
        let fileManager = FileManager.default
        let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let url = cacheDirectory.appendingPathComponent("\(name).jpg")

        guard fileManager.fileExists(atPath: url.path) else {
            guard
                let image = UIImage(named: name),
                let data = image.jpegData(compressionQuality: 1.0)
            else { return nil }

            fileManager.createFile(atPath: url.path, contents: data, attributes: nil)
            return url
        }
        return url
    }
}
