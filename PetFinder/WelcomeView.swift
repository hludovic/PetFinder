//
//  WelcomeView.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 18/09/2022.
//

import SwiftUI

struct WelcomeView: View {
    @AppStorage("WelcomeViewCurrentTab") var selectedTab = 0
    @EnvironmentObject var aroundMeData: AroundMeData
    
    var body: some View {
        TabView(selection: $selectedTab) {
            AroundMeView()
                .tabItem { Label("Around", systemImage: "location.magnifyingglass") }
                .badge(aroundMeData.petsAround.count)
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
    static var previews: some View {
        let previewData = AroundMeData()
        let locationManager = LocationManager()
        WelcomeView()
            .environmentObject(previewData)
            .environmentObject(locationManager)
            .onAppear{
                locationManager.authorizationStatus = .authorizedWhenInUse
                locationManager.location = PreviewMockedData.myLocation
            }
    }
}
