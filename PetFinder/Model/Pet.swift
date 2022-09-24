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
    var photo: Data {
        get async throws {
            return Data()
        }
    }
    let birthDay: Date
    let location: CLLocation
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
