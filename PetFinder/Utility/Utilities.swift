//
//  Utilities.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 19/09/2022.
//

import Foundation

enum ModelError: Error {
    case noAccount
}

extension ModelError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noAccount:
            return "Sign in to iCloud"
        }
    }
    
}
