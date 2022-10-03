//
//  PetData.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 26/09/2022.
//

import Foundation
import CloudKit

class PetData: ObservableObject {
    @Published var isRedacted: Bool = true
    @Published var petName: String = "petName"
    @Published var dateLost: String
    @Published var imageURL: URL? = nil
    @Published var alert: Bool = false
    @Published var alertMessage: String? = nil
    var pet: Pet
    
    init(pet: Pet) {
        dateLost = "Lost the wednesday, March 9 2002 at 12:00 AM"
        self.pet = pet
    }
    
    func loadData() async {
        await loadphotoURL()
        await MainActor.run{
            petName = pet.name
            loadDateLostString()
            isRedacted = false
        }
    }
}

extension PetData {
    @MainActor private func loadDateLostString() {
        guard let date = pet.dateLost  else {
            return displayError(message: "Unable to load the pet data", error: nil)
        }
        let dateFormater = DateFormatter()
        dateFormater.dateStyle = .full
        dateFormater.timeStyle = .short
        dateLost = "Lost the \(dateFormater.string(from: date))"
    }
    
    private func loadphotoURL() async {
        let records: [CKRecord.ID : Result<CKRecord, Error>]
        do {
            records = try await Model.database.records(for: [CKRecord.ID(recordName: pet.id)], desiredKeys: ["photo"])
        } catch let error {
            return await displayError(message: "Unable to load the pet data", error: error)
        }
        guard let (_, result) = records.first else {
            return await displayError(message: "Unable to load the pet data", error: nil)
        }
        if let data = try? result.get() {
            guard let photo = data["photo"] as? CKAsset else {
                return await displayError(message: "Unable to load the pet data", error: nil)
            }
            await MainActor.run{
                imageURL = photo.fileURL
            }
        }
    }
    
    @MainActor private func displayError(message: String, error: Error?) {
        alert = true
        alertMessage = message
        if let error = error {
            print(error.localizedDescription)
        } else {
            print("ERROR \(message)")
        }
    }
}
