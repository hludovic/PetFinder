//
//  EditPseudoView.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 04/10/2022.
//

import SwiftUI

struct EditPseudoView: View {
    var body: some View {
        NavigationView {
            Text("Hello, World!")
                .navigationTitle("Name")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            print("Hello")
                        } label: {
                            Text("Save")
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            print("Hello")
                        } label: {
                            Text("Cancel")
                        }
                    }
                }
        }
    }
}

struct EditPseudoView_Previews: PreviewProvider {
    static var previews: some View {
        EditPseudoView()
    }
}
