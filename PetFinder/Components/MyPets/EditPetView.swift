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
    @State var name: String = ""
    @State var date: Date = Date()
    @State var dailyReminderEnabled: Bool = true
    @State var gender: PetLost.Gender = .female
    @State var petType: PetLost.PetType = .dog
    @State var breed: String = ""

    var body: some View {
        NavigationView {
            List {
                Section {
                    Picker("Type", selection: $petType) {
                        Text("Dog").tag(PetLost.PetType.dog)
                        Text("Cat").tag(PetLost.PetType.cat)
                    }
                    .pickerStyle(.segmented)
                    TextField("Name", text: $name)
                    TextField("Breed", text: $breed)
                    // DatePicker Constraint errors; iOS 16 Bugs
                    DatePicker("Birthday", selection: $date, displayedComponents: .date)
                    Picker("Gender", selection: $gender) {
                        Text("Male").tag(PetLost.Gender.male)
                        Text("Female").tag(PetLost.Gender.female)
                    }
                } header: {
                    HStack {
                        Spacer()
                        VStack {
                            TopPhotoEditView()
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
                        print("Gogo")
                    } label: {
                        Text("Save")
                    }
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

struct EditPetView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EditPetView()
                .environment(\.locale, Locale.init(identifier: "fr"))
        }
    }
}

struct TopPhotoEditView: View {
    @StateObject var imagePicker = ImagePicker()

    var body: some View {
        if let image = imagePicker.image {
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 200)
                .clipped()
                .cornerRadius(25)
                .overlay(alignment: .topTrailing) {
                    PhotosPicker(selection: $imagePicker.imageSelection, matching: .images) {
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
                    PhotosPicker(selection: $imagePicker.imageSelection, matching: .images) {
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
