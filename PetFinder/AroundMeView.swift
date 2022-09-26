//
//  AroundMeView.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 20/09/2022.
//

import SwiftUI

struct AroundMeView: View {
    @EnvironmentObject var aroundMeViewModel: AroundMeViewModel
    @State var range: AroundMeViewModel.Range = .around50km
    
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
                        Picker(selection: $range) {
                            Text("Radius 1km").tag(AroundMeViewModel.Range.around1km)
                            Text("Radius 5km").tag(AroundMeViewModel.Range.around5km)
                            Text("Radius 10km").tag(AroundMeViewModel.Range.around10km)
                            Text("Radius 50km").tag(AroundMeViewModel.Range.around50km)
                        } label: {
                            Label("Range", systemImage: "mappin.and.ellipse")
                        }
                    }
                }
        }
        .refreshable {
            await aroundMeViewModel.fetchMissingPetsAround(radius: range)
        }
    }
}

struct AroundMeView_Previews: PreviewProvider {
    static var previews: some View {
            AroundMeView()
                .environmentObject(AroundMeViewModel())
    }
}
