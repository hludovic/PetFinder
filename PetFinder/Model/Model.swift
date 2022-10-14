//
//  Model.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 27/09/2022.
//

import Foundation
import CloudKit

class Model {
    static let container = CKContainer(identifier: "iCloud.fr.hludovic.container2")
    static let database = container.publicCloudDatabase
    
//    static var CKUserRecordID: CKRecord.ID {
//        get async throws {
//            try await container.userRecordID()
//        }
//    }
    
    
    static func CKAccountStatus() async -> (Bool, String) {
        let accountStatus: CKAccountStatus
        do {
            accountStatus = try await container.accountStatus()
        } catch let error {
            print(error.localizedDescription)
            return (false, "")
        }
        switch accountStatus {
        case .couldNotDetermine:
            return (false, "")
        case .available:
            return (true, "")
        case .restricted:
            return (false, "")
        case .noAccount:
            return (false, "")
        case .temporarilyUnavailable:
            return (false, "")
        @unknown default:
            return (false, "")
        }
    }
}

enum ModelError: Error {
    case noAccount
    case typeCasting
}

extension ModelError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noAccount:
            return "You are not Sign in to your iCloud account"
        case .typeCasting:
            return "Unable to cast the type of the data fetched"
        }
    }
    
}
