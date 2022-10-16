//
//  EditPetView.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 04/10/2022.
//

import SwiftUI
import MapKit

struct EditPetView: View {
    @State var name: String = ""
    @State var date: Date = Date()
    @State var dailyReminderEnabled: Bool = true
    @State var gender: PetLost.Gender = .female
    @State var petType: PetLost.PetType = .dog
    @State var race: String = ""

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
    )

    var body: some View {
        List {
            Section {
                Picker("Type", selection: $petType) {
                    Text("Dog").tag(PetLost.PetType.dog)
                    Text("Cat").tag(PetLost.PetType.cat)
                }
                .pickerStyle(.segmented)
                TextField("Name", text: $name)
                TextField("Race", text: $race)
                DatePicker("Birthday", selection: $date, displayedComponents: .date)
                Picker("Gender", selection: $gender) {
                    Text("Male").tag(PetLost.Gender.male)
                    Text("Female").tag(PetLost.Gender.female)
                }
                Map(coordinateRegion: $region)
                    .frame(maxWidth: .infinity)
                    .aspectRatio(1, contentMode: .fill)
                    .disabled(true)
            } header: {
                HStack {
                    Spacer()
                    VStack {
                        TopPhotoEditView(photo: .constant("Pet3"))
                        Text("Owner: Ownername")
                            .lineLimit(1)
                            .padding(.bottom, 10)
                    }
                    Spacer()
                }
            } footer: {
                Text("Footer text")
            }
        }
        .navigationTitle("New Pet")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct EditPetView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EditPetView()
        }
    }
}

struct TopPhotoEditView: View {
    @Binding var photo: String

    var body: some View {
        Image(photo)
            .resizable()
            .scaledToFit()
            .clipShape(Circle())
            .frame(width: 200, height: 200)
            .overlay {
                Button {
                    print("Action")
                } label: {
                    Image(systemName: "camera.circle")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.white)
                        .background { Color.accentColor }
                        .clipShape(Circle())
                }
                .offset(x: 75, y: -70)
            }
    }
}
