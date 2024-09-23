//
//  TagDetalheView.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 22/09/24.
//

import SwiftUI

struct TagDetalheView: View
{
    @Binding var tag: Tag
    
    var body: some View
    {
        HStack(alignment: .top)
        {
            VStack
            {
                Text(tag.nome).font(.title)
                    .padding()
                
//                HStack
//                {
//                    Text("ativo ")
//                    Image(systemName: pet.ativo ? "largecircle.fill.circle" : "circle")
//                        .imageScale(.medium)
//                        .foregroundColor(.accentColor)
//                        .onTapGesture {
//                            pet.ativo.toggle()
//                        }
//                    Spacer()
//                }
            }
        }
    }
}
