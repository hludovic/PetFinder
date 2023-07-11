//
//  Errors.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 11/07/2023.
//

import Foundation


enum NetworkError: Error {
    case noAccount
    case typeCasting
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noAccount:
            return "You are not Sign in to your iCloud account"
        case .typeCasting:
            return "Unable to cast the type of the data fetched"
        }
    }
}
