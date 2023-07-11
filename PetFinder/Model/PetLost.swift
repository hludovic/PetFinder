//
//  PetLost.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 11/07/2023.
//

import Foundation
import CoreLocation

struct PetLost: Identifiable {
    let id: String
    let owner: String
    let name: String
    let gender: String
    let type: String
    let breed: String
    let dateLost: Date
    let birthDay: Date
    let location: CLLocation
}
