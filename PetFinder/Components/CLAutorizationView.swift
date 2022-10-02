//
//  CLAutorizationView.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 28/09/2022.
//

import SwiftUI

struct CLAutorizationView: View {
    @EnvironmentObject var aroundMeData: AroundMeData

    var body: some View {
        ZStack {
            Color(.white)
            Image("Pet3")
                .opacity(0.4)
                .blur(radius: 10)
            Text("Pet Finder")
                .font(.largeTitle)
        }
    }
}

struct CLAutorizationView_Previews: PreviewProvider {
    static var previews: some View {
        CLAutorizationView()
    }
}
