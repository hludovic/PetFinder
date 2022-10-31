//
//  NoPertsAroundCardView.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 31/10/2022.
//

import SwiftUI

struct NoPetsCardView: View {
    var body: some View {
        Text("No Pets around. Pull ↓ to refresh")
            .frame(maxWidth: .infinity)
            .frame(height: 500)
            .listRowSeparator(.hidden)
    }
}

struct NoPertsAroundCardView_Previews: PreviewProvider {
    static var previews: some View {
        NoPetsCardView()
            .border(.red, width: 1)
    }
}
