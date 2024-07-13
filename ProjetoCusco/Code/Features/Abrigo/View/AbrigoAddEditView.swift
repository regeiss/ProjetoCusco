//
//  AbrigoAddEditView.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 08/07/24.
//

import SwiftUI

struct AbrigoAddEditView: View
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
    @State var abrigo = Abrigo(nome: "")

    var mode: Mode = .add
    var onCommit: (_ abrigo: Abrigo) -> Void

    var body: some View
    {
        NavigationStack
        {
            Form
            {
                TextField("Nome", text: $abrigo.nome)
                    .focused($focusedField, equals: .nome)
                    .onSubmit {
                        commit()

                    }
            }
            .navigationTitle(mode == .add ? "Novo abrigo" : "Detalhes")
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
                    .disabled(abrigo.nome.isEmpty)
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
        onCommit(abrigo)
        dismiss()
    }

    private func cancel()
    {
        dismiss()
    }
}
