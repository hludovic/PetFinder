//
//  MyPetsView.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 20/09/2022.
//

import SwiftUI

struct MyPetsView: View {
    @FetchRequest(sortDescriptors: []) private var myPets: FetchedResults<MyPet>
    @State var presentNewPetSheet: Bool = false
    @Environment(\.managedObjectContext) var context

    var body: some View {
        NavigationView {
            Group {
                if myPets.count == 0 {
                    Text("Press + to add a new pet")
                } else {
                    List(myPets) { myPet in
                        PetCellView(pet: myPet)
                            .swipeActions(edge: .leading) {
                                DeleteMyPetView(pet: myPet)
                            }
                            .listRowSeparator(.hidden)
                    }
                    .listStyle(.inset)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        presentNewPetSheet.toggle()
                    } label: {
                        Label("Add", systemImage: "plus")
                    }
                }
            }
            .navigationTitle("My Pets")
        }
        .sheet(isPresented: $presentNewPetSheet) {
            EditPetView()
        }

    }
}

struct MyPetsView_Previews: PreviewProvider {
    static var model = Model(inMemory: true)
    static var previews: some View {
        MyPetsView()
            .environment(\.managedObjectContext, model.localContainer.viewContext)
    }
}
