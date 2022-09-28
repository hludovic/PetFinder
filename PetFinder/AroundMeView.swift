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
        if !aroundMeData.hasPermission {
            CLAutorizationView()
        } else {
                PetCardListView()
        }
    }
}

struct AroundMeView_Previews: PreviewProvider {
    static var previews: some View {
        let previewData = AroundMeData()
        AroundMeView()
            .environmentObject(previewData)
            .onAppear{
                previewData.location = PreviewMockedData.myLocation
                previewData.hasPermission = true
                Task {
                    await previewData.fetchMissingPetsAround()
                }
            }
    }
}
