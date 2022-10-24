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
        container = NSPersistentContainer(name: "MyPetModel")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(filePath: "/dev/null")
        }
        container.loadPersistentStores {_, error in
            if let error { print(error.localizedDescription) }
        }
    }

    func savePet(pet: PetOwned) {
        let myPet = MyPet(context: container.viewContext)
        myPet.birthDay = pet.birthDay
        myPet.breed = pet.breed
        myPet.gender =  pet.gender
        myPet.id = pet.id
        myPet.name = pet.name
        myPet.type = pet.type
        try? container.viewContext.save()
    }
}
