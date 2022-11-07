//
//  EmptyCardsView.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 31/10/2022.
//

import SwiftUI

struct EmptyCardsView: View {
    var body: some View {
        List {
            Text("No Pets around. Pull ↓ to refresh")
                .font(.title2)
                .foregroundColor(.secondary)
                .padding()
                .cornerRadius(5)
                .listRowSeparator(.hidden)
        }
    }
}

struct NoPertsAroundCardView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EmptyCardsView()
                .listStyle(.inset)
                .navigationTitle("Around Me")
        }
    }
}
