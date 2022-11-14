//
//  EditPetVM.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 09/11/2022.
//

import SwiftUI
import PhotosUI
import CoreData

class EditPetVM: ObservableObject {
    var canSave: Bool {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MM-dd-yyyy"
        let dateSaved = dateFormater.string(from: date)
        let dateNow = dateFormater.string(from: Date())
        guard
            name != "",
            dateSaved != dateNow,
            breed != ""
        else {
            return false
        }
        return true
    }
    @Published var name: String = ""
    @Published var date: Date = Date()
    @Published var gender: PetLost.Gender = .female
    @Published var petType: PetLost.PetType = .dog
    @Published var breed: String = ""
    @Published var image: Image?
    @Published var imageSelection: PhotosPickerItem? {
        didSet {
            if let imageSelection {
                Task { try await loadTransferable(from: imageSelection) }
            }
        }
    }

    func getFilter() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
    }

    func loadTransferable(from imageSelection: PhotosPickerItem?) async throws {
        do {
            if let data = try await imageSelection?.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    await MainActor.run {
                        self.image = Image(uiImage: uiImage)
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
            image = nil
        }
    }

    func savePet(context: NSManagedObjectContext) {
        let myPet = MyPet(context: context)
        guard canSave else { return print("ERROR") }
        myPet.id = UUID()
        myPet.gender = gender.rawValue
        myPet.name = name
        myPet.breed = breed
        myPet.birthDay = date
        myPet.type = petType.rawValue
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }

    }

}
