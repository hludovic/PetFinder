//
//  BadgeNewPetView.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 21/09/2022.
//

import SwiftUI

struct BadgeNewPetView: View {
    var dateAlert: Date
    
    var body: some View {
        ZStack{
            Capsule()
                .frame(width: 35, height: 15)
                .foregroundColor(.green)
            HStack{
                Text("New")
                    .font(.caption2)
                    .foregroundColor(.white)
            }

        }
    }
}

struct BadgeNewPetView_Previews: PreviewProvider {
    static var previews: some View {
        BadgeNewPetView(dateAlert: Date())
            .previewLayout(.fixed(width: 100, height: 100))
            .previewDisplayName("New Pet Badge")
    }
}
