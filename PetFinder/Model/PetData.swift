//
//  PetData.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 26/09/2022.
//

import Foundation
import CloudKit
import os

class PetData: ObservableObject {
    @Published var isRedacted: Bool = true
    @Published var petName: String = "petName"
    @Published var dateLost: String
    @Published var imageURL: URL? = nil
    @Published var alert: Bool = false
    @Published var alertMessage: String? = nil
    public static let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: PetData.self))
    private var pet: Pet
    
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
            Self.logger.warning("Fail loading a pet data: his dateLost value is nil")
            return displayError(message: "Unable to load the pet data")
        }
        let dateFormater = DateFormatter()
        dateFormater.dateStyle = .full
        dateFormater.timeStyle = .short
        dateLost = "Lost the \(dateFormater.string(from: date))"
    }
    
    private func loadphotoURL() async {
        Self.logger.trace("Start fetching a pet Photo")
        let records: [CKRecord.ID : Result<CKRecord, Error>]
        do {
            records = try await Model.database.records(for: [CKRecord.ID(recordName: pet.id)], desiredKeys: ["photo"])
        } catch let error {
            return Self.logger.warning("\(error.localizedDescription)")
            
        }
        guard let (_, result) = records.first else {
            Self.logger.warning("Fetching photo error. The pet don't have photo")
            return await displayError(message: "Unable to load the pet data")
        }
        if let data = try? result.get() {
            guard let photo = data["photo"] as? CKAsset else {
                return await displayError(message: "Unable to load the pet data")
            }
            await MainActor.run{
                Self.logger.trace("End fetching a pet Photo")
                imageURL = photo.fileURL
            }
        }
    }
    
    @MainActor private func displayError(message: String) {
        alert = true
        alertMessage = message
    }
}
