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
        List {
            ForEach(aroundMeData.petsAround) { pet in
                PetCardView(petData: PetData(pet: pet))
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.inset)
        .onAppear{
            Task {
                await loadData()
            }
        }
    }
    
    private func loadData() async {
        await aroundMeData.fetchMissingPetsAround()
    }
}

struct PetListView_Previews: PreviewProvider {
    static var previews: some View {
        PetCardListView()
            .environmentObject(AroundMeData())
    }
}
