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
    
    var body: some View
    {
        ZStack(alignment: .bottomTrailing)
        {
            AsyncImage(url: URL(string: pet.imageURLString ?? ""))
            { result in
                result.image?
                    .resizable()
                    .scaledToFill()
            }
            .frame(width: 195, height: 195, alignment: .center)
            .cornerRadius(10)
            .onTapGesture {
                router.showScreen(.push) { _ in
                    PetDetalheView(pet: $pet)
                }
            }
            
            Text(String(pet.nome))
                .background(.ultraThinMaterial)
                .cornerRadius(3)
                .foregroundColor(.white)
                .font(.headline)
                .offset(x: -5, y: -5)
                .allowsHitTesting(false)
                
        }
    }
}
