//
//  PetListView.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 21/09/2022.
//

import SwiftUI

struct PetListView: View {
    @EnvironmentObject var aroundMeviewModel: AroundMeViewModel
    
    var body: some View {
        List {
            PetCellView(petName: "Felix", dateLost: Date().description)
                .listRowSeparator(.hidden)
            PetCellView(petName: "Médor", dateLost: Date().description)
                .listRowSeparator(.hidden)
            PetCellView(petName: "Marlo", dateLost: Date().description)
                .listRowSeparator(.hidden)
        }
        .listStyle(.inset)
    }
}

struct PetListView_Previews: PreviewProvider {
    static var previews: some View {
        PetListView()
            .environmentObject(AroundMeViewModel())
    }
}
