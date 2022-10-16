//
//  MyPetsData.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 21/09/2022.
//

import Foundation
import CoreData

class MyPetsData {
    let container = NSPersistentContainer(name: "MyPetModel")

    init() {
        container.loadPersistentStores {_, error in
            if let error { print(error.localizedDescription) }
        }
    }
}
