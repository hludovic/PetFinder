//
//  PetFinderApp.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 18/09/2022.
//

import SwiftUI

@main
struct PetFinderApp: App {
    @StateObject var aroundMeData = AroundMeData()
    @StateObject var locationManager = LocationManager()

    var body: some Scene {
        WindowGroup {
            WelcomeView()
                .environmentObject(aroundMeData)
                .environmentObject(locationManager)
        }
    }
}
