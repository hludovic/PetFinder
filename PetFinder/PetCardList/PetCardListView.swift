//
//  PetListView.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 21/09/2022.
//

import SwiftUI

struct PetCardListView: View {
    @EnvironmentObject var aroundMeViewModel: AroundMeViewModel
    
    var body: some View {
        List {
            ForEach(aroundMeViewModel.petsAround) { pet in
                PetCardView(pet: pet)
            }
        }
        .listStyle(.inset)
        .onAppear{
            Task {
                await loadData()
            }
        }
    }
    private func loadData() async {
        await aroundMeViewModel.fetchMissingPetsAround(radius: .around50km)
    }
    
}

struct PetListView_Previews: PreviewProvider {
    static var previews: some View {
        PetCardListView()
            .environmentObject(AroundMeViewModel())
    }
}
