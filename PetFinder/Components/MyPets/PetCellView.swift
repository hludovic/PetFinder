//
//  PetCellView.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 31/10/2022.
//

import SwiftUI

struct PetCellView: View {
    let pet: MyPet

    var body: some View {
        HStack {
            Image("Pet3")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 70, height: 70)
            VStack(alignment: .leading) {
                Text(pet.name ?? "Error")
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                Text(pet.breed ?? "Error")
                    .font(.subheadline)
                    .fontWeight(.light)
                    .foregroundColor(.primary)
                    .lineLimit(1)
            }
            .padding(.leading, 5)
            Spacer()
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct PetCellView_Previews: PreviewProvider {
    static var previews: some View {
        PetCellView(pet: PreviewMockedData.fakeMyPet())
    }
}
