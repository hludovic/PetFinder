//
//  PetOwned.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 16/10/2022.
//

import Foundation

struct PetOwned: Identifiable {
    var id: UUID
    let name: String
    let gender: String
    let type: String
    let race: String
    let birthDay: Date
}
