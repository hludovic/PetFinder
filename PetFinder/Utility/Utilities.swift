//
//  Utilities.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 19/09/2022.
//

import Foundation
import UIKit

//func getLocalURL(forImageNamed name: String) -> URL? {
//    let fileManager = FileManager.default
//    let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
//    let url = cacheDirectory.appendingPathComponent("\(name).jpg")
//    
//    guard fileManager.fileExists(atPath: url.path) else {
//        guard
//            let image = UIImage(named: name),
//            let data = image.jpegData(compressionQuality: 1.0)
//        else { return nil }
//        
//        fileManager.createFile(atPath: url.path, contents: data, attributes: nil)
//        return url
//    }
//    return url
//}


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
