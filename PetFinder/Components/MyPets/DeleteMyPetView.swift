//
//  DeleteMyPetView.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 31/10/2022.
//

import SwiftUI

struct DeleteMyPetView: View {
    var pet: MyPet
    @Environment(\.managedObjectContext) var context

    var body: some View {
        Button(role: .destructive) {
            deletePet()
        } label: {
            Image(systemName: "trash")
        }
    }

    func deletePet() {
        context.delete(pet)
        try? context.save()
    }
}

struct DeleteMyPetView_Previews: PreviewProvider {
    static var model = Model(inMemory: true)
    static var pet = PreviewMockedData.fakeMyPet()
    static var previews: some View {
        DeleteMyPetView(pet: pet)
            .environment(\.managedObjectContext, model.localContainer.viewContext)
    }
}
