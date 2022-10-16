//
//  PetListView.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 21/09/2022.
//

import SwiftUI

struct PetCardListView: View {
    @EnvironmentObject var aroundMeData: AroundMeData

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
            }
            .alert(aroundMeData.alertMessage ?? "Error", isPresented: $aroundMeData.alert) {
                Button("OK") {
                    aroundMeData.resetAlertMessage()
                }
            }
        }
        .refreshable {
            await aroundMeData.loadData()
        }
    }
}

struct PetListView_Previews: PreviewProvider {
    static var previews: some View {
        let previewData = AroundMeData()
        PetCardListView()
            .environmentObject(previewData)
            .onAppear {
                previewData.location = PreviewMockedData.myLocation
                Task { await previewData.loadData() }
            }
    }
}
