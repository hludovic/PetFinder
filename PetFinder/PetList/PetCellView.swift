//
//  PetCellView.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 20/09/2022.
//

import SwiftUI

struct PetCellView: View {
    let petName: String
    let dateLost: String
    
    var body: some View {
        VStack {
            Image("Pet1")
                .resizable()
                .aspectRatio(contentMode: .fit)
            HStack {
                VStack(alignment: .leading) {
                    Text(petName)
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                        .lineLimit(3)
                    Text("Lost the \(dateLost)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .layoutPriority(100)
                Spacer()
            }
            .padding([.horizontal, .bottom])
        }
        .background(Color.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
        )
        .shadow(radius: 5)
    }
}


struct PetCellView_Previews: PreviewProvider {
    static var previews: some View {
        PetCellView(petName: "Felix", dateLost: "12 Octobre 2022")
            .previewLayout(.fixed(width: 500, height: 700))
            .previewDisplayName("New Pet Badge")
    }
}
