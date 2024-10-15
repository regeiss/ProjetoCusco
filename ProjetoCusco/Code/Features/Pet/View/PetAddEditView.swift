//
//  PetAddEditView.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 11/09/24.
//

import SwiftUI
import SwiftfulRouting

struct PetAddEditView: View
{
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focusedField: FocusableField?
    @StateObject var photoViewModel = PhotoPickerModel()
    @State var pet = Pet(nome: "")
    @State var isEditingtPicture: Bool = false
    
    enum FocusableField: Hashable
    {
        case nome
    }
    
    enum Mode
    {
        case add
        case edit
    }
    
    var mode: Mode = .add
    var onCommit: (_ pet: Pet) -> Void
    
    var body: some View
    {
        RouterView { _ in
            
            Form
            {
//                HStack
//                {
//                    Spacer()
//                    EditableCircularPetImage(viewModel: photoViewModel)
//                    Spacer()
//                }
                                AsyncImage(url: URL(string: pet.imageURLString ?? ""))
                                { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                }
                                placeholder: {
                                    Image(systemName: "photo.fill")
                                        .resizable()
                                        .scaledToFill()
                                }
                                .frame(width: 95, height: 95, alignment: .center)
                                .cornerRadius(10)
                                .onTapGesture {
                                    isEditingtPicture.toggle()
                                }
                
                TextField("Nome", text: $pet.nome)
                    .focused($focusedField, equals: .nome)
                    .onSubmit {
                        commit()
                        
                    }
                Toggle(isOn: $pet.ativo) {
                    Text("ativo")
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
            .sheet(isPresented: $isEditingtPicture)
            {
                EditableCircularPetImage(viewModel: photoViewModel)
            }
        }
        .onAppear
        {
            focusedField = .nome
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
