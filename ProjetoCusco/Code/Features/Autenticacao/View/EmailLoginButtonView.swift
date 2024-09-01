//
//  EmailLoginButtonView.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 31/08/24.
//

import SwiftUI

private enum FocusableField: Hashable
{
    case email
    case password
}

struct EmailLoginButtonView: View
{
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @FocusState private var focus: FocusableField?
    
    var body: some View
    {
        HStack
        {
            Image(systemName: "at")
            TextField("Email", text: $viewModel.email)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .focused($focus, equals: .email)
                .onSubmit {
                    signInWithEmailLink()
                }
        }
        .padding()
        .background(Divider(), alignment: .bottom)
        
        if !viewModel.errorMessage.isEmpty
        {
            VStack
            {
                Text(viewModel.errorMessage)
                    .foregroundColor(Color(UIColor.systemRed))
            }
        }
        
        Button(action: signInWithEmailLink)
        {
            if viewModel.authenticationState != .authenticating {
                Text("Login")
                    .padding()
                    .frame(maxWidth: .infinity)
            }
            else
            {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .padding()
                    .frame(maxWidth: .infinity)
            }
        }
        .disabled(!viewModel.isValid)
        .frame(maxWidth: .infinity)
        .buttonStyle(.bordered)
        .padding()
    }
    
    private func signInWithEmailLink()
    {
        Task
        {
            await viewModel.sendSignInLink()
            dismiss()
        }
    }
}

#Preview {
    EmailLoginButtonView()
}
