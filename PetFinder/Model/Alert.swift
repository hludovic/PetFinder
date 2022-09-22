//
//  Alert.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 20/09/2022.
//

import Foundation

struct Alert: Identifiable {
    let id: String
    let petLost: Pet.ID
    let dateAlert: Date
    let dateLost: Date
}
