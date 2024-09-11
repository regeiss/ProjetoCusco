//
//  PetDetailView.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 23/08/24.
//

import SwiftUI

struct PetDetalheView: View
{
    @Binding var pet: Pet
    
    var body: some View
    {
        HStack(alignment: .top)
        {
            
            AsyncImage(url: URL(string: pet.imageURLString ?? ""))
            { result in
                result.image?
                    .resizable()
                    .scaledToFill()
            }
            .frame(width: 95, height: 95, alignment: .center)
            .cornerRadius(10)
            
            VStack
            {
                
                Text(pet.nome).font(.title)
                
                Spacer()
                
                HStack
                {
                    Text("ativo ")
                    Image(systemName: pet.ativo ? "largecircle.fill.circle" : "circle")
                        .imageScale(.medium)
                        .foregroundColor(.accentColor)
                        .onTapGesture {
                            pet.ativo.toggle()
                        }
                    Spacer()
                }
            }
        }
    }
}
