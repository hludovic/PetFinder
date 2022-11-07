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
    private let taskID = UUID()
    @Published var isRedacted: Bool = true
    @Published var alert: Bool = false
    @Published private(set) var petName: String = "petName"
    @Published private(set) var dateLost: String
    @Published private(set) var imageURL: URL?
    @Published private(set) var alertMessage: String?
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: PetData.self))
    private var pet: PetLost

    init(pet: PetLost) {
        dateLost = "Lost the wednesday, March 9 2002 at 12:00 AM"
        self.pet = pet
    }

    func loadData() async {
        await loadphotoURL()
        await MainActor.run {
            petName = pet.name
            loadDateLostString()
            isRedacted = false
        }
    }
}

extension PetData {
    @MainActor private func loadDateLostString() {
        let dateFormater = DateFormatter()
        dateFormater.dateStyle = .full
        dateFormater.timeStyle = .short
        dateLost = "Lost the \(dateFormater.string(from: pet.dateLost))"
    }

    private func loadphotoURL() async {
        logger.info("Started loadphotoURL - Task \(self.taskID)")
        let records: [CKRecord.ID: Result<CKRecord, Error>]
        do {
            records = try await Model.database.records(for: [CKRecord.ID(recordName: pet.id)], desiredKeys: ["photo"])
        } catch let error {
            return logger.error("\(error.localizedDescription) - Task \(self.taskID)")
        }
        guard let (_, result) = records.first else {
            logger.error("Error loadphotoURL. The pet don't have photo - Task \(self.taskID)")
            return await displayError(message: "Unable to load the pet data")
        }
        if let data = try? result.get() {
            guard let photo = data["photo"] as? CKAsset else {
                logger.error("Error loadphotoURL - Task \(self.taskID)")
                return await displayError(message: "Unable to load the pet data")
            }
            await MainActor.run {
                logger.info("Finished loadphotoURL - Task \(self.taskID)")
                imageURL = photo.fileURL
            }
        }
    }

    @MainActor private func displayError(message: String) {
        alert = true
        alertMessage = message
    }
}
