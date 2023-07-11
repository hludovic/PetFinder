//
//  Constants.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 11/07/2023.
//

import Foundation

extension PetLost {
    // - MARK: Enum the Pets gender
    enum Gender: String {
        case male = "Male"
        case female = "Female"
    }
}

extension PetLost {
    // - MARK: Enum the Pets Type
    enum PetType: String {
        case dog = "Dog"
        case cat = "Cat"
    }
}

extension PetLost {
    // - MARK: Enum popular dog breeds
    enum DogBreed: Int, Breed {
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

extension PetLost {
    // - MARK: Enum popular cat breeds
    enum CatBreed: Int, Breed {
        case miaou, wiiou

        var id: Int { self.rawValue }

        var name: String {
            switch self {
            case .miaou: return "Miaou"
            case .wiiou: return "Wiiou Bulldog"
            }
        }
    }
}

// MARK: - The Radius
extension NetworkManager {
    enum Radius: Int, CaseIterable, Identifiable {
        case r5km, r10km, r50km

        var id: Int { self.rawValue }

        var name: String {
            switch self {
            case .r5km: return "Radius 5 km"
            case .r10km: return "Radius 10 km"
            case .r50km: return "Radius 50 km"
            }
        }

        var value: CGFloat {
            switch self {
            case .r5km: return 5000
            case .r10km: return 10000
            case .r50km: return 50000
            }
        }
    }
}
