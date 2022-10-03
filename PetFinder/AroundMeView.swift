//
//  AroundMeView.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 20/09/2022.
//

import SwiftUI

struct AroundMeView: View {
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            CLAuthorizationView()
        case .restricted:
            CLErrorView(errorText: "Location use is restricted.")
        case .denied:
            CLErrorView(errorText: "The app does not have location permissions. Please enable them in settings.")
        case .authorizedAlways, .authorizedWhenInUse:
            PetCardListView()
        default:
            Text("Unexpected status")
        }
    }
}

struct AroundMeView_Previews: PreviewProvider {
    static var previews: some View {
        let previewData = AroundMeData()
        let locationManager = LocationManager()
        AroundMeView()
            .environmentObject(previewData)
            .environmentObject(locationManager)
            .onAppear{
                locationManager.authorizationStatus = .authorizedWhenInUse
                locationManager.location = PreviewMockedData.myLocation
            }
    }
}
