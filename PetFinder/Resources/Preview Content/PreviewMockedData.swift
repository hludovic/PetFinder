//
//  PreviewMockedData.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 20/09/2022.
//

import Foundation
import CloudKit
import SwiftUI
import CoreLocation
import CoreData

struct PreviewMockedData {


    private static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PetFinder")
        container.persistentStoreDescriptions.first?.url = URL(filePath: "/dev/null")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()

     static var context: NSManagedObjectContext {
         return Self.persistentContainer.viewContext
     }




    static func fakeMyPet() -> MyPet {
        print("🖐 Start newPet")
        let pet = MyPet(context: context)
        pet.breed = "Cavalier King Charles Spaniel"
        pet.name = "Felix"
        pet.birthDay = Date()
        pet.gender = "Male"
        pet.id = UUID()
        pet.type = "Dog"
        return pet
    }

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
            "birthDay": dateCreator(year: 2020, month: 1, day: 4),
            "dateLost": dateCreator(year: 2022, month: 3, day: 9),
            "gender": PetLost.Gender.male.rawValue,
            "location": CLLocation(latitude: 16.261587307523747, longitude: -61.62137873321357),
            "name": "Felix",
            "photo": CKAsset(fileURL: localeURL(forImageNamed: "Pet1")!),
            "breed": PetLost.DogBreed.englishSpringerSpaniel.name,
            "type": PetLost.PetType.cat.rawValue,
            "user": CKRecord.Reference(recordID: CKRecord.ID(recordName: "_6ca1cd867330130aadfa04d47746aff9"), action: .none)
        ])

        record2.setValuesForKeys([
            "birthDay": dateCreator(year: 2021, month: 7, day: 12),
            "dateLost": dateCreator(year: 2022, month: 2, day: 10),
            "gender": PetLost.Gender.female.rawValue,
            "location": CLLocation(latitude: 16.04076861022844, longitude: -61.60101545693777),
            "name": "Martin",
            "photo": CKAsset(fileURL: localeURL(forImageNamed: "Pet2")!),
            "breed": PetLost.DogBreed.borderCollie.name,
            "type": PetLost.PetType.dog.rawValue,
            "user": CKRecord.Reference(recordID: CKRecord.ID(recordName: "_6ca1cd867330130aadfa04d47746aff9"), action: .none)
        ])

        record3.setValuesForKeys([
            "birthDay": dateCreator(year: 2022, month: 5, day: 23),
            "dateLost": dateCreator(year: 2022, month: 1, day: 4),
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

    static func getFakePets() -> [PetLost] {
        let pets = [
            PetLost(id: "001",
                    owner: "AAA",
                    name: "Felix",
                    gender: PetLost.Gender.male.rawValue,
                    type: PetLost.PetType.cat.rawValue,
                    breed: PetLost.DogBreed.englishSpringerSpaniel.name,
                    dateLost: dateCreator(year: 2022, month: 3, day: 9),
                    birthDay: dateCreator(year: 2020, month: 1, day: 4),
                    location: CLLocation(latitude: 16.261587307523747, longitude: -61.62137873321357)
                   ),
            PetLost(id: "002",
                    owner: "BBB",
                    name: "Martin",
                    gender: PetLost.Gender.female.rawValue,
                    type: PetLost.PetType.dog.rawValue,
                    breed: PetLost.DogBreed.borderCollie.name,
                    dateLost: dateCreator(year: 2022, month: 2, day: 10),
                    birthDay: dateCreator(year: 2021, month: 7, day: 12),
                    location: CLLocation(latitude: 16.04076861022844, longitude: -61.60101545693777)
                   ),
            PetLost(id: "003",
                    owner: "CCC",
                    name: "Woofy",
                    gender: PetLost.Gender.male.rawValue,
                    type: PetLost.PetType.dog.rawValue,
                    breed: PetLost.DogBreed.germanShorthairedPointer.name,
                    dateLost: dateCreator(year: 2022, month: 1, day: 4),
                    birthDay: dateCreator(year: 2022, month: 5, day: 23),
                    location: CLLocation(latitude: 16.258563662672728, longitude: -61.272922369971425)
                   )
        ]
        return pets
    }

    func fetchMyPets() async throws -> [PetLost] {
        var data: [PetLost] = []
        let container = CKContainer(identifier: "iCloud.fr.hludovic.container2")
        let privateDB = container.publicCloudDatabase
        let myId = try await container.userRecordID()
        let predicate = NSPredicate(format: "___createdBy == %@", CKRecord.Reference(recordID: myId, action: .none))
        let query = CKQuery(recordType: "Pets", predicate: predicate)
        let (values, _) = try await privateDB.records(
            matching: query, desiredKeys: ["user", "name", "gender", "type", "breed", "birthDay", "location"],
            resultsLimit: 100
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
                data.append(newPet)
            }
        }
        return data
    }
}

private extension PreviewMockedData {
    static func dateCreator(year: Int, month: Int, day: Int) -> Date {
        var component: DateComponents = DateComponents()
        component.calendar = .current
        component.year = year
        component.month = month
        component.day = day
        return component .date!
    }

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
