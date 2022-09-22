//
//  Message.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 20/09/2022.
//

import Foundation
import CloudKit

struct Message {
    let alert: Alert.ID
    let author: User.ID
    var isDeleted: Bool {
        get async throws { return true }
    }
    let dateMessage: Date
    let dateSeen: Date
    let message: String
    let location: CLLocation
    var photo: Data {
        get async throws { return Data() }
    }
}
