//
//  PetLost.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 19/09/2022.
//

import Foundation
import CloudKit

struct PetLost: Identifiable {
    let id: String
    let owner: String
    let name: String
    let gender: String
    let type: String
    let race: String
    // TODO: Remove Date to Optional
    let dateLost: Date?
    let birthDay: Date
    let location: CLLocation
}

// - MARK: Enum the Pets gender
extension PetLost {
    enum Gender: String {
        case male = "Male"
        case female = "Female"
    }
}

// - MARK: Enum the Pets Type
extension PetLost {
    enum PetType: String {
        case dog = "Dog"
        case cat = "Cat"
    }
}

// - MARK: Enum the Dogs race
extension PetLost {
    enum DogRace: Int, CaseIterable, Identifiable {
        case labrador, frenchBulldog, goldenRetrievers, sermanShepherd,
             poodle, bulldog, beagle, rottweiler, germanShorthairedPointer,
             dachshund, pembrokeWelshCorgi, australianShepherd, yorkshireTerriers,
             boxer, cavalierKingCharlesSpaniel, dobermanPinscher, greatDane,
             miniatureSchnauzer, siberianHuskie, berneseMountainDog,
             caneCorso, shihTzu, bostonTerrier, pomeranian, havanese,
             englishSpringerSpaniel, brittany, shetlandSheepdog,
             cockerSpaniel, miniatureAmericanShepherd, borderCollie

        var id: Int { self.rawValue }

        var name: String {
            switch self {
            case .labrador: return "Labrador"
            case .frenchBulldog: return "French Bulldog"
            case .goldenRetrievers: return "Golden Retriever"
            case .sermanShepherd: return "German Shepherd Dog"
            case .poodle: return "Poodle"
            case .bulldog: return "Bulldog"
            case .beagle: return "Beagle"
            case .rottweiler: return "Rottweiler"
            case .germanShorthairedPointer: return "German Shorthaired Pointer"
            case .dachshund: return "Dachshund"
            case .pembrokeWelshCorgi: return "Pembroke Welsh Corgi"
            case .australianShepherd: return "Australian Shepherds"
            case .yorkshireTerriers: return "Yorkshire Terriers"
            case .boxer: return "Boxer"
            case .cavalierKingCharlesSpaniel: return "Cavalier King Charles Spaniel"
            case .dobermanPinscher: return "Doberman Pinscher"
            case .greatDane: return "Great Dane"
            case .miniatureSchnauzer: return "Miniature Schnauzer"
            case .siberianHuskie: return "Siberian Huskie"
            case .berneseMountainDog: return "Bernese Mountain Dog"
            case .caneCorso: return "Cane Corso"
            case .shihTzu: return "Shih Tzu"
            case .bostonTerrier: return "Boston Terrier"
            case .pomeranian: return "Pomeranian"
            case .havanese: return "Havanese"
            case .englishSpringerSpaniel: return "English Springer Spaniel"
            case .brittany: return "Brittany"
            case .shetlandSheepdog: return "Shetland Sheepdog"
            case .cockerSpaniel: return "Cocker Spaniel"
            case .miniatureAmericanShepherd: return "Miniature American Shepherd"
            case .borderCollie: return "Border Collie"
            }
        }
    }
}
