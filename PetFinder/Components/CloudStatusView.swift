//
//  CloudStatusView.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 27/09/2022.
//

import SwiftUI

struct CloudStatusView: View {
    @Binding var status: Bool?
    
    var body: some View {
        VStack {
            if status == nil {
                Image(systemName: "icloud")
                    .foregroundColor(.gray)
            } else if status == true {
                Image(systemName: "checkmark.icloud")
                    .foregroundColor(.green)
            } else if status == false {
                Image(systemName: "xmark.icloud")
                    .foregroundColor(.red)
            }
        }
    }
}

struct CloudStatusView_Previews: PreviewProvider {
    static var previews: some View {
        CloudStatusView(status: .constant(true))
            .previewLayout(.fixed(width: 100, height: 100))
    }
}
