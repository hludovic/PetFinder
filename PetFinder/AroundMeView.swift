//
//  AroundMeView.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 20/09/2022.
//

import SwiftUI

struct AroundMeView: View {
    @EnvironmentObject var aroundMeViewModel: AroundMeViewModel
    
    var body: some View {
        PetCardListView()
            .environmentObject(aroundMeViewModel)
    }
}

struct AroundMeView_Previews: PreviewProvider {
    static var previews: some View {
        AroundMeView()
            .environmentObject(AroundMeViewModel())
    }
}
