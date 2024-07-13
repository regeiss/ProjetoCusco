//
//  AbrigoListaScreen.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 07/07/24.
//

import SwiftUI

struct AbrigoListaScreen: View
{
    @StateObject private var viewModel = AbrigoViewModel()
    @State var editableAbrigo: Abrigo?
    @State var isAddDialogPresented = false

    var body: some View
    {
        List($viewModel.abrigo) { $abrigo in
            AbrigoDetalheView(abrigo: $abrigo)
                .swipeActions(edge: .trailing, allowsFullSwipe: true)
            {
                Button(role: .destructive, action: { viewModel.delete(abrigo)})
                {
                    Image(systemName: "trash")
                }
            }
            .onTapGesture
            {
                editableAbrigo = abrigo
            }
        }
        .navigationTitle("Abrigo")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing)
            {
                Button(action: presentAddView)
                {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $isAddDialogPresented)
        {
            AbrigoAddEditView { abrigo in
                viewModel.addAbrigo(abrigo)
            }
        }
        .sheet(item: $editableAbrigo) { abrigo in
            AbrigoAddEditView(abrigo: abrigo, mode: .edit) { abrigo in
                viewModel.update(abrigo)
            }
        }
        .tint(.blue)
    }

    private func presentAddView()
    {
        isAddDialogPresented.toggle()
    }

}
