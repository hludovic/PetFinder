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
}

// - MARK: Enum the Pets gender
extension Pet {
    enum Gender: String {
        case male = "Male"
        case female = "Female"
    }
}

// - MARK: Enum the Pets Type
extension Pet {
    enum PetType: String {
        case dog = "Dog"
        case cat = "Cat"
    }
}

// - MARK: Enum the Dogs race
extension Pet {
    enum DogRace: Int, CaseIterable, Identifiable {
        case labrador, french_bulldog, golden_retrievers, serman_shepherd,
             poodle, bulldog, beagle, rottweiler, german_shorthaired_pointer,
             dachshund, pembroke_welsh_corgi, australian_shepherd, yorkshire_terriers,
             boxer, cavalier_king_charles_spaniel, doberman_pinscher, great_dane,
             miniature_schnauzer, siberian_huskie, bernese_mountain_dog,
             cane_corso, shih_tzu, boston_terrier, pomeranian, havanese,
             english_springer_spaniel, brittany, shetland_sheepdog,
             cocker_spaniel, miniature_american_shepherd, border_collie
        
        var id: Int { self.rawValue }
        
        var name: String {
            switch self {
            case .labrador: return "Labrador"
            case .french_bulldog: return "French Bulldog"
            case .golden_retrievers: return "Golden Retriever"
            case .serman_shepherd: return "German Shepherd Dog"
            case .poodle: return "Poodle"
            case .bulldog: return "Bulldog"
            case .beagle: return "Beagle"
            case .rottweiler: return "Rottweiler"
            case .german_shorthaired_pointer: return "German Shorthaired Pointer"
            case .dachshund: return "Dachshund"
            case .pembroke_welsh_corgi: return "Pembroke Welsh Corgi"
            case .australian_shepherd: return "Australian Shepherds"
            case .yorkshire_terriers: return "Yorkshire Terriers"
            case .boxer: return "Boxer"
            case .cavalier_king_charles_spaniel: return "Cavalier King Charles Spaniel"
            case .doberman_pinscher: return "Doberman Pinscher"
            case .great_dane: return "Great Dane"
            case .miniature_schnauzer: return "Miniature Schnauzer"
            case .siberian_huskie: return "Siberian Huskie"
            case .bernese_mountain_dog: return "Bernese Mountain Dog"
            case .cane_corso: return "Cane Corso"
            case .shih_tzu: return "Shih Tzu"
            case .boston_terrier: return "Boston Terrier"
            case .pomeranian: return "Pomeranian"
            case .havanese: return "Havanese"
            case .english_springer_spaniel: return "English Springer Spaniel"
            case .brittany: return "Brittany"
            case .shetland_sheepdog: return "Shetland Sheepdog"
            case .cocker_spaniel: return "Cocker Spaniel"
            case .miniature_american_shepherd: return "Miniature American Shepherd"
            case .border_collie: return "Border Collie"
            }
        }
    }
}
