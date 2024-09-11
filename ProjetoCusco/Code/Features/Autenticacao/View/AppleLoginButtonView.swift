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
        .signInWithAppleButtonStyle(colorScheme == .light ? .black : .white)
        .frame(maxWidth: 350, minHeight: 54, maxHeight: 54)
        .cornerRadius(8)
        .padding([.leading, .trailing, .top], 22)
    }
}

//#Preview {
//    AppleLoginButtonView()
//}
