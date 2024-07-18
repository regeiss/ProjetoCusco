//
//  AbrigoDetalheView.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 10/07/24.
//

import SwiftUI

struct AbrigoDetalheView: View
{
    @Binding var abrigo: Abrigo

    var body: some View
    {
        VStack(alignment: .leading)
        {
            Text(abrigo.nome)

            HStack
            {
                Text("ativo ")
                Image(systemName: abrigo.ativo ? "largecircle.fill.circle" : "circle")
                    .imageScale(.medium)
                    .foregroundColor(.accentColor)
                    .onTapGesture {
                        abrigo.ativo.toggle()
                    }
                Spacer()
            }
        }
    }
}
