//
//  MyPetsData.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 21/09/2022.
//

import Foundation
import CoreData

class MyPetsData: ObservableObject {
    let container: NSPersistentContainer
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "PetFinder")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(filePath: "/dev/null")
        }
        container.loadPersistentStores {_, error in
            if let error { print(error.localizedDescription) }
        }
    }

    func deletePet(pet: MyPet) {
        container.viewContext.delete(pet)
        try? container.viewContext.save()
    }

    func savePet(pet: MyPet) {
        guard
            pet.id != nil,
            pet.name != nil,
            pet.breed != nil,
            pet.birthDay != nil,
            pet.type != nil,
            pet.gender != nil
        else {
            print("error")
            return
        }
        try? container.viewContext.save()
    }
}
