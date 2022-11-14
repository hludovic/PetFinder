//
//  PetListView.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 21/09/2022.
//

import SwiftUI

struct PetCardListView: View {
    @EnvironmentObject var aroundMeVM: AroundMeVM

    var body: some View {
        NavigationView {
            Group {
                if aroundMeVM.petsAround.isEmpty {
                    EmptyCardsView()
                        .listStyle(.inset)
                } else {
                    List {
                        ForEach(aroundMeVM.petsAround) { pet in
                            PetCardView(pet: pet)
                        }
                        .listRowSeparator(.hidden)
                    }
                }
            }
            .listStyle(.inset)
            .navigationTitle("Around Me")
            .toolbar {
                Picker(selection: $aroundMeVM.range) {
                    ForEach(AroundMeVM.Radius.allCases) { radius in
                        Label(radius.name, systemImage: "mappin.and.ellipse")
                            .tag(radius)
                    }
                } label: {
                    Label("Radius", systemImage: "mappin.and.ellipse")
                }
            }
            .alert(aroundMeVM.alertMessage ?? "Error", isPresented: $aroundMeVM.isDesplayingAlert) {
                Button("OK") {
                    aroundMeVM.resetAlertMessage()
                }
            }
            .refreshable { await aroundMeVM.loadData() }
        }
    }
}

struct PetListView_Previews: PreviewProvider {
    static var previews: some View {
        let previewData = AroundMeVM()
        PetCardListView()
            .environmentObject(previewData)
            .onAppear {
                previewData.location = PreviewMockedData.myLocation
                Task { await previewData.loadData() }
            }
    }
}
