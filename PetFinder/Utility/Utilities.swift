//
//  Utilities.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 19/09/2022.
//

import Foundation
import UIKit

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
