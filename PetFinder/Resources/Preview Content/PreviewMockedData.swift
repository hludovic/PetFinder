//
//  PreviewMockedData.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 20/09/2022.
//

import Foundation
import CloudKit
import SwiftUI

struct PetTest {
    func uploadPets() async throws -> [CKRecord] {
        let container = CKContainer(identifier: "iCloud.fr.hludovic.container2")
        let database = container.publicCloudDatabase
        
        let record1 = CKRecord(recordType: "Pets")
        let record2 = CKRecord(recordType: "Pets")
        let record3 = CKRecord(recordType: "Pets")
        let birthDayPet1 = dateStringCreator(year: 2020, month: 1, day: 4)
        let birthDayPet2 = dateStringCreator(year: 2021, month: 7, day: 12)
        let birthDayPet3 = dateStringCreator(year: 2022, month: 5, day: 23)
        
        record1.setValuesForKeys([
            "birthDay" : birthDayPet1,
            "gender" : Pet.Gender.male.rawValue,
            "location": CLLocation(latitude: 16.25503540039062, longitude: -61.653686524178916),
            "name" : "Felix",
            "photo" : CKAsset(fileURL: localeURL(forImageNamed: "Pet1")!),
            "race" : Pet.DogRace.english_springer_spaniel.rawValue,
            "type" : Pet.PetType.cat.rawValue,
            "user" : CKRecord.Reference(recordID: CKRecord.ID(recordName: "_6ca1cd867330130aadfa04d47746aff9"), action: .none)
        ])
        
        record2.setValuesForKeys([
            "birthDay" : birthDayPet2,
            "gender" : Pet.Gender.female.rawValue,
            "location": CLLocation(latitude: 16.0000778, longitude: -61.7333373),
            "name" : "Martin",
            "photo" : CKAsset(fileURL: localeURL(forImageNamed: "Pet2")!),
            "race" : Pet.DogRace.border_collie.rawValue,
            "type" : Pet.PetType.dog.rawValue,
            "user" : CKRecord.Reference(recordID: CKRecord.ID(recordName: "_6ca1cd867330130aadfa04d47746aff9"), action: .none)
        ])
        
        record3.setValuesForKeys([
            "birthDay" : birthDayPet3,
            "gender" : Pet.Gender.male.rawValue,
            "location": CLLocation(latitude: 16.0000778, longitude: -61.7333373),
            "name" : "Woofy",
            "photo" : CKAsset(fileURL: localeURL(forImageNamed: "Pet3")!),
            "race" : Pet.DogRace.german_shorthaired_pointer.rawValue,
            "type" : Pet.PetType.dog.rawValue,
            "user" : CKRecord.Reference(recordID: CKRecord.ID(recordName: "_6ca1cd867330130aadfa04d47746aff9"), action: .none)
        ])
        
        let accountStatus: CKAccountStatus = try await CKContainer.default().accountStatus()
        
        if accountStatus == .noAccount {
            throw ModelError.noAccount
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

private extension PetTest {
    func dateStringCreator(year: Int, month: Int, day: Int) -> Date {
        var component: DateComponents = DateComponents()
        component.calendar = .current
        component.year = year
        component.month = month
        component.day = day
        return component .date!
    }
    
    func localeURL(forImageNamed name: String) -> URL? {
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

