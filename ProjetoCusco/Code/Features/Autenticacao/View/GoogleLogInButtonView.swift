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
                // .padding(.vertical, 1)
                .frame(maxWidth: .infinity, maxHeight: 44)
                .background(alignment: .leading) {
                    Image(colorScheme == .dark ? "ios_dark_sq_na" : "ios_light_sq_na")
                }
        }
        .foregroundColor(colorScheme == .dark ? .white : .black)
        .buttonStyle(.primary)
        // .frame(maxWidth: 350, minHeight: 54, maxHeight: 54)
        .padding([.leading, .trailing, .bottom], 12)
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
    Group
    {
        GoogleLoginButtonView()
            .preferredColorScheme(.light)
    }
    .environmentObject(AuthenticationViewModel())
  
}
