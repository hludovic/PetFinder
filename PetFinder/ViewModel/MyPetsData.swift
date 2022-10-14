//
//  MyPetsData.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 21/09/2022.
//

import Foundation
import CoreData

class MyPetsData {
    
    let container = NSPersistentContainer(name: "MyPetModel")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error { print(error.localizedDescription) }
        }
    }
    
//    static func getUserPets() async throws -> [Pet] { return [] }
//
//    static func removePet(_ pet: Pet.ID) async throws { }
//
//    func editInfos(name: String?, gender: Pet.Gender?, type: Pet.PetType?, race: Pet.DogRace?, birthDay: Date?, location: CLLocation?) async throws { }
//
//    func editPhoto(photo: Data) { }
//
//    static func sendAlert(for petID: Pet.ID ) async throws { }
//
//    static func stopSignalment(for petID: Pet.ID) async throws { }

}