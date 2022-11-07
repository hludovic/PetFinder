//
//  CLErrorView.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 02/10/2022.
//

import SwiftUI

struct CLErrorView: View {
    var errorText: String

    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "xmark.octagon")
                        .resizable()
                    .frame(width: 100, height: 100, alignment: .center)
                Text(errorText)
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.red)
            .navigationTitle("Around Me")
        }
    }
}

struct CLErrorView_Previews: PreviewProvider {
    static var previews: some View {
        CLErrorView(errorText: "We need your permission to track your location")
    }
}
