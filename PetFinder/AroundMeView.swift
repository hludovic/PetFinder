//
//  AroundMeView.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 20/09/2022.
//

import SwiftUI

struct AroundMeView: View {
    @EnvironmentObject var aroundMeData: AroundMeData
    
    var body: some View {
        NavigationView {
            PetCardListView()
                .navigationTitle("Around Me")
                .navigationBarTitleDisplayMode(.automatic)
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
                }
        }
        .refreshable {
            await aroundMeData.fetchMissingPetsAround()
        }
    }
}

struct AroundMeView_Previews: PreviewProvider {
    static var previews: some View {
            AroundMeView()
                .environmentObject(AroundMeData())
    }
}
