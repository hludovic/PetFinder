//
//  ContentView.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 18/09/2022.
//

import SwiftUI

struct WelcomeView: View {
    @AppStorage("WelcomeViewCurrentTab") var selectedTab = 0
    @EnvironmentObject var data: AroundMeData
    
    var body: some View {
        TabView(selection: $selectedTab) {
            AroundMeView()
                .tabItem { Label("Around", systemImage: "location.magnifyingglass") }
                .badge(data.petsAround.count)
                .tag(0)
            MyPetsView()
                .tabItem { Label("My Pets", systemImage: "pawprint") }
                .tag(1)
            SettingsView()
                .tabItem { Label("Settings", systemImage: "person") }
                .tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
            .environmentObject(AroundMeData())
    }
}
