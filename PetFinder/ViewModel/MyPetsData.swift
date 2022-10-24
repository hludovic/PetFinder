//
//  MyPetsData.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 21/09/2022.
//

import Foundation
import CoreData

class MyPetsData {
    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "MyPetModel")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(filePath: "/dev/null")
        }
        container.loadPersistentStores {_, error in
            if let error { print(error.localizedDescription) }
        }
    }
}
