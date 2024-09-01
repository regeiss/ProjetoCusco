//
//  SettingsScreen.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 14/07/24.
//

import SwiftUI

struct SettingsScreen: View
{
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = SettingsViewModel()
    @State var isShowSignUpDialogPresented = false
    
    private func signUp()
    {
        isShowSignUpDialogPresented.toggle()
    }
    
    private func signOut()
    {
        viewModel.signOut()
    }
    
    var body: some View
    {
        NavigationStack
        {
            Form
            {
                Section
                {
                    NavigationLink(destination: UserProfileView()) {
                        Label("Perfil", systemImage: "person.circle")
                    }
                }
                Section
                {
                    if viewModel.isGuestUser
                    {
                        Button(action: signUp)
                        {
                            HStack
                            {
                                Spacer()
                                Text("Inscreva-se")
                                Spacer()
                            }
                        }
                    }
                    else
                    {
                        Button(action: signOut) {
                            HStack
                            {
                                Spacer()
                                Text("Sair")
                                Spacer()
                            }
                        }
                    }
                } footer: {
                    HStack
                    {
                        Spacer()
                        Text(viewModel.loggedInAs)
                        Spacer()
                    }
                }
            }
            .navigationTitle("Ajustes")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: { dismiss() }) {
                        Text("Pronto")
                    }
                }
            }
            .sheet(isPresented: $isShowSignUpDialogPresented) {
                AuthenticationScreen()
            }
        }
    }
}
