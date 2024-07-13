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
        HStack
        {
            Image(systemName: abrigo.ativo ? "largecircle.fill.circle" : "circle")
            .imageScale(.large)
            .foregroundColor(.accentColor)
            .onTapGesture {
                abrigo.ativo.toggle()
            }
            Text(abrigo.nome)
        }
    }
}
