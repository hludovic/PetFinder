//
//  Breed.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 11/07/2023.
//

import Foundation

protocol Breed: CaseIterable, Identifiable {
    var id: Int { get }
    var name: String { get }
}
