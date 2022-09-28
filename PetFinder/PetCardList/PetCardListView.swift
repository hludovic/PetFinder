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
                    Label("Radius 1 km", systemImage: "mappin.and.ellipse")
                        .tag(AroundMeData.Range.r1km)
                    Label("Radius 5 km", systemImage: "mappin.and.ellipse")
                        .tag(AroundMeData.Range.r5km)
                    Label("Radius 10 km", systemImage: "mappin.and.ellipse")
                        .tag(AroundMeData.Range.r10km)
                    Label("Radius 50 km", systemImage: "mappin.and.ellipse")
                        .tag(AroundMeData.Range.r50km)
                } label: {
                    Label("Range", systemImage: "mappin.and.ellipse")
                }
                .onReceive(aroundMeData.$range) { _ in
                    Task {
                        await aroundMeData.fetchMissingPetsAround()
                    }
                }
                .onAppear{
                    aroundMeData.loadData()
                }
            }

        }
        .refreshable {
            aroundMeData.loadData()
        }
    }
}

struct PetListView_Previews: PreviewProvider {
    static var previews: some View {
        let previewData = AroundMeData()
        PetCardListView()
            .environmentObject(previewData)
            .onAppear{
                previewData.location = PreviewMockedData.myLocation
                Task {
                    await previewData.fetchMissingPetsAround()
                }
            }
    }
}
