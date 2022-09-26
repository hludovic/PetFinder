//
//  PetCellView.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 20/09/2022.
//

import SwiftUI

struct PetCardView: View {
    @State private var isRedacted: Bool = true
    @State private var petName: String = ""
    @State private var dateLost = ""
    @State private var imageURL: URL? = nil
    var pet: Pet
    
    var body: some View {
        VStack {
            AsyncImage(url: imageURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Image("placeholder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
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
        .onAppear {
            Task {
                await loadData()
            }
        }
        .redacted(reason: isRedacted ? .placeholder : .init())
    }
    
    private func loadData() async {
        petName = pet.name
        var fetchedImageURL: URL?
        fetchedImageURL = await pet.fetchPhoto()        
        guard let date = pet.dateLost, let url = fetchedImageURL
        else { return }
        
        dateLost = date.description
        imageURL = url
        isRedacted = false
    }
}


struct PetCellView_Previews: PreviewProvider {
    static var previews: some View {
        let pets = PreviewMockedData.getFakePets()
        PetCardView(pet: pets.first!)
            .previewLayout(.fixed(width: 500, height: 700))
            .previewDisplayName("New Pet Badge")
    }
}
