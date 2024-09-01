//
//  AppleLoginButtonView.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 31/08/24.
//

import SwiftUI
import AuthenticationServices

struct AppleLoginButtonView: View
{
    var body: some View
    {
        @EnvironmentObject var viewModel: AuthenticationViewModel
        @Environment(\.colorScheme) var colorScheme
        @Environment(\.dismiss) var dismiss
        
        SignInWithAppleButton(.signIn) { request in
            viewModel.handleSignInWithAppleRequest(request)
        } onCompletion: { result in
            Task
            {
                if await viewModel.handleSignInWithAppleCompletion(result)
                {
                    dismiss()
                }
            }
        }
        //.signInWithAppleButtonStyle(colorScheme == .light ? .black : .white)
        .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 70)
        .cornerRadius(8)
        .padding()
    }
}

#Preview {
    AppleLoginButtonView()
}
