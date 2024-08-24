//
//  HomeTileView.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 23/08/24.
//

import SwiftUI

struct HomeTileView: View
{
    @Environment(\.router) var router
    @State var pet: Pet
    
    var body: some View {
        Text(String(pet.nome))
            .frame(width: 185, height: 185, alignment: .center)
            .background(.blue)
            .cornerRadius(10)
            .foregroundColor(.white)
            .font(.title)
            .onTapGesture {
                router.showScreen(.push) { _ in
                    PetDetailView(pet: pet)
                }
            }
    }
}
