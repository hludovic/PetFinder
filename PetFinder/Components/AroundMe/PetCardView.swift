//
//  PetCardView.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 20/09/2022.
//

import SwiftUI

struct PetCardView: View {
    var pet: PetLost
    @StateObject var petCardVM = PetCardVM()

    var body: some View {
        VStack {
            AsyncImage(url: petCardVM.imageURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ZStack {
                    Rectangle()
                        .foregroundColor(.orange)
                        .opacity(0.4)
                    Image(systemName: "photo")
                        .resizable()
                        .frame(width: 100, height: 80, alignment: .center)
                }
                .aspectRatio(1, contentMode: .fit)
            }
            HStack {
                VStack(alignment: .leading) {
                    Text(petCardVM.petName)
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                        .lineLimit(3)
                    Text(petCardVM.dateLost)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .layoutPriority(100)
                Spacer()
            }
            .padding([.horizontal, .bottom])
        }
        .background(Color("CellBackgroundColor"))
        .cornerRadius(10)
        .shadow(radius: 5)
        .onAppear {
            Task {
                await petCardVM.loadData(pet: pet)
            }
        }
        .redacted(reason: petCardVM.isRedacted ? .placeholder : .init())
    }
}

struct PetCardView_Previews: PreviewProvider {
    static let pets = PreviewMockedData.getFakePets()
    static var previews: some View {
        PetCardView(pet: pets.first!)
            .previewLayout(.fixed(width: 500, height: 700))
            .previewDisplayName("New Pet Badge")
    }
}
