//
//  ImagePicker.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 25/10/2022.
//

import SwiftUI
import PhotosUI

@MainActor
class ImagePicker: ObservableObject {
    @Published var image: Image?
    @Published var imageSelection: PhotosPickerItem? {
        didSet {
            if let imageSelection {
                Task {
                    try await loadTransferable(from: imageSelection)
                }
            }
        }
    }

    func getFilter() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
    }

    func loadTransferable(from imageSelection: PhotosPickerItem?) async throws {
        do {
            if let data = try await imageSelection?.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    self.image = Image(uiImage: uiImage)
                }
            }
        } catch {
            print(error.localizedDescription)
            image = nil
        }
    }
}
