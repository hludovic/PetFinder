//
//  MyPetsView.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 20/09/2022.
//

import SwiftUI

struct MyPetsView: View {
    @FetchRequest(sortDescriptors: []) var myPets: FetchedResults<MyPet>
    @EnvironmentObject var myPetsData: MyPetsData

    var body: some View {
        NavigationView {
            VStack {
                if myPets.count == 0 {
                    Text("Press + to add a new pet")
                } else {
                    List(myPets) { myPet in
                        Text(myPet.name ?? "Error")
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        let pet = PetOwned(
                            id: UUID(),
                            name: "Woofy",
                            gender: "Male",
                            type: "Dog",
                            breed: "Doberman",
                            birthDay: Date()
                        )
                        myPetsData.savePet(pet: pet)

                    } label: {
                        Label("Add", systemImage: "plus")
                    }
                }
            }
            .navigationTitle("My Pets")
        }
    }
}

struct MyPetsView_Previews: PreviewProvider {
    static var myPetsData = MyPetsData(inMemory: true)
    static var previews: some View {
        MyPetsView()
            .environment(\.managedObjectContext, myPetsData.container.viewContext)
            .environmentObject(myPetsData)
    }
}
