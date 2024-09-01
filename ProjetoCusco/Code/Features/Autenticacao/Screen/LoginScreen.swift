//
//  LoginView.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 15/07/24.
//

import SwiftUI
import Combine
import FirebaseAnalyticsSwift
import AuthenticationServices
import GoogleSignIn
import GoogleSignInSwift

struct LoginScreen: View
{
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    
    var body: some View
    {
        VStack
        {
            HStack
            {
                Text("Cusco App")
                    .font(.title)
                    .bold()
            }
            .padding(.horizontal)
            
            VStack
            {
                Image(colorScheme == .light ? "auth-hero-light" : "auth-hero-dark")
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .scaledToFit()
                    .padding(.vertical, 24)
                
                Text("Adote um pet.")
                    .font(.title2)
                    .padding(.bottom, 16)
            }
            
            Spacer()
            
            VStack
            {
                Image("login")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minHeight: 300, maxHeight: 400)
                Text("Login")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                
            }
            .listStyle(.plain)
            
            EmailLoginButtonView()
            AppleLoginButtonView()
            GoogleLoginButtonView()
            
            HStack
            {
                Text("Não tem uma conta ainda?")
                Button(action: { viewModel.switchFlow()})
                {
                    Text("Inscreva-se")
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                }
            }
            .padding(.vertical, 8)
        }
        .padding()
        // .analyticsScreen(name: "\(Self.self)")
    }
    
    // MARK: - Funcs
   
}
