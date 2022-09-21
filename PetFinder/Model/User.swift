//
//  User.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 19/09/2022.
//

import Foundation

let UDKeyAllowsNotifications: String = "allowsNotification"

/// La classe User définit les utilisateurs de l'application.
struct User: Identifiable {
    
    // MARK: - Public Properties
     
    let id: String
    let pseudonym: String
    // It not defines the user -> In the Settings
    var canRecivePhoto: Bool {
        get {
            return true
        }
    }
    
    var isBanned: Bool {
        get async throws {
            return false
        }
    }
    
    // It not defines the user -> In the Settings
    static var allowNotifications: Bool {
        get {
            let defaults = UserDefaults.standard
            return defaults.bool(forKey: UDKeyAllowsNotifications)
        }
        set {
            let defaults = UserDefaults.standard
            defaults.set(newValue, forKey: UDKeyAllowsNotifications)
        }
    }
    
    // MARK: - Public Methods
    
    /// Returns whether the pseudonym passed in parameter already exists.
    /// - Parameter pseudonym: The pseudonym to be tested.
    /// - Returns: Return true if the pseudp exists, or false if it does not exist.
    static func isAvailable(pseudonym: String) async throws -> Bool {
        return false
    }
    
    /// This method edits the application user's pseudonym.
    /// - Parameter pseudonym: the pseudonym that must be changed.
    static func updatePseudonym(pseudonym: String) async throws {
        
    }
}
