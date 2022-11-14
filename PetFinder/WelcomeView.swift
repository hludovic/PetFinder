//
//  WelcomeView.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 18/09/2022.
//

import SwiftUI

struct WelcomeView: View {
    @AppStorage("WelcomeViewCurrentTab") var selectedTab = 0
    @EnvironmentObject var aroundMeVM: AroundMeVM

    var body: some View {
        TabView(selection: $selectedTab) {
            AroundMeView()
                .tabItem { Label("Around", systemImage: "location.magnifyingglass") }
                .badge(aroundMeVM.petsAround.count)
                .tag(0)
            MyPetsView()
                .tabItem { Label("My Pets", systemImage: "pawprint") }
                .tag(1)
            SettingsView()
                .tabItem { Label("Settings", systemImage: "slider.horizontal.3") }
                .tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let previewData = AroundMeVM()
    static let model = Model(inMemory: true)
    static var previews: some View {
        WelcomeView()
            .environment(\.managedObjectContext, model.localContainer.viewContext)
            .environmentObject(previewData)
            .onAppear {
                previewData.authorizationStatus = .authorizedWhenInUse
                previewData.location = PreviewMockedData.myLocation
                Task { await previewData.loadData() }
            }
    }
}
