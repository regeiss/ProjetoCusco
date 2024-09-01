//
//  GoogleLoginButtonView.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 30/08/24.
//
import SwiftUI

struct GoogleLoginButtonView: View
{
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    
    var body: some View
    {
        Button(action: signInWithGoogle)
        {
            Text("Entrar com o Google")
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                .background(alignment: .leading) {
                    Image(colorScheme == .dark ? "ios_dark_sq_na" : "ios_light_sq_na")
                        .frame(width: 30, alignment: .center)
                }
        }
        .foregroundColor(colorScheme == .dark ? .white : .black)
        .buttonStyle(.bordered)
        .padding()
        
    }
    
    private func signInWithGoogle()
    {
        Task
        {
            if await viewModel.signInWithGoogle() == true
            {
                dismiss()
            }
        }
    }
}

#Preview {
    GoogleLoginButtonView()
}
