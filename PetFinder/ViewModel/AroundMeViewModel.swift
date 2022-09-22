//
//  AroundMeViewModel.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 21/09/2022.
//

import SwiftUI
import CloudKit

class AroundMeViewModel: ObservableObject {
    
    @Published
    var petsAround: [Pet] = []
    
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
    func editInfos(name: String?, gender: Pet.Gender?, type: Pet.PetType?, race: Pet.DogRace?, birthDay: Date?, location: CLLocationCoordinate2D?) async throws { }
    
    /// This method allows you to modify the photo of the Pet.
    func editPhoto(photo: Data) { }
    
    
    
    static func sendAlert(for petID: Pet.ID ) async throws { }
    
    static func stopSignalment(for petID: Pet.ID) async throws { }


}
