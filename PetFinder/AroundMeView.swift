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
            RequestLocationView()
        case .restricted:
            ErrorView(errorText: "Location use is restricted.")
        case .denied:
            ErrorView(errorText: "The app does not have location permissions. Please enable them in settings.")
        case .authorizedAlways, .authorizedWhenInUse:
            PetCardListView()
        default:
            Text("Unexpected status")
        }
    }
}

struct RequestLocationView: View {
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        VStack {
            Button(action: {
                locationManager.requestAuthorization()
            }, label: {
                Label("Allow tracking", systemImage: "location")
            })
            .padding(10)
            .foregroundColor(.white)
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            Text("We need your permission to track your location.")
                .foregroundColor(.gray)
                .font(.caption)
        }
    }
}


struct ErrorView: View {
    var errorText: String
    
    var body: some View {
        VStack {
            Image(systemName: "xmark.octagon")
                    .resizable()
                .frame(width: 100, height: 100, alignment: .center)
            Text(errorText)
        }
        .padding()
        .foregroundColor(.white)
        .background(Color.red)
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

//struct RequestLocationView_Previews: PreviewProvider {
//    static var previews: some View {
//        RequestLocationView()
//    }
//}
//
//struct ErrorView_Previews: PreviewProvider {
//    static var previews: some View {
//        ErrorView(errorText: "We need your permission to track your location")
//    }
//}
