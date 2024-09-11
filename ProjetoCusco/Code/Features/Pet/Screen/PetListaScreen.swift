//
//  PetListScreen.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 11/09/24.
//

import SwiftUI

struct PetListaScreen: View
{
    @StateObject private var viewModel = PetViewModel()
    @State var editablePet: Pet?
    @State var isAddDialogPresented = false

    var body: some View
    {
        List($viewModel.pet) { $pet in
            PetDetalheView(pet: $pet)
                .swipeActions(edge: .trailing, allowsFullSwipe: true)
            {
                Button(role: .destructive, action: { viewModel.delete(pet)})
                {
                    Image(systemName: "trash")
                }
            }
            .onTapGesture
            {
                editablePet = pet
            }
        }
        .navigationTitle("Pet")
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
            PetAddEditView { pet in
                viewModel.addPet(pet)
            }
        }
        .sheet(item: $editablePet) { pet in
            PetAddEditView(pet: pet, mode: .edit) { pet in
                viewModel.update(pet)
            }
        }
        .tint(.blue)
    }

    private func presentAddView()
    {
        isAddDialogPresented.toggle()
    }

}
