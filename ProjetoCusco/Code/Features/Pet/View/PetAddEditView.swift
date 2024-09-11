//
//  PetAddEditView.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 11/09/24.
//

import SwiftUI

struct PetAddEditView: View
{
    enum FocusableField: Hashable
    {
        case nome
    }

    enum Mode
    {
        case add
        case edit
    }

    @Environment(\.dismiss) private var dismiss
    @FocusState private var focusedField: FocusableField?
    @State var pet = Pet(nome: "")

    var mode: Mode = .add
    var onCommit: (_ pet: Pet) -> Void

    var body: some View
    {
        NavigationStack
        {
            Form
            {
                TextField("Nome", text: $pet.nome)
                    .focused($focusedField, equals: .nome)
                    .onSubmit {
                        commit()

                    }
            }
            .navigationTitle(mode == .add ? "Novo pet" : "Detalhes")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction)
                {
                    Button(action: cancel) {
                        Text("Cancelar")
                    }
                }
                ToolbarItem(placement: .confirmationAction)
                {
                    Button(action: commit) {
                        Text(mode == .add ? "Add" : "Feito")
                    }
                    .disabled(pet.nome.isEmpty)
                }
            }
            .onAppear
            {
                focusedField = .nome
            }
        }
    }

    private func commit()
    {
        onCommit(pet)
        dismiss()
    }

    private func cancel()
    {
        dismiss()
    }
}
