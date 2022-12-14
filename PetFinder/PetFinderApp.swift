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
    @StateObject var aroundMeData = AroundMeVM()
    @StateObject var model = Model()

    var body: some Scene {
        WindowGroup {
            WelcomeView()
                .environmentObject(aroundMeData)
                .environment(\.managedObjectContext, model.localContainer.viewContext)
                .onChange(of: scenePhase) { newLocation in
                    if newLocation == .active { aroundMeData.startUpdatingMyLocation() }
                }
        }
    }
}
