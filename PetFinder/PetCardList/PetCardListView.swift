//
//  PetListView.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 21/09/2022.
//

import SwiftUI

struct PetCardListView: View {
    @EnvironmentObject var aroundMeData: AroundMeData
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        NavigationView {
            List {
                ForEach(aroundMeData.petsAround) { pet in
                    PetCardView(petData: PetData(pet: pet))
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.inset)
            .navigationTitle("Around Me")
            .toolbar {
                Picker(selection: $aroundMeData.range) {
                    ForEach(AroundMeData.Radius.allCases) { radius in
                        Label(radius.name, systemImage: "mappin.and.ellipse")
                            .tag(radius)
                    }
                } label: {
                    Label("Radius", systemImage: "mappin.and.ellipse")
                }
                .onAppear{
                    Task {
                        await aroundMeData.loadData(from: locationManager.location)
                    }
                }
            }
            .alert(aroundMeData.alertMessage ?? "Error", isPresented: $aroundMeData.alert) {
                Button("OK") {
                    aroundMeData.resetAlertMessage()
                }
            }
        }
        .onChange(of: aroundMeData.range) { newValue in
            Task {
                await aroundMeData.loadData(from: locationManager.location)
            }
        }
        .refreshable {
            await aroundMeData.loadData(from: locationManager.location)
        }
    }
}

struct PetListView_Previews: PreviewProvider {
    static var previews: some View {
        let previewData = AroundMeData()
        let locationManager = LocationManager()
        PetCardListView()
            .environmentObject(previewData)
            .environmentObject(locationManager)
            .onAppear{
                locationManager.location = PreviewMockedData.myLocation
            }
    }
}
