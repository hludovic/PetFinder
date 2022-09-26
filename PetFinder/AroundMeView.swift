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
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                            .resizable()
                            .foregroundColor(.accentColor)
                            .offset(x: 22)
                            .frame(width: 14, height: 14, alignment: .center)
                        Picker(selection: $aroundMeData.range) {
                            Text("1km").tag(AroundMeData.Range.r1km)
                            Text("5km").tag(AroundMeData.Range.r5km)
                            Text("10km").tag(AroundMeData.Range.r10km)
                            Text("50km").tag(AroundMeData.Range.r50km)
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
