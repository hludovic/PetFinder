//
//  AroundMeView.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 20/09/2022.
//

import SwiftUI

struct AroundMeView: View {
    @EnvironmentObject var viewModel: AroundMeData

    var body: some View {
        switch viewModel.authorizationStatus {
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
        AroundMeView()
            .environmentObject(previewData)
            .onAppear {
                previewData.authorizationStatus = .authorizedAlways
                previewData.location = PreviewMockedData.myLocation
                Task { await previewData.loadData() }
            }
    }
}
