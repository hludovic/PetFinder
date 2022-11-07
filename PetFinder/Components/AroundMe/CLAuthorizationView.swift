//
//  CLAuthorizationView.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 02/10/2022.
//

import SwiftUI

struct CLAuthorizationView: View {
    @EnvironmentObject var aroundMeData: AroundMeData

    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    aroundMeData.requestLocationAuthorization()
                }, label: {
                    Label("Allow tracking", systemImage: "location")
                })
                .padding(10)
                .foregroundColor(.white)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                Text("We need your permission to track your location.")
                    .foregroundColor(.gray)
                    .font(.caption)
            }
            .navigationTitle("Around Me")
        }
    }
}

struct CLAuthorizationView_Previews: PreviewProvider {
    static var previews: some View {
        CLAuthorizationView()
    }
}
