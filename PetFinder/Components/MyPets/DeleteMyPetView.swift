//
//  DeleteMyPetView.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 31/10/2022.
//

import SwiftUI

struct DeleteMyPetView: View {
    var pet: MyPet
    @EnvironmentObject var myPetsData: MyPetsData

    var body: some View {
        Button(role: .destructive) {
            myPetsData.deletePet(pet: pet)
        } label: {
            Image(systemName: "trash")
        }
    }
}

struct DeleteMyPetView_Previews: PreviewProvider {
    static var myPetsData = MyPetsData(inMemory: true)
    static var pet = PreviewMockedData.fakeMyPet()
    static var previews: some View {
        DeleteMyPetView(pet: pet)
            .environmentObject(myPetsData)
    }
}
