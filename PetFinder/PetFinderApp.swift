//
//  PetFinderApp.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 18/09/2022.
//

import SwiftUI

@main
struct PetFinderApp: App {
    @StateObject var aroundMeViewModel = AroundMeViewModel()

    var body: some Scene {
        WindowGroup {
            WelcomeView()
                .environmentObject(aroundMeViewModel)
        }
    }
}
