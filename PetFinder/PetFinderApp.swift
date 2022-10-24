//
//  PetFinderApp.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 18/09/2022.
//

import SwiftUI

@main
struct PetFinderApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @StateObject var aroundMeData = AroundMeData()
    @StateObject var myPetsData = MyPetsData()

    var body: some Scene {
        WindowGroup {
            WelcomeView()
                .environmentObject(myPetsData)
                .environmentObject(aroundMeData)
                .environment(\.managedObjectContext, myPetsData.container.viewContext)
                .onChange(of: scenePhase) { newLocation in
                    if newLocation == .active { aroundMeData.startUpdatingMyLocation() }
                }
        }
    }
}
