//
//  Pet.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 19/09/2022.
//

import Foundation
import CloudKit

struct Pet: Identifiable {
    let id: String
    let owner: String
    let name: String
    let gender: String
    let type: String
    let race: String
    let dateLost: Date?
    let birthDay: Date
    let location: CLLocation
    
    func fetchPhoto() async -> URL? {
        var result2: CKAsset? = nil
        let database = CKContainer(identifier: "iCloud.fr.hludovic.container2").publicCloudDatabase
        let records: [CKRecord.ID : Result<CKRecord, Error>]
        do {
            records = try await database.records(for: [CKRecord.ID(recordName: id)], desiredKeys: ["photo"])
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
        guard let (_, result) = records.first else { return nil }
        if let data = try? result.get() {
            guard let photo = data["photo"] as? CKAsset else { return nil }
            result2 = photo
        }
        return result2?.fileURL
    }
}
    
extension Pet {
    enum Gender: String {
        case male = "Male"
        case female = "Female"
    }
    
    enum PetType: String {
        case dog = "Dog"
        case cat = "Cat"
    }

    enum DogRace: String, CaseIterable {
        case labrador = "Labrador"
        case french_bulldog = "French Bulldog"
        case golden_retrievers = "Golden Retriever"
        case serman_shepherd = "German Shepherd Dog"
        case poodle = "Poodle"
        case bulldog = "Bulldog"
        case beagle = "Beagle"
        case rottweiler = "Rottweiler"
        case german_shorthaired_pointer = "German Shorthaired Pointer"
        case dachshund = "Dachshund"
        case pembroke_welsh_corgi = "Pembroke Welsh Corgi"
        case australian_shepherd = "Australian Shepherds"
        case yorkshire_terriers = "Yorkshire Terriers"
        case boxer = "Boxer"
        case cavalier_king_charles_spaniel = "Cavalier King Charles Spaniel"
        case doberman_pinscher = "Doberman Pinscher"
        case great_dane = "Great Dane"
        case miniature_schnauzer = "Miniature Schnauzer"
        case siberian_huskie = "Siberian Huskie"
        case bernese_mountain_dog = "Bernese Mountain Dog"
        case cane_corso = "Cane Corso"
        case shih_tzu = "Shih Tzu"
        case boston_terrier = "Boston Terrier"
        case pomeranian = "Pomeranian"
        case havanese = "Havanese"
        case english_springer_spaniel = "English Springer Spaniel"
        case brittany = "Brittany"
        case shetland_sheepdog = "Shetland Sheepdog"
        case cocker_spaniel = "Cocker Spaniel"
        case miniature_american_shepherd = "Miniature American Shepherd"
        case border_collie = "Border Collie"
    }
}
