//
//  SettingsView.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 20/09/2022.
//

import SwiftUI

struct SettingsView: View {
    @State var cloudStatus: Bool? = true
    @State var pseudonym: String? = "Ludovic"
    @State var cloudDescription: String = "Online"
    @State var toggle1: Bool = false
    @State var toggle2: Bool = true
    @State var showingEditSheet: Bool = false

    var body: some View {
        NavigationView {
            List {
                Section("Pseudonym") {
                    HStack {
                        pseudonymText()
                        Spacer()
                        Button("Edit") {
                            showingEditSheet.toggle()
                        }
                        .buttonStyle(.borderless)
                    }
                }
                Section("CloudKit Status") {
                    HStack {
                        Text(cloudDescription)
                        Spacer()
                        CloudStatusView(status: $cloudStatus)
                    }
                }
                Section {
                    Text("Blocked users")
                    Toggle("Allows notifications", isOn: $toggle1)
                    Toggle("Allow recive Photo in messages", isOn: $toggle2)
                } header: {
                    Text("Security")
                }
                Section {
                    HStack {
                        Text("Location status description")
                        Spacer()
                        Image(systemName: "location.fill.viewfinder")
                            .foregroundColor(.red)
                    }
                } header: {
                    Text("Location")
                } footer: {
                    Text("To allow location go to settings -> Loction -> Enable to allows it Ok ?")
                }
            }
            .sheet(isPresented: $showingEditSheet) {
                EditPseudoView()
                    .presentationDetents([.medium])
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    func pseudonymText() -> Text {
        if let pseudo = pseudonym {
            return Text(pseudo)
                .foregroundColor(.gray)
        } else {
            return Text("No registered pseudonym")
                .foregroundColor(.red)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
