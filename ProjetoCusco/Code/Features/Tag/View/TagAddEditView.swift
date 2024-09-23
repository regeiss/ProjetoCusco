//
//  TagAddEditView.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 22/09/24.
//

import SwiftUI

struct TagAddEditView: View
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
    @State var tag = Tag(nome: "")
    
    var mode: Mode = .add
    var onCommit: (_ tag: Tag) -> Void
    
    var body: some View
    {
        NavigationStack
        {
            Form
            {
                TextField("Nome", text: $tag.nome)
                    .focused($focusedField, equals: .nome)
                    .onSubmit {
                        commit()
                        
                    }
//                Toggle(isOn: $tag.ativo) {
//                    Text("ativo")
//                }
            }
            .navigationTitle(mode == .add ? "Novo tag" : "Detalhes")
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
                    .disabled(tag.nome.isEmpty)
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
        onCommit(tag)
        dismiss()
    }
    
    private func cancel()
    {
        dismiss()
    }
}
