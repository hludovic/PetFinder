//
//  PetCellView.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 20/09/2022.
//

import SwiftUI

struct PetCardView: View {
    @ObservedObject var petData: PetData
    
    var body: some View {
        VStack {
            AsyncImage(url: petData.imageURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ZStack{
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
                    Text(petData.petName)
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                        .lineLimit(3)
                    Text(petData.dateLost)
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
        .onAppear {
            Task {
                await petData.loadData()
            }
        }
        .redacted(reason: petData.isRedacted ? .placeholder : .init())
    }    
}

struct PetCellView_Previews: PreviewProvider {
    static var previews: some View {
        let pets = PreviewMockedData.getFakePets()
        PetCardView(petData: PetData(pet: pets.first!))
            .previewLayout(.fixed(width: 500, height: 700))
            .previewDisplayName("New Pet Badge")
    }
}
