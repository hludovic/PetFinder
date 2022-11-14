//
//  EditPetView.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 04/10/2022.
//

import SwiftUI
import UIKit
import PhotosUI

struct EditPetView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var context
    @StateObject var editPetVM = EditPetVM()

    var body: some View {
        NavigationView {
            List {
                Section {
                    Picker("Type", selection: $editPetVM.petType) {
                        Text("Dog").tag(PetLost.PetType.dog)
                        Text("Cat").tag(PetLost.PetType.cat)
                    }
                    .pickerStyle(.segmented)
                    TextField("Name", text: $editPetVM.name)
                    TextField("Breed", text: $editPetVM.breed)
                    DatePicker("Birthday", selection: $editPetVM.date, displayedComponents: .date)
                    Picker("Gender", selection: $editPetVM.gender) {
                        Text("Male").tag(PetLost.Gender.male)
                        Text("Female").tag(PetLost.Gender.female)
                    }
                } header: {
                    HStack {
                        Spacer()
                        VStack {
                            TopPhotoEditView()
                                .environmentObject(editPetVM)
                            Text("Image size: 123Kb")
                                .lineLimit(1)
                                .padding(.bottom, 10)
                        }
                        Spacer()
                    }
                } footer: {
                    Text("Footer text")
                }
            }
            .navigationTitle("About my pet")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        editPetVM.savePet(context: context)
                        dismiss()
                    } label: {
                        Text("Save")
                    }
                    .disabled(!editPetVM.canSave)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }

                }
            }
        }
    }
}

struct TopPhotoEditView: View {
    @EnvironmentObject var editPetVM: EditPetVM

    var body: some View {
        if let image = editPetVM.image {
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 200)
                .clipped()
                .cornerRadius(25)
                .overlay(alignment: .topTrailing) {
                    PhotosPicker(selection: $editPetVM.imageSelection, matching: .images) {
                        Image(systemName: "photo.circle")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                            .background { Color.accentColor }
                            .clipShape(Circle())
                    }
                }
        } else {
            Image(systemName: "person")
                .resizable()
                .frame(width: 120, height: 120)
                .frame(width: 200, height: 200)
                .foregroundColor(.red)
                .background {
                    LinearGradient(
                        colors: [.yellow, .orange],
                        startPoint: .top, endPoint: .bottom
                    )
                }
                .cornerRadius(25)
                .overlay(alignment: .topTrailing) {
                    PhotosPicker(selection: $editPetVM.imageSelection, matching: .images) {
                        Image(systemName: "photo.circle")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                            .background { Color.accentColor }
                            .clipShape(Circle())
                    }
                }
        }
    }
}

struct EditPetView_Previews: PreviewProvider {
    static var model = Model(inMemory: true)
    static var previews: some View {
            EditPetView()
            .environment(\.managedObjectContext, model.localContainer.viewContext)
            .environment(\.locale, Locale.init(identifier: "fr"))
        }
}
