//
//  Message.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 20/09/2022.
//

import Foundation
import CloudKit

struct Message {
    var isDeleted: Bool {
        get async throws { return true }
    }
    
    let dateMessage: Date
    let dateSeen: Date
    let message: String
    let location: CLLocationCoordinate2D
    var photo: Data {
        get async throws { return Data() }
    }
    
    let tuple = (nom: "Swift", age: 11, vivant: true)
    
    func getInterlocutor() async throws -> User.ID { return "" }
    
    static func getMessages(from userId: User.ID, about alertId: Alert.ID) async throws -> [Message] { return [] }
    
    static func deleteMessage(from userId: User.ID, about alertId: Alert.ID) async throws { }
}
