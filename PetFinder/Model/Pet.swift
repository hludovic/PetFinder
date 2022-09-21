//
//  Pet.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 19/09/2022.
//

import Foundation
import CloudKit


struct Pet: Identifiable {
    
    // MARK: - Public Properties
    
    let id: String
    let owner: User.ID
    let name: String
    let gender: Gender
    let type: PetType
    let race: Race
    var photo: Data {
        get async throws {
            return Data()
        }
    }
    
    let birthDay: Date
    let location: CLLocationCoordinate2D
    var isLost: Bool {
        get async throws {
            return false
        }
    }
    
    // MARK: - Public Methods
    
    /// Returns all Pets owned by the user.
    /// - Returns: An array of Pets.
    static func getUserPets() async throws -> [Pet] { return [] }
    
    /// Returns all missing animals located around a location.
    /// - Parameter location: The location that needs to be tested.
    /// - Returns: The list of missing Pets in the perimeter.
    static func getPetsAround(location: CLLocationCoordinate2D) async throws -> [Pet] { return [] }
    
    /// Removes one of the Pets saved in the application user pet list.
    /// - Parameter pet: The Pet.ID of the animal to be deleted.
    static func removePet(_ pet: Pet.ID) async throws { }
    
    /// This method gives the possibility to modify the information that defines the Pet.
    func editInfos(name: String?, gender: Gender?, type: PetType?, race: Race?, birthDay: Date?, location: CLLocationCoordinate2D?) async throws { }
    
    /// This method allows you to modify the photo of the Pet.
    func editPhoto(photo: Data) { }
    
}

struct PetTest {
    func test() async throws -> CKRecord {
        let container = CKContainer(identifier: "iCloud.fr.hludovic.container2")
        let database = container.publicCloudDatabase
        
        let record = CKRecord(recordType: "Pets")
        
        record.setValuesForKeys([
            "birthDay" : Date(),
            "gender" : "Male",
            "name" : "Woofy",
        ])
        
        let accountStatus: CKAccountStatus = try await CKContainer.default().accountStatus()
        
        if accountStatus == .noAccount {
            throw ModelError.noAccount
        } else {
            let savedRecord = try await database.save(record)
            return savedRecord
        }
    }
    
}



