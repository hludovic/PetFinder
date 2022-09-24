//
//  AroundMeViewModel.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 21/09/2022.
//

import SwiftUI
import CloudKit

class AroundMeViewModel: ObservableObject {
    @Published var petsAround: [Pet] = []
        
    func fetchMissingPetsAround() async throws -> [Pet] {
        return []
    }
    
    func fetchMissingDate(of pet: Pet.ID) async throws -> Date {
        return Date()
    }
}

private extension AroundMeViewModel {
    func getMyLocation() async throws -> CLLocation {
        CLLocation(latitude: 16.25503540039062, longitude: -61.653686524178916)
    }
    
    func fetchPetsAround(location: CLLocation) async throws -> [Pet] {
        return []
    }

}
